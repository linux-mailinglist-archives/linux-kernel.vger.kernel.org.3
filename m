Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024DD4F1776
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiDDOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378239AbiDDOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7873F895
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DjG7f004892;
        Mon, 4 Apr 2022 14:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JjE9m/mHhWLaQOQyVoA7/5ih4Wfjt/KhV2nIRyGSdO0=;
 b=AeLtwhG0tyaULiSIdUFSDinmugudbyiJyGi2T0EGcIXFh76kxjzn1DdktNBrpzu9jclA
 bRrsyBo0eg39qYtcK9ZOVXsV4kmuw6C2ee5MitsWMKoO6gnxWfYuc98nFHh7dZNupF+C
 Q2Rv+FPYzj0af/yMi3SuWY1GrG2JH+JXVhU2yO9bAPwPAXXr8UJ4a+TM2abAKJxwAUS0
 4FU8p8XI3S3FK3Ipkb9fZeMtaJN2fvyR9HpYn4tANJ3Fzornvl4ONtzM+ELiwyTe46zQ
 OQqXcWPQ2tt+wa+pF1RB+1vQlcy3zt7Db8rCMrpyeK0q6loVTsDw5GFfxmBSeAvzmfm/ JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ud55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EajoY011889;
        Mon, 4 Apr 2022 14:37:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCpAAo7UnzjEMGzzexj1uwlEgnjBiy1m8FwbudzwVwU6kC7dPWiMrAAlxRn7m76IWHV1hB84lw3GN56T9JsUoC1dddJ2pzCQKO6JyHAXKnZrsb4ymV2YAFxgjtv9VY3X996r259P4+h8xwdQ1a0UsM+xm+lamK73ROLSNbrRoqM1UttNrUOZND1VSM19vjpbgS4HFSsmy2zehjaF6nxD4H37yk45Ur219u0ZJ9+QUz9+Sgmp1QZwbfna7i3O4WRv+NncnEOIhem/pr9ZFsPwXObaOOqKhkPV3vtNXZln+ASoCqNuuLm29MyWnuW9tOoW+NpQYrLY3Z3fLqwo/fpojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjE9m/mHhWLaQOQyVoA7/5ih4Wfjt/KhV2nIRyGSdO0=;
 b=CDiowe8FlD5bJ3O1zTk5DK2My2ht7ifojpbRDLGyMpKcj3bkLyuQlaf+r/o9orzePEDDXw/vbCLfrpmX49h6A/fchqv/SjD0hOVuwYSpCcrFHg8mASoHuZjbtRnu0AUmGmhcrn0WJAxwGp9eBO16dsiVWROmrj/lfWj0uYC5Mb7pRrqjnxIN23+sUEHBuK9VEFKdnxvNXfq290dGOScxOMPCTZMEDTOvm9kPsPUkgf/u9DlZ2EP1CQdH5C2Yxnfk/At1i29UOlFXFPKz0BtVr9SpCIxOFOW/vMI/nXin3vUfNHnAzKGQ37/Xr25T5A30idgKJ3tConPeiLCHZ3iFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjE9m/mHhWLaQOQyVoA7/5ih4Wfjt/KhV2nIRyGSdO0=;
 b=z5Lodi/CDfpd0VHMUK2IyOJM52gPfiOZtkt7ybgSEeb0tWi5yZ+CtPRu3NmFmsURDKvI2/iTq05oA5wNB2dnUgl8VQHccP7lwR3N+iC0r7Du+znOuFylAuZws8TY0Fg16Wwo0MRnLjlEWb9qXJB30DVwQWvrnYxE0GhXjx+y2kQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 64/70] mm/swapfile: Use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v7 64/70] mm/swapfile: Use vma iterator instead of vma
 linked list
Thread-Index: AQHYSDFME1qwl54xx0Woadbxqhq5uA==
Date:   Mon, 4 Apr 2022 14:35:57 +0000
Message-ID: <20220404143501.2016403-65-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b28593d-3050-4191-ed6c-08da16489786
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742EF9C5EFE9A56C1EF61ECFDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJi0yCnASRVgd8poyixJ3V66H43pCUWRTvuBZBX005JUMgeBHdijcUTGrpe9JGi5vhhYBjlT1Zls3bW9Q2zwfWLcFuYCSrfB5Rx6FO51onnf9z3U8IGRcJb60ECWRJk21TDF/+khn2hTRTsenfXtj61sRwBQy9yZ7IqKdxbjJx+nMkkgPlUKQGEwqJMs6xP9VtqJjyNBVL29W2238db6iYeAd/4cXinalZFnFAxcSP+OxDxyI7n9z7GKOhxg+1M0zlYApuAhIAHPDRPboRDSz+innPOsGvR3QqoCLFeNR5aiXAyLF/uQj3j0bJyxhU1kNX3u4YrAS8Qp8XR55m4D30B32aiNFwiihgpyEQqA6ddvcitpNtiGx2Q7yoZ4xoB9JzxHjWoH+24B3FUgLDX3Y1KTNS9ohC3Se0kkOc1QR72w8MlOfTNa16wRUN2YMazw1FOIfNS8ydOSIOwFHWvRVN5OtRzgnBzQdUeOUVRJtkVqLvuFL+BUA4/vsqkdoVENKemqB2XgKOZ5K1w+5sYUoGtbP+PaEUXZ1dA1cXQmHIGnH8DKAmA9jcx2wO3aNT8UBg4FT2Pjm2bGlq9OZiHsKaiQIM5NZDu/LUSo7MxDEmLRvUWAdoIXEfZoCC1ts3CxUdjG2a32iV6w2VM3cg/WHtxeMMFGMBmWuYwDo6DvZKY8knUeaOcHaM+JWiXUlV5iv0ZD4g4aS+SQvbMoLGSTJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(4744005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n3//uO4QkNFp/XMhmivjW/8YWEWLUqvDoO6Z7gvumr8ZfbuHn/gvVZ/YSA?=
 =?iso-8859-1?Q?ltFuIr3ZVAPWa476dMNxbnzHAh9DCmqINu+AZBo9uscHFaI6M6uFUVlZRn?=
 =?iso-8859-1?Q?SaNA6TViITaEe6n43feSUfSu6ECu/xzfO+WFpRrnDAl/lQTb1AXPAmk8rK?=
 =?iso-8859-1?Q?h4jcCJad/2H1nIsleVWbzCVZHc8RAqMz6RwkBRdFmSX+k/6INcVw4FjhYE?=
 =?iso-8859-1?Q?txEpt5zScanasSEgU64Y8jGz9zA/H67QLy1RKvjhzLGzEKJA20UlFyQJQb?=
 =?iso-8859-1?Q?2f+BKNE25vunAktIzua3VxE691eTt9ikBc82WB6V34gi5eDxOpWoaFrIN6?=
 =?iso-8859-1?Q?31loUae3AUsdG/m76WsZEf+hpjaJhXtTgNP9k3GEpmImvqj8nJcj1Dze9D?=
 =?iso-8859-1?Q?3EM1UmHwU55yvf54YaF3BXcziOJO/lUDGoFFa8UUt5Y3MZr5Vn9EBQuo3I?=
 =?iso-8859-1?Q?sS/sxdttoPFV20bDQzJWq7pT7BgM0mj2DLxVF4ql9/+R3kUP7E4MT2V+XX?=
 =?iso-8859-1?Q?lOycBiH4vVsmziFptNNwSyCZD8aMZb2Txt2G1CuI5F39mJDIfFx1BMx5+A?=
 =?iso-8859-1?Q?LDPCQhfZV07VCODM9CtU67/A17JjRFRkcBTJ6w3Z/+mEsTz09zXjLhvQzO?=
 =?iso-8859-1?Q?+TaSUdHxGwiKXHkCijVy0XLSIKuwI4CN8wXuS1eKw+3CG/wlS9SdSaqGld?=
 =?iso-8859-1?Q?05n1oOYREv9w/pHbHbCmISNDJxlj1mkBBlBlvw2zjQtPy4XqEGkXERv6Z5?=
 =?iso-8859-1?Q?3aObua43jHVivfj66LYfDT3lH7QxwSs8hHkFsfD87UKiuf1oLYj8Ua06tQ?=
 =?iso-8859-1?Q?yvlWPFOsxQIVqPLWxdIRifeU94J8+Qv4X36H5xFd6EI+xyJYik4O1Jv1oo?=
 =?iso-8859-1?Q?cXSw4YJW7FbtqfAfQIzf/4csgNu1IUokXCRys3/U2L3SbBOl21D+yNqWiQ?=
 =?iso-8859-1?Q?SoLZNh2acj4D6vwsdu99ouQSBNHaKsPJKEX8cyPGGH8QHd7hSDe7ePnI6Y?=
 =?iso-8859-1?Q?+aEePWjBd6impVqHUhDBTOyX5ZSeZrVYE4MiEqkP8lGEZiDRvTp02iEHYk?=
 =?iso-8859-1?Q?wsDkJr4uSftPjEUdYBdKo7Qwera08TxyQy2tRHZjcTJeC5KkxViwXL1kGb?=
 =?iso-8859-1?Q?G/WRGewIxyxhjWp62bE00v37GNZhKM/Zlj0lXWn5brp6s7v+VMmQRbpUQW?=
 =?iso-8859-1?Q?LvYvoTICZ2Ebsvn1xgcSBBydaqqrMCyOmWWD/cbBwrb/IAi/HhKOtFY6pw?=
 =?iso-8859-1?Q?yfml6ast/nRzWEGorbsJRJk6c4Hd7jlq71QSB05x/Cv2l8xQP9/dqOeWhY?=
 =?iso-8859-1?Q?15iHw2Y1/v3eohFc9QfzunY8MxJye2XDGaDHkFcv5b219mjRoxDISXytQl?=
 =?iso-8859-1?Q?z2LAwXmcMs5/d5tJZA8Tux9kx6xc2SUtYTUkPj7qJvrvs99vphuya0mX5D?=
 =?iso-8859-1?Q?EZY37GbdaZnLB2vHb2y5wx/sfG8vvwwqGHVgdntxfXdfqkdZD6Pw8OAp1q?=
 =?iso-8859-1?Q?XVmIMJD/2wkT/V8NDMXI6axzrAu/gwinPa1lfjfImjvA8u5xARPHebzd0G?=
 =?iso-8859-1?Q?8sedtJuBMksgQusQgmBvJKawSJgeHdyUB6xyYtTuZv0LbTB4Ev1r++P5pX?=
 =?iso-8859-1?Q?lyjEkfcJSZ+ilAqb/EzqIQ7bqDnnChgzQIj5tNKTA9cthabUJlML/ZzeYb?=
 =?iso-8859-1?Q?7FPpjgEVNcgJV+SwCUhoCFpNed41iWZpta+a9wNr6xh6yQ5oHb3FGLmCCt?=
 =?iso-8859-1?Q?GPXN4bhdFWh/Dhz+652UgiKsK+pxtjhHza4LhaTbrgZcTxCKYwxWvCAa1S?=
 =?iso-8859-1?Q?w/SyYHT/DK0l0g5bWjn8VovxA/86mZI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b28593d-3050-4191-ed6c-08da16489786
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:57.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7V3D8kyYBD0P2uQ8YXqeFqkm6o10m2UWwRwaugZY5jKJs26mJD6bWfnKVsQ7HffvuATpxQSmvAaedrJzNJfTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: BmjA11ImZEFQGRwGDoMfc6AWNbchBjRR
X-Proofpoint-GUID: BmjA11ImZEFQGRwGDoMfc6AWNbchBjRR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..392bfffc30c9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1968,14 +1968,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.34.1
