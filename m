Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C965101A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352004AbiDZPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351946AbiDZPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F215CEC0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSuT4018608;
        Tue, 26 Apr 2022 15:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IKDwYKLhqDqopKz53LaL0+KebzKU6JMKe1Z8OdOpelY=;
 b=JY5ZdJ7NJabaNaX0eU7y/TB/yr6Y44HhE+YxD2lh4HHz0RpTzQRGi6prPsWDABsqljBJ
 Z/xqmfanrR5nmp7Xa5eXqDexMh1HDmpV/QSw+hDwjoLpi0ELARBEl7+oZSbgz22yPjEg
 VKydeoMlj8ki+s4XgCdbFlHP/qNwZt0voI740vdUWk+asD5nCI1egK91K9p+Jggljn7E
 BPQNP1jNydsz8eMHrOhKmLHmwhAom6bDFnezbvyeSqV6G9yXTimAVGo8GoIFG9r5EAag
 tZGisVXHYGqxhOvPIGwuWemIcg4W+WYoladeHhSPGLmatYdhV8XCv1quoD3GkF0JmYts iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxemf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Ik012558;
        Tue, 26 Apr 2022 15:08:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gsed-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSHzjXeW3GbNCtoghO5NUsxFMxgWxTJ2KI/f19KDc2b9mrfJEnfjbpZ+HgzKhJ0B7rKuE0UNIJ+aNJgOMbb54mR1lx1hdti7pGAqGl/PQB7BP9ujVtD6JEDxVauNk7Z5eE8HWXTDa2Mc3CK5TG99q/j3cMt8cF7YhOR56xuNqtegfrKjnX7XFpMLPOR/jwlnuntUhWph00YuQnN6koycoFy5cDXTRy8W4LNEA0xHQ4XpqJDYyQRAaHWzB8y/rQlDBs1MaF8jQ34L9VBa8uQ1gVcaBln4JvJMLaISPl9W5ZMNYZMkgCK+ZDVLWHmXjHd+mGsB4QSfNb5eASFEOPlXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKDwYKLhqDqopKz53LaL0+KebzKU6JMKe1Z8OdOpelY=;
 b=fAE7Rhl0f7Ovw/rxEKJpjXW4acQDDibafNSUXX255BkMugqtIoayg8i+7CK2HpCr3fth1qJCCcxMWgGrXOieMZdGJA89kEDJQzXcY5Usak/mJpPCpkoOTqYogfnqv9TMNqvOHq8ME6YLbgAfnzDmv80DKXmIARkWeXZVCD8p7P2WTVopg8+yM/cEA+v30FpaWw1Qm7HVizPTtC3sxMj5V9z988dAJqjOp8O6jbn7kHDCV0yqanAG/LaYdSDi+Y4oFETU2aGdC9SuUV0qlMBDrYwIzajvssU2GTOph9H+OZp6I3+HOk1m3xf0NwugOUshZIcvWa967Wfg0eIKmeJWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKDwYKLhqDqopKz53LaL0+KebzKU6JMKe1Z8OdOpelY=;
 b=wtrxBlOuQK0K7lEyHcwhAWsQvgVETwFsGrGKYxq+IdnF5z/Xo/QB5dXJ0+3HbeTamuasGs7/HynsWQQho6Xx0U/U3scwcVYVl6hqtEdYqkjQ3ZEtzN8dFDoFqkFUjJIFquwaf0RqhBXQ+xIlG1j+qaeFa5FTSwtNBL+I9RXaQvw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:08:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 62/70] mm/oom_kill: use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v8 62/70] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYWX9BAyF+seGB5UurYsBuJ0LdaA==
Date:   Tue, 26 Apr 2022 15:06:51 +0000
Message-ID: <20220426150616.3937571-63-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ba173fc-2cb1-455d-1fde-08da279690c0
x-ms-traffictypediagnostic: DS7PR10MB4925:EE_
x-microsoft-antispam-prvs: <DS7PR10MB49259C004552277FADE65CF6FDFB9@DS7PR10MB4925.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjH2D5kidGZJDVWA4Ms6QNelUJujEPycoo8rqdooyieGBDdcAwzU/HJzGYocZNTf57gGg9gNBS9Bssm+yM5TbquZWpuWQGSCWrASYCMvRCbbf5o11oh0iuX4af5pWqjzkniKCFG3q1F5cX2lexDOBjMOIjOsYoE7UHPsD+H493GLhBEk+d99kf4Sj1KdBOF+tEyZQtdGyubmRbplm3E061gBIV2Ugc4fhyhnBpsvswJL7nALV+aLLIWi/07278bGdNVTFO05K07POtyLyM5qxOtEcglWEj2OKf58Gj0/bicika0L9XJw5hol3dxwH1Tz6NGRvdf4nSOcXpMFP8yaRu3Vmh65wUuj2rfokA1Ulf41HnmR4fn3UCy6dLk+AjkViSkgD2Tl6U232yXNBs6ce2uhMOTDBNZMYhEucwomM3+EFuBskl8XCA8/5K9hPG2jZdGoxgCoT15BDiwhgMnoN6LnI7FG3uDFGpBR2+Cy7vJtPb90bV9MAQbhc9NLOQx8hWeBTX5dXXC48JO7p0fwVZCwxUayIVt4cgvZBDxKytz/fCBJMFbwPu+S2ThOBxdhOnwQT8FzmtzpZdMmZaOSfZJPLgoxME0+C1WGZ7QLZsYI2nJdfwQ2WzJqYKvSVz1lG9zlt+B4iXutIht0uLPjGccynZMr5UFPySeDL6tZUa5PBhTkMziacycEZdwJExuwrZvnT0NQ+U9DY8ZUlA9Jww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(316002)(66556008)(508600001)(38070700005)(86362001)(8676002)(2616005)(6512007)(110136005)(71200400001)(76116006)(91956017)(66946007)(122000001)(6666004)(26005)(5660300002)(8936002)(6506007)(36756003)(83380400001)(4744005)(1076003)(2906002)(44832011)(186003)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?szXA4WISaVWqMQvzOkXHPZMMfQFBQmwsJZxRhRIEZF1YK2wSCzAWALq6qc?=
 =?iso-8859-1?Q?m0dktXl23vNW7kdB9mH2UmllN7RP0LVAGNsxapUsZSYepUIZlhrbRiUy+S?=
 =?iso-8859-1?Q?JTT+xBi+9EFKNzhVVDFz/v6MWyMkRX1wKILvpZL5v5VbQ4QvQ87oZA/Fdk?=
 =?iso-8859-1?Q?N26TQdyLA9EayUSVzqsruR1LDdWI1AyI9LZJaVQmUZ9s43MHkILuxbksWJ?=
 =?iso-8859-1?Q?lUQUjhoY7ae56+xVidbrfnkXKQBeSl55MWYOD4FFVFAZTwGCQpYuo6NuhG?=
 =?iso-8859-1?Q?P0/JE1cbOpIgI4BjPgyl8eFVin6/MSxVe4LPz4VJofmBipOTzaxWWZHXZ1?=
 =?iso-8859-1?Q?Aq1w1j16aB+lOyu8kRBSHD0U9fH7cejyEV6PXmHXAGkwRs708q0LbtxlBG?=
 =?iso-8859-1?Q?Gfn9xQ33L78Ccl3wkuUxBKZRCPRQryebYJ1GrgCL78ysI1cve9NXmz0jO3?=
 =?iso-8859-1?Q?4BwwN1tyCVWZM6BukIwYkWjSPeU4ZUFttPhN4mf9S1/67bGkNHB8sCTynZ?=
 =?iso-8859-1?Q?Ea0ma/VXnBnhswdVQhuV3yuJxLXQTAfw3uXALi4UjA5ONNcmsvGwYZlxRJ?=
 =?iso-8859-1?Q?YTV0pVR8ryr5JKciHTI78aymstbtMN0GT59mHx2s7/YzfGJ6x7PyCMLB0B?=
 =?iso-8859-1?Q?Q85H6oAT8haZ0n3rSIbX7RRTIkvtungqQ3/hNxDWW+ubfGNOfv/eD1Bar9?=
 =?iso-8859-1?Q?v6A3ZEIsYFZ5UfO0HyGTlhJ39oeqC8unukONnzyttytahx5o2XodPfF95z?=
 =?iso-8859-1?Q?XA5BTaumbwwjac4zh03Oc2+82jMCkRghEKC3MHyLqi7tYZQulTIH47MftT?=
 =?iso-8859-1?Q?R27LbDvfE+AuTDVwONrcyeObLGjwtpzXCXkmp69MHOpLbekIZCWcPKglJZ?=
 =?iso-8859-1?Q?SaMxgodgIyjJovsLqP/Bavl+GoaXiw3JX9cZAbtp9DigsjZf4vDm9bBcOh?=
 =?iso-8859-1?Q?zvjS8K8o7Ctjglwt4KsKF5uaWXhZAAAMTHg0nbLzmRtH/CPXaZcag7oEDz?=
 =?iso-8859-1?Q?pjzuvy5kG3DJKV2NJNIhb90BFxGOuGk7zr19HML5CxH4y6iXhVBMSShyNG?=
 =?iso-8859-1?Q?HXdIClX5W2/B9QfZMzfVlN+34WEdoVmu/y2s6+1wbcJIFRbCAJQPA3b6ab?=
 =?iso-8859-1?Q?A5NXNxpfLzfjMHrGBglnUygOUcRKehKXLRe4hf15moB3wMxCQVAbEiwsWZ?=
 =?iso-8859-1?Q?FTaUcizTS91lArhPcpQB7yvstY4Dv1/HaKroLAMcjy/wHM35vJGLN5LcRl?=
 =?iso-8859-1?Q?y1nLTP/s0U2pXApbCBcCdCcRm7kSw66AV6RMklyqk2jl1fdYmkQZYbdVfA?=
 =?iso-8859-1?Q?Y2vBcEGPkP2wRVOGF0ABn8NPBeEVwBILzfkRM00CgqV3Rz+xJp8rzyGEY2?=
 =?iso-8859-1?Q?RU763tFp3G5SfzySksByEKRNNEMyzJG3SQOmicFbNXOPzv0A7T9fNPMWVj?=
 =?iso-8859-1?Q?R7QfGIohkBM7YzEalvko6YZias26Fk5pswFKAEC+KOaIyu8entygaGK1t4?=
 =?iso-8859-1?Q?9g8XgIweM91JKS6ps2mQfR2kl7M4AfkEDYwsG4t4K6Wyc6K1Vk3z2N38Dg?=
 =?iso-8859-1?Q?orwFb3UEGyB55r47JHftcSk9z2fVmppiYPGchoZR3701JdYXNICAePDrdL?=
 =?iso-8859-1?Q?T+VoHioF0sbQd4i7YITZVDTsOG47kZqehkZiv8TEAfZc3/JBVToEYiMl/B?=
 =?iso-8859-1?Q?eIWDZFUuYuLCgExeYqrfqIQtA2iZD7weMr1YyYmq5I2vXGpYDhulj5q8XW?=
 =?iso-8859-1?Q?3491VYz6hWQiHwr88dqacD6kMokZETd9hrRZT9JCd4Ssev2sZA8s3968I1?=
 =?iso-8859-1?Q?72b4sICi+JL2Fd+DW1QHQu1pHNnxX6s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba173fc-2cb1-455d-1fde-08da279690c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:51.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bIss/+jLiGjkM0HCJYV/2XzhcPB7/v2h3hu98V9T+BvO3IBJVF3/+SfPvo9gApZpDVVw7cg+KytjJsHnu4+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: U4zZWbcdqwPPXtl_C70kX11drsgvHKZv
X-Proofpoint-ORIG-GUID: U4zZWbcdqwPPXtl_C70kX11drsgvHKZv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 7ec38194f8e1..cc25bd430b68 100644
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
