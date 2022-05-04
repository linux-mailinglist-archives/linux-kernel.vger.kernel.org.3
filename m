Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28452519348
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbiEDBUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245180AbiEDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5842A2E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KsJbK018676;
        Wed, 4 May 2022 01:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jiiqwWTcSVmUrGeXEAypedCW5tagsdzk787hNrV2FEk=;
 b=lVrqA4PEOJJpSuzz8Q2zsJP+dF/wm70iiii7EPHVbsweImjHGtta39AfK36WtzRqVcYp
 0wxDJ0tBJEdN8JOCA+33Xu1BcSU58EQQ4q6BjZ9zLhzOmtyVQpHBxr+QrQVgKll6dIM6
 MwqMacVJ/H1L1fzBGL/RCKaSW8z6C2W8ufWDZ1sCuB7/WYl69N/Io2U8lDj/I9jhd9qh
 hx1MNivqZ+bgp4qD0xVHYO+++jy7cC7qwUExMRYQxTI/ixQm9MPw9Hb0ra66kjWxV/gm
 QGHVzQKT9mVh06+oVbmUPk+oAU10bz35E0O8EQXXVcz9hugm9qFqoYt5ql+CTuE1eDov 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441Ato5020100;
        Wed, 4 May 2022 01:13:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Tkc0UU1D4cP0hcZ0bUD1kbaIwyHJPNiVfwK28oGZD86ZOIqRYdqwyfbRdg940TZVHo7xsOZSrlIbEy+mYdved2WwTgEnbI8co/PhkUc2RxGFSuImjr/exQvYPZ0Zlt6o4vnrdYU+VDgv7V+zY1s9Ozfor5r/o336vlMceoIHP3uuxASdbFsVClZqv6NqQX8Dff6S/Ra92YKU86SPpYNDif47QycGybIkIgZDgl/qzOUhmS8jcw6WMpQWvUX9H4zuil4J2rGf7bogJrqzpvC96cFWgCC2WOjhignUJyrsgO/HImKKjdFTIwO3P66/uGTCJHNUXsifFsjBLDM6KTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiiqwWTcSVmUrGeXEAypedCW5tagsdzk787hNrV2FEk=;
 b=f2F3/eexfFTwNQxqQa8LzPxZfwZBxamD4kwzcN2ZiC3d7zJeEQ1hx4U1qV6JrUvy8k1zkRrvjmrP9GUiYnkY1tV3ggl7ArnSRed26Yy+J89FpnhhAEQtID/l+5zlTdlpukDY/AcXVUfrd3t3Ph1SQ2tkzL+L1Lkk/2D041nZgk8URPd/CHG1FSkLq0dwI725pDDo2LPOl1eYzqo+DsFMokx2fC0lKAsvY5ELew03fRVB1u1v6l2fO3i6ZZZu+9GPxDr7YTvh+aHZP565xxtu2FRjqb3ZUAzr8dL2swMPUQQuLdbn+WWwcZM7Y0fHtJAabYM8YujjQ8IJ7hqMk78CMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiiqwWTcSVmUrGeXEAypedCW5tagsdzk787hNrV2FEk=;
 b=Qsu+Gf4pDLwwWqTPRTgo6mNmn9uKtKhgu45+OeaVv7akJ+tNyQfrVWn30m2LOVug23K7FH9MTdVUzrJspeUwhfQVmREMZ+HBHofjQkH7gm5zWe/1PDMbgEYvwb8hbcSp3YOjFbit/PeAzJPcCRI9tpKm1hbhhmidsXJrDdd19QI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:13:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 33/69] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v9 33/69] powerpc: remove mmap linked list walks
Thread-Index: AQHYX1Q5HqDgOSjbAkKrblSz2IwTXg==
Date:   Wed, 4 May 2022 01:13:55 +0000
Message-ID: <20220504011345.662299-18-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df88e168-7685-4551-7da9-08da2d6b5c6a
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728C34EC01004EDC98F469CFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7934K3arhrvxDxbLqd+233hS9NiQTNqBSha4EOQxQccqBGegIUl4TR13/9/28CfyzWzIJ7AwlVM9vZGxin/HAZtv4UKIXLvc4g8d9Lj97ZYdSVw5GLEYK6vvQGNejYTIyU4TFXi3XTjjyD1Bix3R9w/TXSkUegU2Oc49PuQMWOccFvdQ9INfAKagTyb/zGwGaKHuFxODvlrWPMp7+ZEAxSI9kRW1L4B9Bsvj/wOmNEEzpAQcehHXO27/fu9NAQf0GBcco2W5jyqijcFE6xM13wse1z4KTouVC9+nFIyER1CH7iJYp0nV/2bbn/5ldyBWNbCRVgAegvrToLrW8WHDQf0+vQ9c3S1Ahj2nKC63CHuhNsWI3EMEm+UML9nFJtgoq8fx+Zgxur3n9DgNeBXp9QxyuMGRusWP4zhvVTn/iGJB0TIp3y05XOBlypNJUPVID8uiGegDgxvfuwBpIYGzT+tCmeW4MlJdJJTmHAVzPKa9SF+JavlpYgeA417gij9WyW0Yktoo0JH0Q6pVeAwedFGNF7thLYKl6l1+0qdMRjy3vEhy5S8Wr4116VizZhqn6ctRUr81GCdAX/0jKwuZvSg4Yzdcd8/7CBlhs5Y7a2gdo06+jdnPXeRJrmHGEx5UsLl7ifJNDNy28E41me/As0wqpdQlwplZoEGPyyzSCQyAsqC/0Yw1l+/lp/sAqxzzJ1pDFKW035qUvWa6W9x3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?et5RkwvMAuWa8BlldsTvWfksgvPwZRKpHp2XBcB7Boaq3NHjd8ssrPgmjo?=
 =?iso-8859-1?Q?LDTBzJxhs4bW6Bo8fPYHSzfQ9RnoLPvZH+wDBZXgIEtj1ICLWJBEVuI5w6?=
 =?iso-8859-1?Q?miNYaSkSHzGkcddINhOcpATjhkxHyGgRKBx73xID+C8ND6bhqDEGSslxhx?=
 =?iso-8859-1?Q?IedTwclRp3I5CkaMsf9i3EOOIrsjr0HhvQHE/TARY4BveU2mInFCA+csBq?=
 =?iso-8859-1?Q?zo5twT5BbKpDuMtE6XsNkmfnAYvgMlN4or6E1UBFstzxQ3cNN6az4gnFcZ?=
 =?iso-8859-1?Q?5G5Rfn4PNhGS93BKYur5Zzrv9NGvnbXMjRS10YrdX+Ub72uK/tdo4GlZRm?=
 =?iso-8859-1?Q?NiMKAudr1rCQCmmypeSa0jIjgWL7HFbDTpQa966w24M8psW42iGFPsfFD9?=
 =?iso-8859-1?Q?G6uv//kQeHkBCTS6fygUdbD8afSDrd87xjh+fvYf4HsavezXNNJNuKvLj1?=
 =?iso-8859-1?Q?o+aezvmfXXOaDTDMRb47EhJ0IpIose+tIVQ3Z+ddl1MBaDgLTLUt9n20cU?=
 =?iso-8859-1?Q?/S2uGH3Sam/k8d0eFOlq1l8O1/hDyWrk+8SN/26K+0HimWUci73gjSJ4Nb?=
 =?iso-8859-1?Q?VeHfP3e1cgZTgDnvfebURGKSIhYHjmflkp5t0ojk8PqGv0VZcdn2jN7BU4?=
 =?iso-8859-1?Q?GfaT/HxL/uoP8QU+gXGUbfVAGfD/ZWUIn4bwOaYixJ7CNNPR+6QqQpVSb/?=
 =?iso-8859-1?Q?+KmHn2b+d0F1XY+PHufgWNsNHHFWWsANhKUfP7Dj74KwxfUUK2gTQrytmJ?=
 =?iso-8859-1?Q?VHKk4g//gKCOgZsT9MkKl9VJ0TBbKUKHnnTWGNv0e/HC86RSfESIDXzOhA?=
 =?iso-8859-1?Q?7XfFtEK6JGZlv5i4Lj3BB9dR4s1bYaahlQmShdjHo0H+Lnuepuiuod7wtF?=
 =?iso-8859-1?Q?0WRrsZ03Y7FwPrvzh0mCAQt065AerV4XJMsn4RPc8pic7X3pBhx6XWzz+r?=
 =?iso-8859-1?Q?dPdyqauLBc+7BaisGIQhogoh0+vdeTzYqMVnRX31/as+pAf7t9yMY4Zn0y?=
 =?iso-8859-1?Q?IU7G42xWkH3d+s+IDMlX9+kFhjIam8ursTzQ4qWo7GCBd6I+0wSl4NFl+Y?=
 =?iso-8859-1?Q?hphbUG4Rh2xUiiAgG+zHzyFAYmDAn8AX0lGj4m4mkmDppFaj/IYQUAOTOq?=
 =?iso-8859-1?Q?NjQaz0PRmUBpEM+pG/BsrG2h5gag3fwnRe7Uian+DQ5KpzSNBpuWnl1zVS?=
 =?iso-8859-1?Q?IsJjlMuGcI6Bad6LfwbzP3zvpwvQ/6HaVCS8KMPd48cip35LGlzVan5B28?=
 =?iso-8859-1?Q?nRchlnJ/FG7fjnp0Fb5tg75HmEu88loqIeTAzSnRWvd7Xnr+k3yOgPKlZT?=
 =?iso-8859-1?Q?SzQzfEcu0wOp5FIsyfsn/Lwrm5S0ueFuCsZYCbQd48WwfNHuK4rW1AuG0y?=
 =?iso-8859-1?Q?eYp5o8Jz2nZcqgxy69Zy9J5dpxV1A/M3jpkXERUrVHMfXF8Rym5mmUQvMk?=
 =?iso-8859-1?Q?GSlqvTFuo4Ik4e9Aue8fOB9igJi0C215+DbmXyUb7awBkOujFDGm7GChbv?=
 =?iso-8859-1?Q?5f0UWmn33gzrnvcyXe3GsP0f9oaP4goDeHzDWnKGnX2+4LY8GYWgFTGHl3?=
 =?iso-8859-1?Q?6JAZrd3ht6fpkAg+9lEsAbem66cpyMbZOCy6FpsMWqhdyC1z/pfl4RLxUG?=
 =?iso-8859-1?Q?fbtmD+q35F5iSrbV7mxEJiukGZQKe6JZ2owTj6yiWl3BJCmpjHXKacu999?=
 =?iso-8859-1?Q?1+dttnX2n0Z3x381rzRFaSZnpTSiqdH97iVLtwLlqCb2Ifb0nltM6GrCVV?=
 =?iso-8859-1?Q?uuCcXi4ng0Nn8VUmUI/1S8nQUo00CmXkaJoQWusHpln46H61k0NXCVCMay?=
 =?iso-8859-1?Q?ydaPyCxQBTOonaANiVIhLj2MOXHVzWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df88e168-7685-4551-7da9-08da2d6b5c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:55.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANQhQuPkTc0el0E5Hoj+pDaCLjCtUeLgiWkQqzrM5HKsmq0J3oLOHijburWcOziEWoaUGMfVlayJldqzrw3KzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: EqTx3zfeZuYmMxMFv8WPa-SGc85LQ-w6
X-Proofpoint-GUID: EqTx3zfeZuYmMxMFv8WPa-SGc85LQ-w6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..f70db911e061 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -114,18 +114,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
