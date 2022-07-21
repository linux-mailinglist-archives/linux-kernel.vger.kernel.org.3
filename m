Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C892E57C1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGUAxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUAxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:53:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7084BD25
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:53:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L0p3Uv026464;
        Thu, 21 Jul 2022 00:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=i+IZMfd43v2HyytbYcgR9m7fH7TGbn8+/9Seg3i7X/4=;
 b=PMIAb/iSeFMUp3kEGHcHufV9x4m73WrzDec19Z2JxfTYnorcRl9j5fXhyo7Dj3CVqOFq
 tWAETmaY/yN2MQn+g5+V/UPozpDinOO6yq3YbEb3sd1RNkiYwCtsiDsF3X+oifYAJFtR
 qCzwii69QlVM+SEaF84WbpHsEW7duwzwZi+zaUKN+8dPwBbdQbXC4fUzZyBotu1elKG/
 cYnR0pm8mKVeLgcNayEuvFkfzzZGRNtJpaY4Nq3i+J6LqZ5LKj5ws3mVr1GG9nn8Ejo5
 xQVkhmFDq4DrW0NoAR5i9wjr1WbM7xDPJ1jr9D3lzTSuVt4j8vhxMS59mC8aEX3LHScf HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7aavj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 00:53:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KMGte1007889;
        Thu, 21 Jul 2022 00:53:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k4qbgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 00:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbZSvdg9plv08rEjLupVQkY1fDEKfEr/h/SmBM6MBsasFIcMn/KkbPY1/mFCgp5g3R4RgnnOaV99ka1Uom8XfA6xzJE5JuayUwjdOxH4i8EiOdDfcRzKCGI80SDhPWe9T804KF5iUm2MvLcgom43+hYG7YGHL4dtv9m56Ja1O+j6qMFI4oRWms1Mo//SO9zn7K9fMZjgmrlbzNf+1WftzBPy53CniQzkjhrFgsnSnOfxyE12AXil64M+OV4N3yUK6fWnJa0I+LftKAsSzoeICwPkI/iMRSqBbOZPHcrLvm6B17lv7Xu87oFoAV3pKFtOBKFMyulJHoKXOE84J6KssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+IZMfd43v2HyytbYcgR9m7fH7TGbn8+/9Seg3i7X/4=;
 b=bectsJho90xApSWss46jIbPgxYDkTEdRJ451X+widZOEH0qcio/Zw8H5+xthOdDFNdrb6pmRpUpksPkH3QsFnnXh8+GV3GMACohipi01/XI+JCIL+L7IvyMiVaHv5EY7CXRezT+eoJ/kWRIA1YresZu52KhjaqxL/210+XJqaMXbnk/WIKhHsE7PRI7vBAG3k3WbfAA/ysDVd9OOWjmi5jyqGNvSWKee0u+exgYU52Zx1YBKBsJweITu3JpUVM8znQy0KeaMuzknqsfRcuxGxl/tLC1mkWvsbDAJx/UPhi8JD+NCFyTm1o78xdxvydPQudHPTvieAwtm2xBSTbZ42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+IZMfd43v2HyytbYcgR9m7fH7TGbn8+/9Seg3i7X/4=;
 b=GEIppFfHAxsf1YPk3Rxg6kjrQWKLWDePwQSkDsfLTFV+SvROtmphYDovWUY1Kr9vCqrO6WoPOLrcTp3VLZpaNwO5vcxPatuCe5on59ZGSTt/CeGERg+aeqKYfJNG/92/4XUB0amUl/sEaYVa4jMDehOIglrKZBlBDr4jMgyqqJM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3392.namprd10.prod.outlook.com (2603:10b6:208:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 00:53:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 00:53:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] maple_tree: Do not inline write slow path
Thread-Topic: [PATCH] maple_tree: Do not inline write slow path
Thread-Index: AQHYnJw6aOsbtqNHaEaswARV7Qt6zg==
Date:   Thu, 21 Jul 2022 00:53:02 +0000
Message-ID: <20220721005237.377987-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fc16c88-f9b3-4282-b1e1-08da6ab35d67
x-ms-traffictypediagnostic: MN2PR10MB3392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJfhEdFf5o0T9g+s/JTpbU7nsb4ueUMKj39Zw5hT8DqvENkSA9MswEAuLZY2wiQLooL2KZtpxiHoJpAlk48ns77qCFaULg5dQENSxghhqg3oajlF9UyxqU3mgCA2ZUTBMePDmJy2CPCy/EUnOMOnAD2w2euS4zODTJiF0rBwxmtvJpjRP9lWMAdiJ02PArQqPvvR66fC3gTa4ETbhu+DI0JXIcvo5LmhmwbNk8p20pMFMaRZ38IwAubf8QnXxc+w8/E4Qdj9SD7jHUdTNjIH4y0fgcVfwOu6RhQd6Gt6aVu5RfODH40W/pmKHbcJeJXUmMAty8DJ4IT0nFPL7maO5+uBV/0alh5FBahpmPCBly0I24UzfalmQK7cXi81g6ocrDcJrfE1tOBqGWPzIhYNI5fWqGjIr1KCpAzL7sBllJlbZmlxDgVcDD5Suq3WWplz/PuSPD+gVro4ELy2sCo4OzYNa0OE9srd5xR8iv+6NuXYwQXDYdjriHOV2vEujCAw0e2HggNQdG1LDYiZ9xVUaSiEnUx2gJUXQm/U+ekIrKy3+cuXLdBrIFIHS3sEMVoaC+gduCsvLP20UZVKQHARi5KHKgwuiGLrN2+9V/L/dtjxg+6bXFPTKuKJMu+AC6KM0Y4Vm8Xe+azn8fmAhilneO1yjk3sFSdHJSZuvUlW0fsjfbP+VUP3eVjG+XP6vUX1/K85iysF8+I0NJJhGr01YJZXrdAq7UP2RuyUPslHCvqzVZ3p+FMjfdG4VUrTJMTwPD2iFyeEgdFUQ1KB8sDhTXs/Xxjijl2kU1xd2PRA0Zkw9KM+P4sdT3fZSzc6ne+4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(366004)(346002)(39860400002)(66946007)(4326008)(8936002)(76116006)(64756008)(316002)(5660300002)(2906002)(66556008)(44832011)(91956017)(122000001)(83380400001)(8676002)(66476007)(71200400001)(38070700005)(6512007)(86362001)(41300700001)(36756003)(66446008)(38100700002)(26005)(186003)(1076003)(478600001)(2616005)(6486002)(110136005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cWHdHkYVz3SBnyvX0TAkbFB4vnxxNs/MDwv9U4pBBtL9gOmJySHO5X9DQq?=
 =?iso-8859-1?Q?b5/6Fux295d9ThA2PeIhJNEMTICX5fLIwmb85g9E0SBKve9I/fsssqjqzB?=
 =?iso-8859-1?Q?f1v9roNwRyEnn+JGDJR7mOK0NN17iGVYamqLd5k/TEmmwUs1DBUen66z7y?=
 =?iso-8859-1?Q?QLOHP1a6NA2e5YUPITs+VI6uWkPo+ro7NEci/D1K7nYhzpIH6dLyDIMKfm?=
 =?iso-8859-1?Q?dy7old1AEnT3nKEo3vUGwi1CFaIbhSLu4cMUk/0P//kTs7Urdn1oaZ8QQM?=
 =?iso-8859-1?Q?IIvNmPeB0RngPp+RcQQExSiLGEUl6KVvOnQvborOPAwrqW59xBndsGfN9p?=
 =?iso-8859-1?Q?pFxri4sPA+6yA2SUmMFlYbyKX2kRTr5lHUllxFkvCqfdDtfcwFyOYZUfMc?=
 =?iso-8859-1?Q?88o7QVZGBUTo35J2r7MVXPTQqd5fz3t/f3eRvx1ApPbG+quFhP2GqAarUb?=
 =?iso-8859-1?Q?wzcUFfVTJA5BP8pxF1HMGXwNLoG/z4AQ7F4JPnsfjhFaabGL6CktEy8OOm?=
 =?iso-8859-1?Q?fa9UD9igjwJtVlTGQzSyZRttehxCOt0DWIlqQUr+jpFa/c6LrNYUi3jfI0?=
 =?iso-8859-1?Q?FdXk//YI5+qO1cI562y4pXJOF/9RqvT1W/bZMeLx1sYqgVxrRxFn2uV1bH?=
 =?iso-8859-1?Q?XS3MB24ZloWkWv7g6fQDOVLqgQSrPQeBdkFgToWMK3yLLSdBfMqraGqLwq?=
 =?iso-8859-1?Q?yKcaD710IwMc8Bmcsc4BbvZDHq/ryu74bolTG9H/+DWiqd05TNBPcF5pNH?=
 =?iso-8859-1?Q?Hm47r+0uXkCmMDCwTa1Nz8S/27RrUiqQTHT+U5yQ6vACjb0dnSSjsqVjv8?=
 =?iso-8859-1?Q?Qo4ZHs50+4SOjVVtUIeZDyA/i96LloQTd4kyPfmBTcVLCztFDrlwFgEzb4?=
 =?iso-8859-1?Q?IwocvVDm/LfgCqujKo0aYA5XPM+nT/fWAkt7hUAKLMuP15WytFHgRoNrVv?=
 =?iso-8859-1?Q?Dxf9WV3Ym9mdxS51GCDdDqQLgv2YstuYIyXXhdSNoyiAwVzLEaNZef24kr?=
 =?iso-8859-1?Q?RaSplWVD6to6dH3OhmnBZ8cO9gnWX7LpM3zCQze9IxXmxGRy6kTXRODDzY?=
 =?iso-8859-1?Q?nWUbuSeQTBtC4XVLTzHoOc0zHPV7zAWpPs4hyZPxzTQPN7nLWDDV6wyQ8Z?=
 =?iso-8859-1?Q?Y02m8smBOYWLmJD16XtMbhfk8H6aX2uxkIOr7tmRPXiCvrmIE94wM3BawU?=
 =?iso-8859-1?Q?2xyq/TflHSruA4ZbJeVpIQsEjLoM13GW2vbQHB0NEY74CynppucM1raHXW?=
 =?iso-8859-1?Q?I1dqPWAW5uJ4eeSNGFPbz1y+IT8CqesyN2k4NdrOZF54XByJ7UyIv0hYM0?=
 =?iso-8859-1?Q?57mVCjRCUVGCOX3kLFvQ0Dy5wxVEtkow6Ys3LDxvuJbN6TE1BJaQDaBA1X?=
 =?iso-8859-1?Q?Xda/lkS3crm+sY1DYdihb52Etd4WKOWfL2soXYT1sM9lP5OdIQFXap5SqQ?=
 =?iso-8859-1?Q?FyBrb9u7y9Kxa2gZH+ELDqkdjoT5bo3Xtgd8P+uAEkWwPRem1zOpeR5sfp?=
 =?iso-8859-1?Q?aVIDEcYhAK9cS8bXYB3UZXEbx/5srVVF04wjb6fL9bFwYVCccOwaGRMxcd?=
 =?iso-8859-1?Q?Ju8FfCqXA1QIOzZwKofgLtnCt4C6xi9drsoL1ApSrO1CO7W7aWfhQKpnob?=
 =?iso-8859-1?Q?oGHPQE72UqVKeP3uEGro1NLEYlvq9B4rmqw18Me8WQn/hT5ofrlnwqIw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc16c88-f9b3-4282-b1e1-08da6ab35d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 00:53:02.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQA70kzRFiPQxGMmk52/zQJy9Vh37Tjf6H9iNDgCuu/bRvuA3wES0YqqheZATmPOwpoPqe1m4rSy0iG7br0/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210002
X-Proofpoint-ORIG-GUID: RYnVkdP8zCCKMdDyqc1KQ2oL4nZvxhVL
X-Proofpoint-GUID: RYnVkdP8zCCKMdDyqc1KQ2oL4nZvxhVL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the slow path inlined causes too much stack usage.  Create new
function mas_wr_bnode() to write a big node into the tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 95d8659c5a99..4c383c780162 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4297,12 +4297,27 @@ static inline bool mas_wr_append(struct ma_wr_state=
 *wr_mas)
 	return false;
 }
=20
+/*
+ * mas_wr_bnode() - Slow path for a modification.
+ * @wr_mas: The write maple state
+ *
+ * This is where split, rebalance end up.
+ */
+static void mas_wr_bnode(struct ma_wr_state *wr_mas)
+{
+	struct maple_big_node b_node;
+
+	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
+	memset(&b_node, 0, sizeof(struct maple_big_node));
+	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
+	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
+}
+
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 {
 	unsigned char node_slots;
 	unsigned char node_size;
 	struct ma_state *mas =3D wr_mas->mas;
-	struct maple_big_node b_node;
=20
 	/* Direct replacement */
 	if (wr_mas->r_min =3D=3D mas->index && wr_mas->r_max =3D=3D mas->last) {
@@ -4338,10 +4353,7 @@ static inline void mas_wr_modify(struct ma_wr_state =
*wr_mas)
 		return;
=20
 slow_path:
-	memset(&b_node, 0, sizeof(struct maple_big_node));
-	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
-	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
+	mas_wr_bnode(wr_mas);
 }
=20
 /*
--=20
2.35.1
