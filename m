Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1815A5101A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352345AbiDZPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351977AbiDZPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7815571F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSw9d032176;
        Tue, 26 Apr 2022 15:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ihi8oZmLvAwBhDvarGdeZrQeRljXT08w9qr+aSJloxw=;
 b=JKVxug8iE2baMc1BJ32rYWP9pZMDzVkJAh/qUdD7KexWnks0F7tRfa5q+xXziN4Nqy8R
 Y+87CF4t6ZNgXaGMLs2xo2E7AqvaAvYY8u6qkV+Nfb4YzRHDs51WU0rpmdAykwC8Qy8u
 yn/K2yIP0D+KDF3cz7kfivL+fUFVDyzh4LjwTU42Ik/ByfJRj0QtBfeT4Okahjy8b1FG
 c95i4gIzhrVKrwq+L2sdiM/GSl64qCJlB3t/LbPcDXnX5dJWU5aqghiCigPCs7jwuuYn
 cjyRvjgqmmaqKeHJKqqGNeMhDCZYtXCycVBcX1mvdrS9AagIhKbPYtGFVUgeV03La+Te Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx4yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urq037859;
        Tue, 26 Apr 2022 15:06:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN+4n8u2v1nffqXhWF/SHCb5hRm4SSEoC5lToI8tGCCZc/QI7hGPet+2HBiaNlZxmc3T/xNe8EqenQtTArSnWhZJ48HF0lyFb9lbrS/OIeCsQrp7z5o/Ul2Wmq2/VHr1hW8zNhoc3xKWTDb919SXzCx4u4kk7RcyNLis3dUpGvDotDR+TlVFPy+zt2stbWIGetLPd/U4hTmrgNjE1lojnHawutb1oimFKmRypvmM50FlvFauRLPIH7rHnAvVICPti8Tvax+VaRmLiGVIbBXptznkHAF3YoCN9gnKMoW7wUhMK4UdRU+O407QWfdqGrdZ/0zOU+DlZL7X4LwhHuyRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihi8oZmLvAwBhDvarGdeZrQeRljXT08w9qr+aSJloxw=;
 b=Ika5rpikP8eOXDrOZQ6Ia9vC2lzjlkZHAVX6sx3FEBAxRdXslNQwMRFzIHgUekkZ/sFKWof7Rv1UJL3aVo79Wkj2toxgrT6CCBjviTM1PC7qVumQeUKNCGp3MFdCGsnJJuDW/ht2mTE9vwQiHdKcSRTTsDKQvB4EHuQQeZmuRdVWbU6Wjfav2ZPjoUzw3LLHLP3JjsyrP5bwZXjcYNT9u8Q8uIDC6tg10XRYm0EB7dg3ROX/nM0kf6fN38iyS0Rwlmx7hY3gixB94q1yJLUOYrnkERI554FuwNoOtucPsCiQMDd+euCt5rOEC1/mFahw87zgvrsMY4dclZAlolGqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihi8oZmLvAwBhDvarGdeZrQeRljXT08w9qr+aSJloxw=;
 b=U9shvdGxii2cvUdIZ2W74A2+SxC28qkJ7H4HwUMFR+6Pab1cKR0h7vk6zCPWsk6xaUdCpJWR+UqQW+/V1pJV4i1XBp3ibJohL8m4qkGU53BqpjrPyW1eYpZuV5qNnKL+Z6A62C7nZrNJor2uB6PSdk3hV2r5LpCmD7DnMsQddpo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 13/70] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v8 13/70] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHYWX82NCdM7wcHFEKiS3fxR4IIdA==
Date:   Tue, 26 Apr 2022 15:06:31 +0000
Message-ID: <20220426150616.3937571-14-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3aaed32-d79c-46e4-1b9e-08da27965944
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679ECC6E8CE929F45523D1AFDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WT3kvB1mrMtKDyPafvpYjQpZ2KZIJ1Ry6nDTJsThZVl3j4DL1Lc4LvHDozOoCAvXxz3W2Gy7gkN/NZ1Ti2eJlqqlyDaszpqJouBkg5V54NUTVfsw8GI9hJrLb4oBBZ9pnCkyyBE3hXYEPYJP8YZirK65oi9+N9mzYUEpMso9advtcuXhW+/Dhj5QYBb/L8mgXztfbLHlaGB0CqKwwEEEjTasCXaNiF9D8I8hQ9vjgmvnp9QgR/8yxGz5MpNHJcNqR6qTEYbh9Pi46791X73W70qe45+0ughDmGEWZ1/5k/kJlU2H9ElxZIqs1ss6bQgb31qzZGVW4uylYzZQ7FSBw75hbxA96QQofVFmuebIc/UHkLEH1eujnT8N9GmvEUcm63zZY5xeaVdhh0VeiCPGTe4GX5obe2TCUS6QLQKCewo0sgSBxcnT7bhFsY+EU+xHH3RmW9IJgA0D2N+lovZWWoAdH+pDkkcxxHz+MTlnq1wugqNAKWjgWhoagXbLuIUqXCIYd0R+Qp60LDHaeJqOmwHePF9PZ5h3Em3VLIEsYQM9Xt1H6HWh71q9VcEa0p5IxMyVEk2TuwHlLBy94JrYDOERc/0rzFyfREWVLssbQWrWHP2fMGQWxTy4MhYBEo7FWaNQATL1WojYd7irPZMYqTgDGvAmrO0cqNqTXdcoc+ySIwU070Y6IvsSgVTtS7IscC2o4Ej54i/Cfie2twK6ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wFDNpztbsSYePfrtg9dsteKP4bUD5hDE0jp2tFmVN6XbQDQgvxFvx4q6UL?=
 =?iso-8859-1?Q?Zc29XBB6NT4S5RqA+iqlCnTXrNtG9+HVf0vjk/vcSLfVOq9M7B3LU5xind?=
 =?iso-8859-1?Q?0KXXZkli4jaC2JPzugJPn8hASjqb2Iz5onTK01MNIrGx43YB8uUdmSjmnt?=
 =?iso-8859-1?Q?n9PPhKRQoy68O8J7mCGv6WZJPE/sR96JUNB44fxVmjcOFvbRZTMkjWg3OM?=
 =?iso-8859-1?Q?PVKtbDRxuUwi3OPiLJ3ryUtda/9/rb7euX1aH/zoDSihCNiv1g6oLnnSxx?=
 =?iso-8859-1?Q?J6TaqtHHIx2ZMINrpaKI2Jx/AlstQomdTVET7mMbCXvulfNynsdK0QB1TF?=
 =?iso-8859-1?Q?tsGBQO/0Jj82F2znn6RN5ud35OC6dThy95Q7siaXXHqQgywkK7GiIfTH9L?=
 =?iso-8859-1?Q?XyKphpSBu/PN4s2+RKk+acKTsf5xvQekiVxZ7F6DbM+l8R2fnPqQ36uzlu?=
 =?iso-8859-1?Q?DhYOzKQsWNf40ejBKB2X/Q8A8sMFk1IBrquFvxXsjZJc+GUZUXNZruV6bj?=
 =?iso-8859-1?Q?gJqv1bUeFtHe+jmqbIZvZsdXt4IIfqRCkP4YLSmy9JrwGIB8bh/a3c7Nf/?=
 =?iso-8859-1?Q?LfO/OAOuOyL0FuKmaGGqxCmoxTqU054Ax0vC5Mujb4PQElvtXns92Q+Z5B?=
 =?iso-8859-1?Q?sqZkkVQfay/WIE2MT9vHX7euFb1hAx2NBKSjVhSgFYB5fn8xDDSuDxbylF?=
 =?iso-8859-1?Q?mMC10iw6iDQ3eKlZEAJApppx/X9ucn2RjKBpHQogtzgV6CDRpkaKqna+W+?=
 =?iso-8859-1?Q?fRdxpwa35ZofNq64S3Qz0vOLVFpmJkmI0LIh8IiJcIclgVB40O6o//LZLI?=
 =?iso-8859-1?Q?QkwQ/WcYgSur35pSrvQldxxrvbhcFZyBwN/aC6GX8TMi7bAwB3hz4ovf+s?=
 =?iso-8859-1?Q?2DqF/Y6kWnroOwJAKOT+BY8SBrdL68YczvLPC+drUSreFNZT3fG8LeZhRo?=
 =?iso-8859-1?Q?fVO9v9TePLcH67NlK8RAq/F2G/REF3t3js7ermVDcxD8wWxRndijO4pig/?=
 =?iso-8859-1?Q?pBaxHj3F7q/JmzerndRdgB4+X+WzjmkvsEhtDujKpgOHjVZ4LOKfAlgBO/?=
 =?iso-8859-1?Q?VytML7kUSuZP+5ubdx0/ajJkmWFHLRITlnhjZgZbD+qwanzcdrDQ6Bw+9U?=
 =?iso-8859-1?Q?80GAoJySdcb9f7DCCRyDHKeExrSRruGbNyhxVO4eTpMMH8TWz0IZOfHSXN?=
 =?iso-8859-1?Q?nT1OOAwfaRdZbi9lygCJRqP2OgNSG9+mJu5EixZuDUtEqdMaSfj1CCEQ4K?=
 =?iso-8859-1?Q?CLyVHDNKjMEoddSzinmtZtfraFXV9Gsd7reJYnOWPFNWhRC3hFFs+Oir2e?=
 =?iso-8859-1?Q?S49fZSOkBApyualhtXulOvafKwb8esi9di3KwneudlW7XwKe7uG0YAqT4U?=
 =?iso-8859-1?Q?ikoJvX2JsGFsyMmHzbCq1WKTeffgKG8VcM23PIobtDh7VZY9x27+5g8sW+?=
 =?iso-8859-1?Q?kaUZcXQdr5bSP6jyKdTYIBi2o0ef89KDkTHWSU7s7tbbneNIEgLHE4jx6O?=
 =?iso-8859-1?Q?SsTm+PzSDhReaz20alJiEOQTDPWyh9CcyrUDd0E2bjHGQfUoMrVbKOSk9M?=
 =?iso-8859-1?Q?BsyOoQ6hX1AgUwOG1CJWr2/52UvKA7Rp+Grx40wTLrTWCvpUhVmWR42zT+?=
 =?iso-8859-1?Q?CIOQph3dMBc3zzaRsg0fjZj0RsBeEMJ/izTaMCAHoNbnYX1+C7CXMpc3LJ?=
 =?iso-8859-1?Q?VvpQO2lnrolVd+iskaB56ejAWNG7GJUwDzM9+kSifKa5+EIXgAoVFhXayZ?=
 =?iso-8859-1?Q?/MV5dKfLSKgBO56qjKvN2FfDvb7uM+pREINEfYLSqFzbF1QI/6MDGw+Il5?=
 =?iso-8859-1?Q?Uicxz6NNUYy6sit0LnT9u/334Oto0xA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3aaed32-d79c-46e4-1b9e-08da27965944
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:31.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blHX9dtO0j9JT2pg6pTzdAB3pYzAIe4mCkHmZ85c8gUIB5PtYi2lCJ+okhxL7uOtTqIW8ORxo8XqJMEQw7jawA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=978 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: NBBGVpXTk_WVDZspDAhXzLiRQ66vYfRa
X-Proofpoint-GUID: NBBGVpXTk_WVDZspDAhXzLiRQ66vYfRa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b8679fd1f7e3..dfb2b2ddee24 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2481,23 +2481,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.35.1
