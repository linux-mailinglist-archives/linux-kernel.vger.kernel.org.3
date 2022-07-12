Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE4571C57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiGLOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiGLOZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:25:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5AB1861
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:25:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtMNC030898;
        Tue, 12 Jul 2022 14:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=Rn0BQAGxMhSGs1gC+XvynVyaWYMoY+Vn124DdXvyI6c=;
 b=o81XDsP+BJnpQlV1YbSCUJGPg0nU1JiL3Y5WyTVYIhZ/11DFF7V3AEH1X89m8qCuKInA
 l++qk+91i0DcUCyxFbMFpGjYmwSVp/ZYdQUUzeXI99bGZ/8xJNBkBESP/l7vAaEOzmC2
 37+Zh/vMw+dXl26we96JrZfu5NWK8JtON4Mg/srBBqg17ZSTZ8BBSXIFAjL5WGcP0SmH
 qJYjBNAn0p0UUgPvvCELf+5/flD3BIgDNcPoCrEfUniBmpbc7x+iO/l9D5B2w8PopyJ9
 KwiXF9B/hipUgXL1WgEYuFfYS4gGzO6QRFLMVfYf/1Fa+4MW4ss/dnYyLoqobJV/PLL0 oA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r16ss0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:24:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEFKJt035720;
        Tue, 12 Jul 2022 14:24:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043tu40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2MEI7d7OJX4DmBN6xG0dauBwDo91cXOeZpq9vHtIK8R4yFjZCBw8tCjXzT8gWOv1gHaRFkkkSIvCSAroQ68ZQaXk0UmKCsavezQE+lwN3bm9l2wL6s21c4NLNYtJp4CBicy33THs+FsiFi/xPPgQQb0T8qiYt2Gt3JBXzEzcH6MuQ87Ym44k4BrU/vLKywhm7lsKOX1usGXKqiDcuzHSNLXz/tr34vVDuQBv/Ggmjh0yc8/WW0PUuEYirKJnmvtsu2Qz46LqyjOPOk0NRICOtpRojo48PtT4Kj7wMPlikNmKjTMfNSLdXmJ6Hu2zo/V9mcPdhEK3lUxahe6Y+Y+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn0BQAGxMhSGs1gC+XvynVyaWYMoY+Vn124DdXvyI6c=;
 b=XPuTuvHZEKWsp8o4hplZjNrD9CBQSOGMTqWYct74ZNT3nclniyJ7LbEu4M0dK2BUIufLRcpmyLtKCDzFgqf8A3TY7l7SxPVHeItHFSOVB56kwrQ8Zbn/bGjK7UfNb5xjDo4E5XwGxFiB7jFcFyi4m/fvaTfnN0kMUbMzAwgg++D3XrQV3qLfuQoxKiHmPaMDnJOispF7A8EMFawBTuB38MruBSabD5rn1i72iMqX8vuAlfAvl9oPYjrgnWeiLzYTOFcOw7Qm3ES08JJdo+RCRHB3pzFtgT6tW0TS9BJ/LvIilgk8uPZj0Aj/E2/Wpf51N6PMbn6HKDNIy37aLAstsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn0BQAGxMhSGs1gC+XvynVyaWYMoY+Vn124DdXvyI6c=;
 b=sbyBiwW5hHVSPRgIiYc74ov27sydrOo2NdbjTOJGGJhBTLNgUhl0enZuljKWBoQIiKl3SRR4iTsO2Lo+hsThlNDZ3ET2ESy0OYnR7QHVA7ltUdPF8TEpgKkM3t8pFTS7GnP/dlzhd3l5KN+yeCtmN/O0H3BsezUzEDZSYH4M8+4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB2005.namprd10.prod.outlook.com (2603:10b6:903:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 14:24:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:24:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJQ==
Date:   Tue, 12 Jul 2022 14:24:55 +0000
Message-ID: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4ddd61-1c98-46d3-606f-08da64124b10
x-ms-traffictypediagnostic: CY4PR10MB2005:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RmykWYpfddOCOmXBweNgpPA0tpi49Nxe/T/oNCIBFF4g+vkfN3cXG1BCpEQEHH1v90l4df5toAefvhLK4kqHVlGUyxEjCU7TCEowYb7Y3Jq/4l1VUeysvHpbiRn30Qsl4PrdubyocKoQEz5/Z8WuZFTdEWuqKujN6PYfGlAxupRLVwkbIPp9HciSdznyM1X+PW+Qg1V2ZAs9WgWT10aHxMYs897cW561SmA5CvDsDqGkp9pHrUwmQ4iiQasiINg4VnskwicHmRbUdN/IUzsX5sPVJPll1GY6uWPYtqSWgkBEbvoicIoTH1mVeq/xE9QlrBDTkBkfvuOBW/IpjLfv3iiUAGAdq87COmGUIPbaa8ETNH8v6uJwKEfmKnzNOoE4r6WeExYCEe+0wOhKOihDPmZJ4ECBElGek7+13CEJ50TqVe/jC1LTyc9XbmToTa0RPuFdUiiE0nZXRrvqhTZcZJiQJ98sQBswHg2MgX/eNSlX1mYa1VMZeNJ07dS2wZUYw2Zx1sVAYQhYGeijR2Af1y3EzoHB1vdnsm8HJivRGVRgE9ZB1B24xegHsjvEq69pPQoLZPkMQ1Tqn9LX0gFgUmWvT2eQVdVEsGhNG85q0aN6L5IQwLLG9Il+Px1WkAA3oZ7/zaVp4jNQ2veKNjx88ucIMmXiNFau/Ti6EwFvKBylPkZTti8bdT9A6N36xDefV6eZ95YN8HYPouedPJlp/04Bh+xrO2nxEltwA1IU5NBW4goHoqrL5zq5J7AICwgMFTW2InzFGZvBil4IGLYOgTF13wu7xukzHV535hkRSxBpFxQZk3kPmaW0OFEQXWF2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(396003)(366004)(376002)(8936002)(36756003)(44832011)(110136005)(6506007)(41300700001)(71200400001)(38100700002)(2616005)(6512007)(64756008)(2906002)(26005)(5660300002)(316002)(91956017)(66946007)(8676002)(38070700005)(66556008)(66476007)(83380400001)(86362001)(122000001)(6486002)(76116006)(186003)(1076003)(478600001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ma5AugQYpAF2juq4YJRtewVE9KnAAkEuzZzh7YR0zSsFOyJfxrjfF5o7eH?=
 =?iso-8859-1?Q?OcBLwPUyJopRJKk78nlr1fzcsCtcM4Ikpu61bE1ZVN3KDoCZxrvKAJdUGU?=
 =?iso-8859-1?Q?wmmXdZxodjS0LcyQo9ORtTl4JMmhc1D80gl4b4ZLWyMuefk1DreCEcDfoN?=
 =?iso-8859-1?Q?VNNhJwL4EnL7Ua7Ok8NtrXo/I53xhUAZi/tXKDaAMx6RqhMUelGUHncFi8?=
 =?iso-8859-1?Q?8wjOb57M0NA5lAvXJYQ3mLRwmTcs1ri5bglbKg/T2oPp6mTFPkrW2sMcwe?=
 =?iso-8859-1?Q?fFAi4HgF+zo/X9jvXJzo9OGtbI541dggrCiuHoWnMtOvg5btqDmqXIno0t?=
 =?iso-8859-1?Q?Tg6FgN3a9cjjtX3Bi14y/7XqUKp+8OmoznbzYMOlSUDyhZT2sqStYo0ff+?=
 =?iso-8859-1?Q?oALBPEh71RrqSTl+FBBvs4OhxrhtKnYyNjFELrqV1eoYriAZ8W/XI3PUpF?=
 =?iso-8859-1?Q?o81J0VltPg/fErPr2P65VsBiayR6fTxDUIFLT+vtGgwffh2XwjeFLxVkbK?=
 =?iso-8859-1?Q?sPH4i5BxZFQSvsTWzQ3ZQC2RFsDZTZNKktbdldTOdNx7wcyx+7Iy4ZL3zK?=
 =?iso-8859-1?Q?9oWPBpsfmM/wM5HOAV69Kf0wvPCDDl9p1daxa/afdmhH0nMJFAef/2eICX?=
 =?iso-8859-1?Q?zBNGr2Vreql2YijGsvumqaM1BO7U0KadH9NBmx62hi7rWiSDaTfMP+K1Qt?=
 =?iso-8859-1?Q?hpr4xZlpCo3w+AotxQkLkcRk5vowpry0Js01GMp2bjY4sJmlAQRkf9nMCM?=
 =?iso-8859-1?Q?FsXhLzvyEKMXHP5YzRRszQvqHX6rPnogvElGeI5FmfI6K2tVqBrT4xKXBg?=
 =?iso-8859-1?Q?xU0BY6ZhwQRZ9KswnLHP5hyc8lr2Zo6PgEpmbvBCrOV8zCUXDeutHLGbDR?=
 =?iso-8859-1?Q?L+qDkJzTENyUcniJ/2VxqffzBSUAz9Z/cJfakoImiXx22157hgiKjiTlI6?=
 =?iso-8859-1?Q?MjzNfpPdcZ/rNJbadXGl39A6aARe85OR4Huv0bicaJf4mq58EbNC+4suzA?=
 =?iso-8859-1?Q?lUnMMbsm0Tt/5ju/p+7KcTNcxMhVO0deesnLiGt8A1bULrpVheUiYNS/dF?=
 =?iso-8859-1?Q?YXPQk7ogq5Wnm2TgitQIRoe7z52zpmlX5hOFiRep5POQg1xSzTgUfNT313?=
 =?iso-8859-1?Q?XOtNr47vidpeKHSx1HV8JWPgQw4uWTkamI2T4RR/zSp6k2/lk4bYr9gZEz?=
 =?iso-8859-1?Q?JAD0B49M4b0+EOe4gaIaTqUPgHkI+HCW6lq3PY+x0e2ObWV4pqBCk4OctV?=
 =?iso-8859-1?Q?PIXIVS/uY5fP/9/BNzk84OsQm6BQGKiiOk3cJsPNj//RsaSuFKJJJ2SPcV?=
 =?iso-8859-1?Q?cJK8G36kQIL74g+WKrcMTj1+XEoJxScRuiIJVXcEVWn87gJ60+Xebj1Xf7?=
 =?iso-8859-1?Q?xlrJgQ1ea4N4R0bX/qLXOcCD6Kfj5SFZ52KbYQnXXNGI2piE8x6yaUlNUH?=
 =?iso-8859-1?Q?g3H7C1p/lfD8rAC1/yNL85J10DUEKmCatHAXzI2jOYhxuJC8kHefrxPKzp?=
 =?iso-8859-1?Q?oENRXonSlE+PTSEB24btdKpZxQvlsa0UNof3Td54QEfj1X9jkmZc+Qi+4I?=
 =?iso-8859-1?Q?SerWI+/1E8GzZeZq4k0piLVkFMp54lncUIQNIMZb5UtYdN/gWmeYAFKig9?=
 =?iso-8859-1?Q?Cf6LCClap7FGRIeT5uiFpx4bjyIavqDhBAZnCjr+WXlvBjoTRyS26G7Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ddd61-1c98-46d3-606f-08da64124b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:24:55.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZFISSQSlQTM0eBGzn3GidywREygI4h/+SnDEtQ8F58GUupzYmHUq+24ayAQXSHqjf/TvetzL0IyudlJeI0DEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2005
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120056
X-Proofpoint-ORIG-GUID: geVXbVQgN2F_ebQb2IikepRZg1ze02QU
X-Proofpoint-GUID: geVXbVQgN2F_ebQb2IikepRZg1ze02QU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with C=3D1, the maple tree had some rcu type mismatch &
locking mismatches in the destroy functions.  There were cosmetic only
since this happens after the nodes are removed from the tree.

Fixes: f8acc5e9581e (Maple Tree: add new data structure)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 79e07c7dc323..9dc4ffff18d0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2319,7 +2319,7 @@ static inline void mast_topiary(struct maple_subtree_=
state *mast)
 	MA_WR_STATE(wr_mas, mast->orig_l, NULL);
 	unsigned char r_start, r_end;
 	unsigned char l_start, l_end;
-	void **l_slots, **r_slots;
+	void __rcu **l_slots, **r_slots;
=20
 	wr_mas.type =3D mte_node_type(mast->orig_l->node);
 	mast->orig_l->index =3D mast->orig_l->last;
@@ -5461,6 +5461,7 @@ static void mt_free_walk(struct rcu_head *head)
 	mt_free_bulk(node->slot_len, slots);
=20
 start_slots_free:
+	mas_unlock(&mas);
 free_leaf:
 	mt_free_rcu(&node->rcu);
 }
@@ -5513,6 +5514,7 @@ static void mt_destroy_walk(struct maple_enode *enode=
, unsigned char ma_flags,
 	do {
 		enum maple_type type;
 		unsigned char offset;
+		struct maple_enode *parent, *tmp;
=20
 		node->slot_len =3D mas_dead_leaves(&mas, slots);
 		if (free)
@@ -5524,13 +5526,17 @@ static void mt_destroy_walk(struct maple_enode *eno=
de, unsigned char ma_flags,
=20
 		type =3D mte_node_type(mas.node);
 		slots =3D ma_slots(mte_to_node(mas.node), type);
-		if ((offset < mt_slots[type]) && mte_node_type(slots[offset]) &&
-		    mte_to_node(slots[offset])) {
-			struct maple_enode *parent =3D mas.node;
+		if (offset >=3D mt_slots[type])
+			goto next;
=20
-			mas.node =3D mas_slot_locked(&mas, slots, offset);
+		tmp =3D mas_slot_locked(&mas, slots, offset);
+		if (mte_node_type(tmp) && mte_to_node(tmp)) {
+
+			parent =3D mas.node;
+			mas.node =3D tmp;
 			slots =3D mas_destroy_descend(&mas, parent, offset);
 		}
+next:
 		node =3D mas_mn(&mas);
 	} while (start !=3D mas.node);
=20
--=20
2.35.1
