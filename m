Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045E557ADDA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbiGTCX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbiGTCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7386EEA4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1VWux002405;
        Wed, 20 Jul 2022 02:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ke9TTATY7XtifzWpb2zMyH17PxfZMLlm/K54eKH1rHU=;
 b=h1j4gv07XcZF/wLH8yPi1ziZkaboCUK8YKJwaZVANqvWCWkGa/TWHosO/wRo3u8H9wAP
 CUdzjaU5Y2FP7TVbuh3+Y8nZbJMUfNCWZyf5uqi1wRyq4zEQpeSFourrGdKVYHW0pZmY
 krnS9ItpnFA5T3yLHuhbqIw1Ka0xY4flKnRZAg2EJ7vXS9hqRvU4Rtimo+bthutb7AtY
 kuxy/BCR75jZKo7PBIeM2un2cYVOPndiBxzuVr9m/aed5lWzxFO/nZYB/RCAyhc2KIy2
 dI+4xQJSic3QAA5jl2cY1NGfqFv0DtoiDF6KsTtmfn8fYsT8rvpCjHxeRBbTU06oOCaA vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2AVgJ009816;
        Wed, 20 Jul 2022 02:18:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ww-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj+SfkvrGbEOYwNbd8VkQwAWxMamRcJyQ9BWN6x3+HwpxHceRYyPs8cRzYWzoNF4qzAZA+Oac85Gnt+MF1xp7SnrJvrvIxOBwbIvELh0werfp18QTyLR3NLpqyhQna2+XBXelgPLZUwVM0fZIfZKneX3LIiUfYri8OUMATzMwawdJQuTNQwrDIvCfxatrZhkW1lfZcSVEShrUdDerGJ3NQaLjK+uArUm6W0vDmYR4C1tfkoryfBcxaJtFBUr3aWC4sFEbhGBMt0xswAxeOBJdku7qMY29e4Ex+EaWvRm1KpRkaYttMhGhlQ3isFe6Iuub/pfEOpig5Cr7AJjqWEtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke9TTATY7XtifzWpb2zMyH17PxfZMLlm/K54eKH1rHU=;
 b=MrUfC75J6dOhwg3MzSH6FiIOMYU6CVaJfH8ykpgmsTPRanxBBlSrVCYmNYar55buhlKJuRQnzEYv4WJxTYKzSTsrU7HxUN3i9vf/2qM/M97CVy+Xnq9KSUq4ntg/XXQWZfxORvMHHXc+7c85eAQNW59tC4q+ioWgYRHvOqn/IRPOGvwT4NyC6yjSrUO1SDTWCC8f7L+NPUQ3F1YDUEnFJVndzZ/8ejMVZW5A9c0a4QFdUzjxxg5PR6dZZiDRLw1U1UeiwTRN94TRjxNvnwYRKqBrChMxm9/jfWCekaIqufTKV6eCUbccWItk26n6dSdpvEcACBQD6DooxQdW+pKF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke9TTATY7XtifzWpb2zMyH17PxfZMLlm/K54eKH1rHU=;
 b=JgHzDuZvc46rABKm7Z4r5CGyeNwou1vAWRQGKJAn3qRNzqXkH5CBW4aQtOGPF4i9RmERbPxDw4SPIaZPB2d1EfiEIVd2FArmLeeMzFPv6q8D0SpWfsYzYsX/tRgrkQ9ssZK45I2MBy+6B8pTpnTcOXMUqkP8OULtEcyBuxL3BZc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v12 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYm97vp2j2Ir+QpkaV9jY1lHYIPg==
Date:   Wed, 20 Jul 2022 02:18:01 +0000
Message-ID: <20220720021727.17018-56-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37b4d7d8-bc8f-46c0-1f11-08da69f62a82
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78gwpTo9yfGlC+p8ZXSJaNXjs2n3vA54ebvHUcDpVvnfQMQ4VU+qXeY/C1HbQbedcQkHt0Ubc6Jnvn9t9IPD++DNVqfPXURGqkMoZG+qIpQzgQeRuyTQj+TaOAnI7amxAWis2Y+Qm3tI8avKKgmKufmsSR0BLVAxQ+mEKuS5prLx9CFaNdt2UPPhWN9+TSsZTKRQ73+fN7O4pKTZrVhOohwSz3J2PE6SmbRv132iU2WyevEcKB9WXebKIwShz1sUCef5pSeWJ1PYy8kGOSI1aSC9UwzX9HCdLocK6paRqONeP3yC9Ee6cooxWziwrgZO5N6w337yn0H82+zU7Y3VsNcaXHjf+kvba1AgkKLEjWLUVphwB7YMH/+dD7HLhEd52buzJUyWlfsmBftz2xMsmnI0AkYFHPN31ztoDKqtDWhSZi6N5rkz752Hjy6m+XZFhEB1Y54eeLXWFoZU4xlFLU4xI28siGEcyODKsToxcObKisMMvc3PyXae+fHlD50ZJEdMNcP+1JqWwAQePlJxL3kOECF9uiUJEKiONRRgVt+Q7k3vUKBmfhe5ogqS9RfqC4tw2Fa0wtl+vy/b1mf2MHD1QiSK+P2+uX5+cYSzjlLwpiDX5Ok9AUY0O2CBTaGeIgOaZLrKvLAGTr48FWgpvyBpwkE9hKsScm3yS2ShduEuA2zc2eeGQ6U23FwTut+YqpVycwaa0xshLIqnQcsY2ZgFww7oudUXlyIuoMnsXv8O8Q3SjXoc7MtgXlrB9wIGuOOiOMvbk+Q+/9qWC/7HHIszuBsDPl8MQwd66imN1Zwo6uugZLpuMBHxcw5PpJjYx2QXvzxWyD5UyV5+cYmKXdhGJny6PYXJ7z9//k4YYOhIfMG83dx5OoGUJTrpPpl3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cbD+0Qn6robedWOCCw9FYrJ1lVN6LsbK09aiKifR+PuEsjFTfd7w7TjisX?=
 =?iso-8859-1?Q?c+G8TsEl05HUYlNwsx0pGg1/5oeejzp209jNlpK22/QWLzBvpX1SMoklGV?=
 =?iso-8859-1?Q?/sbXBc3l+mB1CvWXEn43tmY764UKhsikFO3BZKrD1tSF9NJJIiDF96dwku?=
 =?iso-8859-1?Q?jjtB1AwYTP3igF+WSjZK/2rpru/ObjLRAKes/YAzeSm2EghiRwEZZX2pga?=
 =?iso-8859-1?Q?GkTgkWYvyHzjWOLDvgvgyAqOiM9g/LKLEtJOpXvLXMHBf7s9QFrnZLdvqy?=
 =?iso-8859-1?Q?UI5zE+Po9IZtVLwI5A/RaomTQKKrTzH1M/KMiD2acsz0CSyxBqYQvKmYpj?=
 =?iso-8859-1?Q?hwVbCuD3jRQYwzpb4BVNTDu1Z8v9JIghhxGYKjNW+yz6XaUQH7tCRA4W4q?=
 =?iso-8859-1?Q?xfRldR1oEmZq3YX7UlCBlsqvahgmEtnCw1j2UdCEW2Nwg4ZufWpAvH3dFk?=
 =?iso-8859-1?Q?Dk3VRG0cntIfioQq16+V5uDHGwm4iN7eIUZVfnAqg76V3BIxBwPsXfk5SX?=
 =?iso-8859-1?Q?qrlJ5LeFiqiIecWaUx9v40RjdIfyRc6pTe+tByPdEGZgkqR7rA3dCFcds4?=
 =?iso-8859-1?Q?WhgvMXpq+OHrm2sycEdjoMqYba+rAWIEyXKBI7R4CIoY16l6V4rAQJQjSA?=
 =?iso-8859-1?Q?MUJJjKTiz/u1RM/2K9ePEVm6E4WzwfG/iD2Xu6vKlYj3nuMw6oPkQ6sslj?=
 =?iso-8859-1?Q?ezv5fzPbtKlvFviW2O/898uuITG+sHDCgg+pW1mhS64NG3Erc7Cb7NOx4P?=
 =?iso-8859-1?Q?sQ3IP1zXtuenNoEe/Kk+dvuzIuaBoaBEBQ/MVnCx5S1OefEKPj0JT7fOjX?=
 =?iso-8859-1?Q?a06JUToCoQFLTu0X1dZI6ePvNBuy9yiYwDbUFN33P42FOYRNtP29LMK9m2?=
 =?iso-8859-1?Q?QEW5HdeIXbaaNn0a3KjGScnKKJovECclz9iqNfsMjbKGeQlpUKXPKZwiG0?=
 =?iso-8859-1?Q?oa2BAE67NqIQvEKdf89AeQq6oYdPIK7W7WKsYLZo8PWtxgFwWhU1FoGfoO?=
 =?iso-8859-1?Q?HIf8bV3yuOLx0M+QfPg45qOHFCt3JyyVbQozpqW777mG/l11BMRtNj63b8?=
 =?iso-8859-1?Q?dD8ZdRCjDJkTo4zF0plHlINVuydSZqZOujnykYvs4l4bIl46K8D2patJuw?=
 =?iso-8859-1?Q?c4RddwjfSgWvKXS07yDN9U8MNKpj3UsIU+18Vst/yYdoy3ysZqwCpmkpTg?=
 =?iso-8859-1?Q?zrQZgvyfNaZAeKQH/QluaVEJeBNrqkLYhDMi1/39zsaU5zO0qqAr+r9OVh?=
 =?iso-8859-1?Q?0ytZX2R9zUR2DXJrTYOaMJf6k5KXXVAZGdY+hlBG1z1fdKqE3alaND3/bt?=
 =?iso-8859-1?Q?nR6XQ7R7S2muL1ytp+oj5jQ4rXZXhnjhipx2T8Lzw/32n04axF/w+tiL1W?=
 =?iso-8859-1?Q?J9/6QLsTf+0d/uEnpdbf5DH6T9cyUjvxpxBIkE79OPSrtLs8GWaoq6Z1Wt?=
 =?iso-8859-1?Q?kBMboAkdJ03/2AzeMFPEEoXWA9EoDs1+UtbpZwAtRpS3pvMCX+eq3AwMeu?=
 =?iso-8859-1?Q?cplNtYP568LPi44Vi5Z5LLYQSvjTFBmf8k8RD9tKgRoVAKkUYmjXqReM1X?=
 =?iso-8859-1?Q?0OAtlP1IZUB/9vyOi8Jl9wJXX2/RuDozjjTJ01Kal/AdqpZ0U4BROMIfae?=
 =?iso-8859-1?Q?gVwQp3nbBbdJo72x6dcRHJSYY/OuByfQY8oX2YDgWeIHcBBfYGI5saaQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b4d7d8-bc8f-46c0-1f11-08da69f62a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:01.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcyGsyQpx7xxadRvw+oSzq54bArtlhXq50MUsvR7EHAs766NDU3rxDTiXk9Du98ORnytYtJeQvL4gSt3NXyc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=937 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: nCGaf4b9KrOmaZmo8uM1kdx42jQDz_6P
X-Proofpoint-GUID: nCGaf4b9KrOmaZmo8uM1kdx42jQDz_6P
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
