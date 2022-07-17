Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F34577358
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiGQCrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiGQCqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DC19C06
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8dk5004121;
        Sun, 17 Jul 2022 02:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x8RQV3N/YMvH1ePapmcE0UOvrPvGIi1K/8Q1s3WragU=;
 b=h9mLKqQTkNbXTEy5aNWIYKtvEtX/uMbOZJZwFY7TrvVKmgYaYSSCwKcYgMtxKM1NpBHI
 d8VzAwhvxYcfJXasQrMqz1cdmikzgh6aupFxF9aDRW7l6q+Phqzo0HzqXM/pF7FRWXjF
 I8hW0z8K/995AgIkgOHjpf/opxL/rhVMHPBcwvUZYNVs6xX3wrM/RQxUKM9gddL/UTxN
 KRMhWbeP9t4gdIsmFw5GhTbZkadYZl1t8JIO0wbq5A/kzp57/0F2GknuNnrsoLdMLhae
 Z5AEQ0wMxKISJPnvtrobAAphgInEC0HsI8e0fI7uziNA53PodUegP/k9KCDpUdmllshR Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImR036151;
        Sun, 17 Jul 2022 02:46:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eypp6R8/hQIHojAhKISUMXO5RVohGSNnptdwzAn4dgQYsjvSGTA84fhce3uNLPE/6d+MPy76B+gMTAPEj16Wr16EXK2xDZ8/3Ctbq9Cc31dyNLwEypQThveldMs7nE1d9YkhBx2Nyv9K7zZ7BU4dkN3wOWaj9qOKJhfga3aDQbPejXaw88z7kTkKaVGG7OuP/sUK8KFzTAsqGDqiJYdmLhLd3VCN7ZF55LP7+BOVcYAbI1N42ZO2kAduNn0QTRzkWQ6aqVOGZhFiwIIPFqxSi4B1jvIKwqkgK+rLEoH0CJusvIKcBZ8VJ9W7riHqDaAk6neIKjbgmsNBiyqk97mVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8RQV3N/YMvH1ePapmcE0UOvrPvGIi1K/8Q1s3WragU=;
 b=ngBBbsDUYCvR9d8cQZ6EREe5zsxW7F8k1dnJyjRSByZNQkNdpKXIafqNQCLtygmA2KOfNWtvVta59BQgKSCqp4Gomveul3DThNg2iS/ddwvVtR6c94unD8tdqzh7e4n14hRHCsk4X1GEoJdIUxkzpKun0y0k5BOJXru+jOMJ3KB3LPYRBBYmrpMh8qz9PxIuvm4EAW9pkmWTDM58GIlbYQBNydcjyL3+ezugI4TFqcMB8tiizkO79hIAQEJR39/Hknwy6DQdVMDOXaj/VHtt7tyanaJpqAb369z7+rzX0LM1QSVoLLE96wpB1hBBDMQy9E+rkAGused51U7oEIiLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8RQV3N/YMvH1ePapmcE0UOvrPvGIi1K/8Q1s3WragU=;
 b=ZKkpk9TKtXg6dXc7n90TOtiT8bSRYRNya0oFjukdO3TQR7mCKfUadjSxmfc87wOgaPtQdLk0hycbjKVoZcG0DcOldAV1vpkbHe1Im8i6XNY7npYwdzSYHgqDDBUjgbq7CJSKvPdhW9xgRhaLn+u2nXZhfJp6ocfo7FIRKhUC6CY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 09/69] mm: add VMA iterator
Thread-Topic: [PATCH v11 09/69] mm: add VMA iterator
Thread-Index: AQHYmYdwhrjbSulFAk63wcM5j2T2Ig==
Date:   Sun, 17 Jul 2022 02:46:39 +0000
Message-ID: <20220717024615.2106835-10-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4efed80b-ef2c-4c29-28a2-08da679e93d6
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEXTreMQ4QVERjbMtto93jk+zShgKDKkOShYRlDwaWf7tLGmuGV0ZK+Qc3GFtNokfAt7D1P9lrSMiYdQDoY+dmtMaf5BHKabOo/WmfHpcf6L9vpfqBDQqW90GjDyXheCruMOKtigYrLt6v+swFA4BHs8/SilUVAbnDdKXAOpvYCuLT+QlUhzoT6fFT1IzUQYhLojA+bxrP7H6G8T2EqVxOBVUauMHU6K4uWpb2RE+8SqIXPIeWkmw5x/cEfzC2uWSRURZVUV1qUizZDQMlLRlYD2/CJhXVXipW6+fH/Muh5Gk+9J7fcSKt3A82v8CWJXJzuumNsPgvfA6TCqFZ3y0H8nJNpMThW9Ig2p7dWhJreGrez0DzMF57ComElTOZVN5sk4wzOJ/PHio/KKJCHJPmmbHmH8zOQGwdMIUfciK5OcunluYh3SLGkN85j+JIzfN4U4zzSnt0qfLHRNBcTVWSPqU9hg48b81GgJYPJsHbN7o/fbgD29sTJqixesKQgcdsbYBMZ/BIc5MY79q9NptuHVptGwFEH0hHHAm6kt6kwQBLpx3+2IPDqgi3itdwgJHevjGTXtKS5YbkSM9GAXEzKf9859c1MjEchh8l18SGuTDjSf15wsrf5vwdleZtNl/LtMjXxB4LPCpNZ+Gz3KWN2e/Io5xTJHe4Eja/rPJ9tSlGSBGdnQt5FsG+kiCw/wNb0GE9GnheOT6lRw37/1fqLWLzlP8LSjFiDU2Du18pa7Kk6uUGnHEU/H8FIlo8WIDmqV6UpLZS0JNsNtFaPgGi1EK1/9pdVduwFj/IGUqGCZ9vRPL35OVKcYtipsq3JHI7ftnFqcItXNjpaxRiGdUUhxkGDEbLz4wjrtiilxB/ZHFiL7WyopX0rXo9AvuW+XY6jPhVmNRoFDlzFIoIkumw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a6p2UJ2j0r7eUe/0jDScIPUrN47y6dCL8z1FaipqthLaykNMkPO9GFcewB?=
 =?iso-8859-1?Q?taNs7fv7vIV0zjeH6PVXCAFWj+pD/rxm5bxjXAvKgVWrr7L9JolDVgaMCO?=
 =?iso-8859-1?Q?d9lxgQ9OAb2+D3c6yEyPlMnzX4Hm17I0w8Ry9fDXN9VZCEidEIQaPF6WMi?=
 =?iso-8859-1?Q?O/Z0QkTlNWT6ngO82osYySCa9NmlNLSrnCZScPoxMPi4AdSPiqiE1fslLS?=
 =?iso-8859-1?Q?kAbYIpNcFEH7RiNkcJR1z7kICsH9mm6+PTt0ShHAXOb2XZSqn/Hqs3PX3q?=
 =?iso-8859-1?Q?LHonHyhkKdvpCMarmw7XeiONE7aaR5WrMeO7ezUDFasquGPUhopEUxRZ+B?=
 =?iso-8859-1?Q?bM2jPqILQSFBjh4kLcsg2dng1wj6s5C+t0EBHZ4uDGT8Y61EmCTQzDjzPF?=
 =?iso-8859-1?Q?MP4VVSIqRhlpw4DVSDds/gD8fRwW4mkHrYsEiVMsxnWx9xmdA2QVbMpo/n?=
 =?iso-8859-1?Q?wCU1ocwojWJOrt6flM9QKGbmpeRqJuWLqvFsqs/h6DHVTObwfuyJ6Z+IGp?=
 =?iso-8859-1?Q?sUAiRwNvYyL1JveeMWoSdSJBewzrSNmJprcWZBC2dRFJ78Re8c7lWEbLmQ?=
 =?iso-8859-1?Q?sClaIMCiFEg7a+/EDMcRn3knqYNseG2h+mdg6h+uc0RWkLmHMcTZIGfCqD?=
 =?iso-8859-1?Q?+Eqt7Y50cYWLPsw7Nblr4NqQMvt2TjoVXlRoQSukv4af4rS3KIllu4mUIR?=
 =?iso-8859-1?Q?pWFnbqIK7hTYxz5piXBr6DrQr6URFOcKO8DWY07t7/g3za959qtKL8V/Mz?=
 =?iso-8859-1?Q?WC8SzEutmqUdVPP0atwIDG2FD0FO6GT5TNUftYL0cbe9wkCT3OegkZH5wz?=
 =?iso-8859-1?Q?UcGsecZ76op69tL+kkyFeLAS+jWlDTHmSBGp4KmTCewp+ISilJUAaKJ0Hy?=
 =?iso-8859-1?Q?BXZeyhTvYYH4AWokBDADmTOAWj/VkfTPF2+NS4IknQKYXUjeyb8ye6zSWo?=
 =?iso-8859-1?Q?PTUgo25SAUM0FiqHXCnFrKfq/b0guZEmxaIxzf6aJlWLaR1Ws1UI6tQnol?=
 =?iso-8859-1?Q?QmH6tGBPvk0JD+0zUOzu5QxcyYpj84Llj/fL2zwhUApWiObCbd6KGeQ0Ll?=
 =?iso-8859-1?Q?nobt6YOOdG/hk889UuBbQln0MxumwFkNqubz0+D+fbew/OyWVxCFlpWEH0?=
 =?iso-8859-1?Q?5AS52HxaPAb4GPoqbK2akEWM7oj9nYdgnmmpbJXRPphc/Evy75nXNM3kFf?=
 =?iso-8859-1?Q?XBN6IQNSe8miohxtqClgJuymqhR8mulJMocD/Slmf1CkCQ5aSQAhESRB/S?=
 =?iso-8859-1?Q?8dLZ8O/WCkPfqsVByUk+gbnPwc4Jaiw7bdMvgOGoI762iXPjnGCYB3aQPJ?=
 =?iso-8859-1?Q?+4VPH+wslkDHdB9WomhkDobfa8cBHmOapDHL481kf6A7Fq7lckDYoa5f4k?=
 =?iso-8859-1?Q?+BFwF9oBV13aN6Zu94Jf8qi8930cdfzxfh2CksVZdkOwHi/Ve657kisA04?=
 =?iso-8859-1?Q?sRggnFsh2ANxFiTpQurZbUyqn5VpfyHCJrFZUNNMsqtmdXmbT/dkZpB1p+?=
 =?iso-8859-1?Q?a1V08p0tOEQWIBJFw+wDOOgGXUGq5EdA5u8gOGCmeyI6MtU0cf2ovvHw6n?=
 =?iso-8859-1?Q?4j+t/LPLf8Bv8+qfixChoLpcGOh7NT8vK0RpIP0uENR8LtLo2nJcvLKGxW?=
 =?iso-8859-1?Q?f+AvEmpKGPTicef0LJ4T9/gZtU7gV2ifBB/tQFC6+sfX284SQrDPFsJg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efed80b-ef2c-4c29-28a2-08da679e93d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:39.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btfL0B/Hv+dZsVgTKaPFXqhz+p2cseSd1ZIvSqwydznfyXoSURKjaJiRyDW0bmlnacD/ee4aynLNOoqSiwrOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: U9fVqBJqlDMug0v8jvCj1TPTxAjZECN0
X-Proofpoint-ORIG-GUID: U9fVqBJqlDMug0v8jvCj1TPTxAjZECN0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for iterating
over VMAs.  You can go forwards, go backwards or ask where the iterator
is.  Rename the existing vma_next() to __vma_next() -- it will be removed
by the end of this series.

Link: https://lkml.kernel.org/r/20220504010716.661115-11-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-10-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h       | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index adc963765d95..dee609fe5c1f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -658,6 +658,38 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(__vmi, __vma)					\
+	while (((__vma) =3D vma_next(&(__vmi))) !=3D NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(__vmi, __vma, __end)				\
+	while (((__vma) =3D vma_find(&(__vmi), (__end) - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e810aaca6c04..47fbff4d4502 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -696,6 +696,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, __mm, __addr)				\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &(__mm)->mm_mt,				\
+			.index =3D __addr,				\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index eed9e9d96e22..35c4478a8fe4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -633,7 +633,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -641,7 +641,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1341,7 +1341,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2889,7 +2889,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3094,7 +3094,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			goto split_failed;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.35.1
