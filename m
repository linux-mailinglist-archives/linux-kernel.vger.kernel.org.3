Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224DA5263B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbiEMOQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243521AbiEMOQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:16:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4584DF24
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:16:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DAYfrn023623;
        Fri, 13 May 2022 14:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=TXNusCUOI58jGt5R2lM1X0M8rm96woa1pluaxKb23gU=;
 b=nJBqygZeR/yRX8f59Qurck2V0XzeCOdf9+jz8MvOQzLe6qFWxLCt7/jGnTrQUTNsaBQh
 7cKw4o0fx1CX++hfJo/EWPeBEILTZnc4+DrQp53okZPXT78WGJIOWm09CU/1Mwl6SoVj
 kvlvK4BdKV1ZSKQC437nD83hmGsEPKXHhR+Ke7+6bYJ3xZ3B5+c2GdCp88BCbfmT7lfc
 LB0EoHdEoTzeQqarFoBGF5LXjZnrGJLe9awJTumVDYcA8pF+Zkw3L/RAl7rZ7rncW9qO
 twYdvBIDEqhLE6APHYyq10UlpIX+my3tjjRTT/6If7Y8mEQ2IIeQ1qpuz7H+cIlV6V8Y cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsyq52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:15:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DE5lPh032159;
        Fri, 13 May 2022 14:15:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf76tuxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWvZE6KIH69ya904IdyTM7JwBFJZUEzcLoKFrFoKUR6CCS6EpFgVltxcj8QXMcaVjnFLozZpLiz7tJuIUr7AOhgXzs3iObewZzQx5aK67oNcdwG9oQPhV9M2mOsBl633a+gCX5d4POe0mnh8NeLzIXcuj00q5+lvC68tiznfKjHywCSQtiH8SzfYs6HUC/uQCKci4jo2AjLkI5FJEfZLPaTRcMAH9yLsOecIv5UbWUTeySP05xeaPqXVNvLYciPB5gtlWzANQviDolJ54yKARN6Mk3+va5Aoi+hn+bwq35DwrMvZetLhKwDZex1U3slaYpbdbgqhEBg1hpYnFliXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXNusCUOI58jGt5R2lM1X0M8rm96woa1pluaxKb23gU=;
 b=Cg5MlaJ2cD211tavIma7Orfw2FgbySpo6gzfKsqTxTgNWan60zXi87v5bpnCAwX3oZ/ls7hgeEf+Fr+CPKTfJlBJpU+XUaohgbvRyF5UT1E5dTSKuDg421fKE5w+jefPlppdej7Iw5YYq9eKfg8VJsC3/d5m3ZW6Ret4d9+YpM/U6CN77dltUO2EbQSSuYUmlkaErq2XxgGYTXPGjRX0pN9QFtIJJIso9IU36s+lSDQn4Vsj4NIpbdxuRHaMt6201lkk+lOcZjy5w0aT2IP3Zc+Ath0ECPTTfUnopps/JqVbopyGX9SGVAXkI0pbjh2kb3ZFpw6hsTbEREUBs3iwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXNusCUOI58jGt5R2lM1X0M8rm96woa1pluaxKb23gU=;
 b=CQwDvf16TfDeV5iksqAnIywHl0/1+F0W0RyFzqv+N2Xpfwrn3XlGBL60O7Bj7XaHy9ZE2litisaI/vJiLw3seREcKLHBnFCf3OMQQ/QNXg98s2CKZ/X7CMXc2swd3Zv6Wj6JSDUi8R/lf1zcoKziUbv/uLWdX6Tw64MA07rM8oM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 14:15:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.025; Fri, 13 May 2022
 14:15:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] mm/mmap: Fix potential leak on do_mas_align_munmap()
Thread-Topic: [PATCH] mm/mmap: Fix potential leak on do_mas_align_munmap()
Thread-Index: AQHYZtP0s1FcGwbLQUKRqSIXxyhDeA==
Date:   Fri, 13 May 2022 14:15:53 +0000
Message-ID: <20220513141548.2019143-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fe8a190-d23d-4656-a2ee-08da34eb16d0
x-ms-traffictypediagnostic: CO1PR10MB4451:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4451CC050076DD9C8E13B21AFDCA9@CO1PR10MB4451.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axfMrVtPNspd1ec1BbrLOZuYgepmq81hVp2bFHh9gwyeU0334ABoppP5rt6alOI6d0mcy+QmPolljSz6xLSH6/IbQeOBewjvgGGzdcuUmZQ/OCJmUjJR7suS7j9JDg5rIQx25u6hEpkg9eBKVTHGRu4G6vkCX8jsmSlfYLXtSN4FPLlcFuvo8/17YM+G3zdj6ysHOA6Cdbx6Nn9RAkMTf0nOO6p6vuG9WimZxsf3jsrUZn0llrNKVS70bzxECj2jNfXIpD9YIzQq8+ICDuAyv3Qh0Z5bkqgEHcqMTavPdgszFiZI1xJT8Wlzi29yANU4hEkPyguRmBJ/28j5paxt/BTAhixrUxmDMOvlytcHIaFLSWOOuC9cXCR816CVzp0ZPN69sJ5ft+XWEmxwyU1ur+fJnf3HjzZSkEsHnRfIODzzaMjhIbaDEcSF08xA0VL6do7Ie2V0Avz22j2innVEgSCSQwdYvzJeL3aR8dJDX+P0lZsBZSmdGoZ3GSHCOtC4si4GidfjlUOdkHEBFsVkGUukOBAaoj/Q+QpCJSbvUb6z02s30beD59YODOMJtN/RfbRYoIYwhYs31KzELWVWpYj85PTBV27oMbrI7GGe4Rk8Ejbpiw8jxAluR/WLW7dSdNlvm1Fsadsa2wXI8zs9Fmx2F9RwbfcKq59REf8cWGuYQqBXQ3kW/UNjJxYIkdsy6V1ocZVqWIVG7H+c1s5R5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(316002)(36756003)(38100700002)(186003)(38070700005)(2906002)(122000001)(110136005)(66946007)(8676002)(4326008)(6512007)(66476007)(64756008)(66556008)(4744005)(44832011)(26005)(76116006)(6506007)(5660300002)(508600001)(86362001)(8936002)(71200400001)(1076003)(83380400001)(6486002)(91956017)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VufLW5DpNnD4qBIO5QXZstB5gR5f0+SckTleA4j7tGvBd3FWyF45jUd/od?=
 =?iso-8859-1?Q?YF28QqC8KAC2EJFmlKzY84C+mJQ8mXx7t9lpDCpWEqLVtXKhXOw/8WJEG+?=
 =?iso-8859-1?Q?IOp+nAVpbaFn3JcQden810otdQxuHhEwmSwuZ7RDywnTu531x1QPrAxx4m?=
 =?iso-8859-1?Q?uidCJJ3q19xinQlB4OLMbD20wJ86ozJfZ2qLXEFfMUX6AJ64ZpsiqbRX2J?=
 =?iso-8859-1?Q?IK0iWvbxelu+y0EZULedtqSLs+z/I+kVnjeyVjf/rPQM0RGDMWjcctNLlf?=
 =?iso-8859-1?Q?siP1p0B4ID+obMYAwBsdBci3VS4xomLlOdLxqBE/+O5N0lSomGy40MVdx+?=
 =?iso-8859-1?Q?D1Q9oCouAuUbT0WaHIASvGjibaOL9Ov6r53nmvk+52XCW0SIqBJhOwxT4a?=
 =?iso-8859-1?Q?nMMKMlPQH3NJ7lofUY7ey7JOPyEyDbMX9NDfCHl7igPRAs0bAxTTZH7Rf+?=
 =?iso-8859-1?Q?cXw3jkEmU///saeZMvS+VdtZcjXLkEGyHs7BxSEnCrcRP2VclnQfq/1PBJ?=
 =?iso-8859-1?Q?vFzDinA+LXxSP/0p7bx4H/UPhn4txaRsRD2ODleYnL17ZyCmbVoppT+rZa?=
 =?iso-8859-1?Q?uHihaq1njzxIBQ04DH5asqHU7TslFPNwU7lxzLIftoyaHN/Bakuyfw9wwc?=
 =?iso-8859-1?Q?aGoP4+K31UxRrTOmFSj945bnsg12bOaS3jTzbLU2Gv7JhibIeDMeCuNUqp?=
 =?iso-8859-1?Q?sSy70e9DboorV5KGSTZCWP3wN7eg5V9h3cQULbkLKA809fVTzRX5c4lvI1?=
 =?iso-8859-1?Q?8CEGR3nSxHRnF9hDA18RS4AMF2XpRuqe7tNvNNyGHWPDuNiRwBwlsXQLSM?=
 =?iso-8859-1?Q?P9tuhumMzaG5f05AtMlARTS8IhZ0cAElLh8b7vUZJvUYqiHHCRIqOFLhZw?=
 =?iso-8859-1?Q?lc1sAUgfLBghO0RQ0J6cmBvhn/1KzbUtGcK3zftV7jd1x8N6RhTf59hrrD?=
 =?iso-8859-1?Q?FzVqeAkNwbf7Fs7MMHNw9uvrZhtgWpXIh6XtYeE377UvXdIXyLkYj/+alr?=
 =?iso-8859-1?Q?NnWyUo89pGFPLxsxGq8qOvp9urUngN6jaiQq0nY+45t/4MeLyh4UeGoqg+?=
 =?iso-8859-1?Q?CLrjZD7rmFT5QinseGEz+yQNy0UnZ0MSeWWzVZsbsH3sCacqA7ymjtEjCv?=
 =?iso-8859-1?Q?WZqa2fFSjdjsl8T5ey9C9rvyEpftNem4nKoseMQMiiKrgvvctsgveu+FXz?=
 =?iso-8859-1?Q?u8P93WoFTR7xB5xHj1sopzW337y+yh8UPbIptQXmWKIpVvIY0tUPZ3yIfG?=
 =?iso-8859-1?Q?9k2rgAJqbAqmvgLAC+L3ooff0JWq0qWmdDkCLJGJhhviilYoRUzsiEIYcQ?=
 =?iso-8859-1?Q?b3JcGJYaluQT47bz1H4NE/Z4DbEC+w2rnt3wX99rxQIkaNvOHIKfvsrKGA?=
 =?iso-8859-1?Q?XDTCej9cO8Fvxpzy3U2WKu2Y/yNFRhGozREHKYHdmQs0aVLv3y46rinLgQ?=
 =?iso-8859-1?Q?RlSMGwWIsfiR0/S4Jt+Lgf4Oqss8T62UTFhozi7r+Q0kev6gvJmxPSCvDw?=
 =?iso-8859-1?Q?qRsNU+gtleTl/aQQ6s+QMV6JembRH/2jmZpMPB++nvAXwe+p5tBSSuZuum?=
 =?iso-8859-1?Q?A4laThkPzWZQuz0mG8KiaW8RwZvKk4GliDeiqjif4V/QNlW/bkRgXkXaaz?=
 =?iso-8859-1?Q?+W3IgTP1D0v9ObDhOcfy+kY75bCxhrH6MlfdHvB5XuWhatX84KVQKQYG0Z?=
 =?iso-8859-1?Q?DvdrpIsz2S8lZfKROp5I7i1Tv0fNqmHG3J2DQqKdG957GfkDhqYG2sQYPb?=
 =?iso-8859-1?Q?1wgydX/A8ao2sygl/Bx/bvJbv796piuxzFgcKX/FZkvHUWS+SLTsujrwIX?=
 =?iso-8859-1?Q?S0Qkva8Jw0RHC5W1hYOSpk+O+Wzwyo8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe8a190-d23d-4656-a2ee-08da34eb16d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 14:15:53.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ox20WqC8zSfIx96XqzYDBQ+RYHgo/3GH/iBcE5gtnllM8qhOVpKu1E/jbR5a6ZKFroqLD4zcdsuYrZOCqQKSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_04:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130061
X-Proofpoint-GUID: a7tKo0PCJW0bsSiQpzfa8_0rcfkamqhq
X-Proofpoint-ORIG-GUID: a7tKo0PCJW0bsSiQpzfa8_0rcfkamqhq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a leak when the system is low on resources and fails to
allocate enough memory to complete the munmap task.  Fix this by adding
the necessary free operations in the unwinding.

Fixes: a760774e7b7b (mm: start tracking VMAs with maple tree)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ebfd71a79814..9d41df730b22 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2365,7 +2365,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		return -ENOMEM;
=20
 	if (mas_preallocate(&mas_detach, vma, GFP_KERNEL))
-		return -ENOMEM;
+		goto detach_alloc_fail;
=20
 	mas->last =3D end - 1;
 	/*
@@ -2504,6 +2504,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
+	mas_destroy(&mas_detach);
+detach_alloc_fail:
 	mas_destroy(mas);
 	return error;
 }
--=20
2.35.1
