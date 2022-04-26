Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD29510169
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiDZPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352106AbiDZPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797491594A9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStAE032133;
        Tue, 26 Apr 2022 15:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YcMJzeQlSKjU8MCgKs/mSWhI8nh5+ZM9HxWjnWLWBdw=;
 b=bTnBWMBFbDFBrryJ72o8Mj+eME/a3A8oWRGIP3A7bx5TlAkI6xp4sZCuetoSz3lvR3a6
 u2c89jeVdNun5p6O2+CUeFOn+zhnHdzK3Qrb6QbU/xZv2Yz7obkvuPeJxBN8OFfagB7y
 W/JJMapmBlgYpZ9Ojla2MI3pNa+G2OL/70X0WkBhk7Ytc0Qr1WuVJvQJk4RfUyUnQLD1
 MvLzkdzPmDLqf6PiaZb6dkmAgmOryiIzwtKh6tL+yGxOinQeb6gYWcrR2vVQFGRmaf6c
 D0d+mwfS2daMxxRVhyZ9NoPLgeNOz6Z9fa1ZCx+yIyaFF6gwd5zsWudhQqWdBmE7KdiC Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx546-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63mZ012541;
        Tue, 26 Apr 2022 15:07:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3grmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe4eCgwCD2IfkZvw13JqU4GsQ0x9xOvn1Abf+ytK/xLfsTwxssSJWQyvV7Hc9ucSK/4WKF3FFS59Pk01/LzYps9e/flG+QnA9003+nugi1Bbukmmapwo+5EbUkVPXPD4CfCFpIG3NwJKNG/u1dXorf66e1dq7Qfn0bOrCXUaa1rS0Kg337DM4tAp+/61ufCg/5hpmoa/ETYAjdSPsguksnxjZXJ2cRdL344txeSP+ihbE8xQpt/KIUH0iMmllaFmsFcpo3FRafZZkECRqxQyZe2AHIF3IpIjfCLv7gwEwRCr69EF2D9NfUkiJnGqvCUmqJGiGk+cRXFlAymhsGsQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcMJzeQlSKjU8MCgKs/mSWhI8nh5+ZM9HxWjnWLWBdw=;
 b=afQUf2EfQ5w+1jYefEbldcywCU+THHn6KLVC3TGt73jBojAsUy3QRmwycQla4iEXMddX8viGpJ+z9Gt0wbmhtgYE9wr0XOuuwhVFr7QNmpX1cpd6enNIi/BsHqU/KwO7Sz8bJS98+2zPQORCO0DhfSkHVn/P17HFrhbAUnbxeocE5CHZFIZPmGnHr2540WoMCRX8rr5RJ2lGzDpAeZZ2zF66x+Bi+of36hsEK9BdIY0bWaAZJuphEzRfY+m1Ho18Rvc2KyZuXhMeVEH9zjO/1FafVgKsF2S7QLAjgQGxXSXM6K0sC+rWmvCE1kgLIMrUJ1ZeUWBrgy+peYozhbDvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcMJzeQlSKjU8MCgKs/mSWhI8nh5+ZM9HxWjnWLWBdw=;
 b=V4E5TZLzL+CbU4DS6a4640myF3DS4rvoPKMfjwF6Ms686cZs4sbPyTgWXz5TpI2mJYghHKoMLB6IKhR23lVrrerJiwh8oYv4+ZhIGAHA5yehLVeEPZFH+uHP6ARKB4OmyfAUlwErnagKOcCC2UpTEAmdsvZWYtpx01msjjMms8E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 43/70] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v8 43/70] fs/proc/base: use maple tree iterators in place
 of linked list
Thread-Index: AQHYWX89ebzp2ABra0+Sj9Iv/2Vbqw==
Date:   Tue, 26 Apr 2022 15:06:43 +0000
Message-ID: <20220426150616.3937571-44-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f8262d1-919a-45f0-4f4e-08da27967598
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB29292305F9503E3A70309CADFDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfGg3vpUgq04vcMvb9ED6XlrUIDh4QLYn0d8GKxT2amxHQYJgQH5s/5q64qPl9xDHFsnyAwWLVF9e98pny3FdqmfKmXK6Eui+wRpYfSMjHUcBAAP9MHrkON5ckJKPDbISxmQxQ1lnaOOfnTKkqXga4rKSHxajvO0OifoTkn2OqpCLFuvPJZvsej0zCQ+kEyAFDeMWmeUGLmQAEwkmBCZZV8vvtdh+4hLy5dm9iM2f1U9lBryPcfR0wrkv6uKTnOKaM23P/96YZ2ZFQpnF4tylRxuLmO5uf3MXx5bdZs9KCbtxx5ioKzCYUtF79/bqeVp7qNanPojB/NLllTS63LYG6AxheaKS/b5SGh4p2UUUuuD9JBdU800Axm0kbIaSQRs5OXDje/mM7xq/wFovgCT2/ao4zo8P3guIKYK2YauYSBUSLAxTd5BQMTQ8beyur4nXEIxaeqEokyZjlY8UJY7k7GUUiMKxrLR3CPbyRvRhRzjonpuWGS0z6uhXKZBFlwltXzEOqcBZM7CKsRGd0Um5WKS5b86pNJ3aGNPzACc30A5g3NFisg3WKAPb2PVmcxibgSL39f3rEqk+ymS0S7I3lq9XNpOaEbDDFxYF8C60R3R4G81SbKDd82Gyp/lNKDODTC7CTATIz2ClpwcYvHhpw7m5HLexqlj5x5BGgNYbGbchUncQ0It+LINMJiJK7F5aCEfhp+2/esirjFDP6VmPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KPf6ulXb4taiMcTl2la7OUoQ/3fHkVC6oqPoskhIpmeNdIquPfBL3542n9?=
 =?iso-8859-1?Q?zn4drNFcD0MIWpNuLlSRwWXV+IAu8Ur1By4iUhfQU3/O4UJxpou4AasQ64?=
 =?iso-8859-1?Q?m0khuNsmvUwAx+HiEC3c095ojqYhownALqto1lUaqUZAdRrKWjSGOJ78fH?=
 =?iso-8859-1?Q?fHLy5LRDi48NHdW3Vk0FHoWIFwXbfFOyTN6t0Se7MvUb+kZZ6cRE01nhWG?=
 =?iso-8859-1?Q?V7cXrpNkEdy1xYKbtQEUwrH6lXjqsW2QD3cRZPANO2x0F+vdWxfMcjQtYd?=
 =?iso-8859-1?Q?EPLdAaaNf61eRGHy85Kh9HCLrJZQP1DZXiHLBxZVT21K1Vub9mebtKIgbW?=
 =?iso-8859-1?Q?Ua1Acg/4GCqxdZI/VkP/uNSMJnbX+ZpghSTETMTrkvgJk85kVixbXIM8R+?=
 =?iso-8859-1?Q?v9HJRsECKvcwY4JkF0BZHq0ojT4a2pXfnx/5jbXfnWVU0OODJgGvKyafhv?=
 =?iso-8859-1?Q?OovohIVlsy1ehs6ZbRMtHQZDcaon24fzZ/7qRHLSOXAehoEKnIHVDEymBQ?=
 =?iso-8859-1?Q?sqFZRSZNUHOgVo/FT0FP2owKDzcC6R33cOxI4YpZg2TUoKl0VIsGw6WerW?=
 =?iso-8859-1?Q?/mmt26Ij9PaIyxFwP/WFWBECtD4P4MPhAXkpBHPboF6r/mYFvvl7165CF2?=
 =?iso-8859-1?Q?9LacfiY9lb2kzMfp+f68lHEPX4F+mFxQnE92u6EEXarApgCMHAw0thWT92?=
 =?iso-8859-1?Q?k1ez0une8rSrF9u89O1uM5RmAaKi4/2+6a2j8d2rdCamZc7dxIP14j+Fyl?=
 =?iso-8859-1?Q?um+nJBW8XPWILHSWTDJyZgUJwKcARE6gYb2OadoEAHJri/BMOFL1aVUMX4?=
 =?iso-8859-1?Q?3x5FNPGAZYU0+2kxjSkLKsGnORpi840J1G2pTEGxnbEIHsj0VfQFw6YYSe?=
 =?iso-8859-1?Q?7rVELmbyfaUjECaiV6uJji0/Z21NQd84DBM938vdz0bbJzqpa46NAPqv9t?=
 =?iso-8859-1?Q?ptfGJPEHyhsPZmEfJVpU9zCPFItgkufdtugwidgeJTpB92D8oUn+Pj1HXX?=
 =?iso-8859-1?Q?NDmIDN5aQVPUbv2Z67N47fx7/881WOb+Slbe37wDe6u8HAmkFqur4ufoFU?=
 =?iso-8859-1?Q?7oZL45iWXmnZbOYBN74jTPPI93qBi+L9mQrA1H4VPX+HaVhAy7K+hFzYtF?=
 =?iso-8859-1?Q?5xiGYcvJerw4l07jurgytmH9cdTZhEXXCfqafETBAx2+zk5gHmQMgS9Duh?=
 =?iso-8859-1?Q?JRWQPrQawXudlIPDMWpYKTAGi7u8RIi84TBMXvNlkohW+jxK7+Xss563/O?=
 =?iso-8859-1?Q?pYbEkO+8BbUrQqDtT1E6+2BHKGugSZUHLP68tQ1xkNt1r+N3Dfuq0Yr4YW?=
 =?iso-8859-1?Q?fZEneTaE6lFG6rMcZkPGryx/2Pb4Lb8CLeA8ZFvp+MVnfftRxGIegWiNpE?=
 =?iso-8859-1?Q?6ongEjCyeZeHHhwa6CH04j2HU+BzirCV/owkEVv2HnShtcLzMkhxhasKQH?=
 =?iso-8859-1?Q?YOVRQEPj3mjF6WwK+MRYheG/wkjuXw6UezGQaS7N+c3JaUJaPDA+G1vd93?=
 =?iso-8859-1?Q?9SiYlgVqwEG7oFUFHZ1BjnpDgQSWRb26BbPkx5CW1o/T3CkwlBGKep+PLl?=
 =?iso-8859-1?Q?mYCWiE8JurSSsfdOv4k/ECa05jCerQrQd4UAKR0YGgnNMQa0oJyhcadyGJ?=
 =?iso-8859-1?Q?gLM6MI5LDa6SZBNgZ7e9w5RvmQETFcRXu++Xu9quo7d2z8R9hQVCyL4yfl?=
 =?iso-8859-1?Q?3X87WHVbYJlRPcX4PtGb0oEUoHO1bZp31Yk9YKIHrgy/o93eTLfRNRzVBc?=
 =?iso-8859-1?Q?J+tTawWvbyCL+oi9E//wLlnnjhZfLJCM2JjIK/fWyDEb+APzGgqVrG38nf?=
 =?iso-8859-1?Q?mZdOst2dmTFITM4kfrj0EQfySY2UBsU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8262d1-919a-45f0-4f4e-08da27967598
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:43.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49wi4XjRUk5smzLlpcpJAR6sxdiJ1HZswh0bi4wxRK0SipFy/TzqIV3j4zt8lhvqX8Cx4Z+e1j7cVEqqK2WjKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: BcGy3Kz2rNk08WVNQvI9xlF3NfITi9DG
X-Proofpoint-GUID: BcGy3Kz2rNk08WVNQvI9xlF3NfITi9DG
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
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..bf85b85cd572 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2322,6 +2322,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2349,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2360,7 +2362,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
