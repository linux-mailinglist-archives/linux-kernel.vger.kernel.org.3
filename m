Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6152D6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiESPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbiESPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:04:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D3BED8F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:03:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JDA4M7005159;
        Thu, 19 May 2022 15:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=6F5vyXpWMKuTS3xOOpmWgyUFLdW1hPY/0Bkf0YiojR4=;
 b=airdcJCOQfJ/ix2X9El9+gbshMkfoIRBjEqws0ajVtwONVxBpQVJhnwNViikUMXxwWYb
 ldRBdAt2nw8ggxGeh9PHctkXspviAYO5vI0E7wAzFUcApf5/H6WZCTdfH3GuMsueQVZs
 OzhcJmrSqvPpkXan/OdWH4yE9yUpLOYy6wG+mq6K8lOlynvLLqWZsw6eG8OuQQ0UQmLO
 yIKm70zzSy6DmqnXGgM6H1ry+fG2buHtRFg7EYW+tZYXMyPsK/o8z93e6OBg3FnZYlrB
 bLgCySjShviANFDBfQLKf+05U7GvF96SqLBcKlniagu+kQU7oViA7j0ZAwyOBgLdRa0I nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytvjng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 15:03:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEuUkb037656;
        Thu, 19 May 2022 15:03:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vawtb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 15:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4yBhQP2IEHRfxfmblyOqAjGooLVs4ruPZbsgsMnilWethWzmK6ITLoh6oV9NlVa365svnRQVF27BXFzfi3jgEHHCUWUSZ0g3+ueBUG1AVBoEwJzROjOpw4Sx/Mpq3++udwCmE36PO+TXKCH6bfsHnutrTOh1l2d/O5F4R9hbK6Tl+0V4YAuUCCgSXZYqGadFqHDxTW9e8ePAA/D3XN9TvhrxPbcpgA4VEkDB6bD8AYxKMZ7LB9of6tUoOtw8WqFLQ+0nW4IO2nP7awrX87EC88Gl/mebJLJMD8ItNbkbBC9gzBikToXkx450HyjpwZ9phk1ER47Mt2kMnmlQtXpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F5vyXpWMKuTS3xOOpmWgyUFLdW1hPY/0Bkf0YiojR4=;
 b=eybNhqYIOF+ec7RZOnWQi1LPJ9/Hw00u/OQsdUjwb2qrkMlT2HbBV1MloQIvmztN99ycPlMHEKAneSa0EEQU+bbc0qFHbppQI2HE9uUzYbiUv7LssAwQhiFEJf0xAj+tgABJnQ0alfiK48IwTvSJPE/OQKpqguM0cZpqhODczOyLySdS/drM36Kv75ZrGleiTFCD4TSaigIsNy+qHva5S0qAJ0mOplkz5eu9E6BhJTF9dihZFlZ/jQ0CCSBRybwitT23RemW8qLwdNm/mpfFeuqlQmKEGiOzmoggAXYn0NaYQ7t0Axp9r/IZc6+cCp/YsM9Mfhzotbw1S6Mu/emu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F5vyXpWMKuTS3xOOpmWgyUFLdW1hPY/0Bkf0YiojR4=;
 b=kib/vP0CUhK1kN3EqjkiCS/a8TjKGS0E2PnjgEwzAMv1r2SS1ZdmFwWQSbaM2MHnrg7Lw5D7xFLUiRcWLRMNRXc8rQI+8G7m5anr+z1/QVE3HknAjlVRAyIPUyiwO8yGYisfoXn5yfG0tTT7ppk1vG2mCcQDzPCRoUcLle9vpoE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1316.namprd10.prod.outlook.com (2603:10b6:404:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 15:03:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 15:03:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] maple_tree: Fix potential out of range offset on
 mas_next()/mas_prev()
Thread-Topic: [PATCH] maple_tree: Fix potential out of range offset on
 mas_next()/mas_prev()
Thread-Index: AQHYa5GePuPt66PSxkCo8B0sPrPz2w==
Date:   Thu, 19 May 2022 15:03:37 +0000
Message-ID: <20220519150304.1289636-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e84623ae-73aa-4e46-a1d6-08da39a8c09b
x-ms-traffictypediagnostic: BN6PR10MB1316:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1316F3D22F44C8BAE8D468DBFDD09@BN6PR10MB1316.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIE0Hmy83fKTYUwI3uX82zUiXemS7v+hJUEHCWvpCdCP7oWqlVHrzGQhv2XIddKOwVIpkyzMwrf9oSy6/Q2XrVqWTy3rvFeE+F3gTleTD0/pJXCSjgTGIt4cwaaDfuxCg9HxIs1y89u8ErggQWcHc7cpBcrrItyv973v2Es2YCZjhrHhTZpbs2qhiMHaGyXe8BvGZef0NUSMi/GBZQY1goNgPZYZdbwW1KLCsZG5AEjcJF/ZLYQbVhw0M9yrjGgpSj2YTuMyvu41gVx4VGcFyHHwFT5tD8uTVaE4Yw/iBgWXmJyfWBuPdiywhTa0yKI71mDvCwi5aO3RIh9edX+DWNev8LvngaYJqRnm7VSdK7xwpFQ389V2w65EGpmxpmgbiN8/da4N/uJVZnwxc/9LtX/WeBWAOhlmX2Lma7E90EvrZw3BCZdcqrbb1uAWZo1nGqlG00BIlGGYFbM2ZYP1gImWkv1fPyrkSkqbXRakpEkfQ2vYgHMObHrJWzeyJNaMk6n+vR6a5VsUSbgWgPflB9SAwAQTVGHn4uVdbB/WgjEhQBKsjCAUpr/t68cEVpIlz+rC1mMziDHNZUnNMGrE0Gwgze3nqucDKDX8HNkdQKkqSLq0EqebSOMb+iJEAWDBreyewjwOYl5G6NK75pW261vzmgfNlcPYZZ2Y81Oe8dO2LUAPPgITUR+At2sQWCzorrmLDVfp7rs97iHqD0PWkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38100700002)(8936002)(6486002)(38070700005)(508600001)(83380400001)(2616005)(71200400001)(316002)(122000001)(1076003)(26005)(44832011)(91956017)(86362001)(6512007)(36756003)(64756008)(66476007)(186003)(66446008)(76116006)(66946007)(8676002)(110136005)(6506007)(2906002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IQitiN+OnsgfjXgh1VEnDlEXAYqPMeLlw9/MgSVUSGoMDUj8JGqoicRM9a?=
 =?iso-8859-1?Q?6dvqQlgA2wtK8CenhLjBlkTGoByge0YVU6uQsCeyWsI+Q3oLASXrfbM3aa?=
 =?iso-8859-1?Q?oJWc9MF1De3BCw05BfHlRUh4Tws3qI8OsOyyZBiOvTniFEfJaNJ8amMhQv?=
 =?iso-8859-1?Q?vpgi1KQ6EnYzqjgZKSF2kkNZrlxmYLmBeW+GPiL+h4xRTgvAxs2jPdi0Fl?=
 =?iso-8859-1?Q?f3Ak19nY+HKLg12UCStkRr088X7IcJN5tD2D5BuwGxiIFt86T+7B5Rh3yi?=
 =?iso-8859-1?Q?Yhl/j/sbDsqLCYi/vTWSwF/lj/pxTjaVZzdVpoWZsDQN2Njt3CRJD7Mf+z?=
 =?iso-8859-1?Q?ahPpfJjfxL+xUQi3w/IwJugwXbVdFefbVPD3LDwbPwx3VSSdTWwENqD0qx?=
 =?iso-8859-1?Q?jw8HKIu/ae0cMnyPrZM8LdnBN+bOK9HzH/BrE3uYQjQN7LaMch2gGUYyE9?=
 =?iso-8859-1?Q?BNH7ei+EzP/sdNZ59AxMwvrbN86QeKq/whbT7DdLIqhr0oNHOz5i90lGlg?=
 =?iso-8859-1?Q?4fVLQwdFG56c9byhWpNAornrz9VpZ4JGHepbXY5wPbTGrM6R1VtPItIub/?=
 =?iso-8859-1?Q?Vjrvt9KrnqldwWLGM8kdieKZ8kjRdDiHviIj/D+rZDHutAy/08h5UY1YET?=
 =?iso-8859-1?Q?IKbTKEyw8TxA9v997pK/qUMm93Q1l0wy6gyTRRK64wL+Y4pMWY9S1Ggslp?=
 =?iso-8859-1?Q?iFbS6KMOCVq1uxPMbo7Utxjys9K6EGgVu9g2WO0rOCNX+ZJeCa5DKkMO+d?=
 =?iso-8859-1?Q?1LpCa6BEz3N1cW3HuEcGDh37VMPgsmE97dGoEJoMarebeP6O2m1iJGHaa+?=
 =?iso-8859-1?Q?v49GtLk2pLorU2BuAJOirgj4Lsy7E9981BtQoI9DjThFwnHx/M+TJzSEjN?=
 =?iso-8859-1?Q?U/Cz+q8Nk1Q/cPnCfjRuNVUrRZmwMeaO4SUhE2SJXPyslFf2+36S2yFZLF?=
 =?iso-8859-1?Q?VT/GhKrthAKXvtem3HKI2sT9K0XsNbg5+2rpdZbxwj9fca7ynQ7ZLlu7do?=
 =?iso-8859-1?Q?+MIXYWRtIakBy5mHpOWYPCHnfql2MJZSUbMPh7/e2HtcT5/0rzFzPKRvzd?=
 =?iso-8859-1?Q?3otjBqzC0PvCmstCthmehxYzgyP/r3DHD8bL/3EMzOFIvKvfZK/o9euz8m?=
 =?iso-8859-1?Q?nY1acsKjWQDe1P9AXd0xbCkKgRG6yDa8KN1aZCzSyXAyZhIK9oI5VDEUtR?=
 =?iso-8859-1?Q?sS+XgRYfILMiTyIO1/fwSFxb7WaVwEx5RLoheQJv2u5EXloJkI71gjHpH+?=
 =?iso-8859-1?Q?xEbxMG2cL7Fu7ZrVv0dpCFEpS8danfnj0YoRU6Gl20YmssAHPb/c0QD0CK?=
 =?iso-8859-1?Q?JA1jx3osZwU0yII3FjHvwlQroR19TPCPA/X/TXCjXaeJlbzJUGrfA3aCBs?=
 =?iso-8859-1?Q?xVY77BSWSHyK5/Yb3vk9K3HbAh6R/Db98ldSoGWeiSDCQrxd6CHafdtddH?=
 =?iso-8859-1?Q?NHu7CCmCdKFxbG4MhjCpFA4I/73NmoaSW9lqDBcJqJmTTWycKiLv3e0EVN?=
 =?iso-8859-1?Q?C78cxw/jjNrDHYJv4BvTQNO8ln3GPYwqx1RCDYBstf2PLDppUWz2Te5ccZ?=
 =?iso-8859-1?Q?mk/sMFu01V+4ZHdqrIwYuy++YFIdXEAcIkE8g+T1WNnFhyLNbdbrJZbQbc?=
 =?iso-8859-1?Q?KqkZTXEyHVAZiMxwCQh9ajUftilh9pUjArcOzHsFnn8QuDoX7OYcbgYkC4?=
 =?iso-8859-1?Q?nLTa4+kSjlMeuRlkx0nwCk3wfASxL9KnB/SxTRtTcESA8/OK53TNsMa4ae?=
 =?iso-8859-1?Q?9lo3PvdjpFE4KpFbAXjnf6Jc6THb9q2iZmC24lpNW0vCpF5ppmcpE/Ofl7?=
 =?iso-8859-1?Q?xgFgKOvRxWO+pi+16HfecvTmgegBBZs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84623ae-73aa-4e46-a1d6-08da39a8c09b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 15:03:37.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TQ5oI/7L5YVQG7FUfSAcJKvWa2VQVlX28FE0CTnvbiBPEsJJusbc0erl+WxPG98mJ191s3vmKrquNUT9/vnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190089
X-Proofpoint-GUID: skOp8MYI3E80Dj8N4TkM39_CDaU_okcp
X-Proofpoint-ORIG-GUID: skOp8MYI3E80Dj8N4TkM39_CDaU_okcp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When going between next/prev, be more careful to stay within the nodes
range.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8cde2edcb4f8..9f8d3ee792d1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4628,8 +4628,10 @@ static inline void *mas_next_entry(struct ma_state *=
mas, unsigned long limit)
 	node =3D mas_mn(mas);
 	mt =3D mte_node_type(mas->node);
 	mas->offset++;
-	if (unlikely(mas->offset >=3D mt_slots[mt]))
+	if (unlikely(mas->offset >=3D mt_slots[mt])) {
+		mas->offset =3D mt_slots[mt] - 1;
 		goto next_node;
+	}
=20
 	while (!mas_is_none(mas)) {
 		entry =3D mas_next_nentry(mas, node, limit, mt);
@@ -4687,6 +4689,9 @@ static inline void *mas_prev_nentry(struct ma_state *=
mas, unsigned long limit,
 	mn =3D mas_mn(mas);
 	mt =3D mte_node_type(mas->node);
 	offset =3D mas->offset - 1;
+	if (offset >=3D mt_slots[mt])
+		offset =3D mt_slots[mt] - 1;
+
 	slots =3D ma_slots(mn, mt);
 	pivots =3D ma_pivots(mn, mt);
 	if (offset =3D=3D mt_pivots[mt])
--=20
2.35.1
