Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC46519334
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbiEDBMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244969AbiEDBLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7EB43AD7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LIGp4026258;
        Wed, 4 May 2022 01:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GWOiYkqQmn+pJIG7Dg0YNHEA4x0PIU3szxairurVvh8=;
 b=m8HkLFiIwzx+jF0z0vmrR773eBWMR7A5KOxtnUv0wEUGqbkdkDI8Fy6mpI38oeh3WRfj
 X8Ovgk+OfemL4RllrZdUkCIhKjOM65RrUZ1Xom4BuejnctaqTmk0zXKrK3IVRL+V0DTi
 GR3YrrfAJwUvquJdeQxDyKTRvvVG0hljMUdVdzsnb0YF0lg2VezwlGAGmO4o9Xh5bc99
 8c7hWCZtheOLWYaTvGpCxhnlLUtdSi/OLT4p1yatIt5hXpYJ1tEeKd9B9K+SXd3IzxHq
 zXsLBdukuo55+0Ydkb0mZ1V8IQbd76XO+S9OAC+EWScSYwPHnSsVFH4SncBW3VzdkERe 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:08:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvO039119;
        Wed, 4 May 2022 01:07:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck5YSnG6cNrZG9ob0cylU6nQ6BMHo46VcVgLXTYIlINeyViqCZNFGcyQXD4EPlyx1obG/nvJLy4sCb9b26Wt0VjTRd6uXq8cRlF3YH1NDbMZSfFwomPzFi1lH7FIEUsyhNtmxz8C0ZHlO7FUmVAUF/aVHjOpP3vG65gdC5j3roUp4BeoPAGTXA3ctmaWYpJVDhj8jk3qNjej5BbmKlvfUQIZDfigLMRUiK7c0s9cP0rg1CQyf9iYXruSXvHA3sB00g+0BygJ5wPLI22DYrZjprQOeh8lZKtSHJht+7ZH1Y8CPoedUEB9cuuqhFdVi5oXiEKdkTdBqKQcaKR46JLWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWOiYkqQmn+pJIG7Dg0YNHEA4x0PIU3szxairurVvh8=;
 b=SykXOVz4anG8461BNhQBx0X6aRgpNwBgMsEZEMLdfxF+Sh4wXZ3LmTRO845TugCclk3VqlQDfM+LUEECak16IL4ZuWCsZmlYzo1izsJ3/unQIfTiez3rVn3FhpvicQ1VJnpUzcbpSBcAWW1WcGd5/CjZRqNdNSPVxY6lXpGcT6TwVoKZyNDtz4Za6nXrdgHSGEVWS1WCInBys5Qp/oR0EEWa14Exxm/bN45R4W9hvkfYjnQFJyLSW6AFVwSxQ12jBEvoF7IYv1ZfkXKFFF4nhdlbHBPRLy7CG+mcsUs40amEsxz0c1hudLjB3nQZPZ3pHL5e6fc+Xhls7mvOm4ISlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWOiYkqQmn+pJIG7Dg0YNHEA4x0PIU3szxairurVvh8=;
 b=yUdbvuImMTuWkXCNtde5oBbLhYOKadLG2t3uqApqncLj6Lqf0qYKXz/N57abJiOWVT7PGNzQn686q4c61OAlBML+nbY4tgq3oTL32i0+4ceRSQs4mCKIaPa89IBJ+USpNT4XAYJaRpwps+WJtVjuSyHtHxDrUUvRROlOA84wNfQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 14/69] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v9 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYX1NiUouzRjJT6kSNj3KR0ZygzA==
Date:   Wed, 4 May 2022 01:07:54 +0000
Message-ID: <20220504010716.661115-16-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 273753c4-013e-4dc2-f838-08da2d6a85e3
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4214648806B0D27AA368D8A8FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffYcn0aet1go+3imkCmqO2VhHiwXftDqlIAZXthWgs39c2J0IWxgUOLtpN+uAi68H9sH25JA8srp798jYdt3g0OWab3Ut/B1/Fl0/xDyTMCzTLbJN4MkIR6Nu0rlkpHybKq68CBFRDwttiUy6zN0fVSWUA8LtJy0dMPCKvjt2BSoi+m3+bxT46GoUFhlTmVitSQ5TtR6J4Ede9A1uh5b2oYZRK8JAWb68KBSX30u48RSkSfLU13Irc8MwHlYAQjQWDhywitxZo9BXvmuD93ghm+tQx5dBasINF1LawWPynEn4y3OE3e3CKnunrkCICPRJmSpHXCFXhi5JYjvcdlueZvDgix2sGZdPsTddKtPNnCUbJF+d+KAMMcKMpwRDaEtF5P673+VtWD/ZtDmJht7qQI6wJLfH/OLkMfHLyI09c+QgeNaCsi4m0HgMGQwYulqoT5b+gUfwNkcOm2j5IEFf2sia6kUEyOuAicuia4Y1Hlfn1p4HKz3Smsx3/01ZzAtaZwZpLJ9gYd3b4hYUxFES5sfCb9/M3/+o/wFhMaRpPzS8FWa1Bf6Dhmkk7K41xpBptLP8tmy1QEkcCfZA7rO73WrZkmp6DbTf5gA27F12eKgbGy7TyZxepAXSiyl3Bef3a73y3fntkG8E/3Wq8UP/dYcE7gWrVovcdtvTNQ66oP1SLAQsAweUwbqW1ddmzfeuJI61QQ3Y00SYzrYcXWOkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mfd7OuFxRQMx8kJ9EzuCtcSu+psuVFS6o5217d9o9Z2UDJIH4fJbDrf96S?=
 =?iso-8859-1?Q?Dr7nuTDTm6ZHxXB4b7cISPZohJ0qo4AZbKXoipy7KaM00bioqT1zlKiL9b?=
 =?iso-8859-1?Q?B3xIPPn12aQ9CUDUSKX0wUMapA1nNTE6s9B7j2dB8Q2MvslA7idsHZkHV3?=
 =?iso-8859-1?Q?R0UcEwJkhMZ8Q1ZVq+BUSQ+WNYRajXWYfr7lK37Gxn5+E4fwYR8sOZBevZ?=
 =?iso-8859-1?Q?Yivb3I0ScpazRdH8EYfMeIwQr3Zi7c28RGsJzETezlZ3v3LLQ1ghzcjCXB?=
 =?iso-8859-1?Q?A0ZdwhmfhvdejKCo9cEBUYcK8NrBJzItlp5qUI7NMp+mOmBK7TUR08uTJ+?=
 =?iso-8859-1?Q?3kB1ytXbVPdwwlAM06aBrbLuZ9LzHmx+Fccxo1bU/6UEDqXJTWEyvdG5oM?=
 =?iso-8859-1?Q?DL4b069tio2D1hSWGo+ftIaFHjlOfrZ7b4aw9RUBYVEA9Z8ExC0JcKNcZ2?=
 =?iso-8859-1?Q?KzOSwLSSnK4sf2BeNVPCK+CBhesXwP+Ov+afiYGSVYzPTwWSwx5k/5Gl/3?=
 =?iso-8859-1?Q?XJmGo3tLhXgN/ThvYtuHzJBrAjf+GWCOOnRsqDA2RW+HeO+xAurgZCJklV?=
 =?iso-8859-1?Q?tUHGqbTGbCJu39XSAfK/XRKLgJc6c5q0TElCF5znLeAauMHNhdG5Y/syEQ?=
 =?iso-8859-1?Q?lrbGODN/IlUCaIT0Vvcyn1/6SZenvSmIVRXD7+P3iJtst1mOXdiAlq3rdm?=
 =?iso-8859-1?Q?oE5MaiGNr9uO2RgV1eR7ohdaoJgdVYvRt6MkG2fny/BkzzElDWIG2qH4wk?=
 =?iso-8859-1?Q?0DkbjsuA01Hnsl2sHjJk1sq4+/fFaqqJAHAkYJVwdg0x6HR1h0/vNEZWXr?=
 =?iso-8859-1?Q?JV3cErxPxtB2+g/E566T1I+9Wc3NfnosLxwudMjhUAt5efTVfr8JK0nggn?=
 =?iso-8859-1?Q?Yrg/F2rfSX7ee9VxxX4Gr9RIdC1cjenRm6KPuVyK+MgVRT7M3QEUiszdd/?=
 =?iso-8859-1?Q?XTWciF/nAF6SUlFojdr5RW+tTRO3/7mTKiy+m0VEbrTsJy08RJfY5W6Qtr?=
 =?iso-8859-1?Q?2FSK+wsfwqujd6pLy0kiL2i14nir+0K7n04PafyVfKLZsyVsFNjucwK3aE?=
 =?iso-8859-1?Q?ZW8KnPWGa7Hb6W5xgWb2TwVNyeQRnxpn12fzKlloHw0uByyMqsJDGXG3nQ?=
 =?iso-8859-1?Q?Ve5y9edowzoU3Yiv+gIqE2ynNaF/SnQbOKx5vAsdiTgVRFvTWJ1hMMJEym?=
 =?iso-8859-1?Q?hgrsaXu/ZMY6Uk/RShI5GOe/sUkssoGpmmJ60f6nnKTiQmo1b5u5XX3qO4?=
 =?iso-8859-1?Q?zw0OPoxo+c0DyKP3r3VoFFwMOAYMPgCULLOYzQku9MkZSpWa9M1hvCoZjT?=
 =?iso-8859-1?Q?DV4tdQ5hiSaC9JRb1YL/vFZFKytuwPKyE9CVWGS79j6HeZvqgrj5tgSNB1?=
 =?iso-8859-1?Q?/jJf5S+EjKa97rkWE/IOJuh5pasHjASNnwRl5VFgrGVvte5VREv31fZSdJ?=
 =?iso-8859-1?Q?ZnRsiPeBLW0ljkXtWpdQJZvbvnsGy5zWWEVhp1TDInVOdApLmOX0w6iKuE?=
 =?iso-8859-1?Q?WBR4Oi36mSxtXTH0M3oJz+b6Q0cCLg9LSyzKx6OybpIa/83UO6+/CqTVAt?=
 =?iso-8859-1?Q?e2l+kA1uGLtFOTHehA9DMogCtuCU9/YHnq4a3FRW56p/lJva6gYqOdRNEo?=
 =?iso-8859-1?Q?u88E6ySXJDSScec5rkrGreEibpTbA/s864JaoMr+p1Yf0vIBM38sFyskOI?=
 =?iso-8859-1?Q?zwKBYRrgkuuKGrL7vLPTU/3jQtRl0NpMWa/twYgM2qfkeVfjWIpJ7iGeww?=
 =?iso-8859-1?Q?dGaeeKj6VUArwI4FZxlR8WACacX2ussDxBV4lvPb1tFHRmJIoNou7AbfEV?=
 =?iso-8859-1?Q?Zkbwz9B0qu/HAToCZAcNeAyq8EpnZ5w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273753c4-013e-4dc2-f838-08da2d6a85e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:54.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tj9aKXayg71V+2AVaM7KUGsddFAyQ+1GpLXAAiPLUJfn+0MX2HWlyvTvC2ZDb08nlmaMQf/AHMmur0oLGYcHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-GUID: 0Nv4EM-G8YfE8a0f43I1XYCyGuSsNRR3
X-Proofpoint-ORIG-GUID: 0Nv4EM-G8YfE8a0f43I1XYCyGuSsNRR3
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

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to the
maple tree advanced API to avoid multiple walks of the tree during insert
operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does not
allow for the most efficient copy method of the tree and so a bulk loading
algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 12 +++++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9d9b0d96433a..c259f15c58ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2605,8 +2605,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index bb985cc624fd..79af6e908539 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,9 +583,10 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
-	LIST_HEAD(uf);
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -622,7 +623,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
--=20
2.35.1
