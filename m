Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAD506265
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbiDSDBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345917AbiDSDAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:00:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5826AFD;
        Mon, 18 Apr 2022 19:58:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23ILXGv3020195;
        Tue, 19 Apr 2022 02:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/H1eiai/W6mvY4fnzDrvaZVoBfWmwsdv6/VamvcsTns=;
 b=fQgmLuGutUSUO76XdP6zAWKz0M8i2gLnQNMgO0ujMcXDomFY2V21vZevnGXBRlhN5uzb
 9Qv1Tjm9kglBqXmr+64cDLblgKk8DXEybz8FXzRSRrw7BFMqHPEh+AZJZ9I7iiy0t1mA
 3LlF68yvDjXsCzYJOLcIjcvK4i4VOXFuUusbmc6+DGQ10KAgmBYZdPUDC0e/REE9j+MJ
 HqDx5molfEy1AuK/+wpnG/4xR7StF0K+BPE64o9hilG+ojJuj+xgEtjPPciQlJAiHm0V
 DFXVF1n7BALGKtyucBfH1bdm8QPl0BbA07xpzo1tZ6yqy8U9B+t3xcnmYYYhicyt2kJ+ Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd14uua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 02:58:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23J2uk0N012573;
        Tue, 19 Apr 2022 02:58:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8208p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 02:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu9Ej9T/T1J9r0meVqUjCLuUEEp6qTJo9fXCtQ2jPZITpKNraZClpi3Pp+SSYWLQSBtd5E7LYBx2kwz1xFtbl9U5Def5PQsnX8suy9bqZHyQuBQMzxXbyM5FDBORiBS39R9U/dzeTdioIamEfl0+ckOZN+ALHQrjYlpcoB+04YUnbFZ/YlBQLJim7mZv3Udk6UAmyjcV8bv2oKRUydZZcC1iJ1+kHO72bjbM0dZxkJV1QR3DQK7jO53vFOl4LfVfBvc0i08sh7GazZsgcpjBiRN1dNX5OcflMhN4tQmHRkMGHLdAmSawFSjsWvnBvCCQ3cWdfOv94B5JpY9j6M4ooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H1eiai/W6mvY4fnzDrvaZVoBfWmwsdv6/VamvcsTns=;
 b=RMIOd5qP8XtJOndQLPjJEEsXQf9ZhJq49Fd/z+yIyU/ZccKhuwrRNlCsXnuXhwiO2Pqx0skJ4R+9qQ+rjLCZENTna6AvtuwV1WZFjD/FHxoArf4nsQ2RAxcmpAgXrytgAbAdA58Tm0Idbj1YTTPboJaYH5pp3KjYeWkocsJZt9O2V/SIgylf1GPqBEvurROjABz1fa1TzeAc5mVKBzY1Unhtc998v0RfZ3YIB0Jog5Or9/44gGI4GNp0QadpIOs6hrc4xj6MCbd0+MTI7Jh+AO0iDMNe08eE+nytW97eKTOHJL3IQa2VCwYnHRtCja7MflHJC+Vekycbfslwp4AXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H1eiai/W6mvY4fnzDrvaZVoBfWmwsdv6/VamvcsTns=;
 b=Ma1L99OpvJGKssW63+zfBikwaiy0RjhLB7Sbca18tBpOR5Yp2zFf0pTXiEM2CWMfN4lsOTdSF17rKKEg74Yjg8jt2izFBQUUg7ejlkUdh05cffNdij3dEwBuc870X83azw2qBsoLP8e0oargcf9OM6tOx2FBhkd7nPWk67o3Hag=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1755.namprd10.prod.outlook.com (2603:10b6:4:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Tue, 19 Apr 2022 02:58:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%7]) with mapi id 15.20.5164.018; Tue, 19 Apr 2022
 02:58:04 +0000
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] scsi: fcoe: simplify if-if to if-else
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135i9aifi.fsf@ca-mkp.ca.oracle.com>
References: <20220408081237.14037-1-hanyihao@vivo.com>
Date:   Mon, 18 Apr 2022 22:58:01 -0400
In-Reply-To: <20220408081237.14037-1-hanyihao@vivo.com> (Yihao Han's message
        of "Fri, 8 Apr 2022 01:12:37 -0700")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c517d8b1-f4d3-47fe-77b7-08da21b06c33
X-MS-TrafficTypeDiagnostic: DM5PR10MB1755:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB17557139D1CACB58F4BB676E8EF29@DM5PR10MB1755.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3J8mW/SbEi3czKoadeMpGkGn823r/c1t++8jzS0iUKMSXCsVrS1r/L+5OxJmU5gffu8FTphHR5qwxHWyLOoHi0ZqZWMM+kG28jkyRkycKdjAbZnYHwaVNtK/s0eydIzp5h1Clf3+mvLLtyS17KuvLXDuNYux6SD6eY1is/Tt4l29OxhHdqh0bVQ3Z0PJ4FV2fOT1AT+w8uKm8+wc5mo6AOOIqQQGi0Q6KyAGgqhW7q++yMXDqE6SSjbl+SFx/PKUYhn028lIcVi9qbwLjI/E9IJ4CJ9r0qv0VQ6wh1UN6Ry1LzJRnBIqonHdDR724Z7h0edEjCa6hbL0UYx+i8YaeIBkjug0thhfzkRRnKhAjVd4GWM0+2sx0TpGnha/lU/QRbnwirIC2JVDsgE/OoU+DnNLnBDiZ2NTEoQy9SxliY781viTTkHiL76JNo/UsAUcIqam5o5GTkN4WoNGa0m360Zo8DiZGP107ISImiHvx4gIYWPtzoIqVfr3e71hIrdceNDhNFCxgLdT1RmqbeirTmAUT+hbQ4G6UoOzPgi5yskpvpRSIgQmwYEQjAyFgZoxurm2siJFGqk2tfsQ/Ia4VVnGQ1LbhoPNRD7syOPNJphTsU/wr5sw7E/jUH+CVuwtsnLCBfd5NKX1TNCrUZe6AnD/03pnGeI724+QLeU32HB3K89Uvdw6aEkrH/BKr9Ls/LlTu8ZIKEOUTPV6gJGxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(5660300002)(6512007)(54906003)(186003)(316002)(8936002)(38100700002)(4326008)(38350700002)(8676002)(66556008)(66946007)(66476007)(26005)(6506007)(6916009)(6486002)(508600001)(36916002)(52116002)(558084003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ia/slzh8ARhnUvR5kd4GW/eSM5BVCzn9kKOBLrUGcy5D0hT4j0Ls9hagG7Fl?=
 =?us-ascii?Q?G+q8mqL+YOhV5vxjdn3ZIQcHV0jVIOdQEclzz3O9mJlxNQWF8SmfdBODMcUA?=
 =?us-ascii?Q?5Syjpv96kWiPnm9137ty5LhTPo/2sy/hB8a54naOAA1i/9fHJk9QfnQJO5de?=
 =?us-ascii?Q?dUPA1MoifxA4cKwbCtxIac3uz6K7V10VMyxVXOMr4rvk+Z1+4mVVRsWXP9MJ?=
 =?us-ascii?Q?eTMKrT99LfDNB6vLRCQ2+uWPEEVVUfoafVr4hGUuvP6HnMMSGQqjPrYjPjnj?=
 =?us-ascii?Q?y2i0UhEamoXJDC5A47Qeq2fWfo/3dLBZlRvi4N951E+jz8+BETbI/BMGWlQQ?=
 =?us-ascii?Q?dZqLnJ5YCG9xpsYJ4q7I+767gp8jS8LTWM2ARP5/iRP+mZBMYprYGbRywlqu?=
 =?us-ascii?Q?Bt9q8fYyii0kllyLePtxti1LdPsX6nMPoc8OLPG2tSd+kOQxDacqKELnHKUT?=
 =?us-ascii?Q?ZU4NriQsAKFnjFOcwB1/TAFspopbf561VHOTZrkOPmtXEkEWa5B/nlfXOBRE?=
 =?us-ascii?Q?En8tOXIRAZSekmuvxyQzSpYwkgFlSnBvyjT5cU80grU0tgyDoscoQ0R0V2vN?=
 =?us-ascii?Q?T5Z9J8B/VsMVt+JPJMSEYhzSEcWO2JUcNDWXW4whG7U13Dx5FX3TNxPeofcH?=
 =?us-ascii?Q?O0vqn4GXggyL+hCGYJJ5cYjDWyhyJdc7N+rNpf6t0y/t8Uw3Cmx07vp3pUEE?=
 =?us-ascii?Q?hT/sbLTw2xBl3zMKtb0UoHOZOiU1vllmI2Sd2FFrE1BHvl9p5EBFc6PtkPzO?=
 =?us-ascii?Q?0cF48X4y/WH5YCbjkFW3PRmNZN9cEzXHrrNhz+UQKffh9W2kb9kIOEFPI3/U?=
 =?us-ascii?Q?93lO2sjDeQLZPGx0g6Ov9mbioyF6Cetawk6NPltt7iQ5GO7w8116cXKP4hXm?=
 =?us-ascii?Q?SsAnNokKmrVSvfcPnC3blbMO6fLaxnHUQu8m8TzDh3+vEYo6Y4OtkmMIftrI?=
 =?us-ascii?Q?DnuTsib6uQLBRpK3VPcDvvWoeCNv68xIIRTOPUTipz01O3PU/sfYn8yHHqBu?=
 =?us-ascii?Q?4zSQhdoOqJWWoLovp6ASJaBuCE6Z9OODSW2sC04IxVJb8vgkalAKQLH1vms9?=
 =?us-ascii?Q?QDr9J60gxiEo7BlXC3AQFVpT7E3dOk8xxv0rCNOGonoNRNFMTH+N8YW1jDNa?=
 =?us-ascii?Q?/nyWcKDTw23hW4q6dzTCvfDuBayRPqnLphjnMyCPW4rZUwR1R4jjhmOVtqRy?=
 =?us-ascii?Q?SutbhjRtOXms7X3jtwZLzGW5+0g1tZU/CzMQrbBNy+Q2K1u2Vp35CQ26SsEz?=
 =?us-ascii?Q?pxrKy0LPpEYTcImXdS8yEYoYTIwJ3GBao/pJK5mEnKA6iKolc92R4C5f643d?=
 =?us-ascii?Q?HGZLGAj3vtsV6BiVmaSv3b9Ge3T75UYYBnyKeCBq6U6QfDWRGiqidRZsHFAJ?=
 =?us-ascii?Q?ixZVLSryEu6V7n6ZLd6MjPi9T0vBQfPELRHPymvBYx8jpGJKshWWLpBwDQqt?=
 =?us-ascii?Q?SDikLS0++n8t34k1jL6WSWlNq06KAalEh6tOI9Y4pvgUJDePeM73BTLgQajt?=
 =?us-ascii?Q?KtIfzDbysP8HPhGTedM/dglxXL5Qm1HLJFfnX63jpH4WZojFQTz5GVWVvkLO?=
 =?us-ascii?Q?x6oKIsxH9o1jly0Uw3KPOlO+l6gMhFzWp+LFsIzPAZvdVlQ72nJvrI1+q4Ph?=
 =?us-ascii?Q?W+0s1GCPP+jSfbZtYWa859A/JIE7TgK/PQWk36qpjdjTBhiGJGR8tSHsVaEn?=
 =?us-ascii?Q?X0YxisHa+itUsigUkAtBP0PnByDzKcJTFTILky6DFsqJrSCc5Wjw8EieS8wB?=
 =?us-ascii?Q?UPqFQxdys2sszF4T0azkCLmzVeYkTUk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c517d8b1-f4d3-47fe-77b7-08da21b06c33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 02:58:04.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvMEULuTj/meKT9XtiserU8U8RK0PxKQ5IDIFcWHo2q7l7HpFjUxDY9up7mCyOhmiz9y0pOMA6EdCMm6o7mx4f/0P7jI5af6bd8pEuG+7IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1755
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_01:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=610 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190012
X-Proofpoint-ORIG-GUID: p9EEpFXvSZpDaacfzU6IHoUrJ3h3toIh
X-Proofpoint-GUID: p9EEpFXvSZpDaacfzU6IHoUrJ3h3toIh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yihao,

> Replace `if (!is_zero_ether_addr(mac))` with `else` for simplification
> and add curly brackets according to the kernel coding style:

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
