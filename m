Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93B57ADE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiGTCW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiGTCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BA6EE8E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2FSTE030727;
        Wed, 20 Jul 2022 02:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1nsetbPUG+Xwkl6MoCoLG2SLaaPoxrF1tK2CDVotcOQ=;
 b=0paANc66sDirP6DBhjg0uF8mNBwF11dj2YI0Ikcz+YyzbX7vFmiJXNIM3FNwqBAa+7Ci
 b7QaU1eq2G/JGqmseDI8PG1kVT1snShNEzxoNHekbIhaemKAB/P7DJvdj0eUbZnXmFgp
 o4wXRK5Rxbagnl85jSCiihm6/6Ht0pcuGlVpRd8hlLvtl3xJjP6Iec/u8ViJDwc2lAYp
 C51alduGQ9XsoiExiBf9iD8Xl09l04sPCh0pYFcDztn9FaAJox7DAnYPxx77WCRHkRSm
 x/exgEbeytArzzrZDl+moOm/pb+tVXMQneUj3iUQKm0WxNvFUQDoSH9H7RkOn0y1mhyr 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7ywd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHEnc007944;
        Wed, 20 Jul 2022 02:18:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3kw-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2njZAO9qUfIe+X9MJignsj0RZVnBGkCj4DvhJIE/PnDqaEA5fvt4mzhmVg98n5Bhq27XWPA1Dgl4+K22lgLeSmAIeGRArfqsbpCXOwHJOf0zIAh1QiBmwvyscyfXfwFRfLGnvxJO9Xt/ulngcpC7s2mjmsHg7DQ1HFloYO5DIZFb5beIvgyZPHnsTO+MnuQgsyMyisiBAFLRg9lzoGrRI8Dk5IsBLFcFRlsjoxkJDctjRNycgOEuOcIWaGxpo/oa0a4zKZSNJBfuJkRyz+U9pIVqrllk1/nSwVhf7czM9JVIx24MWtkj9KXLM3LOfv8pF5CqS2xDU+2UOX6HhiqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nsetbPUG+Xwkl6MoCoLG2SLaaPoxrF1tK2CDVotcOQ=;
 b=Up7SB21uyGnynXeUDDoipZs514L3Dqxqu6t5jRNTYf+Vl1la5eujhlrfajCQENWvjsuhwr2VWiXDtJq/8txwtVAud0qAannexExuxCqSmtNVyVoFBhdzOOdWEQQMOC52gq6rpKhlz9EtjiJkMVKkgAWnyZlvXS1GvVGPpRvKsfE9EoHvbfWa0X9DIogqSq7Vvu5F7qb2A+Ygjew0MK9/tEu7+lFMpnHAwPylZnwpqLRjt3MGTrOCtmu/hU0qlH6B4Qr6TBuP3KiPmU4OsxLYTmRNLLtzmQiZU/gfWycNUZDpSgHy5krpTnvs4+pdgeH1aSK6rtyv601IhxrpsUoSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nsetbPUG+Xwkl6MoCoLG2SLaaPoxrF1tK2CDVotcOQ=;
 b=hnBoCdLDSNfCNjy6VRODtSSF17Kx6hFGLekM5mZhwvD2ksvcxf+RuRYDwWYsak8PQx11Ao//6pPZhH+9QyJAdfBG9SERdwdn0DyxDXA8wCkvgwLCVEIDnaCFP9UtNlXmRPp9QsE3NaxU88xuuKWRaq87hNyGL5ewE9Pu7d0DWu4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:18:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 59/69] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v12 59/69] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYm97wAgt3MfHFtUeLCDGDfqMpTw==
Date:   Wed, 20 Jul 2022 02:18:02 +0000
Message-ID: <20220720021727.17018-60-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae98776b-8d20-4a1c-ce59-08da69f62bbc
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKLCSaDngQL4RKt+g4mnVMXetMmBLZclsxOqBVSlqnPYjxek02aKY/Q/LAGnvn0uk50RgqlSRIRwKTrqj+PlY4+GlH6GGxKXifkyxTcs+hOfYxKupDuAJTLkywTCCcOOck+fsg0SRRBBhKOysWMUZWJPsE1BgvbQObFIAwebfnvhf1eM7oPvWokqDBmBcUCJa2xEJEJlKUMi/MQSyUA19SAZJI5VOqRUh0KyAqUCO8a10Rj6twtaH8tibUK0wPnDcPhyCuIY5yVXhc9pzr2FQAmmHOwOeMON6HwZy8tcDMR0tSamajbAbqbofQL2djwlZEwepIrP6ZKGYapMY0msHh2F5qPFJgS45EP+ZGDmbfq77CKsvzOQJ9vo3AIG36bRJ+5ZyyFcJK8vAsTalUusvirrQCxw8qUNARtZdP8SAx2GD00F59D3dwRlIwazAJRzlhzM/9R2FLJpS4QlvQdaXxDUAaZJfNlPFJSGfDxRK7bjJNDgNqZZIuvlR+JM7QvZHi+OwF5YQsiVuTAm8ZPjR3VI6KIlaZ1vghIxAplERhvVPWUM38t+yLTZFTbd5pgCuX53PtQGeTGH0eD24T9mU3M/aQ7chjYqxRuMnl26cXJHAy2k2bv2S/cB9aNGpgxLzarC5Udw9d8K8VxFKEfbGs7poYNmXKlNfVxXgfnEZ8w7cU4Kzjn5KFput0URwuu1kypr2rtZ0bubi53WwBNhw11qZgZqfoqNG17ovRU8P/yLWU2M5/hiR+CU8JFAd0s/XrY5dom+x0xZEJz8c4BKXiwadhwUGNfPvpvlPUstlV/YJ/OXjKlElzoqpZDkdhEbQB0fnZCkhX3gzOHy8jma3WQFL7D/AD+GJTto3iKiTmT6OABuxE6ZIGnSfglPptiu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UJP2ahOi+9ves3/BfZche7MfXPxNumVxZKnASkSwuYectytKn3Ua0f9x0U?=
 =?iso-8859-1?Q?a7BhGaSXZrczonkX7KEpIyVx5Tv6R8SLqLH9Dbxd5R+6njszf0cPoFVCsX?=
 =?iso-8859-1?Q?YiQ0uiJfa4fJ+QweoHip+pNQ6/T/uBCEKzgXRFJLD7JxOWK37iJqXF27Kt?=
 =?iso-8859-1?Q?VVjJ/Pa+RnikIuMn46OrwkyWKNvHaFgZx2llU62kM3nTVdvGd2qsRdeCrh?=
 =?iso-8859-1?Q?tfiLwkI8EUPWz1meXLpTCPtjR7fJ3AY9TRkd+OHSo1jf0qmMsjzsQ5xQBe?=
 =?iso-8859-1?Q?2X/Y6hcHcVstTsxMj0tpdMhPYHhjG9bX26wY8KH0z+T5DSdrJNeCCpCzQp?=
 =?iso-8859-1?Q?xvomVmhJIHSgQT+raHPTZGta6222JG4HkEcdcxddb39palMjUd7NTJgT2z?=
 =?iso-8859-1?Q?xt64BM2HHb0pBrn9/lBIOi9OX+gbx/tKWVwysWTjTgWZ2KOElZcUVOQS65?=
 =?iso-8859-1?Q?6NzyrjEsvzCkyHdEh2B7wIJixVfZt/gMvdBJ9qRKipGLYJZzNanWa731tU?=
 =?iso-8859-1?Q?nZIiOAS45yWcxcvXHvTbFoo7MM1gX1goIe80U2T7H1apGI4GBtNY663IPX?=
 =?iso-8859-1?Q?+4dB1KMPtFalBA1gb9rU61PoKhyIaOD3jBQmc7/3UxlqGQOnqVYqgdhQLd?=
 =?iso-8859-1?Q?0fSwOlsQ2okfgTNBtZYovhhRb6cHcNHoqYWkCaz+V+/bH4qdbry37tcykl?=
 =?iso-8859-1?Q?PmU4D8aF0ahVpcpTj5BVO74mZgLQogpak6+dVryfN7+Uhbv9kYgoCsu/7p?=
 =?iso-8859-1?Q?Rzs/pmjindbU3pYp+CJN1sIqwIVRwT0Au1O6ap9hekYjsNiruHaxgxJ+Ou?=
 =?iso-8859-1?Q?2pvddiRo0WIjOIjiK2vY+1MTiHxUMZEseoj92SvPzhs+ETZukvVADuOYfq?=
 =?iso-8859-1?Q?FJmzMwU5sJiUA08manTF7EWBV5oDdgtUOo2DjRFQ/BiFWzY2erPJpKsXHh?=
 =?iso-8859-1?Q?iIoXolEuXQ58sns2CVuLXf7+n3XjU+8jgijrxP25Eu1y7zrJC99F7kUYeg?=
 =?iso-8859-1?Q?vgru9ql9ODLZjorb//MRMTC73A6Nv2zZZVhqDEWnOMUeiWUg9WuHPTtMQf?=
 =?iso-8859-1?Q?seY2VV0pNV3HFPaunT7UnhDkkaAp5xN7hfSiQhIxfidns/wUy2llDO7eNb?=
 =?iso-8859-1?Q?HMKuzjwAykVNobT7zg/iY0FkR0KkWpL10qBYSctp8bBxxISQDTo9oOl/Gr?=
 =?iso-8859-1?Q?RQXGlcAXNBFrMebKJ3Pxsa1yvLL8cfxiCU/dKgrLngLFEZmbiJ/AQfPuNb?=
 =?iso-8859-1?Q?9kdkzo4u+Z1+Kbel8UnGAf07X+jfGNSk4hrYUTaqiquBqc4r5+LLYgqc+l?=
 =?iso-8859-1?Q?YUCgq78HxjrQ5CncHb/AXIqLeARxYlxoMCfwO9oh8OAy8YcPNl6pmGh+jp?=
 =?iso-8859-1?Q?DUQyK2HBc1TZSQm15Cn/bcHKHIyMnVGyw8Ym9HQdfXKIcE8b/5Kgv3ADqk?=
 =?iso-8859-1?Q?1SpZRtTB72YiF9/plinjE/wemATl2vqrJaQ9wDF+YRYDRx9mTd7wFRQd5j?=
 =?iso-8859-1?Q?PBXMuCc+hKNq7koi9FOtOve/WMLToa8Wls5xFRscJxKVw4vakFy/QOxX81?=
 =?iso-8859-1?Q?cGJpkkQNo92Bd54aYCXl2Br0BtG2acSr9KZakFKnc7gr7sBi/s54N7vIRz?=
 =?iso-8859-1?Q?PY48kw90XdEnouOieU4wgKQ0cx28ReDII+O6556c2VuARQGfnlOJmqjQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae98776b-8d20-4a1c-ce59-08da69f62bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:02.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8u3uWx4jVOXfiuXevdkQ4FEZqhoPzeTBYvLncZsWyqBegh6OlUWdVGU+JVy97SP2Fexj6yiYu7HeopZU7ZxzNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: qDVWGwxzAX-7_bMTVJTXE98caE1c72V0
X-Proofpoint-ORIG-GUID: qDVWGwxzAX-7_bMTVJTXE98caE1c72V0
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

Link: https://lkml.kernel.org/r/20220504011345.662299-44-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-60-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e0fba9004246..8644ff278f02 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.35.1
