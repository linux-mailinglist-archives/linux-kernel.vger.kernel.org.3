Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490CF57E423
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiGVQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiGVQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:08:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD854052
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:08:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MG3m0B003518;
        Fri, 22 Jul 2022 16:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XGcuwHWacmRmpOhw7fK7pZyhCKk++4ieBMODqclr4w8=;
 b=rm8YxWB9o7VIbSpO56VEw+sGr4Qx+8TciA8eQFqO7n9tOqmptmwOO2Ey/uvbEn38nuBV
 goxIEPy3E1G4IX/3vhKB7geLlBMRq4QRSpsygBUBV0li/8zmj23QHug7sKObWVrYejOq
 KRbD/xHZkWdusBiAS2na9Mp//8zxH87MiEPMn9thLUIoi+yF6qTWGB1S8W9x1of6CJUt
 Bhj5m0oL6wwViVCwuvjEs1rSFERGjaEEYG4skTKx1ubtAit7F6qZzLREvB8I096oAaxR
 dMELL1zqgZfqinfvaff+DxnB7a8LuPKxFPDOZMN37fJmjmoqSX5L6zpCd2J9au1JzBwT Hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsfuux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 16:06:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MFaeMU009795;
        Fri, 22 Jul 2022 16:06:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gkv5v3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 16:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfbhkCPICzE8GXjKnaG36AQW58Kal1NtcPlcII1IP3SKGLOC/Lur9fQF4y+1KWGFhL0BUiYEM8LM4qUyXznKgZAaz3o56gRAUZ4TJBBnXO9jt9RkT3PyDyT/7yJHeJ31ayju4yft0ZbQZLbvTk0dNNNuIex75oT2Z56k5j+DdetUOfHde7Gtv6AyOvVx70QMrnWKOQ0Gvq6c/O38l32XXqYIaNPMGZgmGUiJFmq1SgeI15GmRM8/jMzIizTdOoCLVOqnbrBDH9K7yxSUaSG0YH0L0Dt3P/mNrSS7BZkpZluY0p06HJNZnpZ4kxw+rREGTvkGoZxs+3srNLlpKMhLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGcuwHWacmRmpOhw7fK7pZyhCKk++4ieBMODqclr4w8=;
 b=GZfTW+zT0gsVLzcO03BZXh5tsqq/KE8+ixQG5ah8W3bKVPg1uhMawfjrrHRbmBXwkBTKD+rCrPFhatM2lSK/tHk719CfcknrKMAdCZkTDbbci8kthppZ9wiVvXSupXSc/SOYy0QsM/MA9tmqjdUuyUkHH88jM84SeW2Z7y66yZCW5hQGQFUchk4aYjHYBYq4j5OgWhMaHKE5cgmdSskV2BY6QuVi08WQpiQWI9vV4Hz3EXVvTg4+QU7+P2RqqpdxwwwtPTvU5v+XVfUMeM9An2KBtNtM5aodhF1OM/Szd/6Glv+tYnnyai9DQpbu2E/pXBeAAcndra2/a76fV2zpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGcuwHWacmRmpOhw7fK7pZyhCKk++4ieBMODqclr4w8=;
 b=aJ964QgCf6SapWhQ/6Ae5OwMDNMNRk+7hcDwnjhMonO3obEraW6Ckunf7XoWDpQEyS9SAJCbTjNf1bOELtRSKko9Ie2Yy7taxrDkYMu7BV58aI9uP8+FTlg81sDwpjO85KJhnPfgwXkvm5a8ywI+KS/PKKPIj6fJbnvHAx3UemE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3877.namprd10.prod.outlook.com (2603:10b6:610:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 16:06:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.025; Fri, 22 Jul 2022
 16:06:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
CC:     Hugh Dickins <hughd@google.com>
Subject: [PATCH Fix 1/2] maple_tree: Fix mas_expected_entries() off by one
Thread-Topic: [PATCH Fix 1/2] maple_tree: Fix mas_expected_entries() off by
 one
Thread-Index: AQHYneTxBplYF04hykSpiqmj8a6KEw==
Date:   Fri, 22 Jul 2022 16:06:03 +0000
Message-ID: <20220722160546.1478722-2-Liam.Howlett@oracle.com>
References: <20220722160546.1478722-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220722160546.1478722-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7df0790c-8962-4cae-d3c8-08da6bfc1410
x-ms-traffictypediagnostic: CH2PR10MB3877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTyEPQlg95HR+6MI4GNDAhsnt1n8jJD5/T7gNJyMhYLBCq3uWsTP1rAJzKv5nsPgTgEbgx8pDJJRzcA0NzIJ0kBUI6wojhX3Ya2N8ldhM8qqBDW3wYD7BX58HNTE9pAG78rmYwgnQO7+6kEFprLQYBQ3lVDmawW4soC7CLXoWgTGcudVVOpWrbbnpQYvMqqhT3ELqp9A651cepZcQZszkUenj27dB0gw9B3x5m2wil+s11SCTkygjIe6572de+1RgTbm9W/gBaGFDVRQHXUMAUnYYLCChbwUeyrbv3GSoyEHi4wQY9RqJVyzppTtT56Q/XEbIO9LZN4ff5ErrUP1D/H/hppfbbFqKm46fvaMenbk1HiySxGTG3OBLOelWA2kbQvYEaYc/eYLqLSC4lwUXx+31ftdYpLd6Z4XmHbWmjeIc1hD/69pOkukVgN3ye05VibD82f6sPq6qVOx2C0W2QGxx8UVSr2hem2ZJfWh47CN9NS3guw/dgvVgaTkR7fy4AWnWIoB6m9vmogs9kz/+kVCgJ8/dCdBOX1uiJBvwO0F8MT6/KIvqSnuolSkbG/YmSy0UaCPwDIJEZhfQW5blhUw66oroGp6ZZLt9Q5JqpO+FqRzTN1lF3WrXK6rm+7rWBJqlgTUuIysmhR3RNgErzyxvN0ZcOSsM5imyYeoP+puf0wDBed+zHnslAEcCQP60GAi0IFEZaPMcqd511wjHO0O9imIFuPzLJz/AlnjczvlYJMQgmlc1uD64Vmek6wSa1u3PKTu3QIxR7e1QTX7+ypsyRhw/7ABZ9MKSVEFhIZJvP7uvMzNibOZWXIH2x0j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(76116006)(64756008)(66476007)(66446008)(66556008)(8676002)(186003)(6506007)(4326008)(66946007)(478600001)(86362001)(91956017)(2906002)(122000001)(38070700005)(8936002)(5660300002)(316002)(26005)(41300700001)(6486002)(71200400001)(110136005)(1076003)(44832011)(38100700002)(6512007)(2616005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tsxrDShlJQroI2TgQ0/22fwy8ESXoi1/ynjWwjAla+3o2UgPoIs4sFR6dr?=
 =?iso-8859-1?Q?6xCerCugMi8zwINeqR0Fh4aHLCVekmNFhGIcTLiIKrhuOoiEdqZfMJI9yq?=
 =?iso-8859-1?Q?pyIbH7nhiJgD5xu5bSe4x7zcghIW+zhqzEG0xka28CEd7m1y9HV2geOd5b?=
 =?iso-8859-1?Q?ZUELZyZyBYOAPkvGqrZQDexco3dsgHiaWRvZQh2WZKybP3ClN4p6504t0M?=
 =?iso-8859-1?Q?ew0kompkGWrfqei+rg/U0ARUbafOiJr0syU8KrewdVPyKctLLyFtAd7V8f?=
 =?iso-8859-1?Q?0znwpgm6uFN8CizzpmQ+mP3uYbJ/R4IRqA/TH0Tfm35nEhZ5aJyMLbvmqm?=
 =?iso-8859-1?Q?4IgudVwyz82c/zoSN3VDaFNAB1JhuvD30K7Sh00VsEvL9pOXe90HL5HgQ5?=
 =?iso-8859-1?Q?SSPzXHW5PyxNqHMWDB3xo5WdtFcSyLj7J99R4HMC5hdaeRcC394d9gHEta?=
 =?iso-8859-1?Q?xKKeEtBgxbjKpMnexffX0znP1QHwyMDwVJysyJwgmkl5f3TQ5zneh+4isY?=
 =?iso-8859-1?Q?C5YlwgsXqNNc9yQ5iscGRXJk0iDpdVZ+d4dlCzscRPfHOVBvBM3u5C46zZ?=
 =?iso-8859-1?Q?PHkCCv4536QgwaoPC1VApKN3D71Tv9VIM5wbD9m7t3j/Y3GVMhCNdvjDZA?=
 =?iso-8859-1?Q?7HK/aH3PoYjsfTH6yHwocfnLzET74/vCu8VHbdGPmHUeWhiKnbim1FpKLK?=
 =?iso-8859-1?Q?zaqpj9ztjb2oGFNFjdVI6Nz19KFrwZZcBSNe0SjpSLwA1wKBuT+/vf8414?=
 =?iso-8859-1?Q?UEDbUTCtSvTrAgbm1R9mSJXyPVM5f2Z4FSt9KJugsmOV/FRl96wjbuI33U?=
 =?iso-8859-1?Q?8Mw777gzXwgxO2Tiqn2GxstbU4qCIHfr9zf7dmH5mLtzNvcCdi/B7lecW4?=
 =?iso-8859-1?Q?4GMxEM8A/hQEkFLv716BxKfK7Y+u4KlR3QE/7TF6dwR0yxvEce1YLROBoq?=
 =?iso-8859-1?Q?joacxJnoIJd3txlwve38yxu5XdV1v2vBQnqv5k5aGEABJYC4IGw90sp0kk?=
 =?iso-8859-1?Q?T7+4UHl9L8J7Bfh/0My2HCXdxAXgt4Yzy5sXpXcElfuH1h3L0XM5KkecsG?=
 =?iso-8859-1?Q?ipfh+jL+Esc68m74dqPhUHyet/YMgatkDtXwh5hFdF4qz7H274RJlzQtYF?=
 =?iso-8859-1?Q?u5b2i6deS8oS0A24KYn1C9AXVyNKxsRIYrhTFjlnVqEeQt48qbKF0fdDb7?=
 =?iso-8859-1?Q?VERhq+KeFVilWEnbFeWJnCkT+0MtaCjhIR8AdbztBLnBLaIESG3wMG+T8Q?=
 =?iso-8859-1?Q?50q6Pu3dLOWawZw3cnmSHzTQBU7j3D6MHzqcRId0cA97UD5zXnel5Pgbat?=
 =?iso-8859-1?Q?d275WFgQj35kjZf9ZcdECxV7AeKs+np6XxUpGyc9NEelkO4QQvc4LHMnQh?=
 =?iso-8859-1?Q?u+YleH6G13+RAHHHIaycOXv67ocLYXSTCY2+ncJk9cwJbwrc8MV+Lv6nyw?=
 =?iso-8859-1?Q?w91g/KhYSCEd/q46qJ50QCZv/jmhwqrEWWGR7QT5Fsrah77EQkrIVnnPt1?=
 =?iso-8859-1?Q?phQ+tcrjo/AEp4Cg/iQGN0xCPg9RncSOGsRt470NuVS4MttFJlfTYDvD3y?=
 =?iso-8859-1?Q?G3dwl8t+sr1aDbmGgbxo01fUoKr9zjW+Oj0undeBkg/xGfZw5O95WdQC7w?=
 =?iso-8859-1?Q?s3U2ZhdLwbBmVQRb5s9Eyhzy/2y7IE1+HfokWMWX/2BpsQcyJym6ZlTg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df0790c-8962-4cae-d3c8-08da6bfc1410
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 16:06:03.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSWlrfbTqP4iMM1D5c+ewB/f3u6CHRqfX8rqMUXJBL0IvGoUqzaPGoruDPx6YXsyDtLem8s/WaW0sKNKgWkgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220068
X-Proofpoint-GUID: 6nfiNpe-PFrlh0To2oIv6rD9WUjFO_y7
X-Proofpoint-ORIG-GUID: 6nfiNpe-PFrlh0To2oIv6rD9WUjFO_y7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When inserting nodes, a final call to split the nodes will require a new
parent.  Add this as the working area for mas_expected_entries().

Add a maple state flag which will WARN_ON() if there is insufficient
nodes allocated.

Export mas_is_err() to be used in checking mas_store() returns
externally.

Fixes: 06b152b7980a (Maple Tree: add new data structure)
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  1 +
 lib/maple_tree.c           | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index bdb891b0d2b5..a30e03b06bed 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -457,6 +457,7 @@ void mas_store_prealloc(struct ma_state *mas, void *ent=
ry);
 void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
+bool mas_is_err(struct ma_state *mas);
=20
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d00ad50b258e..a3ead5fb5307 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -64,9 +64,15 @@
=20
 #define MA_ROOT_PARENT 1
=20
-/* Maple state flags */
+/*
+ * Maple state flags
+ * * MA_STATE_BULK		- Bulk insert mode
+ * * MA_STATE_REBALANCE		- Indicate a rebalance during bulk insert
+ * * MA_STATE_PREALLOC		- Preallocated nodes, WARN_ON allocation
+ */
 #define MA_STATE_BULK		1
 #define MA_STATE_REBALANCE	2
+#define MA_STATE_PREALLOC	4
=20
 #define ma_parent_ptr(x) ((struct maple_pnode *)(x))
 #define ma_mnode_ptr(x) ((struct maple_node *)(x))
@@ -243,7 +249,7 @@ static inline bool mas_is_start(struct ma_state *mas)
 	return mas->node =3D=3D MAS_START;
 }
=20
-static inline bool mas_is_err(struct ma_state *mas)
+bool mas_is_err(struct ma_state *mas)
 {
 	return xa_is_err(mas->node);
 }
@@ -1215,6 +1221,12 @@ static inline void mas_alloc_nodes(struct ma_state *=
mas, gfp_t gfp)
 		return;
=20
 	mas_set_alloc_req(mas, 0);
+	if (mas->mas_flags & MA_STATE_PREALLOC) {
+		if (allocated)
+			return;
+		WARN_ON(!allocated);
+	}
+
 	if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS - 1) {
 		node =3D (struct maple_alloc *)mt_alloc_one(gfp);
 		if (!node)
@@ -5706,6 +5718,7 @@ int mas_preallocate(struct ma_state *mas, void *entry=
, gfp_t gfp)
 	int ret;
=20
 	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
+	mas->mas_flags |=3D MA_STATE_PREALLOC;
 	if (likely(!mas_is_err(mas)))
 		return 0;
=20
@@ -5748,7 +5761,7 @@ void mas_destroy(struct ma_state *mas)
=20
 		mas->mas_flags &=3D ~MA_STATE_REBALANCE;
 	}
-	mas->mas_flags &=3D ~MA_STATE_BULK;
+	mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);
=20
 	while (mas->alloc && !((unsigned long)mas->alloc & 0x1)) {
 		node =3D mas->alloc;
@@ -5799,7 +5812,6 @@ int mas_expected_entries(struct ma_state *mas, unsign=
ed long nr_entries)
 	 * insertion of entries.
 	 */
 	nr_nodes =3D max(nr_entries, nr_entries * 2 + 1);
-
 	if (!mt_is_alloc(mas->tree))
 		nonleaf_cap =3D MAPLE_RANGE64_SLOTS - 2;
=20
@@ -5807,7 +5819,11 @@ int mas_expected_entries(struct ma_state *mas, unsig=
ned long nr_entries)
 	nr_nodes =3D DIV_ROUND_UP(nr_nodes, MAPLE_RANGE64_SLOTS - 1);
 	/* Internal nodes */
 	nr_nodes +=3D DIV_ROUND_UP(nr_nodes, nonleaf_cap);
-	mas_node_count(mas, nr_nodes);
+	/* Add one for working room */
+	mas_node_count(mas, nr_nodes + 1);
+
+	/* Detect if allocations run out */
+	mas->mas_flags |=3D MA_STATE_PREALLOC;
=20
 	if (!mas_is_err(mas))
 		return 0;
--=20
2.35.1
