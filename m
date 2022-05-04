Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F016B519330
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbiEDBM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiEDBLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC24348B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KvDs5027626;
        Wed, 4 May 2022 01:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PZwFBtxZpYqUBNg6uiqdHNVJC+TxbTVs2dZmQECAgYw=;
 b=TmDZobNrX1hWtymtKID0f0C96+YIkUnyMVSssUrhv1MZNLiy1xRkZg/mldYf1WD9iq1O
 YltxmKacUX2JXO7pAK3dHjLtK7V426m5FJDVTspid4Icch88YLpMpjpMXZsK0+t5+yYb
 MnVnxZCx3TPUIhQ56pVNrW4+F8Ax86Rs5fTdLdFu8Jpnxj+g+8qWva+8NZBXZw/BukNv
 2n852nupbblkKmJYYFfMYiDdWr2i4WoRoEu/65KqVGdByZnAnqCzRzuzIAGJbt+RXmzf
 05bcDosPF/300DJmr+I41Z7OGRJFILzdwDJSMc7wUV0eu3lhCuC6ttgpTH/jGg/EQ8vZ UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f65q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvJ039119;
        Wed, 4 May 2022 01:07:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHJFVsk61S+NQFDcUCeRuHtqTJNiCemxTAT7k+mNy7G0kheMO0L+0qcM/Zmh6W6v/UyGCCUNil8h6O0e3bszIdgYkyY3eqREOQX5ArA4ZjU3+XxOjVjaTgUrIbgYoGtnjcec5Ads4mWbCZGeoc1DY/gLAY00z9DRpO0moei8J6MQSMSw4kFrZvA28ELEXtcn5PatmCM7o62+VXZLMdQ3zZC8DgoyToWPY04XyH34zNPj4DC1whdu5vshVaaQtH+83OP3hosdyzelzPSZXbglPaHfKG+y2I4VqbB5v6E5Cz9ShMrCbnHuVTWAU4gDkILn2qxzjXBg+M8qwLPQ0FZvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZwFBtxZpYqUBNg6uiqdHNVJC+TxbTVs2dZmQECAgYw=;
 b=JRz7tMQ1Nxzq/MVR1WnpWw5waoI86RE8DxLTf+G4mkmFJGWPZLDJ0CkufcXwFYpOaXtdNPXej0PExBf7eCObJft7g5oBoAaTLtwmfKOfymgZnTpK1aC23ZZtzkvT+71byAfic0SooQTZVOXX/2ufj98mcTmgwrbcI1/0Cdi/id+rdwo+SIyGQluNYw8SxVkcq00g8tOkNR74yO/o4lf2zMc1osRxV6uIWQI9hP4Ew0TieHM7sEGn4ldQ/JYlay019i+b7naiynu6J4rkQpJkBEnNB4MVqjrSTEaRwdeYxV2xCBB/ceTSBrKyMx7Tvx7v5h3sYyvWLpp2gjZgvqPUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZwFBtxZpYqUBNg6uiqdHNVJC+TxbTVs2dZmQECAgYw=;
 b=BILCBjq1v2TPuyReEqXsZDydg8QpZTDBWa+hnuUkuDMkeamQxdVOjSogQfkcZ1JzoPoJ5vrg9xwXiOqCz1tE2Zl0KJyV9+CddE5re8LKCD3SQE4/JWmhS2Of7zfB9Q3oWHi+ynrvQ/+rfHhmi0LVxAXtOsJuMRLlP8SwOTnmm/k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYX1NhZKDMPG7C/keyeY6aTlfpJw==
Date:   Wed, 4 May 2022 01:07:52 +0000
Message-ID: <20220504010716.661115-10-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9122d0d2-7d19-4348-fedb-08da2d6a843d
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4214619724EF862DA1B0BD13FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZSmQ2iuVld2D3vPxcjeS1X2bJpZ7dbmXw68ezvh2bd8Hiv+Dh2zZZJMBPrFCx/LZzLjFlsDt8hH0dYQRw1y+doXqfkF8l55wqMgYZmOO3LjCaHpG6L/08KtFnfgOM1X03jPTsescUhBYI+E6nm52KSEUm8S8LnQ8ffdb6KeDInv2Zmd6yrEEZ3ZVCXwIQy7BzRZl/ob3tVBvk3Bs/eBH9HxQtx3Eyhyq0cMREx8yZOlEQqPFcDDszWol5oKyQYBDvoVAXD8ZMok82X3vCNr1EFdF5saMI0DQS2yhqlEDSBfeR7QmloBPSStTxwLFkLL5Al9+863tyPq5//VRetBwOo3KsIx0j68hnOLZtwBIswfvLRiLBvSnUA7LP6cwn8YROkrC4zBvd5Z7jtizlY9JvM6sQSxlDwJpgui/wPno1TEYpBQspAxzIM/k29UngtQazk+Grb+f/dOAuWTc2wf78AIzwJD7GW9/rkYiLePgwf9+oiG/NUFLqzM1DjmZNEJTKUvH0hmEg1RLZVoXAS9E0jkgR0kH+GsTl0/mGT9tTvxA4BsdijmxIB+n/tVwW/7K/cKJ284QNrHKWOmP6oWLpfkEPmQDH5u5PAxmVftXJI5+MU0vvjVa7U317ukjCx/B5/UmUhC34H2Ysm2OIJeb0OaPqGKYgHhGBMdWbS3wsJV7MxkiwiBQSErFG7jTnL6T9/bzpyi8UYWiuYIItd2sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(30864003)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H8mlJgMEQamDd2xAuGm/Fch1i/mjY+lyTqDoJaj7YVlqxKumdHxvanpn7e?=
 =?iso-8859-1?Q?IlQ0okNtPKPTUJnJ0diP4J3YlI58MwSOGtyYVJFYfhIqI4vjEi7HX9sPNf?=
 =?iso-8859-1?Q?mBflgVnhJHa31R1VtZ31OSgykNPVwdJ3Htst83QDvKEE+WGscHpGE6ogYO?=
 =?iso-8859-1?Q?ioCcdW8j0jgqOFy0LIxxBDfGiOf5S5N92gQfZEPSuV/6QoqWyf41G34TyW?=
 =?iso-8859-1?Q?5r0Oc5uT3DH4x1JtUePPyq67ycMpuh0+QsJ7lYt4GNArq1x1S92mY5qqL9?=
 =?iso-8859-1?Q?XEZri+tkB0YL1Sfvvd6QY5K/SKWyGA/E6j44ZIr9bbQRJtRH3QaDv7Uxi1?=
 =?iso-8859-1?Q?f4d62UMLDYSbewV+2TMrzGvtkon43BDfqpo4g8qiNbD3pkz+YG2wFL3X6y?=
 =?iso-8859-1?Q?KVERllcWjMvLaSYqASQB0ANZJvNrhQ4KCNUUxTudFmfW84L3wFFQTWDsxf?=
 =?iso-8859-1?Q?gSOjSUBYKGeM5tbrSFqmIMnyHAIZa6VJIaHRbMZyYwUeIzG/fji9Ata12i?=
 =?iso-8859-1?Q?+uml74MLXm4Efc3F2anC3iBVG+RmLLfvjc3nx3C7fX0xIyWMTrMetfXr7z?=
 =?iso-8859-1?Q?JcCfrTDHUD3DqXFyASXpO/e1mN8gNbGjp/panakDgv3Lz+AfLbTb7gxxqo?=
 =?iso-8859-1?Q?6dAryWMJsy0eJKiAd0/LEMXe95r85S911ge4e9Me4i07dw/g/XIURIBibI?=
 =?iso-8859-1?Q?IrjQ9wdSmN+uXbwbepLkvyKZilob0JNjzPIXyjBjpFAP4FhMjVdEPRewBb?=
 =?iso-8859-1?Q?8HFQ3fdY0Azxi4+GwIUlKNSNsKoWZWjSr/ukxyMaXzhHlHMP/ULHrfZxrY?=
 =?iso-8859-1?Q?BITlzOAGF+sp9cmliFE/2Sc0IJaXpnIcQQHqLcEsKkZm459y/ZlSlsIXxe?=
 =?iso-8859-1?Q?ASrd3pW3HzhEAS1yAFA8cVQDcqnDkDcyX/jFtIDJshk6GS2lmXKDhZ/NOT?=
 =?iso-8859-1?Q?keTYQanZEvCed5eSYKkGr9dxpFH6dShkBsSMC7ssYoqFgKFC5yk8B2/L6Y?=
 =?iso-8859-1?Q?dvj/bZAV7751SwlKnokEV8XxBDKlqGX/QBO63sA7nLPpSWXBLJ3wfb0B7N?=
 =?iso-8859-1?Q?kM+V96rK2L0u4Nd2GkOGrfGrDRR32BxJggZwluNHwBzUhcj7gUngZXum9t?=
 =?iso-8859-1?Q?KBxIVGiOg/OB1FMGeeggbtPiyVbmneAaaNeZ8Z1Gx8LpMLRMakh1wAzwvx?=
 =?iso-8859-1?Q?PMQwnuCbdoD7N417txVqXsbtGOR2iJx6Soy+fviFfa2wqJeOMA+cXBJSlE?=
 =?iso-8859-1?Q?YDGdPswWNnsDI/nLi5SMN1S87zbZYGqArE4IMp2s6qFDgSaRXLLxGsZYaS?=
 =?iso-8859-1?Q?lggNVSD1aWNMPk5kn+9drttEgrcptrFnRaStySGzB6+mZ84I/thYHv63lF?=
 =?iso-8859-1?Q?QelZBsN1YKYxOeDCEbWbeV3Hy1djx0aTaMV+h7Lh+awLVcbvapKFVMZ/dE?=
 =?iso-8859-1?Q?LJrbJ8b4IdbaFhP3jB3Vu3XdcYvTO56JzVeacZOvoPv0abWCAgAaWuRLeM?=
 =?iso-8859-1?Q?S+y4wLRNEgL9AUyE331O5rr1yxdmGGA17RSoGifbXgs6e8nuUsd6zAogPV?=
 =?iso-8859-1?Q?/cl74d1kPVXF1Drsm99jA6WchF6XD+fUCj9pUc/zv5QXbuDkGQsrMIdU5U?=
 =?iso-8859-1?Q?cKHKWNEzFQGPaLIbGjs0A7WuHuJ1onIFDMnQ9141WDV+h9r1LhwiN52+ar?=
 =?iso-8859-1?Q?sfOH5wmxafC8bZscPsTvP5dUDT6M+lGv4tdcwLFr/nGu29pZQmLZC+vVgJ?=
 =?iso-8859-1?Q?TALFuWzE1t+spb42SOs90nT+GheTZtUkPjDb6TUqbM/CoEEf5IrP8ikMz4?=
 =?iso-8859-1?Q?oHp8z6STgaZoqn6/fop/oFWwzhExncc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9122d0d2-7d19-4348-fedb-08da2d6a843d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:52.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx/31WobiZewYK54d6P4tcdZzV3dk7DM3qWoEkZzaj1rlN6yhm41jyCTCW21KFTvwZoi3aFhrh6QTU3k/tjUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-GUID: Q0JYskmMJiWyCyHcFU6ZgglV0Zb663Ne
X-Proofpoint-ORIG-GUID: Q0JYskmMJiWyCyHcFU6ZgglV0Zb663Ne
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

Start tracking the VMAs with the new maple tree structure in parallel with
the rb_tree.  Add debug and trace events for maple tree operations and
duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in kernel/fork
for process forking, and used to find the unmapped_area and checked
against what the rbtree finds.

This also moves the mmap_lock() in exit_mmap() since the oom reaper call
does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  73 ++++++++
 kernel/fork.c               |  20 ++-
 mm/init-mm.c                |   2 +
 mm/mmap.c                   | 323 +++++++++++++++++++++++++++++++++---
 8 files changed, 396 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..859e8d2ea070 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -98,6 +98,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5502e176d51b..92a765d8d3b6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b9316b2c11ce..d42dc897a913 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2574,6 +2574,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* mmap.c */
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 87eddd509de2..645715a4a89d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -476,6 +477,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -671,6 +673,7 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
=20
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
 extern struct mm_struct init_mm;
=20
 /* Pointer magic because the dynamic array size confuses some compilers. *=
/
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..216de5f03621 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,79 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mas_szero,
+	TP_PROTO(struct maple_tree *mt, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mt, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct maple_tree *, mt)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mt		=3D mt;
+			__entry->start		=3D start;
+			__entry->end		=3D end;
+	),
+
+	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
+		  __entry->mt,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_store,
+	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
+
+	TP_ARGS(mt, vma),
+
+	TP_STRUCT__entry(
+			__field(struct maple_tree *, mt)
+			__field(struct vm_area_struct *, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mt		=3D mt;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
+		  __entry->mt, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(struct maple_tree *, mt)
+	),
+
+	TP_fast_assign(
+		       __entry->mm		=3D mm;
+		       __entry->mt		=3D &mm->mm_mt;
+	),
+
+	TP_printk("mt_mod %p, DESTROY\n",
+		  __entry->mt
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..bb985cc624fd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -585,6 +585,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	int retval;
 	unsigned long charge;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -616,6 +617,10 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 	if (retval)
 		goto out;
=20
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
 	prev =3D NULL;
 	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
 		struct file *file;
@@ -631,7 +636,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -696,6 +701,11 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -704,10 +714,12 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -723,7 +735,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1107,6 +1119,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
+	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index fbe7844d0912..b912b0f2eced 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -29,6 +30,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/mmap.c b/mm/mmap.c
index d7e120ad5825..e777da0132f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -381,7 +381,70 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -436,6 +499,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -680,6 +744,56 @@ static void __vma_link_file(struct vm_area_struct *vma=
)
 	}
 }
=20
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+inline void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas=
)
+{
+	trace_vma_store(mas->tree, vma);
+	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(mas, vma);
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline void vma_mas_remove(struct vm_area_struct *vma, struct ma_st=
ate *mas)
+{
+	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
+/*
+ * vma_mas_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mas_szero(struct ma_state *mas, unsigned long start=
,
+				unsigned long end)
+{
+	trace_vma_mas_szero(mas->tree, start, end - 1);
+	mas_set_range(mas, start, end - 1);
+	mas_store_prealloc(mas, NULL);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
@@ -689,17 +803,22 @@ __vma_link(struct mm_struct *mm, struct vm_area_struc=
t *vma,
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev, struct rb_node **rb_link,
 			struct rb_node *rb_parent)
 {
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	if (vma->vm_file) {
 		mapping =3D vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
 	}
=20
+	vma_mas_store(vma, &mas);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	__vma_link_file(vma);
=20
@@ -708,13 +827,15 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
=20
 	mm->map_count++;
 	validate_mm(mm);
+	return 0;
 }
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
+			       struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
@@ -722,7 +843,10 @@ static void __insert_vm_struct(struct mm_struct *mm, s=
truct vm_area_struct *vma)
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		BUG();
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+
+	vma_mas_store(vma, mas);
+	__vma_link_list(mm, vma, prev);
+	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	mm->map_count++;
 }
=20
@@ -756,10 +880,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	bool start_changed =3D false, end_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
-	if (next && !insert) {
-		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	validate_mm(mm);
+	validate_mm_mt(mm);
=20
+	if (next && !insert) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -842,6 +969,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 again:
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		if (exporter && exporter->anon_vma)
+			unlink_anon_vmas(importer);
+		return -ENOMEM;
+	}
+
 	if (file) {
 		mapping =3D file->f_mapping;
 		root =3D &mapping->i_mmap;
@@ -882,17 +1015,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mas_szero(&mas, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mas_szero(&mas, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mas_store(vma, &mas);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_mas_store(next, &mas);
 	}
=20
 	if (file) {
@@ -906,6 +1050,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -928,7 +1074,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, &mas, insert);
 	} else {
 		if (start_changed)
 			vma_gap_update(vma);
@@ -1025,6 +1171,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1178,6 +1325,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1253,6 +1401,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1732,6 +1881,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1846,7 +1996,14 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
@@ -1879,6 +2036,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1895,6 +2053,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1911,12 +2070,19 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -1998,20 +2164,31 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2097,6 +2274,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2302,7 +2505,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2375,7 +2577,9 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2399,9 +2603,14 @@ int expand_upwards(struct vm_area_struct *vma, unsig=
ned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma)))
+	if (unlikely(anon_vma_prepare(vma))) {
+		mas_destroy(&mas);
 		return -ENOMEM;
+	}
=20
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
@@ -2438,6 +2647,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
+				/* Overwrite old entry in mtree. */
+				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
 				if (vma->vm_next)
 					vma_gap_update(vma->vm_next);
@@ -2452,6 +2663,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2465,7 +2677,9 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *prev;
 	int error =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2479,9 +2693,14 @@ int expand_downwards(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma)))
+	if (unlikely(anon_vma_prepare(vma))) {
+		mas_destroy(&mas);
 		return -ENOMEM;
+	}
=20
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
@@ -2519,6 +2738,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2652,14 +2873,17 @@ static void unmap_region(struct mm_struct *mm,
  * vma list as we go..
  */
 static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
+detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
+	struct vm_area_struct *vma, struct vm_area_struct *prev,
+	unsigned long end)
 {
 	struct vm_area_struct **insertion_point;
 	struct vm_area_struct *tail_vma =3D NULL;
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	mas_set_range(mas, vma->vm_start, end - 1);
+	mas_store_prealloc(mas, NULL);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
@@ -2700,6 +2924,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2752,6 +2977,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -2778,6 +3004,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
+	int error =3D -ENOMEM;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
 		return -EINVAL;
@@ -2798,6 +3026,9 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	vma =3D find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
 	prev =3D vma->vm_prev;
=20
 	/*
@@ -2808,7 +3039,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > vma->vm_start) {
-		int error;
=20
 		/*
 		 * Make sure that map_count on return from munmap() will
@@ -2816,20 +3046,20 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
-			return -ENOMEM;
+			goto map_count_exceeded;
=20
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
-			return error;
+			goto split_failed;
 		prev =3D vma;
 	}
=20
 	/* Does it split the last one? */
 	last =3D find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		int error =3D __split_vma(mm, last, end, 1);
+		error =3D __split_vma(mm, last, end, 1);
 		if (error)
-			return error;
+			goto split_failed;
 	}
 	vma =3D vma_next(mm, prev);
=20
@@ -2843,13 +3073,13 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
 		if (error)
-			return error;
+			goto userfaultfd_error;
 	}
=20
 	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
+	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
 		downgrade =3D false;
=20
 	if (downgrade)
@@ -2861,6 +3091,12 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	remove_vma_list(mm, vma);
=20
 	return downgrade ? 1 : 0;
+
+map_count_exceeded:
+split_failed:
+userfaultfd_error:
+	mas_destroy(&mas);
+	return error;
 }
=20
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
@@ -3000,6 +3236,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3049,7 +3286,9 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if(vma_link(mm, vma, prev, rb_link, rb_parent))
+		goto no_vma_link;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3057,7 +3296,12 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
+
+no_vma_link:
+	vm_area_free(vma);
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
@@ -3103,6 +3347,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
=20
+	mmap_write_lock(mm);
 	if (unlikely(mm_is_oom_victim(mm))) {
 		/*
 		 * Manually reap the mm to free as much memory as possible.
@@ -3120,9 +3365,7 @@ void exit_mmap(struct mm_struct *mm)
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 	}
=20
-	mmap_write_lock(mm);
 	arch_exit_mmap(mm);
-
 	vma =3D mm->mmap;
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
@@ -3146,7 +3389,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
-	mm->mmap =3D NULL;
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
@@ -3159,10 +3404,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3184,7 +3444,9 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+		return -ENOMEM;
+
 	return 0;
 }
=20
@@ -3202,7 +3464,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3214,6 +3478,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3257,6 +3523,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3264,6 +3531,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3400,6 +3668,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3422,10 +3691,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
--=20
2.35.1
