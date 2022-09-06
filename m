Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5175AF511
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIFTvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIFTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC61057A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id90Y024660;
        Tue, 6 Sep 2022 19:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZaC7lqQRQkSDIkJGa0g+/q1+WSqSUKrFo9yctwdc7aM=;
 b=kmoasXSH5EA+TyzdZ1hZzpKrbnSFsJPTlq+4CLOWdJXySoFrfipiQmwDak5n7KYP86oU
 j0pOMQadcR0rNi3i2xys2IjREJZCL1exEDYQLvZv8+UVmGzo3yfT6i7EGvB7FxDDcpYp
 O1ielOPJLqdBtmWD/U2GvNdDBTtBBydM2KeQ7alclJTzUvmNPGnYRckpAdFpJVoGtIdh
 69ulggCn2Bc+tL3e0Z1PlIwmS6AwcatiU0BfWIheV1I+uexF3NcA78J4C2rjGpZRjyf4
 t7cklqbtf36sMy3DzK1jeAPf33d4Vfq6rHVz6z1bQ3CzemtrssncyTzP5i8np3SaM/Qg ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8KXJ023727;
        Tue, 6 Sep 2022 19:48:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kr9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ0yGwd4lf9ptbcSBS688qoBJwHFTdo8V8Y73QG2XIf4GrRGyn9IwpcJZdAJbZ/YpDhjMu9DlVBipnWUwsYDdsQDmDw+VqQXQnS01/Z0FHmGEBI1GVouqjREIX+0PcLStYbhSRmHepJtCux9ZTzffgSyunvZZSPhMxyaZX9U0yus/DbjPP9HY4Y03HLwl3dq0NERlSvjQibJGl82SLJc7CiT8yOF4nXujV7WCbwOhjUJjaWT0i1Nw/RE5cVm1XdO9K2kMZRLx0ARvlOmKtfIIdm1fgLSeuMeb8LIqBMkY8rZNNtil4he/0p+Je8JIGkU8mOE6tYQD9h3bdoDHiv/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaC7lqQRQkSDIkJGa0g+/q1+WSqSUKrFo9yctwdc7aM=;
 b=LztuM1+AK/RmLLJSRxN7Q7U5YQeUR07HJT57M+t7b9uGL/OCyh8Pu9sjtH9RCHJ1HeYbMk5tDErUAfdI7HiloOno7JHsnhC2wi+nChmcS3I++1WaubQpFk9xEqLAKgAKr5iHHgVxu93ySQ8jHbHOJzIiczr7lUI3cud87yDgHO3VUrjC1KyRsCQD0jZrNPoGzImuBVZxmSS0ezxfSMyat83o/4pASwwaBaeCGYFEkZVkpni4TOdJwihYNgdZ2pJ5K1Cvcy5fD+CWZS8NA/8AilTDlziDKIhVeGsSWnagKB7/RSjlQ5tAEwkxrwWzaSMCxoQrZED6dmCL4SlaLs8OVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaC7lqQRQkSDIkJGa0g+/q1+WSqSUKrFo9yctwdc7aM=;
 b=HI+dWHjUVeAru2QpNwO20Jjlg5QjwG7tIFjjBEsxHkIunDELAoS+4wu4eo2b7l6kL10JXwoWXBgnOyU1VHZmOjXxJjTRnqLqSXSG47070tWoTR9wqvq/L2KgPbdqOW+jOXhxXy3i4FpX4GylCfRIpJcTE2f3Xr6PZpUdsXrpiwQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 09/70] mm: add VMA iterator
Thread-Topic: [PATCH v14 09/70] mm: add VMA iterator
Thread-Index: AQHYwimt3pVVX5iKe0W6kP0G9E2e6g==
Date:   Tue, 6 Sep 2022 19:48:46 +0000
Message-ID: <20220906194824.2110408-10-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e496790d-5e0d-438c-e088-08da9040d243
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSh0D1WGAwAXcqxIh+np1d64WoL/1ZhhDec3KrOUwMzNGRVibZ6pEhoXXaDkbXUVkGW3Et+4/AkDgirNFny1Ie1CSdAF1Fx0EfkRmeY8xKFf5t+xAUqaaNnjHW0ui8s0fPq6q4ddA3KGenO5zaVQ0SdHoIsO5JB/bfeUxwXAyboHBu7Kb40zxKoE2g9d/A62FLuIRYkU4KcnWNnuVdCZYZm02LXGrE0bQ8D+066w+HxHlJ3CaWKvEa1RlwaHDWs6b20tDMXa1efXo653r7skd8mvjLK4tfos+HgsDTV0vTtbG5ukBCMeK7B/p4zBqqrVAtL0jSjpswZJGWWyWRbwWlv29FYAq50ILlBJWmlUv4R1s3pzrbTPinsUnY7hk0USXStgNxrNEiNuQZxqXlh8mU29ZvXQJW6SueJD9hPzJQayqfT1EYBwcB9iC9kUbgkgHlw7O+zq/+/DrhsuroM9yWfxK/7V5TLi9hAUkEghVZlzwzVVBcLGY5zxtmLii9EK/HNCqkq0nqs5nnBUJCbSz79D6mPBFGC+ezXf0+ef3bl6cuIjXyMQJul0HIWsIfrsfvZSMxvMXlP4J/KxIkifuj696f8loM/ugl806Ddjxe0dGXY8YiC8aD2fwom3c8jPdtDom8YTZykmJuusMwV5CHZTq2XvTQ9EUvr/+8c3iTbqrhjY+oAThQnX0wkv/cr+m+mHgAovEMZhbBSeexljo+VQALb+pk+Fu2zyIO92oMs1ssHkEEfZdSzCtFGjnaMEq6+ARa6i2TOJwHEKWLdNVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uV4dBUNhxWsl3sLSPXGs1mmXK2chBtmghFXUwrSK7Isfi7yxxBgYVx6Xjp?=
 =?iso-8859-1?Q?l586VONqBNzowPGuBe5I1r2pf+DxSZWKJYJnBjU5b+kESysD2WWAn7KBcj?=
 =?iso-8859-1?Q?zlciJR+7q0v1atSZzq5wLWy+fDvd+mIYWuu7xpFFV2HSs678DJ0DbKZZtM?=
 =?iso-8859-1?Q?tgNm5gceAP5Qor4BPsKVGPuQv0IzGlEJvovBxI2jo8syup+wDsjYGKFlqW?=
 =?iso-8859-1?Q?isoUCWp4G7xFH5KvDd605tzHtd+xr2Wv9hlOPIFv598KdoxF23Aa5lw8g5?=
 =?iso-8859-1?Q?B9hZUKlnP5cS6Ch6WVm62l66YqjYrWLVd7CijDqZlpsKDyWJJ+T4GCrkPH?=
 =?iso-8859-1?Q?xK1XdFgq3RAyf96bCBlpYROY5hQpqdcOyJZc1ImcfvzKZ41yXo7kmUYUme?=
 =?iso-8859-1?Q?n6asDB/nZVGYJFE8653FZLMmMzR5qVGpuCb3SRXc4D/sJ1TPf/gH9RjujD?=
 =?iso-8859-1?Q?kj+nqpEbcxnItQ2cTfksDdKwOP1CLnErzQvf6SCrclWuz5gpaLy3ZWPqPM?=
 =?iso-8859-1?Q?xHSJWkooYY5ZV8Wp1sC/V1D5dR1vV7YHDSdkmgg/24TKv+jOdYDqHtzlOz?=
 =?iso-8859-1?Q?vOuziGnqRYLwYRJh1XE03MEQhzOhnf1lyWnqKsJ/JW+IRYZ9lTa2dKehVC?=
 =?iso-8859-1?Q?7w4gtGyzUN+WA1FfEPwtrNPgRd0jge9PXPZ3cIeGURZu4/Ndr1iVpn1bvz?=
 =?iso-8859-1?Q?x5Qi2A54FTxsLVKsBk8k+BpFDWCVh4sdvy4w+Xr6Wa0yzh+je4Jw065Abr?=
 =?iso-8859-1?Q?YmYkTTvKi6VeKGT6VJc8wGB4uqXfFx12r7MrYX8d0EKjl7kAFn9IjycDGZ?=
 =?iso-8859-1?Q?MIudjtq3b0t8FBliq1ciEr6TdK1fV2OJHvdo2GhJsX+6BdQfKG/YMfbsXw?=
 =?iso-8859-1?Q?ovDwfKdO4SQyjZbYfTRR+WH1KcYGHquYSsxJYrRNuD66h0nxecEI0SqeZX?=
 =?iso-8859-1?Q?mPElWHlnWKti04i2nuT5IosZw9F9yoRinZhzPj86CDR+nDp+v/gZraUT6/?=
 =?iso-8859-1?Q?0fT/YX+yzmJxdmTS2Tmr4iLgGwrkB9WhA15EMacdQyXgGngWyR+nSdPk4q?=
 =?iso-8859-1?Q?lGkvbnXkdPFsjHYW3CbRDJOTOxa8RVYMckHqmNj8Yez8zOguRV1dqySeM+?=
 =?iso-8859-1?Q?/No9xZJ4VyL3UIRizBI8hGRdjvN3jIHsxTf5n1XsxmZhDtefMLuCpyCamm?=
 =?iso-8859-1?Q?QKBmzfFvZjPFPljNFbkc4Ozo0NwNr2BsGhFwOt6zUiotI1ypqj9egHhjrQ?=
 =?iso-8859-1?Q?3y/KQeQeEfOX4vvFtzLrEbGAHtv4C8m6WaZXhvyWZUyJDJrC/ucTt8RzDD?=
 =?iso-8859-1?Q?A/MKOS9K9eeW4YVFh4Mhm7zbN/itSmb+Uo5EgsvkRIv+d0XQMKaDGQXFlZ?=
 =?iso-8859-1?Q?OF3nVLrCgx0RXcedlX7ZETpJvX9S4WhUiyJjry3RAktnTYFY1ji7vley6U?=
 =?iso-8859-1?Q?CWN4niuUFZk7ImsNldLkojh3RJpc9lVvziJe0mg3fjxbnhLVY/N3/tM9+L?=
 =?iso-8859-1?Q?GMOHYhFK5QeJw+U5TObMhEaFUg1PjkmZ0u7e8Gs/q8N2wXZNbgSbFFIkCd?=
 =?iso-8859-1?Q?pX90ftR5ct530oSVn1KvO6Takt33EQtkmXR7kQFRgIa4etfvSQvFhpOtmd?=
 =?iso-8859-1?Q?Wefic64qazkKpQpxeDHaX1MrrOGoFjC3LH32o5uJ67KLO7OzuxGHUV8g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e496790d-5e0d-438c-e088-08da9040d243
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:46.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owx6BYMXnbZy3A8eqrAXVuuVaEGbdyPZ1MHFMlR5xIyTpITY/ggdLPFtqPUOE0P2GxWptskBFlIXzgC+Ow9lqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: PcS3GhWXAttdC2t4yJ7W6iMrKoUvfj7Q
X-Proofpoint-GUID: PcS3GhWXAttdC2t4yJ7W6iMrKoUvfj7Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 include/linux/mm.h       | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5ee6e6d0c1c3..a458e5f73fee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -661,6 +661,38 @@ static inline bool vma_is_accessible(struct vm_area_st=
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
index f5d6869912be..a249a7d5f5da 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -778,6 +778,27 @@ static inline void lru_gen_use_mm(struct mm_struct *mm=
)
=20
 #endif /* CONFIG_LRU_GEN */
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
index 5115eea6a0e6..20718645d82f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -586,7 +586,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -594,7 +594,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1291,7 +1291,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2843,7 +2843,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3051,7 +3051,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
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
