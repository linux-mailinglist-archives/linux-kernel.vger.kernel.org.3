Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36F51017B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352005AbiDZPMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352115AbiDZPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09758158F53
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxhW032179;
        Tue, 26 Apr 2022 15:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u4TPzOyIIC867zisfZ8dQoM9jL0GRs3uSqIIgKGvw5c=;
 b=P1TpeCjcUYGtohDbLuQSAVtiYY6Q63yUOYAEVHn3f7eKFD3EcJvvtva/PKw7tK1UfeyQ
 x6PqQIHUm7Ix9Rq5kwWccpYjoiIDqq8L4WQUGQG5sDCtPv24AjbJuPGtQsGzGhpqVnho
 VET5qUvSetgLgjopC7fTnhDnwiTS70D++zTbocf/h0j1dz//gkGoewO3ni5nAUXYu/vd
 AKK7DEpHkWEJ3GAOyHpMcjLjp+ltbO1Y2yo6D3hHb8Cjp3ohFm8uS1HZVskAKDIucgy2
 irnni4E9Uh7K+UUa/eWefFMZDpmSDsQz2oyVxSy0DSOIJJEsc+DZGvt0NRzae1K2AUQ3 Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx54g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF5550019202;
        Tue, 26 Apr 2022 15:07:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ff1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPmL2vIAZGISaMceLqZWctDs2ohrKSznb8IH+BkFDPRuULeqK02mlTCDlMJCfLQT8xF40SBFxfiMkDiO/GAKBFDhzUSwAeE39TyuELEChzjIS2j+UbAYZufzYPHmrHBBrlXFyIX6P78b7PWikSQvFtzbJSv1XgSFCVcDSxhG8ZMp9BDiD9Df+jVb1WauDRckjDkwz5lxctuc1t1A5r7cik1URq34TxPqoSozMr5DjPgxxP3oTntLz37PKNj3kjaqxDYMC+J8M64ZqfaJzNFUrF0mFpKg9SOFZNkI+QT3ozHBAOTjFzOtFW6/CSkllC76lJLVGsuSthSR/3vHW7o1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4TPzOyIIC867zisfZ8dQoM9jL0GRs3uSqIIgKGvw5c=;
 b=hHCmAW52YZnVOS9ofGeNMJdCy4wxW/Hz+LJjqt1qCYVDwfPy/bVx0JGtnb7cXoEMawRBB6GK8BOyMP/+dUbnahdqgxHCa2RQ8iYcnu3v3EFz88hDIE5NIoSACOlmeT9nuhP69ABKBlCte05mryhzNL4NW6vfgTwxLDh5qUQuPO4tkzr7iXbSOCI1SEem0xOhAVOGs47nVgzlESFDcDiBR3bWior6sabM1KUdObNBeG85yVmjw2tVd6dWpudkq2PqzR3F35zlg01x1p0VObxHep8JIBwL589LCq+iKTULvkoSU+JaB6Yu+6x4QW/UqVmurK+OQAlq4k2C8NqGC6m55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4TPzOyIIC867zisfZ8dQoM9jL0GRs3uSqIIgKGvw5c=;
 b=qRuO5ySzJDFGtUj8YzM4vq4wnH0ZKnb1R0rKCFgAb5Q3BKlITPDj0bzvwO/z/ze8bWtOnMD0jsEfPafu58r7KBXiasOhpakyxMUGdjs8lxIxGVTTVTieMoUifX1y9w4hzIfDInUSwWW5k6fdfCn0mhGLRPyaKXZ3s8sTtJperVc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 45/70] userfaultfd: use maple tree iterator to iterate VMAs
Thread-Topic: [PATCH v8 45/70] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Index: AQHYWX8+aWf9Pkxxbk2ykOig5YRJUA==
Date:   Tue, 26 Apr 2022 15:06:44 +0000
Message-ID: <20220426150616.3937571-46-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 444ce2f1-afc2-4184-3480-08da27967874
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929189F96B4F306B8364373FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3daXTSSzUCEMWrb4Un3jQs2ZtZ0ZcNx0Quu20Weag811xOy6247dHVcHK2vP13MYs6NaOsMqqGGJbeTyE8UjXDP0oG8Vwi5/ZhT9Vt4hmYhL9bjU4Ui/oY26z8egCvKDXmgiOvtpLgKwBUpT//4E0MliC9Sdbyl/71ghbJSqmBNdj/hlj0Ga3b/r42otDVxTCaFkERVJFpGb//nkkngsWkldVljQ8W2GJRSRsgeli1Xt8CjRPpgT063ynZyZVzJUDO/bLl0hnvjgiVvZYvQsI5pwI140XUSpUYhm+QcerUghtAF4eUwfudz9PdHlIAPWFncKrpBwZTy/MT/tBN7hJmrkeHIfZpTcNygbwZc845RyvYekfe4lAhed3aWq1JcFfOKuc88Jdc8n//eygDI7SKBV7a/Ng/GhKa6OeLDNe6YbWc1SCOETTe8TY4L79uFyErSoaXLOPd57R9M5rg0l2QLj146mkmDdJcGJ/7llPqV8OamOko+z/y4AaFP2MIrpDiVE9zoFi1JnwTV7N9axFY/3i9D8DYuAFjqWrG+u91E4iLFR+Zoe631WzQUkLXm+YLuLHROBF5LMmCW6CqayW5T7Ef/PsX1L0HHEQK2kk8z/LyQf/m+EwWke3MGQl6R4PqeQGgRvzk1UWgLQHC6/iM5qK05FBGP7n4iAmFvLAgQ1COkEDXkKYQZ/BpMm7W8utTLa7vroZVfHQldM3RVZzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sC8EjLJLjCwCDPXOlWJQrcskBlL1uR4ioFYSVJBxLz4xSprsJsh66dKEyo?=
 =?iso-8859-1?Q?jAeqIpPVXbXgpS1dCnLJtIt3tIaQlFqMqYTnhiWePVY3BQVj5UXIBjfqsI?=
 =?iso-8859-1?Q?g6QvmBtcWm+MKwWAdn0aAhTUk4kakXDZDIg0UL+j9H9jzcn25F6Q9WkYNn?=
 =?iso-8859-1?Q?aNMWpkSJwmD17Tpdwd07kUMJFuh4ebKN0zYTZHy8fLFIbqycnjz8gXWPta?=
 =?iso-8859-1?Q?xoOeQT69m4/Nzq2qWio04BADyQhqQU69tGunLV7m7Iv5g96zInbOZHkn6F?=
 =?iso-8859-1?Q?oMEHv65OTfQJg777SDZTNOova4iEIPoVZkgUKNd69ulfwhYMoQeXFyP4D3?=
 =?iso-8859-1?Q?6ODf2EPbZM7r6V5ycMlyc0xMWuMUa5RfgSmcYxPPd6S9eoQL+52Zdb5Sgv?=
 =?iso-8859-1?Q?xUuzwofo6VKrF8+7JTWDB2B4mv9iswFYtPBEtSSzLQP4x+8S/RZ7B+ZrRy?=
 =?iso-8859-1?Q?hp9Ow+h00IzIm1RUjyfCPOC4okhODMYvJdKs/Vzpfn9F1gUD7kiQISOQN+?=
 =?iso-8859-1?Q?Vpqj7f+CRc9GeTwkBvuNZStVYTIf8sqQsuQwJiIOXr6+wFAcROO/6F1vlx?=
 =?iso-8859-1?Q?Wb101E7BJtNqqQLbvMA87l4/mIZgn66o1Z6c5iURf2jZO5/QZyxfHwIuyC?=
 =?iso-8859-1?Q?VfruXiX2G0K7G0/2r7riJWLaR0aXq5uXZktnmKez8rvgM1s38LhXzymeFf?=
 =?iso-8859-1?Q?aH+psn5ZEp53YcaqJljGt3oJI23Vc9Pg1YL26mVPY13Otmgw670fhSm7tC?=
 =?iso-8859-1?Q?ReoP5NCz/ObuwQa0uu+k0I3z1c9ZBx7MZ7LY1qns1EkVvxh3E5gzSrPQ9O?=
 =?iso-8859-1?Q?TVDekGJXNeos0Suv+l9nk6AHs83qGV8JCqR3Y5sIqg8W7YuabuYII0N1MG?=
 =?iso-8859-1?Q?lvzkVZEX5IqLebUQj7z80QXfpZGjiqC7g0dSmwevWitBmrDXqlbOxMPTxo?=
 =?iso-8859-1?Q?u25fSID8myw+x+OweXrtfRkLaZhvQAarQ8s5hgGA0MVm7lTfvgMn7nTe2G?=
 =?iso-8859-1?Q?zCKFc5HZMcpfLRqTUT9w3RGpoJi4nArnSKfzktWel37y92RFFADcdqKMsz?=
 =?iso-8859-1?Q?c8CBM5IiWVeVGUbMwdTdXnyBw9SDNx6J+NZCT5Ml/y13MSmEaSeT+C3HF+?=
 =?iso-8859-1?Q?+hpSs6+m2j1PjcP5dz+m7b0CNmk+WeKnGtPcSQ+C3EWiikeYWP6d7PMTyq?=
 =?iso-8859-1?Q?lu5Z6ui1qVYU6XEUzBsmfqUTGI1OxQb/x7j3bkjnG71Irn/9fuDxvcXaOy?=
 =?iso-8859-1?Q?aJ0aywzzr9iPmoRVXoV5Ibr04CoBjteI81IAdsWUkYOGKw471vQTNZKuN4?=
 =?iso-8859-1?Q?3A2Iw+iFiwirCiHAce+V9ZM61NGS9Y8Gj4ofobB+GOEUDsEVl3lkFt1dMe?=
 =?iso-8859-1?Q?6qq2kcp8R2q6OYzmNiS9JLYRW57feUQkqDFHS29WqRf7Gz4Rd/BUGNHrVb?=
 =?iso-8859-1?Q?IwDg7XMnopKW4zQExdVnpS0S3CN6ZDbxs8lPHd2ChllRn/+RT5rg08a0J1?=
 =?iso-8859-1?Q?RonWUNPdSufk+V8OEac2Jz7kQcd+XQ8aSByLt/pqRfmmlM0kFV3b796Q7g?=
 =?iso-8859-1?Q?YwUxExObNg0VDPmnGaWXwDZ2X4G2edtMofxY03d0vb18HWP3/UaFjgxzAt?=
 =?iso-8859-1?Q?uUIV4uV9awISkZg3sk4+K4Xk5g0rIa8zJ73k8XkqI/MstT7bpX0pGNl2ZO?=
 =?iso-8859-1?Q?La+aPri7UtM43HDA42F4Yxtz/0xlBPXrYGly2cA6Rcc1vozLXGiyCkptjE?=
 =?iso-8859-1?Q?qha2lr19ZBNqiNiRTRCtyfl6nXwdg+OZ037HEjBAmiG/Q1TKevuD5qYzoV?=
 =?iso-8859-1?Q?wlj+Ez1Ug7jUF28iwJBeXcizmSqC+s8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444ce2f1-afc2-4184-3480-08da27967874
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:44.6301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPALxiqPLeZdvYWc8OyM5tiXCeRNmvTL6vgdTC/FeI824wo4e+J8TnSNXRzJdAiCmINTSF6Rtr8oz1LRSoTXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: __jVkSQsXAyofbWfsZO6BNJcNChLUv3Y
X-Proofpoint-GUID: __jVkSQsXAyofbWfsZO6BNJcNChLUv3Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 49 ++++++++++++++++++++++-------------
 include/linux/userfaultfd_k.h |  7 +++--
 mm/mmap.c                     |  7 ++---
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..f4bf95660536 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -610,14 +610,16 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		VMA_ITERATOR(vmi, mm, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -798,11 +800,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
, struct list_head *unmaps,
 	return false;
 }
=20
-int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end,
-			   struct list_head *unmaps)
+int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+			   unsigned long end, struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	for_each_vma_range(vmi, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -852,6 +856,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -868,7 +873,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -1285,6 +1290,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1327,7 +1333,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1352,7 +1359,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1412,8 +1419,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1471,8 +1480,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1516,6 +1525,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1534,7 +1544,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1559,7 +1570,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1579,8 +1590,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1645,8 +1658,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 33cea484d1ad..e0b2ec2c20f2 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -139,9 +139,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
ma,
 			       unsigned long start,
 			       unsigned long end);
=20
-extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long star=
t,
+				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
=20
@@ -222,7 +221,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
ruct *vma,
 	return true;
 }
=20
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index a98f7c765628..5a042f09bd69 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2528,7 +2528,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		int error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			return error;
@@ -3021,10 +3021,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 		goto munmap_full_vma;
 	}
=20
-	vma_init(&unmap, mm);
-	unmap.vm_start =3D newbrk;
-	unmap.vm_end =3D oldbrk;
-	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
 	ret =3D 1;
--=20
2.35.1
