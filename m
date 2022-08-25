Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D125A1A58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbiHYUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHYUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:30:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF28AA4D2;
        Thu, 25 Aug 2022 13:30:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PK4Eoc002384;
        Thu, 25 Aug 2022 20:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=uHpVZY9usK43rlJWKavSv6jGuZ4wub8YfgJLKF+trTI=;
 b=nh8BZ5eQ3qSaEV3iLW0r1sk0QtN9c6coXSeYYeL2a2Xxn1xDCy3EoYUl13e7sU0x0MWZ
 vSydxE3EsCSafWyCNka+HDsicBGP/My6fFECK1yuoi48W735VVYxiTqLefQ8a0Xa5z8F
 ZDbuYby+XlSMF5JJ+YpAYlANuftG7uPZIYTa+aAOqPuWEsTY2wbi8efU1f7HfBUy5SwP
 SDAMeFzkyzN5D2Qfiov96E9IoqoPcrgJ/YHiVzeTrRZlamVk0HjZqqAkIlPo72nhiMbX
 h46mK0AautByj0Bce+zDKqMZ35vYTXxxQNec3yBsFo9Hx7oHwZDe2p+fpIEiFMQNT80G 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25qn73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 20:30:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PJWFxT016709;
        Thu, 25 Aug 2022 20:30:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n585ct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 20:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfgGatQftqJhNhFvhKqwf9hAYGCKhgWh0peE+FAjIGmtdOZikjVLJw0TTXA7g6RaSpOU2OHX1QOhQbSTupbvWgMznWnslI85J6gr3pqc2Ad6+uR7RM/3Jm/fxDPXLE700H4+GAnHY+SmjhOb0g13ryaIDzg5+fDfA8XMhEZz6ITsJv8cmiH3imjYR1afSELkredZfOhyyTNY6em2f4aJ8TjDpC1V3yFYSBWlAI1qonhy2vPiRrJArEKOdW8EcVAYcRecr9XxBX5eKMS6XBEj/u6qdsUh1kMnQNiGMXEZllXzmibxHq7ncJMkgAjQcHId79f6mTJfOsfxr+d637Cf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHpVZY9usK43rlJWKavSv6jGuZ4wub8YfgJLKF+trTI=;
 b=MBSjf3/ygkJ1tSM1tL+EeQ0Hq/LvbnZ4a2Iy+r4ni7yfSi04v4d3j1jXDUdls6I9DJj0bC5G/KHPph1fGrGWBqQ7MRelGL3gLoGajEtkBuOG0bpECZo1wSmdF6VpLWyYvu97ODZYbxbEIyw9DT9HvmVe7IUPetwQxAFQ2Zrg9rEMh2SfxCpO83OgqniuchcTZzEEAsoDP+itR6IlFE7rK2aPNhTSbPwWyKR1WZO9dW0GMc9H4gIM/94M2ZJYsFli55Y5OkBDyY+OFlwg+SNb2RQzr93J5LBJt9GGQUlCgBzPqy8jkW/slCixi78N8WyWzxiDL7OnjfakNCSrWk18DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHpVZY9usK43rlJWKavSv6jGuZ4wub8YfgJLKF+trTI=;
 b=fG41kDk3pqpheozdNjvd6MijS9DYYBe759pqoOjES4MF18TOE96jSeFe3/QyOZCZcJEClZjIj+5BWkjXh4YUNAtHLoRfIZM5SaN3hiMV1OsqjmU2yTc6kKrtnKhZ7U3wyS7dKP8xEksfJFOOK5jnTApRF7uaYwwdzE8/gmfHVCA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5268.namprd10.prod.outlook.com (2603:10b6:208:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 20:30:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.025; Thu, 25 Aug 2022
 20:30:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] mm/mprotect: Fix maple tree start address in
 do_mprotect_pkey()
Thread-Topic: [PATCH] mm/mprotect: Fix maple tree start address in
 do_mprotect_pkey()
Thread-Index: AQHYuMGBdhRwsk8f20CcW8E/VYXZbg==
Date:   Thu, 25 Aug 2022 20:30:24 +0000
Message-ID: <20220825202939.3041660-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10e43276-06f4-4475-1e70-08da86d8a3eb
x-ms-traffictypediagnostic: BLAPR10MB5268:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DrR3bCRlrRs2RhxoIiqDB1dKiU3OQiT+2Gz6rqTVnRTiuvWCGfdcAm0xFV5K4rYZ2fqCQsQrnQ4rRTP4PfZXcevav+rGoVUPudZ42Z5He803eBgvptEhvAP9g+hsbZu4Y9+6itCM3Q9eOEyoNziwmhXePyl7o27UGZKVLt1SfTPVWaDYqd8vvD4uN3QII0FURArbSH4N2QgYSerXpDzgtH2ogML6MvFDsggNAcGweveV54fFf35rlghdyQdDLh+NQ4crOK/pu+QUU8CPeJWGfIPK4/kU4Pj8t7YzjnGGPhki4x+PG8gTfzQLlJrm9nxEiXeetUtvGIE1MIoUtaf4sPCx3IIDpB8o8kKzqq/g/Ufg8rePoWiXTsLclZkZ9dw8joX3ccT8+gwOeT2s49NYkwi4BoP+tbSO4rlObXj5JkybkVqBsBKHTg8camMs+WVeqEGURANw1Ih4bEmtXcG3TVZ3Rx3mQOsE69IAkF0D6v0WiF280acfGg4SQ6iH7owoVoAze/i/nyosRPywmXYpX0P3N8rESFDCrVroYIHs456utvH7OEdUVbUzVxKNRJFCvCzlLZrtXMh+DVVh5w48dz4htSzXr2aJ5O4faQp7TZd4M9ZNpbpZIM7eQPN8Q2SSXChukXrB+Mmg7KVgsqPSXVpaMmRahOJV7E0ad2ezMsLAlwX86AgnPBdn/avXslNPwWS5HKcJSIyCQ0Ij8iEWaVdAgFFbYlQw93TQxvwRYzrssyjvAMpnhs74UQr7cmWX5FdXYCIqZmR/mnThTY9nYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(346002)(376002)(136003)(66476007)(4326008)(44832011)(5660300002)(8936002)(4744005)(66556008)(66446008)(64756008)(91956017)(66946007)(41300700001)(36756003)(76116006)(478600001)(122000001)(38100700002)(71200400001)(316002)(107886003)(110136005)(8676002)(6512007)(2616005)(26005)(186003)(2906002)(6506007)(1076003)(6486002)(86362001)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WsqwLSYyub5VK54IWkuPsgCFLtsRGv8gHZZoZeoN0f2+8f2ANzfX4+hQzd?=
 =?iso-8859-1?Q?2d1CnkOI7NuLIT8wwHUlwVqcgHWAoySKocTJbYtPIQWhHILdijGH1G2JTK?=
 =?iso-8859-1?Q?6+ovd1M1jKwUu4IrTFqeJPQH+rNbPSjltoPjH/1E00DF8edDqgKUr6fG2V?=
 =?iso-8859-1?Q?bXZSRbGm6eoR426dIXNJqkDUhCJMWQtqGtJ8/ncWqpgen7vl3XF353xFV5?=
 =?iso-8859-1?Q?6dvDn7ivCjZuOp3qJnSX6gBBfzgiDemgMbNBWkKW8wuUzOG/AAjyY1ilt/?=
 =?iso-8859-1?Q?aWnYpZVW8TzGRtUKiL9AayzF1gdE8pcPRQGZ4QnvWZK4QmkXhGf7sTvuwv?=
 =?iso-8859-1?Q?mYlqmDI2P1UTqV5gjVmasO+3YRAE9t3JJ2zUIw3/V+HNVPh1IyzcZ5oAxr?=
 =?iso-8859-1?Q?uhheQnKgCqYB9cdgAKIlXRFgdV2yaULqsPMQ3+JoLk060C8lin7+RF/NAz?=
 =?iso-8859-1?Q?7YJxZE7ownZ+u61rs+8NFJU3JT4FSqD55ffctIAQKPFC5sjnHZG6na79qy?=
 =?iso-8859-1?Q?MWwPd2SQrxtNC5LT1aYbryOwSRZyeghXWlsIhJasDF/ZYC/8zlcqS+Jb8x?=
 =?iso-8859-1?Q?MdvX64lTjuC3YWBpGd8JFzDbhKMPOQbAUObDqXJMZ6eYoC39UYmjbNr32n?=
 =?iso-8859-1?Q?vZWbRR7UFRE48dEJTek2UWIeMzEgSRtDBD1IfY+lxRcuGSFdaKwbRVL3Gd?=
 =?iso-8859-1?Q?8olUVjxejC5wSk5oW8MkrVdsQHN6jU0UH5shubM+lNO60l+Im0bNGV7of8?=
 =?iso-8859-1?Q?GbKIlThQkM8u9wzHLwONLhKTz1dorLsR7XSZuDbQgqXKf1EE2P6AdZAWzY?=
 =?iso-8859-1?Q?nWHlwA/E9iCE/fAboc7ecUKguikD+bwZc/bhMY2LRlm0gyOT3vGTufu9yF?=
 =?iso-8859-1?Q?13Lel0KBb2rIHchRA6kulLi4EaRFtFQL6IL7puXi5VKwWBxGxYjR8uVLXu?=
 =?iso-8859-1?Q?BNL9gQOaawldxAFTfq7aN9vC3sFZpOHbRS8WnmIZN+MlymF+ujvJte9Okw?=
 =?iso-8859-1?Q?5R7vxntz9Fq8/2U/Sqgq4uYoqjzPgh2vRd0XfUGYrGcF59vTzzfbJAgvAj?=
 =?iso-8859-1?Q?IyX7lsYwCE/GW2JIvvIpfllVxPgLnsTG+5Cfp1xuh+Wf1uH4DLG8QWBbOd?=
 =?iso-8859-1?Q?fuhiMZIGvYPp7F+GeAhMKXLzPan8r/jJOjI/uAD2uj6TwbCP6PMwRZewl2?=
 =?iso-8859-1?Q?8Qna/TGAL72Cfghh0OryMrRADa0ZrfEBH5Ye/dinc/UfvQhQgbLpFI5prF?=
 =?iso-8859-1?Q?MSmsxMAqWCces7oPh+uSzZYyCcwM7lWpWRlku2wryoGPViSae8Tnbtq0Sc?=
 =?iso-8859-1?Q?3zabhkwFQcmzTSrHJBtryqDk7PJ9fwESX0njAkh1pgn3n2k6sfjHDNDIsM?=
 =?iso-8859-1?Q?ro8fT7yEjJNAfq80+pu9r1eVBgbU9iaka1HOlNVMhHuvfqD93SKGKQm200?=
 =?iso-8859-1?Q?9KWFwbDwtJ3RJJ25Ryx7qCDVuCgSWpBpWKH5Sxq+gc5l6wqEHSyj5DGxTf?=
 =?iso-8859-1?Q?+mX7Zh29mdituOFyHTzaSPd1JYK0zquyOujyx4NNqXAwzjxJm8ZqC5MXyC?=
 =?iso-8859-1?Q?CbZkaGF/E9IgXhek9TvUfmWiRG4YFZERwEEa5jYz5O7zIxju8w9aPCxCqP?=
 =?iso-8859-1?Q?efZuCduK0deFMpUs48zhRFQz9xToXgQJ1m/214eLfZDDBVuSua6G1mCg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e43276-06f4-4475-1e70-08da86d8a3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 20:30:24.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztEQrXsclgg9Z+Hrakg0DhKUVSDPaBUsib8Tp1YD5gxHYARmTwFah86ubwYOL2mB3VIKSRjnkyiWYcdAgKh+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250078
X-Proofpoint-ORIG-GUID: HTmVdK-dHl7tLAvvMmO-Phn19-3IlbBK
X-Proofpoint-GUID: HTmVdK-dHl7tLAvvMmO-Phn19-3IlbBK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the untagged_addr() instead of the address passed into the function.

Fixes: 3338b715d25d (mm/mprotect: use maple tree navigation instead of vma =
linked list)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mprotect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f2b9b1da9083..3c79796be65e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -675,7 +675,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
-	MA_STATE(mas, &current->mm->mm_mt, start, start);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	start =3D untagged_addr(start);
=20
@@ -707,6 +707,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
+	mas_set(&mas, start);
 	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
--=20
2.35.1
