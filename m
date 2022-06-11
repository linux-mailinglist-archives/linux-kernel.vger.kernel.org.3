Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE935472E0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiFKI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiFKI0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:26:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04696F3A;
        Sat, 11 Jun 2022 01:26:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B3Bjn5022581;
        Sat, 11 Jun 2022 08:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IscHeGThVOkj84Um/HZ0q8ozmmmI4X2fzgSEz0Yk718=;
 b=EmLXoz9i6iYklITjhVqMpnnu5qkJWdUjIqXWud9XGvk6FX/1uK1Z6uVh3J6c/gFqDFnU
 r87XY019qIhX331O90mTT9NGKXvJ30zk7oq49t84+bhOcXiLRM1UP9vFcm7zetzioqOl
 lwdoXTu4MMgNQYFc3kYnkuniupdpXJhqbAS4SREZAqRNu72YDAhpVebDUWJqX2h1fC57
 cuguB3WO/xYXy5Z/2edoDJfyewmWGgUEpE1g5J9Z0KQFaIqf3UhjQwh/jtJ973q8qaRF
 ARYJFqZBHyyXN1OrMfAuGH8pInptR2TqQGdV2fd+F27D3+tBOdpKfzD6k2bS+ScKeDdK BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx98755-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25B8A0x7009256;
        Sat, 11 Jun 2022 08:25:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg727n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duOKP7S0r+CuIuP+04IQ+/qiBG02fdvoZQeZvx8m52jToVcAD/MzNFppKFNZvoYLeGwmLjogFak8dZgFDPw4guR1CH3BScuFi3BV7/Z0bSgxKHkaDOOJny1eaYb1Doqgw4zUl+NIHLCkPee6X1YvbapJ0afcduk/QEXcl3L/exqzth75Wh1QL9P3Km8ao4P+dqlwdtgUszPcBFzsEFzkLq3YF00QqbvFeZNZXyApDpGMqwfaTn1+CuPMF/gb8p5MdRjYuLc/a4lWYvnXT7feK7PRrTRWJJAt7iey9e4Yrgnge9i1hWRCJ2wVasuQn2yW+Ln+c0Yy1sUU+nwgusF0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IscHeGThVOkj84Um/HZ0q8ozmmmI4X2fzgSEz0Yk718=;
 b=POhTKrYRtR75mTrro9tPETyctQbdbzVDQ3obxloNwvloiEeQbvurwYob7TMwhnzmmCMp1Ef1qnC8za/JIRILrHX98gEZ2fsYJ2SnuVNqn6J/rUHdL7NHmYQKCdsCUroAl3o39cxFZXZQDfSzk4rhNUys+x9hUYecPvsDw4gTDtBG/Ez0cH1r2JjLNazD6AEwOa5iCGfxYOIHBmPyiGxDSp5X6n1GmUwqQaLdJX5VBVOltPyAHndvzMad6h8Rl9Mvh4TgDJ7svx3IYDsqPlUtHCcODDIC413HRQ/5ihmCiMmqvdShK6pNSb9phoPF+k35dOelmG3tjvbvW+pEqeaEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IscHeGThVOkj84Um/HZ0q8ozmmmI4X2fzgSEz0Yk718=;
 b=UccsT7CjKaJFx4y8jB3JoW272D7R5xz2TGC/Sm3I0yogF1IMuRHyyIINbUj2rSOyCXzPEc+6gyVv/OZP/puMCEnyC9yALWgNhM9ocMEVkFQ0NXjw+D9DYMzm7GdrgADuZi52IZll7tv2+fXjFcDSUEVHo1WHtrpqr5r6FKzz8/0=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BL0PR10MB2945.namprd10.prod.outlook.com (2603:10b6:208:33::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 08:25:36 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 08:25:36 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        hch@infradead.org, m.szyprowski@samsung.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        corbet@lwn.net
Subject: [PATCH v1 2/4] swiotlb: remove useless return
Date:   Sat, 11 Jun 2022 01:25:12 -0700
Message-Id: <20220611082514.37112-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611082514.37112-1-dongli.zhang@oracle.com>
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3212357-dfbd-40aa-f9ae-08da4b83f5d4
X-MS-TrafficTypeDiagnostic: BL0PR10MB2945:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB29454ECCE894A434E9EB3E7CF0A99@BL0PR10MB2945.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znJFE71GSHoQbLHLrHlz4PRXo+grIxxgN1CvKB2SksOf8BhdpmYwTdoNLC6iKOp2iWK0M2pOyMRX1DixhoTS6rK1Pz/MXE+rbwmhyETMgvBrzvaypk8NjTd2GWzBBwFoshUxGFvMsQI6Sh58RXMcFUSwy7CoFAae0jL+kXjNAFRkkCrd8czMyNH5NK7EMhtftllnb4m9wBbu/ydJ92lGl+fcqriVONVV4mtpU1ufEtRJH6u8opfzRrVSjJ42w5lOxK2/uD87HEsTvpnF5e532fW57XljDRibody0QBvmaowBXknyN5zF0Cri/ethenWbjpVeu9cHEk5lKgzuEnroZBqQ/cwc7CZNXYGMYKfiWK5ZTwzGDHYo5vSU44F+bmjodvi8MFbd3OcaV1xhLaYTAnaMyKz33Toa49LPgoUMJY0FbVmx2QadiGBsZrthChcEUXADuvT9j1k7aYVOtyc+4jW6o1q2iWiuwKmPKHo2OIgKH7ZaExa7eW7kYciBx8TNmXtp9yHXSQ61RcTTbzI5yAynv9QcJID9SG0k9KlFbH2dJpGGDIncl950nIt9rxjymZIZSw+Mbgb85xgKLchOhwQeZiw5sbjGiXbI9M9NvUFSD0LRQAEg+WYhOcK8hMAQP2vkdN/mOZGZuDXQeozYOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(26005)(66556008)(8676002)(4326008)(1076003)(66946007)(186003)(36756003)(316002)(2616005)(6506007)(6666004)(44832011)(7416002)(38100700002)(2906002)(6512007)(86362001)(4744005)(83380400001)(508600001)(6486002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4cO7Kimzj6ntQkFkggPdaioRYNT6rD1aL5lGv0sCDCJ3iSly/AHnRHvOiQm?=
 =?us-ascii?Q?3vY2WUltCjXrOpjpH7WDiojSi0T5GwPe6B9oyoFNvic6OlvT1BamXm35tRvR?=
 =?us-ascii?Q?nQIKAWGti98MVc7gVKsjIFDcRJsXwesaNoiAKX1K0RF5ZQOQ9mvn2ma5dsv0?=
 =?us-ascii?Q?+BLQx7mjwiucTjZmDf7F7AeFTV9k++1k+7xMnG1j5yibpYD3g8jleFTCrHZ1?=
 =?us-ascii?Q?xDA6UYHaWPsfF5IJTEQ8H8KEC83EAv/Y2ILkUAvN5f6U3BBqIMjZGY3hyl8L?=
 =?us-ascii?Q?0AChZdwaT0ETI+s7CXW5ceZNd7hHi4MxCS0fiWNf7ehjgYDq+qjjEDP2zm12?=
 =?us-ascii?Q?9ZUFPpgPndNrIccrqMlws93SAjHE+yk8lX1SWNQ5XsE0639MPBNFbWX/nAK2?=
 =?us-ascii?Q?KRfxRfVlH04Y5uJ9VYPs+wg0NfycBUrRPxYRH41QzbHxEXGn8DOBnvK7Qenp?=
 =?us-ascii?Q?pVmdqnUuA1PzCiwiHU0aJ7e85QAtc85pXNuffvMYJy3MAkYRGYnvAHPV3NYr?=
 =?us-ascii?Q?829IFCgeBrXZj3mznvO35Ezt8bJD1HB3eZFGHsWs44TSAgs2yaNMXSHU6oFc?=
 =?us-ascii?Q?kGt14AJQzrzxj4dbMESrh0JohuefzAnv2+yicYzXIFy3TfnbsCsL01CVw/S6?=
 =?us-ascii?Q?qLuQ74G1nA+/D1qQsGlyUJZvk0WbYJ50AIMJE7MlhCVuxwkK+0ydB+TDRkmD?=
 =?us-ascii?Q?tdIy1Tc/3TeaiaPArEB9g5mzDNmuEhFe+Emf/j838prMU650UdA9pkpussny?=
 =?us-ascii?Q?OGOPL+3vvlb4ghH6uy6IrOJc2CkM2ueVh35U+qeZ9mkK3mzI5Q9HsTi1gtp5?=
 =?us-ascii?Q?FfXYZ8CE9fXkoDLVREMtVz+cesMPce6WDOgNhBfVwGAmMX8WbW2T/X740f9s?=
 =?us-ascii?Q?jIN9IFUkg8Wusz+MH1a/4/6GA4GHsyHTjHTFATXh/oCKJu2HcoZfMiHUXhvd?=
 =?us-ascii?Q?liYsk6xehDeZuNnvcrUMDuoOkw1CNlX9KB779gtao9r+jqPfqjMMTpr+PhtN?=
 =?us-ascii?Q?+JSKPQkyqiONWuXnPu6+HqfkdNRwlv0EtKY5L0z9zCuNQSlVA6fcXWrMJjqA?=
 =?us-ascii?Q?CheFdhSoFYhirZyE+ZYDtaAxDLNozzjup2K4wCLbKF1F/0oFRRc4yeZdKZ2L?=
 =?us-ascii?Q?n5+gHJeCPqK9lxODbq7avluZWE4o6ZWpK3Hh1itwK6w10R0E8/fHGEalC4C7?=
 =?us-ascii?Q?YX6cBIY9f4BRo9i3vBsNBtIqTgOdMfyCIwiT92KOKZ9S9xbPEJME6NfDR0Kj?=
 =?us-ascii?Q?TzD8vT9VJsXK4EPhsJZCci40P2JmxM28U4EPUJRFsQ0ycJqXO+1+4k92pK+1?=
 =?us-ascii?Q?Hx/TNgxY4jE/VNvJgMLlWWIKeZBjsKSe/ooh+I36Rkaggpq2MG3mSh8e2YIY?=
 =?us-ascii?Q?Fv0AoH/ZaIIAzGzm/R+Dvs1/Q2S40E9bN9/DeTYn6feRcjO7w3rmJJJubmzI?=
 =?us-ascii?Q?jpFjvby79+QV18iAX13KqrKMOWF9DpjtTrmuIeU4OMogkpgJoeD31Cuvw7Qh?=
 =?us-ascii?Q?qIHK9sCN284e7LSGbLrKZcuVHsHmZXjg6uP7Dg3kLOYwYw8QeuWNsst3m1aG?=
 =?us-ascii?Q?5ZYzR2YT4XRwsL6K+ziWfibdek5HfW2eJNMiOnQW7+9SxjPH7QNPZ7WcjbJ9?=
 =?us-ascii?Q?lKH2IPv4QrZ9Res+rQONuaEtV/dHbna1mpKVDFF2Hlb0SmD8Z+qRqzHsSafw?=
 =?us-ascii?Q?3ms9e6dqj6eEcA6bKACnUVlpAylYPpxOcDDEnVbtf+FTUsVg0+djEwzgsOe2?=
 =?us-ascii?Q?k/uAVGD0+NGremsVF6jSf/mLYRdOdls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3212357-dfbd-40aa-f9ae-08da4b83f5d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 08:25:36.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uloQ+brnQe1zsKjvD9/Pjkk+FVXpSNNRqaYi1eNjRdnN+NH3yZR02DN86sYvaodBt5c+mWcmIhFTzGPY5jYxyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2945
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_03:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206110032
X-Proofpoint-ORIG-GUID: ksjCx4EGJYP5IoPJBs8qt3EaGhQgB93e
X-Proofpoint-GUID: ksjCx4EGJYP5IoPJBs8qt3EaGhQgB93e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both swiotlb_init_remap() and swiotlb_init() have return type void.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d38360..fd21f4162f4b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -282,7 +282,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 void __init swiotlb_init(bool addressing_limit, unsigned int flags)
 {
-	return swiotlb_init_remap(addressing_limit, flags, NULL);
+	swiotlb_init_remap(addressing_limit, flags, NULL);
 }
 
 /*
-- 
2.17.1

