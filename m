Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD1510187
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbiDZPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352025AbiDZPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31E1569F6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT1MS015475;
        Tue, 26 Apr 2022 15:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CdBpZzcJcG0onb+w6Af3iJ7g864CcC56/t/J2YyxCig=;
 b=zu40MG3YgJCf2ve9o5WgahMBCri4ZE/QMg6JqBU1Ceh3tD7QP98kL9E6bJi+tmwadT5o
 NRtN6PLc6ub/KZ2fnvHkIxp2IazlSqW/2JKQVPUYIa5W36cJrGrxb1Ql9ThcPNB8qL1i
 //U3t5pn9XjSALgS9A96Znh5dZiu7pog6yVw8SrECMZUPe11yZW3w6Ro339lxr/RnVCU
 jzaJKVVJEx++4EEVqNPGEc9nJnDENugTZ7edPzEqzwMFpTpXQDdvlu6HXrjwpbsn8vf9
 J/rQV0UcCn0bdC/ylUJQMavfeCL264sE4krdrCGKRNMyCK5Dv7zLbdhqaODuEUwdtUs/ bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Us3037859;
        Tue, 26 Apr 2022 15:06:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1qhK1MQhI4vpKpjwP8FPf7GghFCeKX3ijK3d/blf0mO+WYj227iuBa8Qh7eh50m6XrJec2xoKUm+q6bGrVDoLPegKV+6gAucQ+kN824GmS4KXup/evhzbaJNA+RZIrs+g4tyPVu7xaZSWDD6t9EhJ32COVNAXFt6M/ICavtmoGmZqT8a6SztbwePoGq9H5VZXSr+uQLzNqTm4vAvBIjKiUHu6d7CrEBdXDXzarB53EyNfR1l0RuAJIm2M3XrwhCgnl+/HX+ovJUfiPDBxlHdKJ8GmosGAEMfEL1Jq32coaAIpiglXKXOosdpUY4y9CNBSFoS70U75ACnbJRaoZy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdBpZzcJcG0onb+w6Af3iJ7g864CcC56/t/J2YyxCig=;
 b=Op4fMG0gerGw92RrqfZbukbMJa+9h7B2x5Pij4Ik/8CcGS1VrFiFWtzPHAFdm9TTdip5Uv4lFMqpioxg/cub4mj7Ab/XAflNb/2CEXlwHm4DpYc9gZdd1Ty6po+427CfJQuL1dgeWzV3O48mXf2SbgrlUIddEy3XSBk5W0rT7VIWx/LVZQ0udRHGbmwvyEq2j4TZJ9pOY11x1rnh1L07VCcDGfN+GByvqDJsP5w5oOrTKtP1i7VqiH6wMO+iscC2KT0C/4ePbUZTaPRrJCyfxGhMoud4+hMYFNPnPgaxR5Q9uIL61fai9zIwayH4siRca/xTbpyCCzzsDP3j3ntG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdBpZzcJcG0onb+w6Af3iJ7g864CcC56/t/J2YyxCig=;
 b=QHGh48r1/aVmNQa8aNTtU/JnjICLlequnJV0Cjfr56JCllgC9kRYRHeHpus2lvofY1X31dYSS7rl8abgllJ4F7vcHo5le0rXdjZVxaGGilWD60AHC0FBdX2TAhAkfm/H3Wp2khruitBq4fuD4IABPyd13UcZie8ZvfsCCSwfoRM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYWX84+45146fpu0iPsmgBhR+6VQ==
Date:   Tue, 26 Apr 2022 15:06:35 +0000
Message-ID: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc348590-bebf-4107-4430-08da27965b9f
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB46795656BB6E31AF1647FDB5FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUoJcAtS+XB4WW6AGKj8q4FsCUulSrspTaW9X888azIEgA9wp9J+E6RX1qUUrHhqwKhf1rzSnZlOa6JTgm1r2Bh+B2ApcUVOW/4FLGkRbdsXeLng8rZq1KJz4gr/mKmcfg6ofXxuf/TPBPG9evPLsZJvUPiDaKkRzCrCcWCDmfvtKkuVZgQJgnIP3nx1aUYOvLUwo5RD2FbOeKK3RnQ2JdTGU2chB7IBEFgsvW/hZ9g/SBovmg+nix4orM9ChgtnGBINFfZ6bKmpgV8lce17uMTRUql5Uofep5Cs0OTAdE6Cu2ZkJTSr1Il4F0JMLxRL16m29pDBoy62QHCgemn02KFVrAUxRIolf6Gs8lxn/ug7nLKmjG1s0S5Q0tiGrJOVsvY8HZE4s+y+4+ol3oBJsfMDbChNwOishCtYDrTj3tcNcmpUYXyoCtRt6PDGK7FDkdJxPBzJnJgk2vczLgfVn9YMAK1HXohvtpzXLwCedcqAABjGZOaJOuR/c6Dcczko3QHwhkA2XdTaHxO6KOODm4LKp9KlItMTnSLkrKHmjRzo7XLK07gb8ClqoqVOCYklcZO5PAGN/K8j7/6VdH6Yg6C+loOwmW5o14gAuRLXl2pj6yUKRqk4Qx1WgzlMpDgeBQGYdDhWqiCZtN1kAQJvUGD9CP7vb4vHE5Q2YcsGCljduW6eAskqvOmPBWtYLP3QbMIvqwNkFO/WxASFxscwaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(30864003)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fUG8GPHfpy34qaLAZ3cEsMwUA0/95eJ5kyxN/ua6fHhxtZTbxvJJ6ZZouA?=
 =?iso-8859-1?Q?Z3JglUXHssSmAZng0Y5QQDhdZTnmBnfeU0uQw9pNrB9fytMBXqtCO0+GjR?=
 =?iso-8859-1?Q?mlYqJ6aXnlhHXv0R3K9cCfv+pS6dMUx9O0GUVsQUGW006n1nbmHms+OHKW?=
 =?iso-8859-1?Q?EHxpfar7Ym6nv2IVNimB+58FZhiC8ApBVnkFy/+06pSasc86lSnPeAWVn6?=
 =?iso-8859-1?Q?eVkCh3yE3lS1BNfvDmBcxvX+shgO75mafNHOtV/V+KlQ7uJ5XKXSArRPHL?=
 =?iso-8859-1?Q?GpqYh+bRS/ciNcn2rhr6Ru+QDo/vMNvn2AjfXbsBhVelwJdN+zyfH/zHtb?=
 =?iso-8859-1?Q?Pja6f7DnaE+XqBjXu+71uPddlzPND1HVNBGeE9YuP+/cEQruWQb14z2/Xh?=
 =?iso-8859-1?Q?agigosST/1LgMWdfRdq+5BWX52d1sLCniYCY+7RoIRhqHwyNOMfW2IT4qI?=
 =?iso-8859-1?Q?kdiWzHwbop0t3SPcdeyjSJt+nOBgA8WOjki0Eiul8Z+sAX55ZXqECzDW4m?=
 =?iso-8859-1?Q?qnkE7d0kUh9hL9+GFwIFTHl9SfWaQsXogonQlQd0ek71SZRUqouV8dDct7?=
 =?iso-8859-1?Q?OD0f4gy+Y+PLfsMZj6jj5PNLci5TlrUYKoX8Ev68Air/Q/GbY9W4njWAWH?=
 =?iso-8859-1?Q?f72HfuGk2W6Ed/k6vbztQ0cF4WFFxwMuIQDzN5N+/FSfZtWt8RyxOc9nco?=
 =?iso-8859-1?Q?ne3qnYmqkDkKaQuFqBG3B9YdCwHWyNGiwPsg9omqfswTE6xKzxLgIU8/mV?=
 =?iso-8859-1?Q?7YGIOr+h4IiI9lkvSrdIvtQMcpoAZkJXNwMhO2ZJwvcZr3di59+hYYOgqC?=
 =?iso-8859-1?Q?xHpB+p/T7rDSecW4EmE5U+55vWLJg7y75Fvn/dFW6auF5910AHwb1OBNXR?=
 =?iso-8859-1?Q?7ZxdD4VWitgYsq6iG6ZU6LfGxTAvTkrnJqdMe5J4ZEodCRHp2ZUqaz3OSI?=
 =?iso-8859-1?Q?SOES+rdSVri7+UivjhIiDpqfMZxl399vwe7zvKw3H5yejhCG/Jb53puOEb?=
 =?iso-8859-1?Q?9MMoCdubkGX8qVb4k24c8i8Fj1fWk4HUIL0kYTUnN8d79jif7U37bPBm9r?=
 =?iso-8859-1?Q?WagOOzU/oP5kg/HpZSSvchkgwP3b3ea0S34xOb5AfG3ortFxiaOcDbdnlE?=
 =?iso-8859-1?Q?jDFPrzJ6tfEyTRCcQJ171Gpd7cWk6vsag8YMbzQ9QChWCK5paQ4r40hgVF?=
 =?iso-8859-1?Q?+4kiZvox+lhen2tPxFeG+9OVSnwcsuA0Cqqb1ILm9ef4ExPWFX2e6d68of?=
 =?iso-8859-1?Q?4i8Ti4eu4NGM+NB68UQnsu1oN9wsmADmyU5IhTsTCVCBjHrCHk7IGX4QSa?=
 =?iso-8859-1?Q?eODT6EWzvykG9UZ9cf0F5JCqYMjQZpggT6rmYoj+FaPcrPgYpDQE37u1u3?=
 =?iso-8859-1?Q?i8qBCPizI7qZzkVi1ekmJ7efUfZ155SIQMRyTlHjkO1wGmQ+YWoucwenFR?=
 =?iso-8859-1?Q?TSkQCOIzjnjhxZj9VTlFIYK1oaIbEYKKD+eLgUL0rNxh7kGdGDYzXD08ph?=
 =?iso-8859-1?Q?urIkvoXTXsNkXQNlUQKSXamXWbAc/+P1+DKhLDLwIlf1DvZXM6yKryMbSR?=
 =?iso-8859-1?Q?P8Elzo4gl7dZ6O1CZUBjrd1V/BNm74l/0/Na1UtwpuBBhpfPAAiSG4++wj?=
 =?iso-8859-1?Q?eKMA/IyHAE/up2TRrUytd29NmX39H1DpQSuKf1y6Qb9VjBePxWqPS7R/Jf?=
 =?iso-8859-1?Q?T16T//keLPsRF8tyEi5MaNjQeL/5xcEh/3wkYmYRl9Xw5g42TSix7j1uBt?=
 =?iso-8859-1?Q?2USLcTyeXFTqJyBA2LB1WdZ6lkVvipLROlrGZhXx9exBe+nyDCLrUwP1jV?=
 =?iso-8859-1?Q?GevWTfA/uLv/Pu1N65VZkOl1AtFXUec=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc348590-bebf-4107-4430-08da27965b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:35.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sKyGPJf2gdvVs+BvI2hwPsYYMDIYt9HuGJLOvI47fLkRiA83kQkGjCCMeLrMDPIQA7k4nojBU8NKMxx3JRm9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: MlxXzqNSxEGmyPaZp702ZR82DpMWCk7v
X-Proofpoint-GUID: MlxXzqNSxEGmyPaZp702ZR82DpMWCk7v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 281 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 223 insertions(+), 58 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ec09b68a3e0a..aeefa2c7962f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -197,17 +197,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -249,35 +272,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2732,38 +2772,113 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		return -ENOMEM;
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vma->vm_end =3D newbrk;
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	vma_mas_remove(&unmap, mas);
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
=20
-	/* Check against address space limits *after* clearing old maps... */
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED)
+		mm->locked_vm -=3D unmap_pages;
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+	validate_mm_mt(mm);
+
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2773,30 +2888,52 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		mas_store_gfp(mas, vma, GFP_KERNEL);
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma_merge(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if(vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	mas_store_gfp(mas, vma, GFP_KERNEL);
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
=20
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2807,18 +2944,21 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2829,13 +2969,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
