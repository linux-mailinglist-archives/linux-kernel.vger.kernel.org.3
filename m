Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89D51016D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352227AbiDZPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352085AbiDZPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71C158FA4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStYC032115;
        Tue, 26 Apr 2022 15:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+UHCW8nFXeFjSUwDaJL/T85wPbd8q1FFGkops0wcf/w=;
 b=j9J8gYbCuW+KPKUZSp0S4ThH7dteDRyP4mk+njEtw0p5ZfP6LGm61g/zDd8tXNgfsjVw
 2bsv+Dm5np+3XsjyDuHV6FUdswvWBkqQjatgepC6uIy04X28S8k8e2E7uRxtTGSBJGad
 McZ2zOZpSvHQKzqmk4d3NQdotZZgMwL48eUEj0UwkqSx1MnFC15Dv2yXGmqWKcKAuITe
 Z8fadtnUTr2Q+lLOqhZKduj170CPnHGCgfBfHGbjbIsATA8CD69G+seWeEyDfrCtnQQ2
 onJAdIkI6LAWXMHElNqDURKJuQ0zjLgEGAu51xxs9hPHIpLBL7tsed29wlELp8ySB9Rx fA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx541-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Uo3037883;
        Tue, 26 Apr 2022 15:07:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkugm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6hvNJpCfws8hxK+aA1MyNrgN03/qDqohI1KFeS08V9wIcv+5wK/DdirKJZf8YULykO+FCPTxhY2/gIyvmtVuQ//AMDZmdmYGvJoWf7kvmthkTqbgGIs3VJf24msoeBoyQmkXINue3eBwcGgvRcniPDrcTZhJTn2dGtZaOm5ic29en6a6gUA+1ELvfrCICCENI8u2iRWRcvRhpj7AVr+Xv6PoFsIXm6rcBZ7KbIqAeQWBxXQqDgn4N04mHc4m26GCKWpCRmUn6Cv625u5Vb4WVU05iHT5pfYxcu8ibxKPbdRJ/QEQ6yrTxZFjRnuL4F2h5n0nOcu+T/lyiigpI0cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UHCW8nFXeFjSUwDaJL/T85wPbd8q1FFGkops0wcf/w=;
 b=dA+q+SNeNYG+Uk6UhpJ+aNqHJo9ih4qWHDSB9WilFJx5l3O84OZX87qPEb2dzOzpzCX7AEn5N7l+GmflrRGiwaAqC81CFS4V9dAa7AJAu/FGrAWFTIgSK2yRw3pbYZu7zjZxmpIJNeUQtt+DiYHhtKzDZWdIYdxbX012oumtq5+YowhcHxt9enl1r8bxeWRAm3NgCFOBWyxlh1gvW0wZeM+JmFUtjSiziEDij1pQ6Be8V3boAcEselrQyDq5UzcjWejq3uOLNRlGGebtiD+8NvuItEC27lzZ1hNk3JKnE6fFLYrZFw2/dq1oONb5XulyJ5K0PJnCzfeMMBrGhrQscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UHCW8nFXeFjSUwDaJL/T85wPbd8q1FFGkops0wcf/w=;
 b=CrrTnr09OA/nMwanCf4t1ahTV6wqwWIlL2+mwuWtnwLgZ9UrQJPSgcjgFefOUtiYPsewtGmAYfJPY9wNwN4ru62bNrS8WQBUeRew6N2zUK7khlFEtFGV3K2sLraPqFTUyUbU3Qzqmbllwsmu932vqyK26NL5CJ1yPcvKMmDsxTg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 39/70] optee: remove vma linked list walk
Thread-Topic: [PATCH v8 39/70] optee: remove vma linked list walk
Thread-Index: AQHYWX88AkFFE7snvUWnSOzIXJXYYA==
Date:   Tue, 26 Apr 2022 15:06:42 +0000
Message-ID: <20220426150616.3937571-40-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24494ca2-48f5-40ef-814a-08da279673bb
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB292986781FAEACC29C442A61FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H2xUiRBvz2JPg6r6B1K2HvUcXadl5gfjmGiAtjq6y6KajPwBeeCiF6NAWqXSg+Hyq0p3AO8TfFs8fydpgAFLtnOYOgDh8s1D+OqlmUSd/DkT5nV7YTc0m5GruwJ4j3FT1GuYqUbkDGJkPkHXO4z93H652VYesHBcXryoNtoWQ+IXaUzKF5jehEnidSzS0zOZMApf3OmrhdcV/BVRcUy5dcoxSmGqGJNUqaoZOd9d3ZtcRA3O0QnksNNEz5F0WHKaNSa2jiLY7i39Lu49XXDZlH6j/Ae8tkPbCH1tb8CWDCMDPdjm9oxHtKABJtfUdPqhO3968piQ0yNJMvTRoBDswqXuYcdr9+XBtufGnHfq0TaVTA2AVHS9o9uTiC3TwhBKGmPAqvYileUqq2QsUdLCQz/c8WqyvZHLeUY1EezNuLr4I1ufkjyJK6NiWW4v5XLK7IHV8f5MuJuJubXcr40nbFKOeZJeCLJWE/HgIYgMY5Ww6rMJaNtj8QHaicHcU9Wg5AuBR+KhZgJOs49tTKiQDGsbPbfACPxgB9Ix2CsAyVpfGnlUl6rlOPNyUIYGyViip95TN98qvizubM8d+itTRdGFotidn5nvVC+SlfxMntT6UvAXWRpFm+H5tjleeDAYHnyGxvmkz5CI+SjHv4ABgNjMB+2dz9ev2/CeqkEE9FmGiH5kdSx+9R3bTMMzXuoUdS3yYePcX8yArxI5ECJoHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?goOuZFUnCFeedgpjr9rOVAu43YXxza0P4Y8xo/tHICCJMoUQpi5X11Bcdf?=
 =?iso-8859-1?Q?JnoJU2o5RagZvbyLgFtSJKbjhDjzpvOsLwcbtqWu0fFg4pnqeSXjHCT7xT?=
 =?iso-8859-1?Q?+mzDg5n8cjsIlroel16NEVIfnJi8TV2mON3k9yF/HZtT5ZUW/ko2db1Dro?=
 =?iso-8859-1?Q?4rcTD8+ztVFcUK4cYnEctNQosFJdK6apvTYCg262BscgdeluokZGfMeqWx?=
 =?iso-8859-1?Q?hfvLYkRSy/MpE+BVpNeI8lAlTw/5fs6Xr+OGZLcD1nUtg9Lz+wtI1ax58g?=
 =?iso-8859-1?Q?XGJinMaYL5quLBD4yDmfvPxGgB4qrGEhcUd7qoiZ/ez4jogqb+SbIX9hFD?=
 =?iso-8859-1?Q?tyVfkTAscCYKqU5NchQQkkZe8n1J6LGGRWULze+LpVvIwSpb5XEjWs39IX?=
 =?iso-8859-1?Q?LBfYWlEcvtv/9/Sqnqlv6zr4IsI+rFfKTRkXLot2yYZumErvfUXZ840R66?=
 =?iso-8859-1?Q?uiJHZ6LVdaBAN5CSj7lccAQlcMXbeDv5Y/XnXnuG90Wvh0wyERapI41HBE?=
 =?iso-8859-1?Q?xsItX7AGl1BEAGE+p4e0jHKruQ/xAj1P0YTZ8LVaW8mL4mceInVOEI79Q8?=
 =?iso-8859-1?Q?JtfcbmutvTVdcB0VOW3ZBfj++m4gfArQp278oEl9p+/9KJL1L3I0JXqwXH?=
 =?iso-8859-1?Q?vkk0xjCq2lBSKYqGqsTCKL/663zwEMRNvQYZ3x9IrOMdd7SFCCa4unw7B7?=
 =?iso-8859-1?Q?Os2gRy1prMCJltwdT/mtoOG6ARIvFXXPlVBJQxJyy9zx8VlxVf1JMGwPuF?=
 =?iso-8859-1?Q?pECFPoM/6sX/hGC7y5vHQCNuo56OU1FTUa1S3+liQXQKlm9BnDE6qG1fDS?=
 =?iso-8859-1?Q?si8ta/hK+LqkfiabnxZi0swEZ52A1VY+5JYkBXq1+7T1aLfSpiNg/TXgUH?=
 =?iso-8859-1?Q?fuQY8I+91J8hEUIYskoyxfsMVBWLg2NSfHM/7FCBRblNfeBCSQUcMV5B5N?=
 =?iso-8859-1?Q?CWl2IxJdIubRISBPAXqEierxqM52qPo9mxy4jBSqIrspsm+Ht1gBd55bQI?=
 =?iso-8859-1?Q?Lv6KzmtXYiShQiQtchvJrUvuBur022EPdt9uP/JtpTIkYhrqoWIZiGrn3V?=
 =?iso-8859-1?Q?xpsb9i2sNeUDPkgNgPNJ6AnzkYH8lRpVA9ktf3dKdYqJK+AHJoI3BIwuqx?=
 =?iso-8859-1?Q?ezILn4xHDaY4KqasnwrJPiNAawyQ/VcvmHZB1+eK3EtqD5hsy1dQv1xfzR?=
 =?iso-8859-1?Q?YpeOeUtNzWauC61fx03qDEbaeVlZ6wox6Bg+QAcyeB0Xj+KIgbGW9VoIjp?=
 =?iso-8859-1?Q?Hu3MuA/OBfrA7kHE063n4rvceKP99anp4QTXE2mUs+gU4OvEBkybcEwm0T?=
 =?iso-8859-1?Q?rfEeDzMcUoFmRwSlozQPvEJkaaNrkTZ4/6S2Ej643vC+TIbya9QRq5J/pi?=
 =?iso-8859-1?Q?aFu8+m8U8wPUfKCEeitKfz+1Kio32Vzy7s+BuDCdz16wWMWUGGu8KUKS7Y?=
 =?iso-8859-1?Q?sx2UvOkWOAkPq9G56Jo0bHzKtmcuZXAOq5ubxQTq7ZC9B2rz57mTvqT6Nm?=
 =?iso-8859-1?Q?jMth3tNmXupiPRMqD7SESTHoFPkjSUAsb08VU8gQOh/L91tn+aOm7kmWSR?=
 =?iso-8859-1?Q?kmjsfl+r7YFxWVJ9P8aF3bCZnqh4dQLBv1EZIzDlBw5CACx5D3RNwd5sA3?=
 =?iso-8859-1?Q?HTFyzW4KT/qUQTV0P81lSDxEmUSOPT+CU3ljuYqyAlqQ5kuVPCI0kmcnEP?=
 =?iso-8859-1?Q?PmEIlxlRGhmA9ZI548VaOvCgPAlpzMCjb7Ic6u1dDoiFP/LMxbAmvrM2Ee?=
 =?iso-8859-1?Q?nhf9reO53psP7c22UsZLaYgY+3r6sPGBQYfuo4wXOS+Kqa7QitlQezG+p+?=
 =?iso-8859-1?Q?rMAOrLcG+aorccmv9oaet5V1UWlKHdk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24494ca2-48f5-40ef-814a-08da279673bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:42.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egFqbe3QgLclqMcbWd2gCFRgljhCZenu66kWnRVrHoxliMWpLlsCs7Nol3S95brqpRkmfYiY9W7y062ZLZT2rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: hmSbcVcIBYS0PLAY75WgxBDZeLLKc47H
X-Proofpoint-GUID: hmSbcVcIBYS0PLAY75WgxBDZeLLKc47H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..d8115dcae6e7 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.35.1
