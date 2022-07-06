Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039B567BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiGFCF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGFCFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:05:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04EA1A046
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:05:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265KwndY025714;
        Wed, 6 Jul 2022 02:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=JpHNdo4/97bPsG9IVQ4/3s1woppaCUy6AaTay5NOHXk=;
 b=Li7GyHjaHOFBtl9LuoSaZws6NiCvfL16ORqvFOiP/eUgfQT+fFwwqZplbHcVUhss7kEL
 Io2uGK3hMj48wAd34cpuBTjuruwaklOFLydMO6sHn7P560dCA6OM7ps129njffrQo5dA
 gfoZ4Upe3cLdhRFP0OFLYkVuwamLxWs0gbYIGFMQq3Gx8jviMzr0M/9e30eWAFIRUfDh
 30rKt3PzbzjjgA0SV8liO7ooqU99oUuf6vAjfCGvMQiO5clV4RjJ+f3h6tAIN5UuqVP4
 8Nn/b0BvCE9iZys0IdQMyeZubKThfo4D1buA4F3A8tcwFTYMPzwBdYbPJpl4KGjQ8GhC 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubygmxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 02:05:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26621s0D031741;
        Wed, 6 Jul 2022 02:05:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud7p3e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 02:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9Afg7eudvdWHbNhtAG2D191/f4KGYVzi/R9S4SztJ80OSA7vVbutQgnZTTOp4RoZLK8ulnF9RCVmFf8D5Vrn56AGQfvjxmvP1cI64kdZbVwRDZwZ8gBrCEIMS4TYxV3D8HwlrC5JyPRwLgWILOqjTEnRtykJWg3h2mFb8ROc8nerWuLsU7wHptqom3XQDeATfyv050wo3mt6zyEAvn1w/AVZ3C8w0lLgYXm+ys2JTqJJDgeqM4dtbD8dtTUYeQZKhJsMwMFzlV7XApgWYktIxI/8P8gq/vrvgihGLljgNZFibNb8Bp0h3D7p0fza/BvXsLE0yOEvZ50PScZGCdCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpHNdo4/97bPsG9IVQ4/3s1woppaCUy6AaTay5NOHXk=;
 b=LYKqwTWS2ZjmuNemMQUU6ewYcLc17PawBmAbtqm/r+YHPSvLlA9gLAwvnbJIjUlvVlaZFpza2sD7mFkTnblDFpZfYIHdOHEMkrD/xrE5uHSkpdPesj9GAoKwe+dv2mmjT3s3+n4+hbtfOfFso7LeM3Kk4Fy52/M8GX91oSto7MbXlqZs/BY/OzSAObpvO1w0a48NsccN1wmwJXO/GwTmpm3bal0fFvVsOY6LJqrhr/DnSKElASCLmBZkmFOK3RYaM2z1gxEY5X/Sgt4XgksVwLpylyqHEtrIn+xJ4w32xMjWDSUjMysA833/ioXFLDSBcTOtnRNa4eqhrhJxp72qlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpHNdo4/97bPsG9IVQ4/3s1woppaCUy6AaTay5NOHXk=;
 b=hCT3DvGBgyBQ/ONOFmEaDHqX8qc22M8KwGH9rAdVj4/3oJ9zHJ08U8BuxUHDH30jk8Wppn2YoRupIFeOayjlVO7X8M/JiIGVzVeZFW12qMIuTNvEzigEKMy0D9UtojNXRpB3AS6M4nIYK26sF3p/Rdg9kH+YQZla79zgbAEGmt4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 02:05:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54%3]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 02:05:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Thread-Topic: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Thread-Index: AQHYkNzinLp2ekiGvkSjFulTKej6Tw==
Date:   Wed, 6 Jul 2022 02:05:37 +0000
Message-ID: <20220706020526.1869453-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9caa15c2-d87d-4c1e-ee01-08da5ef4052b
x-ms-traffictypediagnostic: SJ0PR10MB5549:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1WQa5CcqHm5Te0F3QZHr0K0gLZ3LlTtIlyeIk6K0XYOZCssl6G4HfL8OzefsVyR4dgTtmyg9trBZuuWglqDGU5n1JHo3rp33btb1vnHQGF5I+nVKymVMF5gOXYejXOo0J0SaX1ScJLxfGk2MeGJ1qAV+FFBby0KDQG3RU6lUgaCfmDvhtwRTpf0GAOktJlYIoEHtPmek+vq2W/7wYyfX+e72hOaueXp+MEXXLPTYajYQ1/OLFFVJ0zuF6sX9aqLWI6EuQC8KWCadGYVBlAiCnHDNZr1iz6HmHc4VGqKytW668oTFDy/3mOMq5W2YbwkMBHgro+/pHgrDNvAZS8MkCpBSi0dnEufblD3E97Hqdp0BvJIjdVE0XgZg+MlSdKM8e/W6Le9PYnIRRiQeo6BtHFeR8Qzx8t+VCzwF6CnB30MZId2MCmGBY0AGupnn6xODZA4GL22W1Dfvbd2V7x3zX5Wimu+uwbiy9ZgcKe+H5yQvL9aGS3CwO7K/tGm5nGnNc0G6AUpkLRbv3B3ozgc+4VljApDjwdJ5hILFliiRHcUZPtVy3kF7klnarfui9YY8emQawjhkDXbaT6ety3pqi/Svo8niEYQVwLVuAXEGqZmY93u/k+w30KBop+vX0u0ZvS9KUR01RP1mAtcZcLPPC/FkNjfOiDLIIBZCbgBeTQBxe5sp8DtERSf4yO0QMvhVZ8wuBh1Ahr/meESVPydMeBrNNtnq8RhGXzZnG6BwhabZ1mvqnSMffm9SxPr/cAe6/jYei4gcEEXiNtEF7l+JbMfG11McplrvXBCJ6VT2L8H/Q+XsOo1iJtkqRdRstuy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(346002)(39860400002)(83380400001)(186003)(91956017)(71200400001)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(4326008)(66446008)(478600001)(86362001)(6486002)(44832011)(8936002)(5660300002)(26005)(38070700005)(122000001)(6512007)(38100700002)(41300700001)(1076003)(2616005)(2906002)(6506007)(110136005)(316002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fTmcKg/H/3k1E5LHztHCmg4zsDNKaoUSleTWdqoBb0Gy7LTGEaIRKisg/Q?=
 =?iso-8859-1?Q?TsyGA7gqlS3XRtbAuvPul2wQtvfKg+Ramp9JSgLSicWmQkX0qalkeSk6q+?=
 =?iso-8859-1?Q?bNMR0HHG6YJS/zd/rxeW3/eB/BE4KVgt9wBcLqslVgBm3o3twuQ7to8xOu?=
 =?iso-8859-1?Q?yam3RS1F3A8qGDKiITLSwU5Q/NU2e6VTF7Ot7zvn6zSHvs18eauYaug7/a?=
 =?iso-8859-1?Q?L3HpVB6WRhF7+YQgKtuPgu31wQRK6OsAhjKup1Ala6mxRXyEsisYKGjTQN?=
 =?iso-8859-1?Q?JB6/sElicn9cxtBOWymHJ6SNnneBocynul+AzjekLveubQ9qLbEpcL1dXo?=
 =?iso-8859-1?Q?KH9TaoUCdXxRhntameM1PGCQdKhEcLopXQK1LgcLedqjBEulvuUwSmu80b?=
 =?iso-8859-1?Q?eUzCeUjYoPgXax5/saaCH4k5YHYvkKCK/Q9YvZXuy0q0eMBucSPVcTsHnB?=
 =?iso-8859-1?Q?DceVoN1UZsc/DkDq8R/oUiNQJ6t1P5IFLVgZgX4j1hUorsb8qqIkMnrvpO?=
 =?iso-8859-1?Q?L06ut2NaIwYOtWGkQaaOPMKiLSu7DWvJXJkQ0D++J8L0D3s45u0NJaLB94?=
 =?iso-8859-1?Q?rGBKxbl84l7i11W3tOU12gYw35imkjHMRxoOgKdxpbzJMwvQCXOJS1cdj6?=
 =?iso-8859-1?Q?oNNIKjOv0Q5ROiV+8MZePC3w9rLw+EtByiNqUGjqJMCyzNEtMuO4F/jtqE?=
 =?iso-8859-1?Q?oaGnu609pYlXMDQnqOCaY/ZISub76jilvIqWnfNJBsD+j6CGi0Z8EG1XmI?=
 =?iso-8859-1?Q?x8ilP1YFpxy46TpXieaVcA+ioSI7ynOURhwR/Y9BdfpbROJsrwAFMYBWPP?=
 =?iso-8859-1?Q?jTEHqgHTuFbtRfsAwIr+gnGOzfxK8pd/nqu1+SV/rgBHhSosUVL3iomLmw?=
 =?iso-8859-1?Q?7aUdvLvGALgKxxfq52T6JmrPO+WCJt5VfT4q6Ab71BCe8Igx/sY+pjR5zW?=
 =?iso-8859-1?Q?V3NBF1T7Rl6x51O9QZlkZecC/505OneYy7YxW5Y4Y1JEISqldg7mbPJLZ7?=
 =?iso-8859-1?Q?8JeBCpU7f0kxgfmTNV5ivbdJJwwj5iUTF+ErLHW2b596PVskjtQUbO4au8?=
 =?iso-8859-1?Q?4ccFjISDc6fDRxSZdQzYFsWHb/1cux8kJAjavO1ISw3YQwyKU0P6HDy0fe?=
 =?iso-8859-1?Q?TtzjBN+dyuXRa4Qkg1ixMthXjchUFxqj7UQE2pF5chqGPIoYIngA1CVFad?=
 =?iso-8859-1?Q?etvSyfnRYKrw6IBB+Gvi0cR3iPow0l1hDP6LH/Y3iRmxnXdALNaUgUATps?=
 =?iso-8859-1?Q?BrDVAOCz9favDw8vHmixWTR1JqGj6unfv2gjXhxgyFNJYhHPXIhGld9f30?=
 =?iso-8859-1?Q?CYbuqblyv10dqKj3EtWNvJhUf5zfbHOS8vSaFKbDDcWqJgj20R/DT5Idnz?=
 =?iso-8859-1?Q?XcvuySg4h09hAmU09tMLDpXWpiaYZkbGpnJKxwP+bz2OBK7dTA0Eiq52BL?=
 =?iso-8859-1?Q?tWSHZECof/UOQHFGBXbAfdlx7GiIqpd/WvIWe7PYEnSt3GO+V1F5qkExwF?=
 =?iso-8859-1?Q?dRHtSAZM03L8HuB9FW+u2MyXGU9oX9hfJgGIxUt6H9a+R33jkkOOp3U+aK?=
 =?iso-8859-1?Q?pagYgSkcJSwlYj/qZ9sP0QwMT04bn4qDG9s0+pZ8rckcii01GbIx9lI77j?=
 =?iso-8859-1?Q?o28PXliR1rOoQ58W9e3p7MSe1EMyUcpix794cRp/zdjOjc2szz5iGwiQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa15c2-d87d-4c1e-ee01-08da5ef4052b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 02:05:37.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbhF9BGL79Oa2+u8U8ps6YjpXGvm3Q2pNkzDKMhXEz4HWcH2ces8f5g69T1IxfkOKDKegYlITMH4OBVhICFcHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_20:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060006
X-Proofpoint-GUID: zMpRKK1d89nUzVoL4VxGQpFS6IVfnkye
X-Proofpoint-ORIG-GUID: zMpRKK1d89nUzVoL4VxGQpFS6IVfnkye
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing a range with a NULL which expands to 0 - ULONG_MAX, don't
use a node to store this value.  Instead, call mas_new_root() which will
set the tree pointer to NULL and free all the nodes.

Fix a comment for the allocations in mas_wr_spanning_store().

Add mas_node_count_gfp() and use it to clean up mas_preallocate().

Clean up mas_preallocate() and ensure the ma_state is safe on return.

Update maple_tree.h to set alloc =3D NULL.

Fixes: d0aac5e48048 (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  1 +
 lib/maple_tree.c           | 34 +++++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 3c6642358904..2c9dede989c7 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -434,6 +434,7 @@ struct ma_wr_state {
 		.node =3D MAS_START,					\
 		.min =3D 0,						\
 		.max =3D ULONG_MAX,					\
+		.alloc =3D NULL,						\
 	}
=20
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2cccd8f2153f..79e07c7dc323 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1293,17 +1293,31 @@ static inline void mas_free(struct ma_state *mas, s=
truct maple_enode *used)
  * there is not enough nodes.
  * @mas: The maple state
  * @count: The number of nodes needed
+ * @gfp: the gfp flags
  */
-static void mas_node_count(struct ma_state *mas, int count)
+static void mas_node_count_gfp(struct ma_state *mas, int count, gfp_t gfp)
 {
 	unsigned long allocated =3D mas_allocated(mas);
=20
 	if (allocated < count) {
 		mas_set_alloc_req(mas, count - allocated);
-		mas_alloc_nodes(mas, GFP_NOWAIT | __GFP_NOWARN);
+		mas_alloc_nodes(mas, gfp);
 	}
 }
=20
+/*
+ * mas_node_count() - Check if enough nodes are allocated and request more=
 if
+ * there is not enough nodes.
+ * @mas: The maple state
+ * @count: The number of nodes needed
+ *
+ * Note: Uses GFP_NOWAIT | __GFP_NOWARN for gfp flags.
+ */
+static void mas_node_count(struct ma_state *mas, int count)
+{
+	return mas_node_count_gfp(mas, count, GFP_NOWAIT | __GFP_NOWARN);
+}
+
 /*
  * mas_start() - Sets up maple state for operations.
  * @mas: The maple state.
@@ -3962,7 +3976,7 @@ static inline int mas_wr_spanning_store(struct ma_wr_=
state *wr_mas)
 	if (unlikely(!mas->index && mas->last =3D=3D ULONG_MAX))
 		return mas_new_root(mas, wr_mas->entry);
 	/*
-	 * Node rebalancing may occur due to this store, so there may be two new
+	 * Node rebalancing may occur due to this store, so there may be three ne=
w
 	 * entries per level plus a new root.
 	 */
 	height =3D mas_mt_height(mas);
@@ -3995,6 +4009,12 @@ static inline int mas_wr_spanning_store(struct ma_wr=
_state *wr_mas)
 		mas->last =3D l_mas.last =3D r_mas.last;
 	}
=20
+	/* expanding NULLs may make this cover the entire range */
+	if (!l_mas.index && r_mas.last =3D=3D ULONG_MAX) {
+		mas_set_range(mas, 0, ULONG_MAX);
+		return mas_new_root(mas, wr_mas->entry);
+	}
+
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
@@ -5657,15 +5677,15 @@ int mas_preallocate(struct ma_state *mas, void *ent=
ry, gfp_t gfp)
 {
 	int ret;
=20
-	mas_set_alloc_req(mas, 1 + mas_mt_height(mas) * 3);
-	mas_alloc_nodes(mas, gfp);
+	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
 	if (likely(!mas_is_err(mas)))
 		return 0;
=20
 	mas_set_alloc_req(mas, 0);
-	mas_destroy(mas);
 	ret =3D xa_err(mas->node);
-	mas->node =3D MAS_START;
+	mas_reset(mas);
+	mas_destroy(mas);
+	mas_reset(mas);
 	return ret;
 }
=20
--=20
2.35.1
