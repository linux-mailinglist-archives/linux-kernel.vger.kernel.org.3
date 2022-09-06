Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5322F5AF4BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIFTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIFTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF909F1B2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9bG020014;
        Tue, 6 Sep 2022 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=d0WqjIyOin5lT4evYs5Gl3Ooe71ZYDLBRySaYeymxDk=;
 b=wnwXpEkAEXpZqficcXgsVAYJ/dXDJwbXSo3zknfUNyokE3F9pXavBWrh/rW+WnxJRpwt
 jddl+awvGds2o1V55iedoJc0fp6250VurOc2IdJYOwKBT5jwgSw9eOzgVvcK2Fwhiqua
 NZgY9w1i6lki9mQv0gHu4QYuAFxi6CYqPBV1y8tJ/OMd6i1md8Sw+7nbZ032YFFkLbFv
 Q8u7uesgUSg0NOprhtMjH0LOcryD95kkQ/qi2VsiORc5lfqHknuYjMat97ZmXw/ftnke
 tFwfjK6gBhD7I8U9lAjAJr9+jYc2RQkqPEdqR94dHkAeDArvSBS48MHgzMYgseQGHss6 Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wb027549;
        Tue, 6 Sep 2022 19:48:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGPGpjZCrYJmFOJ+M753/45rvt1aha85idXVt+D7HDk+SfrTI9rdFl2OP8Oq6nMW+7Xs9Od8y4ZHlQqYy+L3p+pM9SZIkfLiL4qD8m5W1d4Aoews8xINWhnfTrIuqmGT92VdMOFXFDjZBa/XArcrTnznZEoDcTZCyPm+f5avqMW9aMtBJJkIDNjQbiGA4zSUf6Vfae1gzoXpnwKXfSQFxRYh+b00jbbZ/aGQ/Z0grUtLO4V1zTLxdOwimRrYIHipRyHS4kbYb75VWljGIi64E2YtS5LfSd9PE95IjDWYMczrblDhNBERjMOwnAvcTG+nMyDX6S3K0fDwqMa1a9ZqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0WqjIyOin5lT4evYs5Gl3Ooe71ZYDLBRySaYeymxDk=;
 b=L2cMZQ65IHzEazcx6AD8BOkNOpcb2HgKBcAnnIjpu6kUFA3dEIGxJx85wbhNmbDitPN+Hn3nAy+6k+L+TPEqsQn/BNCm3UUmoBd1H22ACsOalMiLuKn+D0tlF2N0D+IVgy/Ui6nCgIGq2btKlpZxKvV9yzR5Uqx2vPyYm3HgoVPndlcLSddCgTIRIUet/CMCwqs8X6oUSCh/+jtR6Jo5GOfaqVPNNrnwCcCm2519uz+Ja8+HIPPe1fw9yabw6y12KMXy9SNXCg/byefehtnzIAZCbai96iknq2W9XN1nnAj4Rsc2TymV7M8GwQGrUBT1IpErDA0ob9YQL1jnJkCWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0WqjIyOin5lT4evYs5Gl3Ooe71ZYDLBRySaYeymxDk=;
 b=hgd8Cjpn/22hbtbMn0u2os8nULVY8Y2NuVXrLDrr1U4sfU72e5Mih6SgG8kBPxDmPtI/vytI5L+WMUEqSU3ozBadpaQ4Hprb5yaIdaii2tGfd7zXcR6V4bkHuZY8AM+ni5PIr4fEosUFLGKE+LYjalgV8pfV2pBshaPgSgWAGuA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 17/70] mm: remove rb tree.
Thread-Topic: [PATCH v14 17/70] mm: remove rb tree.
Thread-Index: AQHYwimuwyJNjLEqLEO4Cz3iu0C8oQ==
Date:   Tue, 6 Sep 2022 19:48:48 +0000
Message-ID: <20220906194824.2110408-18-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9622eff-3af8-47a2-9ccf-08da9040d537
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMvBzlC/1s6mhfqMLvIBswsqRePqwDT2v3FFJYxKTMSmh2DjHtxXd2QrheRjOj8llKvc8dkz0U/95p27PLhPtZj4Mdwwrt4K2VgADTNDot8SlG6ABGyO96hUS7VFT+BcjR5y1xJQEXmZzoIAF6PbF6AAR726GMhGpwEUATwn9DYpcj+4hV7MZs4ISm6zLt+WtNJgS3Vb/PFCOjjuLEqOQA8qQhTEemoDY+Elk9vW4G7ByyARADH0LCUk11ojV0KWndigvxo3w0tiERl9pXa5dKjlT6HHnDMLaaetolNLrbhZYvJLr3Zjwb2brtew/zuA2ziiwm3mTnuIEmcAWOXOTpazvPLT5E4VdK+ScG4vLKGaoGuSf8vlvL46/jUEE6NBj7e7e8e69X88tBgwFKweyUnmKvxqt7EihJl6gYE5bZHM6pdPgp3/7fB0Vq7TzzbMDBfRKMcEdM1ZY1C4X7RBUVPUpqnTWayCXJAHaG28PuUXwviYvcRHJ1ymBi1TygWGku0dBKYub6YqFtmCRd30WdpAxSVe/FW5pOvsonDNu+IZseD4tYn8V+otlcEgyXnVTnpUGO0YZ7hoQk3RdjJnnIaZHdF/Lf34UefvhtTN7l+txHn9D8//y8lkoCTRBlUDnpm53bDnqx4aHwAXxfkIfwdRMOtXpTA02yXVGYTBx4Q3/4ngDEMLjBpb6m+OjuXZXqmwjg6jyvHqfC98ChdimoDUfroQO0moufX/xSN+PZs2wl5sZs9JOcTDNmU87uKsKoF3UkGKePQC04i/EIeziQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(30864003)(71200400001)(6666004)(38100700002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lRhLHcy2A8x9F/7lJDzkqje5BtQTM7nsakfhActZJ1rATxnZaaoqG0A62i?=
 =?iso-8859-1?Q?DC8kFbWSMgGhomTjuPaRJyUj6fXI2uo3150G+ORCwm1Q6XS955GZ6mjpU1?=
 =?iso-8859-1?Q?DUpOI9hdyVpIwHclcTHtbVfFGguBGEW6XrMFQkE9HyA2GZ+Yhuv5+rntGi?=
 =?iso-8859-1?Q?owmx/CWrTrrVpL1lUDnUsLJ6/b1GOs0IZ6dNZUf1q86gHWIVXXpBal4553?=
 =?iso-8859-1?Q?s8mhTW7KmndIVRQoxnTwQKD23fQba0WtB5YdjU1kSnHYmJ4HR4bPk4hugB?=
 =?iso-8859-1?Q?CckgTyxU6IeZQpN8AJMhQSqkBIABjjhhUd7EHAXTBMfBegWLKtDS+MNiYD?=
 =?iso-8859-1?Q?m3cbie06P0V+tFqrifMZVEksqHEDFnAry67dtNAZWsgCNdSYbKFRlFarwl?=
 =?iso-8859-1?Q?MrVu5B3+wxtCljC2Yb2tNht9Jk2Z/jCt8zkeoDhaPrhk2YFJE76xNvyyOf?=
 =?iso-8859-1?Q?G13RSsYfNX19ZpnEtigRfpOxfDPLAuAoO214igsbh03tEfKvOR9u1jDRj9?=
 =?iso-8859-1?Q?WmwSaMKv79f9sPi0WjwebzqZspat3fEQst7aHlOelJ8JfMhjn2nxt8llx/?=
 =?iso-8859-1?Q?t8X2WtG8Ey5Mc3J+jueF0vDeEXoHqzoyEPsTu2TzlkyKk51p+ftZ0xDAL8?=
 =?iso-8859-1?Q?jWQ85cLt++uKvmpmkqBVgyISmiBqEgkWqvZeidGfoBQxCquvZASMQSq4O4?=
 =?iso-8859-1?Q?f8gA1OcONaGI0Jpw6J5/mGp2Gy0yr2PlFgmiPJgz8GeVYZ35I+rlhQM5jT?=
 =?iso-8859-1?Q?dliQdtuLy8QVU0cyCTLH+J8q0yMgz9D3dnjFOOyT18Npqx6Ln+ZfSwNnu3?=
 =?iso-8859-1?Q?qdbFzlSdFNtcsyb9fd2376nblw8MeTQw8MfaqtVt4sFRmdjX6obE7XQopK?=
 =?iso-8859-1?Q?5eAti8MylfLS/BFLuZ49XdZ/fvIRirYmnHDbKM5kkSu17PmkX/UMqrO6uZ?=
 =?iso-8859-1?Q?NwG7EWX73ra+14msFt5wjzoQQjEOie8rJxkvvC1FiWUr+sBlLCXGC5Supy?=
 =?iso-8859-1?Q?ifpq9mBJdBltQdWc5AKECkErqqHxpRCuluxiq4X+Ocvp7Wz/hudKobfTev?=
 =?iso-8859-1?Q?4+XEyeFYRnc5n9bctG3aXICHRHfv4jqAyDRmQBgFYSySgTLxtVqZc3+3uT?=
 =?iso-8859-1?Q?NNhlBQUdV8r97MVCfTX73ZEflv+n0GtAPejJudfSw/ZPUXNSojvl98xh6v?=
 =?iso-8859-1?Q?tZiJrqN5vqhREQjIiLNOSo2nGQgEHv3p3P3NHYNmp26KDdbVHzknzRPMcA?=
 =?iso-8859-1?Q?Vo9Gq3HOukE1frVWN0VDAVjDUDh2cC9LE0ncTvgVkya3E8wogkmR1YfJGW?=
 =?iso-8859-1?Q?dIKriSwB4tSUNgQp7PsiCpocjgYCT7sDTdw9yxRkJE+R0SbHDos7osSdg/?=
 =?iso-8859-1?Q?h7pno24sHZlgZU4q2s3EVleWa4juEX+2Z01VmIVBaGkPAT0cTKG5JFlYEK?=
 =?iso-8859-1?Q?hPLMyy4Ccnqj1l6Wxi/limRu8xZ0yx3o+z/DngXUccjdBEE1+5l3uWKZwW?=
 =?iso-8859-1?Q?HHgcTDqhDj66+EEuro4wHnmjO8i8ghDySJnGN5qtvqHAdhesTbgB+Eght7?=
 =?iso-8859-1?Q?Q0YiMXfGDafPMESbTFsTStcuZWUITqsAdky6Gw242e0npH+QawVN8b7wME?=
 =?iso-8859-1?Q?0jeDtcxeBQy4yYbL582D2TAtSXj5YPaaGXt9PyWgGeI9psaquVDDrFjA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9622eff-3af8-47a2-9ccf-08da9040d537
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:48.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fiW6ez0GvXqV9N1gZMzLT3UDuhKwKpDOvLDNPJ4Gb4BHv8h73XmZntaRmPsuGCx5KUH+MtP6bPCdbCFTBQxiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: DUld8pHyz-GPO4hhJkzK700fLTL1qLAJ
X-Proofpoint-ORIG-GUID: DUld8pHyz-GPO4hhJkzK700fLTL1qLAJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the RB tree and start using the maple tree for vm_area_struct
tracking.

Drop validate_mm() calls in expand_upwards() and expand_downwards() as the
lock is not held.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c    |   1 -
 drivers/firmware/efi/efi.c |   1 -
 include/linux/mm.h         |   2 -
 include/linux/mm_types.h   |  14 -
 kernel/fork.c              |   8 -
 mm/init-mm.c               |   2 -
 mm/mmap.c                  | 506 ++++++++-----------------------------
 mm/nommu.c                 |  87 ++-----
 mm/util.c                  |  10 +-
 9 files changed, 144 insertions(+), 487 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index e01544202651..4c1bcb6053fc 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -95,7 +95,6 @@ void __init tboot_probe(void)
=20
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
-	.mm_rb          =3D RB_ROOT,
 	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7b6a815b79d3..042a3ef4db1c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -57,7 +57,6 @@ static unsigned long __initdata mem_reserve =3D EFI_INVAL=
ID_TABLE_ADDR;
 static unsigned long __initdata rt_prop =3D EFI_INVALID_TABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
-	.mm_rb			=3D RB_ROOT,
 	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fef2cbdb44bb..cac845989bfd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2658,8 +2658,6 @@ extern int __split_vma(struct mm_struct *, struct vm_=
area_struct *,
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
-	struct rb_node **, struct rb_node *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a249a7d5f5da..b9ae6ab41444 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -412,19 +412,6 @@ struct vm_area_struct {
=20
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next, *vm_prev;
-
-	struct rb_node vm_rb;
-
-	/*
-	 * Largest free memory gap in bytes to the left of this VMA.
-	 * Either between this VMA and vma->vm_prev, or between one of the
-	 * VMAs below us in the VMA rbtree and its ->vm_prev. This helps
-	 * get_unmapped_area find a free area of the right size.
-	 */
-	unsigned long rb_subtree_gap;
-
-	/* Second cache line starts here. */
-
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -490,7 +477,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
diff --git a/kernel/fork.c b/kernel/fork.c
index 16970c346b5b..5f81c009bb20 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -581,7 +581,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 					struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
-	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
@@ -608,8 +607,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	rb_link =3D &mm->mm_rb.rb_node;
-	rb_parent =3D NULL;
 	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
@@ -701,10 +698,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		tmp->vm_prev =3D prev;
 		prev =3D tmp;
=20
-		__vma_link_rb(mm, tmp, rb_link, rb_parent);
-		rb_link =3D &tmp->vm_rb.rb_right;
-		rb_parent =3D &tmp->vm_rb;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1133,7 +1126,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
 	mm->mmap =3D NULL;
-	mm->mm_rb =3D RB_ROOT;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b912b0f2eced..c9327abb771c 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
-#include <linux/rbtree.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
@@ -29,7 +28,6 @@
  * and size this cpu_bitmask to NR_CPUS.
  */
 struct mm_struct init_mm =3D {
-	.mm_rb		=3D RB_ROOT,
 	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
diff --git a/mm/mmap.c b/mm/mmap.c
index 68ee2958c0be..f60d83c7f233 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -39,7 +39,6 @@
 #include <linux/audit.h>
 #include <linux/khugepaged.h>
 #include <linux/uprobes.h>
-#include <linux/rbtree_augmented.h>
 #include <linux/notifier.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -247,93 +246,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
=20
-static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
-{
-	unsigned long gap, prev_end;
-
-	/*
-	 * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
-	 * allow two stack_guard_gaps between them here, and when choosing
-	 * an unmapped area; whereas when expanding we only require one.
-	 * That's a little inconsistent, but keeps the code here simpler.
-	 */
-	gap =3D vm_start_gap(vma);
-	if (vma->vm_prev) {
-		prev_end =3D vm_end_gap(vma->vm_prev);
-		if (gap > prev_end)
-			gap -=3D prev_end;
-		else
-			gap =3D 0;
-	}
-	return gap;
-}
-
-#ifdef CONFIG_DEBUG_VM_RB
-static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
-{
-	unsigned long max =3D vma_compute_gap(vma), subtree_gap;
-	if (vma->vm_rb.rb_left) {
-		subtree_gap =3D rb_entry(vma->vm_rb.rb_left,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max =3D subtree_gap;
-	}
-	if (vma->vm_rb.rb_right) {
-		subtree_gap =3D rb_entry(vma->vm_rb.rb_right,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max =3D subtree_gap;
-	}
-	return max;
-}
-
-static int browse_rb(struct mm_struct *mm)
-{
-	struct rb_root *root =3D &mm->mm_rb;
-	int i =3D 0, j, bug =3D 0;
-	struct rb_node *nd, *pn =3D NULL;
-	unsigned long prev =3D 0, pend =3D 0;
-
-	for (nd =3D rb_first(root); nd; nd =3D rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma =3D rb_entry(nd, struct vm_area_struct, vm_rb);
-		if (vma->vm_start < prev) {
-			pr_emerg("vm_start %lx < prev %lx\n",
-				  vma->vm_start, prev);
-			bug =3D 1;
-		}
-		if (vma->vm_start < pend) {
-			pr_emerg("vm_start %lx < pend %lx\n",
-				  vma->vm_start, pend);
-			bug =3D 1;
-		}
-		if (vma->vm_start > vma->vm_end) {
-			pr_emerg("vm_start %lx > vm_end %lx\n",
-				  vma->vm_start, vma->vm_end);
-			bug =3D 1;
-		}
-		spin_lock(&mm->page_table_lock);
-		if (vma->rb_subtree_gap !=3D vma_compute_subtree_gap(vma)) {
-			pr_emerg("free gap %lx, correct %lx\n",
-			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma));
-			bug =3D 1;
-		}
-		spin_unlock(&mm->page_table_lock);
-		i++;
-		pn =3D nd;
-		prev =3D vma->vm_start;
-		pend =3D vma->vm_end;
-	}
-	j =3D 0;
-	for (nd =3D pn; nd; nd =3D rb_prev(nd))
-		j++;
-	if (i !=3D j) {
-		pr_emerg("backwards %d, forwards %d\n", j, i);
-		bug =3D 1;
-	}
-	return bug ? -1 : i;
-}
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
@@ -361,19 +273,25 @@ static void validate_mm_mt(struct mm_struct *mm)
 		    (vma->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
-#ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and next in rb\n");
+			pr_emerg("and vm_next\n");
 			dump_vma(vma->vm_next);
-#endif
 			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			pr_emerg("rb vma: %p %lu - %lu\n", vma,
+			if (vma->vm_prev) {
+				pr_emerg("ll prev: %p %lu - %lu\n",
+					 vma->vm_prev, vma->vm_prev->vm_start,
+					 vma->vm_prev->vm_end);
+			}
+			pr_emerg("ll vma: %p %lu - %lu\n", vma,
 				 vma->vm_start, vma->vm_end);
-			pr_emerg("rb->next =3D %p %lu - %lu\n", vma->vm_next,
-					vma->vm_next->vm_start, vma->vm_next->vm_end);
+			if (vma->vm_next) {
+				pr_emerg("ll next: %p %lu - %lu\n",
+					 vma->vm_next, vma->vm_next->vm_start,
+					 vma->vm_next->vm_end);
+			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -396,21 +314,6 @@ static void validate_mm_mt(struct mm_struct *mm)
 	}
 	VM_BUG_ON(vma);
 }
-#else
-#define validate_mm_mt(root) do { } while (0)
-#endif
-static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
-{
-	struct rb_node *nd;
-
-	for (nd =3D rb_first(root); nd; nd =3D rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma =3D rb_entry(nd, struct vm_area_struct, vm_rb);
-		VM_BUG_ON_VMA(vma !=3D ignore &&
-			vma->rb_subtree_gap !=3D vma_compute_subtree_gap(vma),
-			vma);
-	}
-}
=20
 static void validate_mm(struct mm_struct *mm)
 {
@@ -419,7 +322,10 @@ static void validate_mm(struct mm_struct *mm)
 	unsigned long highest_address =3D 0;
 	struct vm_area_struct *vma =3D mm->mmap;
=20
+	validate_mm_mt(mm);
+
 	while (vma) {
+#ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
=20
@@ -429,6 +335,7 @@ static void validate_mm(struct mm_struct *mm)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
+#endif
=20
 		highest_address =3D vm_end_gap(vma);
 		vma =3D vma->vm_next;
@@ -443,80 +350,13 @@ static void validate_mm(struct mm_struct *mm)
 			  mm->highest_vm_end, highest_address);
 		bug =3D 1;
 	}
-	i =3D browse_rb(mm);
-	if (i !=3D mm->map_count) {
-		if (i !=3D -1)
-			pr_emerg("map_count %d rb %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
 	VM_BUG_ON_MM(bug, mm);
 }
-#else
-#define validate_mm_rb(root, ignore) do { } while (0)
+
+#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
 #define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
-#endif
-
-RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
-			 struct vm_area_struct, vm_rb,
-			 unsigned long, rb_subtree_gap, vma_compute_gap)
-
-/*
- * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
- * vma->vm_prev->vm_end values changed, without modifying the vma's positi=
on
- * in the rbtree.
- */
-static void vma_gap_update(struct vm_area_struct *vma)
-{
-	/*
-	 * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
-	 * a callback function that does exactly what we want.
-	 */
-	vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
-}
-
-static inline void vma_rb_insert(struct vm_area_struct *vma,
-				 struct rb_root *root)
-{
-	/* All rb_subtree_gap values must be consistent prior to insertion */
-	validate_mm_rb(root, NULL);
-
-	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *roo=
t)
-{
-	/*
-	 * Note rb_erase_augmented is a fairly large inline function,
-	 * so make sure we instantiate it only once with our desired
-	 * augmented rbtree callbacks.
-	 */
-	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma=
,
-						struct rb_root *root,
-						struct vm_area_struct *ignore)
-{
-	/*
-	 * All rb_subtree_gap values must be consistent prior to erase,
-	 * with the possible exception of
-	 *
-	 * a. the "next" vma being erased if next->vm_start was reduced in
-	 *    __vma_adjust() -> __vma_unlink()
-	 * b. the vma being erased in detach_vmas_to_be_unmapped() ->
-	 *    vma_rb_erase()
-	 */
-	validate_mm_rb(root, ignore);
-
-	__vma_rb_erase(vma, root);
-}
-
-static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
-					 struct rb_root *root)
-{
-	vma_rb_erase_ignore(vma, root, vma);
-}
+#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
=20
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -550,39 +390,26 @@ anon_vma_interval_tree_post_update_vma(struct vm_area=
_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-static int find_vma_links(struct mm_struct *mm, unsigned long addr,
-		unsigned long end, struct vm_area_struct **pprev,
-		struct rb_node ***rb_link, struct rb_node **rb_parent)
+/*
+ * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
+ * sets up a pointer to the previous VMA
+ * @mm: the mm struct
+ * @start: the start address of the range
+ * @end: the end address of the range
+ * @pprev: the pointer to the pointer of the previous VMA
+ *
+ * Returns: True if there is an overlapping VMA, false otherwise
+ */
+static inline
+bool range_has_overlap(struct mm_struct *mm, unsigned long start,
+		       unsigned long end, struct vm_area_struct **pprev)
 {
-	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
-
-	mmap_assert_locked(mm);
-	__rb_link =3D &mm->mm_rb.rb_node;
-	rb_prev =3D __rb_parent =3D NULL;
-
-	while (*__rb_link) {
-		struct vm_area_struct *vma_tmp;
-
-		__rb_parent =3D *__rb_link;
-		vma_tmp =3D rb_entry(__rb_parent, struct vm_area_struct, vm_rb);
+	struct vm_area_struct *existing;
=20
-		if (vma_tmp->vm_end > addr) {
-			/* Fail if an existing vma overlaps the area */
-			if (vma_tmp->vm_start < end)
-				return -ENOMEM;
-			__rb_link =3D &__rb_parent->rb_left;
-		} else {
-			rb_prev =3D __rb_parent;
-			__rb_link =3D &__rb_parent->rb_right;
-		}
-	}
-
-	*pprev =3D NULL;
-	if (rb_prev)
-		*pprev =3D rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-	*rb_link =3D __rb_link;
-	*rb_parent =3D __rb_parent;
-	return 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	existing =3D mas_find(&mas, end - 1);
+	*pprev =3D mas_prev(&mas, 0);
+	return existing ? true : false;
 }
=20
 /*
@@ -609,8 +436,6 @@ static inline struct vm_area_struct *__vma_next(struct =
mm_struct *mm,
  * @start: The start of the range.
  * @len: The length of the range.
  * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- * @rb_link: the rb_node
- * @rb_parent: the parent rb_node
  *
  * Find all the vm_area_struct that overlap from @start to
  * @end and munmap them.  Set @pprev to the previous vm_area_struct.
@@ -619,14 +444,11 @@ static inline struct vm_area_struct *__vma_next(struc=
t mm_struct *mm,
  */
 static inline int
 munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct rb_node ***link,
-		 struct rb_node **parent, struct list_head *uf)
+		 struct vm_area_struct **pprev, struct list_head *uf)
 {
-
-	while (find_vma_links(mm, start, start + len, pprev, link, parent))
+	while (range_has_overlap(mm, start, start + len, pprev))
 		if (do_munmap(mm, start, len, uf))
 			return -ENOMEM;
-
 	return 0;
 }
=20
@@ -647,30 +469,6 @@ static unsigned long count_vma_pages_range(struct mm_s=
truct *mm,
 	return nr_pages;
 }
=20
-void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct rb_node **rb_link, struct rb_node *rb_parent)
-{
-	/* Update tracking information for the gap following the new vma. */
-	if (vma->vm_next)
-		vma_gap_update(vma->vm_next);
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-
-	/*
-	 * vma->vm_prev wasn't known when we followed the rbtree to find the
-	 * correct insertion point for that vma. As a result, we could not
-	 * update the vma vm_rb parents rb_subtree_gap values on the way down.
-	 * So, we first insert the vma with a zero rb_subtree_gap value
-	 * (to be consistent with what we did on the way down), and then
-	 * immediately update the gap to the correct value. Finally we
-	 * rebalance the rbtree after all augmented values have been set.
-	 */
-	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
-	vma->rb_subtree_gap =3D 0;
-	vma_gap_update(vma);
-	vma_rb_insert(vma, &mm->mm_rb);
-}
-
 static void __vma_link_file(struct vm_area_struct *vma)
 {
 	struct file *file;
@@ -738,18 +536,8 @@ static inline void vma_mas_szero(struct ma_state *mas,=
 unsigned long start,
 	mas_store_prealloc(mas, NULL);
 }
=20
-static void
-__vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-	struct vm_area_struct *prev, struct rb_node **rb_link,
-	struct rb_node *rb_parent)
-{
-	__vma_link_list(mm, vma, prev);
-	__vma_link_rb(mm, vma, rb_link, rb_parent);
-}
-
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev, struct rb_node **rb_link,
-			struct rb_node *rb_parent)
+			struct vm_area_struct *prev)
 {
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
@@ -763,7 +551,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -776,34 +564,20 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
- * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
+ * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
 			       struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
-
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
-		BUG();
=20
+	mas_set(mas, vma->vm_start);
+	prev =3D mas_prev(mas, 0);
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
-	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	mm->map_count++;
 }
=20
-static __always_inline void __vma_unlink(struct mm_struct *mm,
-						struct vm_area_struct *vma,
-						struct vm_area_struct *ignore)
-{
-	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
-	__vma_unlink_list(mm, vma);
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-}
-
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -816,21 +590,18 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
-	struct vm_area_struct *next_next;
+	struct vm_area_struct *next_next, *next =3D find_vma(mm, vma->vm_end);
+	struct vm_area_struct *orig_vma =3D vma;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
-	bool start_changed =3D false, end_changed =3D false;
+	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
-	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
 			/*
@@ -957,21 +728,21 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		unsigned long old_start =3D vma->vm_start;
+		if (vma->vm_start < start)
+			vma_mas_szero(&mas, vma->vm_start, start);
+		vma_changed =3D true;
 		vma->vm_start =3D start;
-		if (old_start < start)
-			vma_mas_szero(&mas, old_start, start);
-		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
-		unsigned long old_end =3D vma->vm_end;
+		if (vma->vm_end > end)
+			vma_mas_szero(&mas, end, vma->vm_end);
+		vma_changed =3D true;
 		vma->vm_end =3D end;
-		if (old_end > end)
-			vma_mas_szero(&mas, end, old_end);
-		end_changed =3D true;
+		if (!next)
+			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
-	if (end_changed || start_changed)
+	if (vma_changed)
 		vma_mas_store(vma, &mas);
=20
 	vma->vm_pgoff =3D pgoff;
@@ -995,22 +766,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		 * Since we have expanded over this vma, the maple tree will
 		 * have overwritten by storing the value
 		 */
-		if (remove_next !=3D 3) {
-			__vma_unlink(mm, next, next);
-			if (remove_next =3D=3D 2)
-				__vma_unlink(mm, next_next, next_next);
-		} else {
-			/*
-			 * vma is not before next if they've been
-			 * swapped.
-			 *
-			 * pre-swap() next->vm_start was reduced so
-			 * tell validate_mm_rb to ignore pre-swap()
-			 * "next" (which is stored in post-swap()
-			 * "vma").
-			 */
-			__vma_unlink(mm, next, vma);
-		}
+		__vma_unlink_list(mm, next);
+		if (remove_next =3D=3D 2)
+			__vma_unlink_list(mm, next_next);
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
 		if (file) {
 			__remove_shared_vm_struct(next, file, mapping);
 			if (remove_next =3D=3D 2)
@@ -1023,15 +784,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		 * (it may either follow vma or precede it).
 		 */
 		__insert_vm_struct(mm, &mas, insert);
-	} else {
-		if (start_changed)
-			vma_gap_update(vma);
-		if (end_changed) {
-			if (!next)
-				mm->highest_vm_end =3D vm_end_gap(vma);
-			else if (!adjust_next)
-				vma_gap_update(next);
-		}
 	}
=20
 	if (anon_vma) {
@@ -1059,7 +811,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			anon_vma_merge(vma, next);
 		mm->map_count--;
 		mpol_put(vma_policy(next));
+		if (remove_next !=3D 2)
+			BUG_ON(vma->vm_end < next->vm_end);
 		vm_area_free(next);
+
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
 		 * we must remove another next too. It would clutter
@@ -1089,10 +844,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		if (remove_next =3D=3D 2) {
 			remove_next =3D 1;
 			goto again;
-		}
-		else if (next)
-			vma_gap_update(next);
-		else {
+		} else if (!next) {
 			/*
 			 * If remove_next =3D=3D 2 we obviously can't
 			 * reach this path.
@@ -1119,8 +871,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	return 0;
 }
=20
@@ -1273,7 +1023,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
-	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1349,7 +1098,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma(area, vm_flags);
 		return area;
 	}
-	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1519,6 +1267,7 @@ unsigned long do_mmap(struct file *file, unsigned lon=
g addr,
 	vm_flags_t vm_flags;
 	int pkey =3D 0;
=20
+	validate_mm(mm);
 	*populate =3D 0;
=20
 	if (!len)
@@ -1829,10 +1578,8 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev, *merge;
 	int error;
-	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
-	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1848,8 +1595,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
 	/*
 	 * Private writable mapping: check memory availability
@@ -1947,7 +1694,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+	if (vma_link(mm, vma, prev)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1993,7 +1740,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
-	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -2009,7 +1755,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -2367,7 +2112,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	int error =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2419,15 +2163,13 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 			error =3D acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2438,9 +2180,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				/* Overwrite old entry in mtree. */
 				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (vma->vm_next)
-					vma_gap_update(vma->vm_next);
-				else
+				if (!vma->vm_next)
 					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
@@ -2450,8 +2190,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
-	validate_mm(mm);
-	validate_mm_mt(mm);
 	mas_destroy(&mas);
 	return error;
 }
@@ -2460,15 +2198,13 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
  */
-int expand_downwards(struct vm_area_struct *vma,
-				   unsigned long address)
+int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *prev;
 	int error =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2510,15 +2246,13 @@ int expand_downwards(struct vm_area_struct *vma,
 			error =3D acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2530,7 +2264,6 @@ int expand_downwards(struct vm_area_struct *vma,
 				/* Overwrite old entry in mtree. */
 				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
-				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2539,7 +2272,6 @@ int expand_downwards(struct vm_area_struct *vma,
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
-	validate_mm(mm);
 	mas_destroy(&mas);
 	return error;
 }
@@ -2671,10 +2403,8 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, str=
uct ma_state *mas,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
-	mas_set_range(mas, vma->vm_start, end - 1);
-	mas_store_prealloc(mas, NULL);
+	vma_mas_szero(mas, vma->vm_start, end);
 	do {
-		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
 			mm->locked_vm -=3D vma_pages(vma);
 		mm->map_count--;
@@ -2682,10 +2412,9 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, str=
uct ma_state *mas,
 		vma =3D vma->vm_next;
 	} while (vma && vma->vm_start < end);
 	*insertion_point =3D vma;
-	if (vma) {
+	if (vma)
 		vma->vm_prev =3D prev;
-		vma_gap_update(vma);
-	} else
+	else
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
@@ -2807,11 +2536,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	if (len =3D=3D 0)
 		return -EINVAL;
=20
-	/*
-	 * arch_unmap() might do unmaps itself.  It must be called
-	 * and finish any rbtree manipulation before this code
-	 * runs and also starts to manipulate the rbtree.
-	 */
+	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA where start < vma->vm_end */
@@ -2822,6 +2547,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 	prev =3D vma->vm_prev;
+	/* we have start < vma->vm_end  */
+
+	/* if it doesn't overlap, we have nothing.. */
+	if (vma->vm_start >=3D end)
+		return 0;
=20
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2882,6 +2612,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	/* Fix up all other VM information */
 	remove_vma_list(mm, vma);
=20
+
+	validate_mm(mm);
 	return downgrade ? 1 : 0;
=20
 map_count_exceeded:
@@ -3020,11 +2752,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len, unsigned lo=
ng flags, struct list_head *uf)
+static int do_brk_flags(unsigned long addr, unsigned long len,
+			unsigned long flags, struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
@@ -3043,8 +2775,8 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
=20
 	/* Check against address space limits *after* clearing old maps... */
@@ -3078,7 +2810,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+	if (vma_link(mm, vma, prev))
 		goto no_vma_link;
=20
 out:
@@ -3197,29 +2929,12 @@ void exit_mmap(struct mm_struct *mm)
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
-	unsigned long start =3D vma->vm_start;
-	struct vm_area_struct *overlap =3D NULL;
 	unsigned long charged =3D vma_pages(vma);
=20
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
=20
-	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
+	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
 		return -ENOMEM;
=20
-	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
-	if (overlap) {
-
-		pr_err("Found vma ending at %lu\n", start - 1);
-		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
-				overlap->vm_start, overlap->vm_end - 1);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		BUG();
-	}
-
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, charged))
 		return -ENOMEM;
@@ -3241,7 +2956,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+	if (vma_link(mm, vma, prev)) {
 		vm_unacct_memory(charged);
 		return -ENOMEM;
 	}
@@ -3261,9 +2976,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	unsigned long vma_start =3D vma->vm_start;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
-	unsigned long index =3D addr;
=20
 	validate_mm_mt(mm);
 	/*
@@ -3275,10 +2988,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, addr, addr + len, &prev))
 		return NULL;	/* should never get here */
-	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
-		BUG();
+
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3319,12 +3031,16 @@ struct vm_area_struct *copy_vma(struct vm_area_stru=
ct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev, rb_link, rb_parent);
+		if (vma_link(mm, new_vma, prev))
+			goto out_vma_link;
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
 	return new_vma;
=20
+out_vma_link:
+	if (new_vma->vm_ops && new_vma->vm_ops->close)
+		new_vma->vm_ops->close(new_vma);
 out_free_mempol:
 	mpol_put(vma_policy(new_vma));
 out_free_vma:
diff --git a/mm/nommu.c b/mm/nommu.c
index c63793c53a82..321c7e6718a8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -566,9 +566,9 @@ void vma_mas_remove(struct vm_area_struct *vma, struct =
ma_state *mas)
  */
 static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
 {
-	struct vm_area_struct *pvma, *prev;
 	struct address_space *mapping;
-	struct rb_node **p, *parent, *rb_prev;
+	struct vm_area_struct *prev;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	BUG_ON(!vma->vm_region);
=20
@@ -586,42 +586,10 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		i_mmap_unlock_write(mapping);
 	}
=20
+	prev =3D mas_prev(&mas, 0);
+	mas_reset(&mas);
 	/* add the VMA to the tree */
-	parent =3D rb_prev =3D NULL;
-	p =3D &mm->mm_rb.rb_node;
-	while (*p) {
-		parent =3D *p;
-		pvma =3D rb_entry(parent, struct vm_area_struct, vm_rb);
-
-		/* sort by: start addr, end addr, VMA struct addr in that order
-		 * (the latter is necessary as we may get identical VMAs) */
-		if (vma->vm_start < pvma->vm_start)
-			p =3D &(*p)->rb_left;
-		else if (vma->vm_start > pvma->vm_start) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else if (vma->vm_end < pvma->vm_end)
-			p =3D &(*p)->rb_left;
-		else if (vma->vm_end > pvma->vm_end) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else if (vma < pvma)
-			p =3D &(*p)->rb_left;
-		else if (vma > pvma) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else
-			BUG();
-	}
-
-	rb_link_node(&vma->vm_rb, parent, p);
-	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
-
-	/* add VMA to the VMA list also */
-	prev =3D NULL;
-	if (rb_prev)
-		prev =3D rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-
+	vma_mas_store(vma, &mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
@@ -634,6 +602,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	struct address_space *mapping;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct task_struct *curr =3D current;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
 	mm->map_count--;
 	for (i =3D 0; i < VMACACHE_SIZE; i++) {
@@ -656,8 +625,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	}
=20
 	/* remove from the MM's tree and list */
-	rb_erase(&vma->vm_rb, &mm->mm_rb);
-
+	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(mm, vma);
 }
=20
@@ -681,24 +649,19 @@ static void delete_vma(struct mm_struct *mm, struct v=
m_area_struct *vma)
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* check the cache first */
 	vma =3D vmacache_find(mm, addr);
 	if (likely(vma))
 		return vma;
=20
-	/* trawl the list (there may be multiple mappings in which addr
-	 * resides) */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (vma->vm_start > addr)
-			return NULL;
-		if (vma->vm_end > addr) {
-			vmacache_update(addr, vma);
-			return vma;
-		}
-	}
+	vma =3D mas_walk(&mas);
=20
-	return NULL;
+	if (vma)
+		vmacache_update(addr, vma);
+
+	return vma;
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -730,26 +693,23 @@ static struct vm_area_struct *find_vma_exact(struct m=
m_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long end =3D addr + len;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* check the cache first */
 	vma =3D vmacache_find_exact(mm, addr, end);
 	if (vma)
 		return vma;
=20
-	/* trawl the list (there may be multiple mappings in which addr
-	 * resides) */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (vma->vm_start < addr)
-			continue;
-		if (vma->vm_start > addr)
-			return NULL;
-		if (vma->vm_end =3D=3D end) {
-			vmacache_update(addr, vma);
-			return vma;
-		}
-	}
+	vma =3D mas_walk(&mas);
+	if (!vma)
+		return NULL;
+	if (vma->vm_start !=3D addr)
+		return NULL;
+	if (vma->vm_end !=3D end)
+		return NULL;
=20
-	return NULL;
+	vmacache_update(addr, vma);
+	return vma;
 }
=20
 /*
@@ -1546,6 +1506,7 @@ void exit_mmap(struct mm_struct *mm)
 		delete_vma(mm, vma);
 		cond_resched();
 	}
+	__mt_destroy(&mm->mm_mt);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
diff --git a/mm/util.c b/mm/util.c
index 8d944ce71e94..10effe256dfa 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -288,6 +288,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	vma->vm_next =3D next;
 	if (next)
 		next->vm_prev =3D vma;
+	else
+		mm->highest_vm_end =3D vm_end_gap(vma);
 }
=20
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
@@ -300,8 +302,14 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm=
_area_struct *vma)
 		prev->vm_next =3D next;
 	else
 		mm->mmap =3D next;
-	if (next)
+	if (next) {
 		next->vm_prev =3D prev;
+	} else {
+		if (prev)
+			mm->highest_vm_end =3D vm_end_gap(prev);
+		else
+			mm->highest_vm_end =3D 0;
+	}
 }
=20
 /* Check if the vma is being used as a stack by this task */
--=20
2.35.1
