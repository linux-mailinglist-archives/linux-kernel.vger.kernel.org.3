Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1600577369
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiGQCv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiGQCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01628222A4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8g37009610;
        Sun, 17 Jul 2022 02:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ke9TTATY7XtifzWpb2zMyH17PxfZMLlm/K54eKH1rHU=;
 b=ErGMlTAy1hPZQoud86YRuI7HHFTF19MUUJeM+0vXI3g9cqDHMEKkrqS6X5vnPah2wm7x
 LFUMaW5SbSfmRhlPIdGYlT4X7Kxz+ZApaAPMWfAQdCWGlSQ9Mr+54YaCo1NXRN37L2ze
 T5vYalBBu0lP95WY88eddIH+C5c7jxtuhlYb16+xZv7sFFL4i0GVlCO9KfI9PvbAfeGF
 Hxr2nowIabAOCQn0tIOE7cvUZjYaLCw9D3fBsCcjnkZnumCg9zXD9n5m8K97IdOu4xcB
 Nr09Yv5UwjnoPnyn952XiA46M4rZle8y39QjLEQHuMScYUhRo6uj/oGoOgrMA9Mk4d9M MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0ynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxv036125;
        Sun, 17 Jul 2022 02:47:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmebROrGCZmOFoi9x3iRehXNb2POSnmjB0gOKIBolfWGx3buslbZ+lIFkyyTJfoZ8mJ46rhWIrHYJwCj6tlvu+Q9aS9JZ7VlMAmb9N5qjpdXJX7HE0kVASKAbD1YR0f6Bu0V6cNfirxGQAbzoiP/woHNZcTT2XlwwlVPhPtbHPm9CUtIDAmsMiBzN6zajPRmO7MwjXS8cTuOzAGolZWIymQk9hXsBIM49iv5msm5MUvu775KqikUfnN8fPCVFUA3n0Jqiy6pOEZ22ZmKsUnmlVfQ4gR/KssUlDIEz6I2oqRed5qdeJn/GV1aAhZoYQfSJ7aIal5hk04YkW6Qr5gdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke9TTATY7XtifzWpb2zMyH17PxfZMLlm/K54eKH1rHU=;
 b=P7zFNYbayaq51pBK4zS6wqs1hRrcryxGwxsrfndV7vTotAuIxe0dKziNrJARW+UudemQyxlK+rc/Mk4VcA/k3LfRC5/EHTzLMunFf4k22zrtbpXwrsdEPuxcX9AlHKMwngApwfr2pMJYoE7r6TEyiehO6OQ+qTa84TSaOPKptqsuEeKI8jEw8lyyNprFANowNgNNt8/8AqU8qGffHmQbKsj/51WEFhS7AMijEgTk5znSeqA570wCjfz4NbaVFKy+qmmkN1HSGpgcZOP7YNjWGTLMbx8jgG/hw2N3YGtCGOAnbqI6cpcNb+Y0uUo1EVNO4j/vgVyjbKrwPL7vYrRn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke9TTATY7XtifzWpb2zMyH17PxfZMLlm/K54eKH1rHU=;
 b=rPz0VLIZJhsVGTilCS7JCjexZSqUcuRn2STvcbfj1JmtoY4ZmMzBkyJJaLXBBAobKUsceVGMGGo33Eoo3rGVH6CE8qDhdN9QCqAr1c+b+sSNxshHmQepcSO8Pc9oJBcPA29AZ3LjnlaNSByYXyLWGaBXJz0C5eibyC+pqFE6QEk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v11 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYmYd5uFkX07/5REWUo75f88QNaw==
Date:   Sun, 17 Jul 2022 02:46:55 +0000
Message-ID: <20220717024615.2106835-56-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a11f4c23-ba11-4d86-730e-08da679eb272
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fb0KwgKYvCum0V1bW1+R87qLCSNH2zG7y0SKPlr97368bL1NCkaluYyqmXITu2GegCuJnmBMZXe4pNd4YGhZGqEMroByqV8bRMj136Rh23dStn39DRlJKMPYQH71wCAZ+oivgs9joWx8ef51fGoz+UuiXy0zYelmPhwinq/uxZ7RTCTxZMJwMN8HVioLwoxAKRxATsZ0G3sECC6Ywsj360bjd1ctEbGkKiVZwageeTDshLDJDZaxNhDHktGEvtJw73TDhLSzmsJRVJs29QLpQMNf/Z7FWWbS0cNOnxfnRuYtyIl/C2or+ba4b+luvEogCgEGO9A222YIvdza8GmYvNKp9QFW2HOFHIsOsKVTt6xFXxB3BaRUFUQGYNGezWvjPycAC6KtsSa38IRXo66iueQlEO8JTqBpaGuk6GVvgZKhFKZjCEoNph4kdYfDPd/QojgymVbaJUcRfqopdi/E4sljtVNlNCjIfv3qX4UqJRy1Lkeufik4eCsjDQ2B9mF/rkUzRVPNkpm6iEaVn+qaVQrfeVkH8JjaFVbVuDzZ1szAFJH5v80Txe5oJTfGIHKoHZ2WRcY/bEbnpyUKjIpPZpvKOw1WP+JYB3mBqP+ZCJY9cgAprghgu89cOL5Sd13s+fqR1s5T97JmhaIP13e1+cs9kyVkq453+lmu5o08o+sD/J7yt3yW4HzlHO/ELcW21yyRrKJpjf4fZd+Ac97Jor2b2rTxXe4k0Xcyy7G70fAkbw99+WE1mRcwzcjQalAPO7K0mQh1+9ic6Jzj3967VbsKihPO7MEaIihfSHn0MTMTr/3pGKCpLslWE+xYoF3GfisWIXfutIQRPGkIVCg9iTWrgtGaiJinBSgwmFge3bKoTkc4p5r4FZRmYzDuhic5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qNDfKwqx615uOEFxWATasaQt9ZqLDAG5GReSM6qLQvR2cXgtuxNYKjGcf3?=
 =?iso-8859-1?Q?0r+WZp/A2eBQlMJco2MXzybK0+nscZkwH71zcdZMveWCJOUIfw2aw9nmO/?=
 =?iso-8859-1?Q?9NEO84BWqfaAQG+0EtnaErvzvu1a97Q/hOofE60o1pKZrmj9DFsMKKsBL6?=
 =?iso-8859-1?Q?9eYlmvyI2dFVxGCjNmZNEI8F0QuGXUXn4m0lCXC/zOmZF8KFoy9Msln6z3?=
 =?iso-8859-1?Q?FVa72MuhUrUStfx7lRT+ZPRCEEql6ANbTM5md5qUyahKpkri2Iie+1gQvx?=
 =?iso-8859-1?Q?JOjM5XRK4bHdFOvk6gvBKp00Q6QkD1gTL9ig3gGFnalG+2WLTBoNWTvtJz?=
 =?iso-8859-1?Q?hSQgtIAyMhtSzVp6lvkfJ5767xvucyMiYteElgdabQX+t80YDPpNXYFleS?=
 =?iso-8859-1?Q?gZ2kY+tkGogIt1qsu37efpAvxgBKxsJwwX50u5ogYsQebBitSy6NnEizd5?=
 =?iso-8859-1?Q?8HHUjPkmweL5c8YauaOIj9sMw6xWoeucHeJ/7jYYcX7co44DTWxhKQyeqQ?=
 =?iso-8859-1?Q?JdSg91PuO+UPIbLqEPTzFsC43Mr78w0swz8sUFG7/kUsi/SzcA7dT+5mw+?=
 =?iso-8859-1?Q?tFe763FzlBSuTcc3IJ1Kmj/AWnwV4aL9+PKtidbKyFZSDK/O5sX7qhB1jE?=
 =?iso-8859-1?Q?Kx6kGEbP85HTTrjzUwvoOImqmOZQPh1vH1TgJPBhDd/eUWGXRvkM36a04Z?=
 =?iso-8859-1?Q?H+AYrL3rs+Esynn6Ub6ghA6bYJmLwqGs682J7awdd54/etKwLVZcw4EPMh?=
 =?iso-8859-1?Q?UtQ+H6O5ieVIZfzuzHFhMAfybix7eXxjrY14wOgsKY939VJhCoJLfJea9z?=
 =?iso-8859-1?Q?SoVV5pd0QZQvHisPRH5Cc/GoQpJoGrwp6oorWbvUp8Aqq0bE/uC96rbTat?=
 =?iso-8859-1?Q?uHaQn86JPy6sMbPzNpq7KvvwpYlBr+VpIxjc2G/lxkDbEHNU3B3d6rVy0k?=
 =?iso-8859-1?Q?xzQfkkx7+I9HyAtKHHpekfczMeThtz04MI8wXHlceLeQVPg69q2ECwWQwJ?=
 =?iso-8859-1?Q?AIO1FPLbTsUnkpJdLJjrVh7vgnFifCwozXfZPNhfBv7WcHt3iRgP8NBvzF?=
 =?iso-8859-1?Q?KtHbDTHnMajfJR0ewM2QLljySjNBVj6ZLMHYKsSZM4iB3iDW9K/zqa1wQV?=
 =?iso-8859-1?Q?06Uug6S9aqnH8xmeqaFfLYxb9fOxCTQTVyBP7BSIY1cun6qP2k3MOR5oRv?=
 =?iso-8859-1?Q?PD+iCYK817N+wWBM1Lty+tUcDTmBIqyOaq/5AIhCawY0cEJHa4m3hOa26p?=
 =?iso-8859-1?Q?cYjnhiZ0ayXOU8+SQyjs6pJ58NiPpyXmz2srkjlVLrKBmnr7F1beS4Apgx?=
 =?iso-8859-1?Q?8ObWuIpauMfq0zNaLdtbC8qK9y99vXZk/L0DywV0EKGPWcEZie1R/yse7e?=
 =?iso-8859-1?Q?+aVS4DEmID2tIx62QHOFoglG09r6dVMyxgw7vlSfr8RJ1pfilBnMpqO373?=
 =?iso-8859-1?Q?Ab6blj1rMiH2sAUI6xkbI+BAAkEahWSdEerKAi4BgKYboQWCl3k3k9cG8S?=
 =?iso-8859-1?Q?/VA6RG9M+VTCHv7MPQFIMvqVxNk4TRaYfaqbP4Y+b6JHClso/wGP5iqe+C?=
 =?iso-8859-1?Q?BgNJaC48fmOuI9WW8ZI0ouYUrVwkzt7/KknHgAvwS2rJCxpyFUdmJ4cwUi?=
 =?iso-8859-1?Q?Z7Q081/De2URyMc+QSEfWsa/5lyXf/2wHtp+Ld9gkgUzHvHUv4J5r1xQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f4c23-ba11-4d86-730e-08da679eb272
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:55.1772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsPdHSKdN/O6XDeJhhEy+0AaE4Qf09zRpK4jwq/6/TXQR2m2teCI+3gSoZmOb1DpzHiUAEAVtnLnKJpQjPuByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=939
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: JbTJZ2NxT9kmlTueL9O8xYQnpKxgQ-r9
X-Proofpoint-ORIG-GUID: JbTJZ2NxT9kmlTueL9O8xYQnpKxgQ-r9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass through ULONG_MAX instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-40-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-56-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 655c09393ad5..d8e1b9ff72e6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5833,7 +5833,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6131,9 +6131,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.35.1
