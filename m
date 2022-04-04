Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4374F176B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378111AbiDDOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378228AbiDDOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765333F890
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl3gf000849;
        Mon, 4 Apr 2022 14:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GL3y41eAJS4/UHy/KRE8lzo0fOUPEKqN1nE8X9jh7KQ=;
 b=cEG5WXwaTloh/tVlehD4HWN2jRqgtxT80I+JvFtfiZhLttXrZRRMklH9mBcruSPO1FUk
 7tdktV/XTrngEUTVZNMTyaafILxD6h6LU+AEo5S7+GCiyCFQhqetyH9J2dz2ENXQduZE
 kbyWgEtyB6xedXP3Db77DbVvQLSus3/gKbTC7G+urZONEnZ5S4xXHXYbuxS8Es2rvdhh
 aBSEIoMuB5I1cvsvz6+b5tvhOBlYs8kwih1e8QdOichAV51nF2bHiwqdyVM3+imt4s0+
 X9hJev3BpOR5QDbj8KH1apUnBNbOckLez0qtgNjHUoufhQ6OHH7ffh71XFS3s2sAL1e8 qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3skbpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EajoX011889;
        Mon, 4 Apr 2022 14:37:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLKaL6eaS1J0hR11+lX6GK3a7qim7ktY3w51/H+KoIQHNIEgsJsja1j5pD00RKiu6NORKKlsvMVJy0Hh+V/MleyiQc64dXx7oEY00mTwUe70uURVFAMv6+iTSJW9eVbQfpgHGYWA2WRmTbI5ENIuwLVfDDSn3CF8kpUzvMrXtrbxu+eyfZ37A8dRB2ZcqfhIyQt8nDuA+CnZjP/tQ8LcGj3+agsqqSA99BWOagFjzh+5cFBQMTmjWpBP87nRSe1LS47mgE9MCcVNaZ+Bh9eRduShs9AHyxFX2Mtu+TTRYrtKEp7UuyWOe2kmFdZaoDaY5FoRvp1XOcc7BmbCSdlQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL3y41eAJS4/UHy/KRE8lzo0fOUPEKqN1nE8X9jh7KQ=;
 b=cxgiD46UgjVoO00aODfG0aUogTZn2bSJauKmyGaibeu8jcd/Yw1u6z3E9UqtDoCsouJnuNaJMMqSz1GTUljpmxhJ52xBzroVTHIUMp5Pd0l3ct8SHCFx6YRBXAJIRZnHAMKU19OwyuWxZVhLP6oWtwzJRC0PGOXsJxITwOOd/gfotWkcqQ6dDxJiAiYP/qElylb3+b9Kwi4B6tQj41jaHP1HlMkgvIy1jLNBPG4tSidSTaftXmZsmGuU5p0NClw5tfsxF9WGcLL9hLQEjkEFyZooyv8ddyhowbnbHVvHo63Rj5Ocxbgu0piofiHU/DhcPK/IoC1TbaH9RIFD4H6ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL3y41eAJS4/UHy/KRE8lzo0fOUPEKqN1nE8X9jh7KQ=;
 b=kLi5LLa+69MPazXFwlJ9cC3+NMy3WPfj7dubeghO9GeZzkHv74I+oGLlsEvgVKrdVReRalPdYZd1KbSYgNK/5Mwz8LOYOs6FLcWpf2YtHv4hqfU1NixQE8TwA7hX0pQWdCJqjho3NCycQ6CeU1ph+YXSWp+TLEan13E4gY42iyY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 63/70] mm/pagewalk: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v7 63/70] mm/pagewalk: Use vma_find() instead of vma
 linked list
Thread-Index: AQHYSDFLEEB7WXXgNEW0FhkiCLRaUw==
Date:   Mon, 4 Apr 2022 14:35:57 +0000
Message-ID: <20220404143501.2016403-64-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87c763b8-3423-40ad-681c-08da1648973f
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB574284CFEB1FEF2E4F70F5D2FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvJh1rkyfwNvBE2xigp/lx7cmLRNa0sPRLEjHjL9mGIBFkjP+LaYgyBv/oXha5rjzT17yMAS2tTWO8vjb6Q5y50DmdDUsxOdG7Oruw4z4mu9G0NRPcmIrRv6fJjFtI+tZ89WRzgVtXFv1vmuqaCrQo96Q8yxH+UGpJg0tIra3Eq/Xf0fRdFZ/1HhHX783S0ua+20NHF6L+mtm7IVGoQnWsa9J9QBBUGGaOXXUZfNVCJXcv3QmXX76NljdKV2dKXPfk+h0AZcWkr6djwgaHvBD5mS//04V4lTJr+OX+gTBixHXe/QStr7Et0zSQRS+oLjOMDjUVnAL0lHBQr4OPLY7yH/1WAMDcDNEgNv/xvAjpmFNz/ci9NbUwRfCvN8Cyp4EBYgG9R/vqCTyk+7o0uMWNkjl34PSayMZk9h+sbNWHxsumzsgzHXBfGg93DYMXgm4+13Ld431B1GbfYrKwTESB709++R7KW4K0ZELdItakDrESLMdSc81F0wg0uTJp7HwTjy9D/LEhdsdM/L7IBs0jJfWv+9nJ6t7JM0bHmabai6C+ACtqxtXfthNvjNSxvqlNJLz8SH5+/35nBYJVV1QpoguUckHQFAqbryRhrHXEjDf2r/PaouQkkP9O2bLe3SUPpiq+Y+WNFNgMFTs082jk7oWSy+J8UbvRcpuHT6JlEkIQ9G5FjUmnv3GXzPvKvQHiKzv6A56hNClysdkL47dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(4744005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tMn9ywlJg2UZ+g40zjYKNGOjJz8KEELI2G/J6Ew22V+kxfUcAjhyGZum+M?=
 =?iso-8859-1?Q?ZaPuDEFzPb3DrFD0ihlOQNNkSSFvOXlVhFjJANgCerqp7W0JMircgrgs0V?=
 =?iso-8859-1?Q?AjYhYFc951SwcFhmUkHX+0f0p2Bhyr9IBWyenwE6abyL12kFqLShM+yGCY?=
 =?iso-8859-1?Q?gasv+V+TFvBdS7QFnbBoC2HZDr1+dNAyrM+Grb3k3CQ/5kNUi++kR9GGdO?=
 =?iso-8859-1?Q?PW/flfhgGG7rExY4t4M0tvys9OTEKXUO/VZHzXdj9texQFJC4V9BQPrIbk?=
 =?iso-8859-1?Q?VQOG0BMUIDJiKrKS9bSG0h0JajLVhFsj/ysMA3qTCCLcXm4dLxTY4sP7c3?=
 =?iso-8859-1?Q?Wv/j1ODagWYauQAXn1tpamUFbEltuHwYsS3+m9ZGWOYKo23iDJZKrs0Ajp?=
 =?iso-8859-1?Q?cfF2ZPBpWm+SAuO74DEm5MMJ6deOXeHQe4wcDtUU8+kA3OhmGzviXUdPOh?=
 =?iso-8859-1?Q?xsCFyKdCftvJy6jYYS+ry75wyaDTKSj4ARgt/IUMy2N+VaWXE8rjfyLslA?=
 =?iso-8859-1?Q?MRT+ty44Cq7UqWY78jMydbtygD+73nGjklEYr4A8DiZmtY+vKSZRhNClBV?=
 =?iso-8859-1?Q?WGvJ8H9s1NVFcwpyoTtqr/Ee9AJh45uQx41nG3IHAawfQbsS1holKD6TkZ?=
 =?iso-8859-1?Q?k66jHaBSXnKjjoH9iiCdtDyjKfOQGx8LnBfWMhuEDBqY5bE7YcqT6zEG9o?=
 =?iso-8859-1?Q?x+4inIjHAHZz42F3LiJ+Ozlg/wovH24ozcC6AC1Q5FWUjCtEFGUaVW4N8a?=
 =?iso-8859-1?Q?Ngdmx/JhMkThf4myW29Jr+f44nWE3AY99DLrfiCX2x6yWGP6d3XQtlLFAt?=
 =?iso-8859-1?Q?5kOfzUhmK9yFCCY/xej3NJz3o920IE90mZGgourAzEMjiXgGqqPtiTEDZQ?=
 =?iso-8859-1?Q?COtcRaK9wijBMayFGBpIbL/G4w9Gst5Zc8Lo3K1tgCh14a1YZiUkpxQMkN?=
 =?iso-8859-1?Q?HBqMeONscOoXNn6uonpqE5DfJcDA69HScFKy8C5jC5Bytfa8kt6jFWS5FN?=
 =?iso-8859-1?Q?v46nps+EzRlFY9JPyU2aQRj1HEe2MoLt9XIrIsJzQtEFS9FHyhV85wIXpb?=
 =?iso-8859-1?Q?mSD9XFnxf9N2grXEYEKjFU/ceFzDFz9lMeye/1y8b6mEAY3Br6vAzDcFPe?=
 =?iso-8859-1?Q?FDjakOe9JeZUW6SsvouMnxvDb9KeDIA8irEoxuXG/31uhSz9o9syzApjHk?=
 =?iso-8859-1?Q?HX0kaueZ8XkQX2EjSGpXXSuwo3+0tSUCyN49BzUUuGJ1CVvBIMxtdsr6/7?=
 =?iso-8859-1?Q?uGBQ4RcB06ecP9XOSfhXNto/zn2gRaoLv7ba7BF6qHknmoSH3dIWQa327f?=
 =?iso-8859-1?Q?8hjMUIWxVbMnasbzyAfs+6Lg35+lJyVQR35nUtuIfaDcbT6d86WhetHmnh?=
 =?iso-8859-1?Q?Dp4xA61XTa/r0Nr+Vts9ahWShGvhsUjyKV2H/ZP+A1EQqck4FwlAxcWbb3?=
 =?iso-8859-1?Q?f3CuHhStpSBgFOJechfH9Y/dVjfgoLMkF+g4ZjHxHd0fHf6IRCHLwDMFa9?=
 =?iso-8859-1?Q?Enqsq1YhzVKeDPq//hO5VqtxBId98/oMpvCH1EteJ7QyWnSQSf9+bAdPqm?=
 =?iso-8859-1?Q?4cKjwZFhS8LRkGFOFwtdeG0EcMJuvcrFuUOZN5rj+sj2N4DeucriDwtlqC?=
 =?iso-8859-1?Q?eqCng3F31UhNnqn+xV4aqwbvV5ITwx8wHPxWsv09oW5s8J5f8mtnFXTTdR?=
 =?iso-8859-1?Q?BVHV/nNnAWyna7oNoPA8sQpoHTBwa7U65oWUTMPi9HkHquwnWQoNfvL+wv?=
 =?iso-8859-1?Q?+2x3rtd36uMcWFOSgWakXwpbIPlrf7SlBHTmaAcjqxqQfrlqlFqL0i6Abv?=
 =?iso-8859-1?Q?hxIhwiT4DM0nsYGECMn57c5rXL+RlSI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c763b8-3423-40ad-681c-08da1648973f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:57.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uby4RddZq5dOhSRfCcBqG0UkDNp8l+BzsT7CVWesYc5rIlx6AwpfO9WExy4eXcuGoxTbsDZkBHzGgi6GMIneJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: fSxcYMpY95y9TyjLU_vNFj73VlLj1aSO
X-Proofpoint-GUID: fSxcYMpY95y9TyjLU_vNFj73VlLj1aSO
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

walk_page_range() no longer uses the one vma linked list reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.34.1
