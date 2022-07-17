Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93FF57736D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiGQCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiGQCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD30222B1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8ght031747;
        Sun, 17 Jul 2022 02:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6iEUrGA7Q+pr5OPzK+e3mZOWwFcPcmnp3Vl0Vo6zTqA=;
 b=3PCQGgaYFnVDG7MaA8STrCHggrywm+DoIr/zx3IomF0LgObO0w3CM26+h8nM3sY6XaS7
 85VFwomJHEexDqzYdWTNUdCZCG9FeyAA4RaTqWMfWE16HirocdyJNYeZj9rWbdP2LITr
 C23pS4RIsNDqxL3wa8KoGXYb9ZnHjNRe6HyiP9D8Q7dLvWKKx3aOgtOTw61/2um4WGh1
 UGvr2tRZLDgortQCetJgDJP7/6BkHqBBvuO6neg2RpfrpzBhpL04XtmjGlp1kMDstcj/
 Ty9f4OLp3a2naWrTu2mZdYYQ8RL/KZlarcPp76z9MICmEOQIR8UzXE2eoAtd8NHahk6m fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxu036125;
        Sun, 17 Jul 2022 02:47:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+0Mrxw3pjpiR7zR4l7n9Tshqem3sggzQNJ2jhZ87lDG8dfUR62YxWsNwZJfSvGKsLgeq/ckKDoMPbq2oO/WKa0OPVhYWArXXOvWuSg7IBi4TH8LFTCydYi3QBNUkEqoEd8CGkokmP/EYK//ex9P4QHZsNl4ptpt4DcgnQjjEeeIBlbtDI2arE+jGFPQz5uYVSn61A8liHRWJsXNGgFzF0gbsniEVkDO+F7ycdMxj/8Ac0eczp6um38rTepGbQm2K/zgnd4raFleBPiDwA/iJLSqhkCeFMLSDE+yk0EJOVvjkzfqLPGPXcmcPRrDEETxetwpg/42KleMg++Hw/sCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iEUrGA7Q+pr5OPzK+e3mZOWwFcPcmnp3Vl0Vo6zTqA=;
 b=M8Rh1Q1EDtQ3uED4CxJX4GF0nQKNHLXjVqDzN/GxOSrTbN+hfNr2UOzenOZZGGcDhNPuOypdcY+7Xd8l/gxpTUY0wiqxCDsNKUXFywyn4FNfLA0TVjtXIcqN32uzOsIJhfGKlNWU5yxSjaVWrXxE+jf3RKTKatx4BMBYcZJuTr/VAN+XvE8cLZ3KGbQd4nSFhH5aFRZ2g9YFoqDEe/pOn8Cs+hB0mLcdPseI5OPXzabZtoBrJHV20jYQrghQLQcN3QhP46L9Qy+ehCvCWNwK83m+uuzTDYd9V9tLEFgq2QNAYvDuR1XCCg2pAcPp/J3lawZ896Gca0b/8NPiWeaKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iEUrGA7Q+pr5OPzK+e3mZOWwFcPcmnp3Vl0Vo6zTqA=;
 b=NCYXdsvNXuaOd9l4C3f4q7EctqB26ImxnxjnTKJ4LnL9luSazcYwh1usitNIdAlr3neZdQ7NPj2ise+gTo0Ic1RXhs1dT5yoTFoXT6AN5smhWe/3faWbNEAr0w21wBpkQ9IYlDveRNw5cPMAg+YSAZBIQ4Zj5oN1ZCNZkhgRSYA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 54/69] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v11 54/69] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYmYd5ocmNdLRE8EmCXvUApcSqSw==
Date:   Sun, 17 Jul 2022 02:46:54 +0000
Message-ID: <20220717024615.2106835-55-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3e416c3-1dcb-4b41-0047-08da679eb23e
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hpu+PXSmlsSGWAYYHn8pNeGkCFlRO+g/zMVBpOB1OiBdL6GtUNvK0ZWOfd0oOXaDrCeI1LV9rg0IJ8NaeYwMNVmkkZ9LiLG/qkmzgs2xzJQD6DxycG/gZopjVc8XMa9uKaGqGFpGElUhfj9/+al8zMS9Pi1fbelkWyIMmvqCPUExxWVf4UvM1CU4fqzOPUjz/uH/nfFhGsqN7P1sP+7xH/PwvXKF1PpVrblJG3jtz1YTb648gSQJd1ttfxRs7Ms4oIMJuJirNVbjOjpYWvG31Pg66rZ0TXV1VgXdZ0EB2gQS5M0nfL7+0KWsiLr2QKANpJ/S1gOkAiidmbs8EU+oVYNBhuP8YK60xEhUKowhJdg31R5v+s3CGuMpTZarxxqQ6lVlUQ6R0FyajKooo4T0Q3JK1KHW1Qs8g+tOcoj/9qChwGS2Vy5pVIh4pHDE2xLj3vhaXLBGFfnJ3tJW7UAo7WN/3dZt5KOSLp5J+QIhaMDabcWsgtcrB3bLmAMLyJSZa1/4g2/VvcYSzX1u0tSlMiQ5T8e5NS8px7yETQU+81iXZl6lZkEa7wMuja6t0uES2ycem9iOAj4RI4os4A9sbnw9NFtAcF2RTYiyrMa8+iSFCn/3t92Kp6O5b5T15ugwJ0nIktwLaP7rZGHrGV8+PCviom8/qSjsvo3cIbFx+SEyWyi+8XAOJKW/4F+xuSHfPCHVzUH3zCHwjKFAMJ3dkaA4psAw+EiiCEzZcXsF63bwttbmPhDkfmfoWqGvaNC6z7LTRT/u26Ekni4dhwi30MK8TW+3gt/hPQjkdS5R2Bd6eReAMW7k/Ga2ikk3si7GxCwF0VZOi5/26FIvGNeT/vV5vG8n/ha/wmDvwfIq6LP/S9Gub07+Cj5+vg/tCXNw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(4744005)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G1OJpps5ymDtY4fpuGYh4sPLn0Te6qeHk7So1B2rI1pyTy0L2oHG/wWtBn?=
 =?iso-8859-1?Q?04f4VllaUV9X+vdi1cLfO3GfSBXoCBK567lJA7bXix9huKtKyYdaBUDPxB?=
 =?iso-8859-1?Q?Zmhibv9ttIYz9nLV9sjShmCxrRDcWiEj5+YIznuh1/LYqNSu096rfuQoUK?=
 =?iso-8859-1?Q?4o+vLPD42lJO9alECO7GPZR9S63W4tuRshoamNai/lnV1CLnu4dmgFgXPV?=
 =?iso-8859-1?Q?eVsZShWUHmCf4Iscwa7Y9FHAqsk9BhNIIrSBszNxmIqBEUYHRP1A18rD+q?=
 =?iso-8859-1?Q?gQWD2WRINu0NeXbIuQal8axJWfYP4gWjBePeMcl/5W9nx4rxoPbQY885uL?=
 =?iso-8859-1?Q?BFkRbbWz/Gk2rYH+LD+5MfDZeJ8MRbdXN5ZJHruOqrD2s/OE/PLdw3T7im?=
 =?iso-8859-1?Q?u6Ic1gG6kv7QoFo1pLIJrvJK3xe+CQHea7paWQ07UGFlK4qz9WEHkyS72g?=
 =?iso-8859-1?Q?5JDSQnipQQsumIfJrktgWD0bkm5FEmMTqpNAb7dFC7SE18xM5KIvxsw9kq?=
 =?iso-8859-1?Q?Ss6itkZhooCosM4EYSdFKCPh6cdNt7gBf6w4y2L9Bcm5aPNHLq7QBuP8oN?=
 =?iso-8859-1?Q?0ROOA8FAOYssz5CCxxp1b001yWfnhAGmUG9u8XdpuBcEicD7VrCnOa8x7R?=
 =?iso-8859-1?Q?5xItR6pBBJPUwJtENWoXr6hmWzmB9Usw5G27ZwNi4DaAES9PXJuSDdjzm1?=
 =?iso-8859-1?Q?73DCjF54A9wpq2iEmaSMw74JNqdLp+aG5wICeVlXSLivqlNNL8A06Ueu1e?=
 =?iso-8859-1?Q?hlcvmpeoWUMXTHJajbJVx1gdea5VMIjQSa/tp5a1pUxsSU5Jj28XM3KFvp?=
 =?iso-8859-1?Q?xBY397T2duqYCRjRSbVpqaHQ4dOZW+r9slbabcPiaf30+TTpAQyYF2EtCo?=
 =?iso-8859-1?Q?7r77ogWsMB4uX05MQPQph1bQX30yKGsquHHsnMYPuNT1GODnhWJTswvKFP?=
 =?iso-8859-1?Q?fTqTh5y7jYfkNlkBcbwakynUF8MQ1iEHGWwr/hBjSApzebq1LgkJoOkCAP?=
 =?iso-8859-1?Q?3cguMBhGJ97Sp++2GYX1DDUJWhEl+00qEtqRtTK4stZL0yUqFSaoJoPW0J?=
 =?iso-8859-1?Q?mpwb8jaX3YejDhq6Q2MUldnlHKpH9yvss24GNcaLYaQIaQ8+Vo2Q7r9+mn?=
 =?iso-8859-1?Q?bhxQ8pr3JRkrA6BlZRW9npQNtyRm7oDKERlNLulQz2XWz23EqUNH2YQGfO?=
 =?iso-8859-1?Q?whjPCGFHKaLAkPkWTgjeJ3iy/XaL01aL8ToAHYk2yKCRhxSasp9eF+CQ/5?=
 =?iso-8859-1?Q?BtghdBwQ0WPfWietZhRa9Yy8GJh3k86atlNnsxacveDvDj5gbh7PJtKSdR?=
 =?iso-8859-1?Q?hV4nUNCw4uOc6s6S7Tb0Xej5zhz53KHI/oSKfIDIgMxGyEvZ/hgpdDAoQp?=
 =?iso-8859-1?Q?NWYF2IbXAOcRQjt16kDKCiCOgo0K3LumkFhHdtj3eOcRiZsfb3m5bI+jt9?=
 =?iso-8859-1?Q?hdYDcQscLIldR1Rr/4XrBQklTo8VlCmqV2wIYOASGww74Ufp15v5ErJ11Q?=
 =?iso-8859-1?Q?oOJpWpuucxTDuly4TiioZt8HHwF6RYdSiI53c0bgbkgkkfH9RGRHP+MMXq?=
 =?iso-8859-1?Q?bCdD9mIAedHEueC6xvYF4Ym45f84GfVQJ5OphqQhG2LdI5BP0hjlu36uyn?=
 =?iso-8859-1?Q?aQ7QCDE75pUCWu7jxdZP9028rkkvmTy7udab1ETAot6dr9Kzv4cGCuTg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e416c3-1dcb-4b41-0047-08da679eb23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:54.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIrtDckJ7/vEaK0wXuX6KDqcMf6/N8jUHIn0k4nMtF85Q+tMXTlRZCWrfvO3kfiAubqzSthINgQL4kLo0pK5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: l13x2_-VzFnBT8IiUmaVENJh7faCbieN
X-Proofpoint-GUID: l13x2_-VzFnBT8IiUmaVENJh7faCbieN
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

madvise_walk_vmas() no longer uses linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-39-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-55-Liam.Howlett@orac=
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
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0316bbc6441b..12e8010c766c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1238,7 +1238,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.35.1
