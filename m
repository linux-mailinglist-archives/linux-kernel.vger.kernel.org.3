Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE4A553FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355521AbiFVBBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiFVBBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:01:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B131903;
        Tue, 21 Jun 2022 18:01:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0Il85017637;
        Wed, 22 Jun 2022 01:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sivU7Ajjma7J+69aw6E+PzzWxyNFz/JeXLyPWeg6bz4=;
 b=fsFoklZJ25qMIKbrBI9VK52NWj4JJxDjXBpDQF1PVcqfgF4A2D4z6TiNqwwi/xzlCpaS
 ynyk1fecBGyImqgJbEGL/AitMNprTWJgBJls9i3A7mANObuAnKCuI56D5qDwIT3OnY6q
 e79lTNfAPSZrAZ0I9vST1k2OziDSX7jgRJMj2ye7s7EGpoPhV8LoqPMm0/tIbk9KuadT
 a25NM1AauxWhSZZ2tjsi5MjUK/+lfH60g8m918QMOqBWEyDrziwI05vdJkEwA7vlWIPJ
 WDr3D2xV6v4t3sMuJn2Pz4lRF6diyQsOpBcuK517tBKbz5dCwVoIcah3uLDmOyPCiw6b tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78ty2hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 01:01:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M10khF001871;
        Wed, 22 Jun 2022 01:01:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5uxhhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 01:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLERr1mkVZ6WKsByKt6K8c8utcF8VCHDxxIZCKnZoMTt6GX2FXqJSE2jSpr0xm1nzMwAMF9hmErxEmc3XFWGY36HqbjsWwI/5yjErr5ZZWhSu8oPsH/h6VNoGahlmbUvlVyiFikfvyfhP5lpVXuXIAaF0Rry0w2fFGTXYTFcPJUY7KvS38M6zgzAaFIEAcai/4HSfG7quZOq6RSB496bVIY9ngzIlkLt+G7G9NcZadxtZxk4rFS4zx0mDvtZ155c75r79KmGczyuWLuw4iHB/CwmtQk8jG3/w8r733jbaoVB9NoEe1kVWUR3itR4BjU0NENoQIfvObTkMR6SHPCKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sivU7Ajjma7J+69aw6E+PzzWxyNFz/JeXLyPWeg6bz4=;
 b=Pgeu59Ac40/K385QOFbVwlQuB2LtsN/B6iZecvUVLXPLbVlVZC3UxiYucIcpAe1wyAtFhHAPZhdFKbo8bN1kkck4CkXrk0nlrB5W9bHJQcBf6Qq9wvMR10xuMAm/5NgdN4zP3i7yf52OoMUoPxhWluBarZ6TlZ93sCaITCbjl2vAxI0UmAaWOAsjjbDP2rutW817YOqCk068NV1kW50ukur4QJU6XYsoK4KPTT1hKyzB3MKO+Jhdnwra/ynq5tIFwIJvB9FCgCzuSsSBNC9OKMyieqE3Kh5EgDbPuk2/p5Dhe30ck8ky8WHJArhNKXmAfkfNu67IomsdBnlyPd7P/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sivU7Ajjma7J+69aw6E+PzzWxyNFz/JeXLyPWeg6bz4=;
 b=RG/OaXKpqiKyYT5Zf8Rg13LVJXGKIoNXRmyDHwnRIWwMI12PS71WPjyfA3upnVIcdUhEKXHdr5Eid791M12jffThiBlZOGBPwIZTN5gVLjecBmKrwdRA5Q3lj50VtihTHsNiKLfhX07qhOIIk5TYN9M+sX9VmFDbGIA5yJIKss0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 01:01:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 01:01:25 +0000
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     <stanley.chu@mediatek.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <powen.kao@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error and type
 unmatch
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1xpjyud.fsf@ca-mkp.ca.oracle.com>
References: <20220619115432.205504-1-renzhijie2@huawei.com>
Date:   Tue, 21 Jun 2022 21:01:23 -0400
In-Reply-To: <20220619115432.205504-1-renzhijie2@huawei.com> (Ren Zhijie's
        message of "Sun, 19 Jun 2022 19:54:32 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b825e598-540b-4a5a-c728-08da53eabae4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4654A56AA497D5D174174AA08EB29@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cpm8ZyePLAJYDDgMblC57CHUcr8DVU2fklTAng6Hm2WDIcuqbKHboFrIfZKQItRv+VsdKVpGK5BG4UdZ0KM5BTjR/PsFUnfH1/LQ0zN10bU5d+8qDDswXIjhtgaFyMaRrx+WA6caU1HvvedefDrWNK3F+QcRoQsyJXZ1alCINb5u0+eAElrcY5vL5yP6U6fi6OByG8v96pS780rPSFszu0qxftXvm7Ii4B4jVmP2tycGUfspUh7m1YJveVkv0kJAwSt2cAXkHCaeFG5gRf5+9LFMigoik1nf2N21cK+6GG9TJXY1Zr6ttlv0yfm6TQUK5ncFcw3+K76Qlk7GAI10xwYRzViFGcgAWTmb3ZwA6eTegTWsXoONo88OHnhctHAdoRywsVcui3bo1JBynbDUP8P1H44RqGIs84qmkLs6Y4ydtIHkP9Cawmj00p2+RHNcGiDDBMVPHfw/mttAHiHBtjQGkIovjkqm+iLFJv9dqzyjb90ucuuYVmt1QwbIUHmSqrT3EhFG9MlVPyN+X15nnXk4XM0OhtojqeUvljStWBgGDqfDEly4yggrM8vt0qR3swNkzH8iwRS2ZB1uXJhL0kNbDX3L/m8X8LGP8dC96MfMxhYtPOKWjuCtYbdMzGnc9B6eMn8sTMGJ2SurXiLp67JLIdzPDHzwJqs+IWMcyzsJV3Lbu0VFHCLkU3CHsNonb9agfDdi4ppcxGGeiZHctg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(346002)(39860400002)(38100700002)(6512007)(41300700001)(6916009)(38350700002)(52116002)(36916002)(8676002)(86362001)(26005)(5660300002)(54906003)(66556008)(6506007)(66946007)(186003)(6486002)(558084003)(4326008)(2906002)(478600001)(316002)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANINadEVbOql5dQ8W/gdsPDNcvM1aGxTsSEs/qsJYjZvL0l7QQB+WhvakGxb?=
 =?us-ascii?Q?iQOieNLcjm9FNK+m+okNFSLxevQyFCNEfRQ9oJ0LodfRZI9urNolP6Wx7JFW?=
 =?us-ascii?Q?SMKOZm3CxQEW5m9kChurgwBdWHo7wRgGnoVkfXJRuUtDWyojsLsp+sHTTT/u?=
 =?us-ascii?Q?nnQVfy9eOJZvSTx6sjOp7cbnYCCNFSwRiG/QewvyOJqmkP1p0JGaPKiokPIu?=
 =?us-ascii?Q?XdKvLe1NQV8WlS4o+uWeNWz1KGIFf6aWmQ/g/ReS680q93LTvWezKAQU6taq?=
 =?us-ascii?Q?a6/3EkX5W+YFA2tG+6rZv27cJqwDiBU8w4HwHPlSFdMqg55F37Tt4Nc7VBm2?=
 =?us-ascii?Q?cpg9EvU+kTvReud2COSHUtAjfF2oAe+/fCz0x4bJ+9ujnKXiQzvwbe94DLDU?=
 =?us-ascii?Q?FDQbCf0ms+BRMcR/az0czcau4iJX2R/UL6JtJulR2J2euxdifkcT1Zewy1e2?=
 =?us-ascii?Q?0CAILAq55DzJvg6TqXb7kBZBPhyIz0eX6/YBxtay3vMYFEvKbABAnq2m8mDP?=
 =?us-ascii?Q?BxvqhGLvDurM312InW79m/Ff+E+YjEub/KsRU4T786kvJnbkFigbqsY8zClW?=
 =?us-ascii?Q?5WRtUb+EQPny86oo7pAjwoGaiLKehKhWb2a0LDkkITkEg0ONIQad9sEaC02Y?=
 =?us-ascii?Q?6JwnPeNVcYFnoRQVlIqkEgyxI2oeFvwlZLhSclu8TSdthLRPU0rDGWpW4F5D?=
 =?us-ascii?Q?BSNy0zT0RMtcrc/RfPuRKGz+UJk/HDodwGpn49ay592src7OXIbqqRI2iojG?=
 =?us-ascii?Q?G4aKLQqNpaTpicGjuiD3dTw/+kNMCT3AR7gonFpFGwu+Ee/kP95CfzgQ9SuY?=
 =?us-ascii?Q?qFlRCXa2gdSRi/Yc+stgaOXFyOlMUsFI4z84T7m970Y3iB1RHpYFq5m3JeDz?=
 =?us-ascii?Q?o/bi8YM4fHMNyWDPcoxN/0+/CVW3TIsuD28TMtRT0RUE3ODzyfA7sUeEwM5T?=
 =?us-ascii?Q?NvklaKunPxPm2OLxmb/x+KNWhGKz49k3w4903JzefgMlQYUnIpEJBEyYyUP3?=
 =?us-ascii?Q?/xpGMtogJWCAOGcckw1xN+t9offuhM90Ah864pNxT6jzNo9en6czMbQcCHsn?=
 =?us-ascii?Q?7aVPY0vggUlTaE4QakRGAbmuqHhMmNU5lAU4CsP+ha/yImbNWCiOchEgJEv+?=
 =?us-ascii?Q?usKpkZmUNRWkD962PphipS6clYqD8ekamnA1AU003Vb0/KXPXlYWyNXNguOP?=
 =?us-ascii?Q?SiOQvOonegb1gE/0w3EB0xqNPHG87sZRnIBEhpH07VYowR1UMgxyMHAgV0JV?=
 =?us-ascii?Q?h0bcqMSmPZCQSmWaz1Vp5xs0EPNP15OHeDUhCnxGkh78vpwq0KwEkcPXsXZb?=
 =?us-ascii?Q?RDg8d1Zt9p/ZYqZgCoLxpnIusR8towmeIkmrD2eixeRSZv94x+3apMVSclC6?=
 =?us-ascii?Q?wc+5jyUy290fBgy2Uh3MGIRYezx26d+5ApuujfiXGUt5hte+YJLn3gOHRKxM?=
 =?us-ascii?Q?f3BiaYFbxDXJMz9k5WGG+KOgE+uSq7SPeJtJALtsYUScvtMcrkTBF7di6yht?=
 =?us-ascii?Q?VGvhQ4JnU2kY3x6OF8ZaE8LnpO2CAahC+ZzbLqCqGiVgMPEQZFw4RRuTrmCC?=
 =?us-ascii?Q?mkbMkeSG33hEafpEnswgZp2GaMyXhDO+26J99bC60VXzNkekuj1wWUsGz7wR?=
 =?us-ascii?Q?l98n3I/CutN9bqRQ5XnvuJrMTa4L8z2w86pYR82HIcdd53R7tr+2U7W4BEGH?=
 =?us-ascii?Q?0bMWvnSEvBjuHhHk8XRC4FGlKlPM6D6N4vicyB96KK3yDjd8Gp4dVsSjfgCi?=
 =?us-ascii?Q?jhhUPFMyjPtv1jgx9JsC72iTINQBm6g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b825e598-540b-4a5a-c728-08da53eabae4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 01:01:25.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NE2zUsgn+0S3b/5gUI1V5vlZec8o5yZiXpNznTP1a+3DXELNSzWOb+4X59EKtYyaNasYsmTzp7fajyZ6Q87DFUXtsf+JaFkNbAXSkBOVmjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=778 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220004
X-Proofpoint-GUID: yrkEVqHMA5demBozSHWx9ghTnmJBq2xV
X-Proofpoint-ORIG-GUID: yrkEVqHMA5demBozSHWx9ghTnmJBq2xV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ren,

> If CONFIG_PM_SLEEP is not set.
>
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
