Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81868519346
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbiEDBVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245387AbiEDBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BECC44744
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjZ6R013502;
        Wed, 4 May 2022 01:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Psb13NSHR3XJBjyprPpY1a5JdAq76a4SZ3cWVRlHxNQ=;
 b=Kd/7m7oR7lMmuXd4k5DySIEI5ua+S/nmdXcGSORTQxCE6WnPq7Y63obHq7C4u4ZqjhFO
 xmErSRjY8CfzrnVRAA/Oaln8IHZrikElbKIEs0wmL6J6/KG8YSDIspeNypBVKv8vnO4V
 jBzfyuV5OGgTRxdiIgvlnPW6AJUvQPSeQtDkNPYz+p/OdOgFwz/uTAm2t3+bfTToKzpK
 RX7moRjVutkBum2DOfCitCWBjE8CSbe/zRL/0wnPnEqO2UIpf+VvmesZB+z+gmOYsmWt
 wmUfa9W7ysPNmEqWo/gIY6nvuSIUGG+hyfR9SX9t6nKmZf2/Zlyt0FWXy7Uk+7GoWdcU XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BJT2001264;
        Wed, 4 May 2022 01:14:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a57vyf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCfgECjAQt2LmODS35dFcH365jphjgWK26h86jwWqfQn5tJufMaxyy6hxz5hiUE1n8Erb+GGzwROc8DH2+lXjf+sopgh186se/TURs2MqzVG0YI+3J6yEU3+YlOJe1RkFyr3j6+3a5YvCrtEyTjcrvrdxqn1x85qd05RDbzu1t9DkEo+reAaBV2VwizXMfEhv+d0wrldt8C413Fmb5uJh1RjHWMTB8yadW7beoyoaxuzykY7kMp/KiiMv9GziXZkAfoKoAU6D5NqTBr+YIXCQnU6+IfE0h+oW6M2xeI9PFMw+Ua7F9I7rf8pOHPr3YJB6DXJ75qdSokgZzzpprOu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psb13NSHR3XJBjyprPpY1a5JdAq76a4SZ3cWVRlHxNQ=;
 b=CEnoqgyvQJnAV0bwPCnF+bVzWGTvu2OoMJRHRK/dyLGdOhzHHiXFteJg/69Lh07L9yu8gcICmAWtJmni7rCnpP7zeDoxlkuGdwHwXNlPX5rVqkuiT+TzAd/+Lnu8UA1iC/abqAdzSU7PS4MzNgkGRfhybk5/8RAAdJGSksE20VnMdIvg/SZHoP3XL1+C1lAMmdXhfLV8rXmOlzyrn63ToAnqOiaFYvKNbGiaGG9VfivWtmOJYYQ9o6JJ44cVxaHn0iUmWoqt/2JPgham6YlXh5yUz8Zhiv0PJ90FJEnLbaCo698vTGCdwOhk70abYGR1gHhkq8oce8pynLLhm+xi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psb13NSHR3XJBjyprPpY1a5JdAq76a4SZ3cWVRlHxNQ=;
 b=DARrR8aTiLISYFdMc8wUPexrEztHq4zJnie3d0zROsIkucW3BfB1KHLxZ4zYM8Mchgsbdqg3NMpINbs3/DxHrGeyeJ6X6KJRquV0d1DQVdk7ffTlcJu3R0UQQLRFWrNyPCBtANjEEcM03kFU4zDt07FYMOw8YIckkeAXTNScZn4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 61/69] mm/oom_kill: use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v9 61/69] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYX1Q/fkFTmB4MzEeZpNqQbDFgHg==
Date:   Wed, 4 May 2022 01:14:05 +0000
Message-ID: <20220504011345.662299-46-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97959f6d-b8fd-48ef-0e4a-08da2d6b76ca
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688300A8131079AB4EF40D1FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4BepKKPJUMAGNLCXwQ3TU9bqw+ksvS+bE+BcdBf4bKoNOujCXMIH9jkJZLgQKge7tOUx7dmwiAFem9lkN8jl/18taEwJ5CNGnkENMNZOb5Q0dgurU6lGgACcPAHS58NbzVem32lfKqt9drRIcTSnLlGMMiuYmT9xnUZZku6gGNr2rtJSupnDtxkzKXBwdgWvB37HT7rXs9yRnjHpf54Nubxles/ObXJCpIWGWps1+q+H3994GhKBm5Ckhz0Xltz2mTwHG8fRLnjoiIAXkdYgRi+tsb+QMMdBid46j+68S5HzVP5FYxNL38+Kr2ib3HYZuSo0ckGcdFdLqK2IO1dipqqa7PmoIPpkwblUju3qPY9rUwCG6VRBfYe9iFQQuneg+E+tGtVauRRxi3fYsK+ZHAXqkOSmlUNqGjkMqYjUM37XImpc+7fG7SjvNoA1iM6+SMnJI3CxofG8x1XQK6JHncVJqe5imIU0onrvehWpGdcqjYOMJOT8e5qfiJkDMtNEEC4uNq7FY+RdKF65GW/RNXQkYjE3caVBb+vWlMskCvAbt2qPgz3e81D0NYY3K8cioksF6AGs1vcQ3wMutGAKWXRE4+6gbY1vGqOXx9KFphIMKs6ToKbdxZ6eQlT8d2HtlFNEXqZiUSRfCHz6sLTPLGZISK6saF5dTRf2emu8I7fF/vpulU5Te7gmDZ/ZxZ8gpNf4Ece5tP7uMSh7R+07g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BQOIpa1pYn0r4pkwbek1OvwK3VsgF0o7CW8//PqWd4Kswt0ghCWtGQcfF1?=
 =?iso-8859-1?Q?yleTdkflUAWkVIga+ObCHORy0M5ad6pOCrAzEjW907Ub9sBRXxyTmSmwMY?=
 =?iso-8859-1?Q?YrU9bC+Yz6REOnKAbeFAm63bFX8HCIrNZEj/kFJrpDlI4Mk5W2RKFeSk3R?=
 =?iso-8859-1?Q?2Ccb00iiNu2UwfagfqQfMtlojXv5ttoiq9fBy0NoDskMx80RY+e2m5yArl?=
 =?iso-8859-1?Q?wr30pkxBzp3nV898lFy99GdsioZAIWav3O/fQy+2sv49MOiCXeXGoE+2jo?=
 =?iso-8859-1?Q?3nBzVbujUhwFuBM7QtAp9WwC78s4+Ukq6grkxgURdwcp5TCBNUWPXZVBJ9?=
 =?iso-8859-1?Q?71EEAmDRlQ7moUhSmcmzkcxCSnMD/bEJ+n0NqdqR6YYgZXNMPx/W+ILk8k?=
 =?iso-8859-1?Q?iMaQgjIuz+mx06cB1yelsmNqW/w0e9ZD9qK0cOyLonBlI2xXlVvHjOvpia?=
 =?iso-8859-1?Q?Y2Edl1FKojIlDpuk+r5kXdTmY25I8BJK9ed6sB+mDWvZz+ITTVfAxiAspi?=
 =?iso-8859-1?Q?hnS5O2t1rUrU3slvxm0TX7lEWrlYM+vxcjPjxW/BWBdbISOMw3IKM3gMR3?=
 =?iso-8859-1?Q?ORN6UPpTC5wxR0IxW/b5Ua0kwYKMflOY8HMQu48334Upz4HxBvRITqKIss?=
 =?iso-8859-1?Q?wQ7tIoolHZ7i7j1Vo015zxITZRinfPcrSDE0/lRuW5+HVx3c6m8oA4cCB1?=
 =?iso-8859-1?Q?wdNFRBmFUnGDokygD1sDL1HK/VKmAGWIk+Ss9z7DcO2XZNQz9ktGkr0qWx?=
 =?iso-8859-1?Q?eJG9gYrZ6Kf1T6dBsiplSliHW/+s0yDDUkVUSx4K9AjJN2zdQ2IE1xZiNQ?=
 =?iso-8859-1?Q?+iYzw0V7ZiuFglNVhX/kejJOsj8oH9D9oZdI84nYSNUJiUoYcWgALm8UiU?=
 =?iso-8859-1?Q?lL/cpW/ED8nmygsFGgce4IJaLZVYV60d9VfRTDDTDlqLQA33LHI9X07MRc?=
 =?iso-8859-1?Q?7PufA2WRKs9kTS4EPesh02XW3sut/bqNKToX9xY417TXfo2AkDSTPhPymn?=
 =?iso-8859-1?Q?NaCwxCU9SFPntmHOB0A0gbv/6YphYelocAjktXlW6a3wA/K/z3B/NqATIe?=
 =?iso-8859-1?Q?Yaztsj5R5dhTYXcE6uNeb8Rcp2+HkH3XiUx+rwN7ev21RDwzCXuGKViPHM?=
 =?iso-8859-1?Q?M6zA+3vE0M/arJxjJuhu4ioVfniHVw3GAFg0tKA4+w2JKX7FTK22UDIZTH?=
 =?iso-8859-1?Q?RjwlMpAjfLrms4UDC/ULNI0lDRNtla5rK/qciro46+T/ffCT4ZRvk540VF?=
 =?iso-8859-1?Q?/mGwLDOhVZXBKSu873q0BVtvGz5e4VfPe4Z13WDfhnrO//AmF3g3PHDq6T?=
 =?iso-8859-1?Q?7KfuwcVkDr3lMYY7CUBm77/MWpZEBIsxKtgz5q6ZwSubQe3N4bd8eVGcZa?=
 =?iso-8859-1?Q?kkKByZYClDc9GuMN4fiMnAmm+7zskET2GsB5zBC7565liUpAQVF6kedF9p?=
 =?iso-8859-1?Q?PmqrphbV5cPdOjwEFG+66NhPAuGU/gbrO1Fhyt/lRNi9uenSPVV+R7K5MR?=
 =?iso-8859-1?Q?FFReDBowat9JGHFvvZFMHpDXZAspKxXbiuXhPRo442/f/qOZtoI+n7dBht?=
 =?iso-8859-1?Q?aXhTLk59qTKA3m3EjBFSmfszqiCCMpy5gTceyuyzX963p1QpPrnferrTLp?=
 =?iso-8859-1?Q?B6CJYLESvPU825KqCqAElyI+BfGfKaWk/oQePXWcvbzr0HR+ar9Ge/N7py?=
 =?iso-8859-1?Q?aU+8eXCR/PFi5zVO3MiJuNaxTGJrFfNfJYHzjGQOSuqcUGtZkXjTtRvZvv?=
 =?iso-8859-1?Q?ashpeeZD5WMthqMRLVQnmHtC5St0JpTrolOmokW+1c9AJ+JIcKPrLcA+1K?=
 =?iso-8859-1?Q?T9r1OyMDxz71PuxpWVXKQAu3V43bosU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97959f6d-b8fd-48ef-0e4a-08da2d6b76ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:05.3917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vPH2V4AUIslObJcAVsYWZxypSvDtMULUNHx3BAhQi2R0jILk+6NQV1q838L928V7HGcbpZx503/4mj29JWTew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: pttukGNMKE0x0yzp5wwQ7wJl90a99DNi
X-Proofpoint-ORIG-GUID: pttukGNMKE0x0yzp5wwQ7wJl90a99DNi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 49d7df39b02d..f3adad57f47f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.35.1
