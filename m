Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7654EEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379650AbiFQBsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbiFQBsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:48:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD335930C;
        Thu, 16 Jun 2022 18:48:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H0qMhX026649;
        Fri, 17 Jun 2022 01:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wt689crj3pOysbwsczbLz8BmmCMbgiZGtDf4c1bAWoA=;
 b=wFSt3a+Fp6ULt/5tOpF5gUpP1QKsjQ9U96qVzTnPkqaqN6zSHZB4PfDk+25yWjhvwIeZ
 7+56X/pNdLG/uUZLKUAlxKVaFVdpxRyY9754Vke4DTpg/q1GJZi/oyc+Aw23ZWofBByN
 5BHcmBEZv0rxfYhYgsdl0E0NmUjDhz4ZOqA6ay5qMSUlxf5lb2hiN0GjT2VQVQqfAi8L
 rvn2tsEsfKXvwrUbcyjAPVtDKFFBHNT4URUzS0Cf5d3kv7YtAe8x4eAXmLcRO1MsXF2n
 HiWEJzt4D2hlIgzK4fApp+bDzGZ0CtHxRCwQOBjfJqGMvYMX0v99HIfH1Bb+1mnckMlX ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0ms4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 01:48:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H1k2kQ001364;
        Fri, 17 Jun 2022 01:48:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7qq1p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 01:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5g1j0SZ5B9pYNvwhrCovOfGPkKAlGrA7UvEIZugVvRqUzaSsgmjv0h5rpX238qpTTIwvUcM7qb9mY+5HqhzXUWZjViRWoyng/9MHgpMJkkI+hxABAcFMuG2M1tJL4//QrV+S2frgaw52VsbPCVhs54TJ8o8EBC6cd73bTcRIPZoa+U7BgVxGv9PYFsTQSqajWcPLsZPR8ybeSgEIEF6IA4UmTEPOnsu4z35Leh2fLBeC+hDHMhVhYItt1iv3dPu6aHMYAOvZXQQj2376L9L85ah5G7JEvZy5/rwV5dPzjDa6dpG6fXP7UJ9GtmZ8Y1YH/EmoKpRKibE8qjSmEWRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt689crj3pOysbwsczbLz8BmmCMbgiZGtDf4c1bAWoA=;
 b=QRqp3//gelUD+3J4A40q4Pk7nicdWrqZfqtq6OlgT8nGAVvSiQIPVz4bmNitSv+ThTCjuUaAahXwpdzm9hbpWxIBQZKM5aQ2dNIvSs6bKAmuo7QQr6ZLxLtuTMLgJ45lRn1Kpw/gLg8aCIdhzs1pvJ/Y0Znz+3xM2hwA/4nPCtVOlCyT2iptu47+hlq9IpN/h6WTlf45tYONZ95nNY9KWScpaJHDnNn3iXtGzH6135MyWrYPpFZpwbUaabmSV9k5doExeNsSiWOakY245dk4m1dWMijOCDSqoW57rtwH5sVaPktR+3q1MguqdHQGMnsjz/gsjOi8ORvwUQpYGDpexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt689crj3pOysbwsczbLz8BmmCMbgiZGtDf4c1bAWoA=;
 b=HxJSgnO5T3pyY/BvaRMAhKd0xuIrB+y9YeD5U4/MZsW6pOUPgwt8rnrbr7kgnFP2RDV8fCDk+2rTtNl7sPGpfhxWNp9wHxVQoU6xtwVeffvZZM9giY1DnXoAZaPtrzK6uLJ/EyRgvMZNRe6mcdZUkDRhkbT/i2boS9uj5U4KJuQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5621.namprd10.prod.outlook.com (2603:10b6:806:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 17 Jun
 2022 01:48:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 01:48:16 +0000
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org,
        beanhuo@micron.com, krzysztof.kozlowski+dt@linaro.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] ufs: host: ufs-exynos: remove unused defines
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rpwoyaw.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4@epcas5p3.samsung.com>
        <20220615121204.16642-1-alim.akhtar@samsung.com>
Date:   Thu, 16 Jun 2022 21:48:14 -0400
In-Reply-To: <20220615121204.16642-1-alim.akhtar@samsung.com> (Alim Akhtar's
        message of "Wed, 15 Jun 2022 17:42:02 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6425e697-30ed-46fc-ea43-08da50037289
X-MS-TrafficTypeDiagnostic: SN4PR10MB5621:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5621C69B4376949F78434D5E8EAF9@SN4PR10MB5621.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oX9+OxVo0WQ863dnoEpBKmraZZ/loArj046/5ZZdaIvJmorogyprux3+eGQWBVU1u60VQvuoyue4aaEJJoij+pPCCN7G1X5B+19tAlKQMlwKkWt9whAkam+Rq5fKpCqcQpUO3XdDhQ3grh4t2JwdxuvtMmw6P2Ke/6/L2wptZ1EfPdXyrgNrCvbh/vh9M9FfFQMfLgdcIvzGBSzsoVThjf1eTTmcUs4WJ9ekdjBDLQZD175d2mTfqsFezV2xiUHX4v6Dk2C+hGcLJGiI3hgdMuhZLRtVNHN7oQBsNW5cNtpY2e6LQIts4UJcNYYOvzEDDCW9J1s6JleK6RQt6Q1uxm8O6+ziYkmOQyhwSL7eo9X8eQL/21vD1O1FRTIbY3v1Cq1RAex3uDrx7T25lJuetJGEF9HECajRTeze4/88oq19qhTyRTpZKXNuyh5k/inHIqwxB7DG+XiQ5fzpNyui+vKbk7UYrMCfXROOTHZbOHmFzXG6q5PXqrja565wbnA09Zoi8uK5NBl2o8ZoIlBK6Nwcx6r5Qj0ikEI3QsK4E1CqG2eNqX9WzTV7TgQm/BGZX1Czyy/CEqocaEXTdgTAncl0hc+MC1Y9d6tmAoMaEsbvy87bcMqdzJY6EBlBXK3mo967RT/xzlfWuHvXqEzxDPHavE2mrWc4xoGv+cZJeyHcvvbpeZlNSwMFocdn3Tlya5ZIaSQGrg1s3NWINQFbuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(6916009)(2906002)(508600001)(36916002)(6512007)(38100700002)(5660300002)(26005)(66946007)(8936002)(52116002)(38350700002)(6486002)(66476007)(6506007)(4326008)(316002)(7416002)(8676002)(186003)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JBorLIrv4G4ymRKGCa9nJsA4gpL7CZ0mrp2liikt/HuqA3YBnkGmmuMZtYwZ?=
 =?us-ascii?Q?wSKuqhAm6lX+9obVlAMJdUZds28DW8h82aWJiznf3YLO//dw6VQAXzhqKB9o?=
 =?us-ascii?Q?y1vMhx9G9BjS+D9AXmADsCsfYhAE5G8Pqco0In/rCNJAHu6v/raXowwSlLZW?=
 =?us-ascii?Q?4D5tr+dplVlonSBGcvl5nW5NlikfoXfymOjyEvWIIp33wSSSSidZDWyEny2F?=
 =?us-ascii?Q?GZysOmVmUi2ngWadp/MPXDDk8upCVud76bPSt/qXpot5u/KDB3y7xXoIPMB2?=
 =?us-ascii?Q?AGrrRQp04JbYMMu+BfN0vOZYuSbJ3vy/AKtUAzWEdvnkbNuyyEe4guT+PR+K?=
 =?us-ascii?Q?v0/U2bmmYI0L0lytZDRcrPhDuN/JW4d65lKw8mgjXaAOS7ZtnwDqmt18wLhg?=
 =?us-ascii?Q?igK5rhdlAvaeiOk8ZKKTrZTiKqFdM3kq23s0R7WfDKvWAOTn1wWJgDV7Jv7X?=
 =?us-ascii?Q?PK8j9u25eKRO76mXIsAjFDWQy8UuVeqI6h0SVTBMzFQAKqMHSwFtyzNynhWq?=
 =?us-ascii?Q?cDtTDd9ymQYpXstIVN88ILFbgDI61RugKXW4gSaCiLTQ1HJSa0+fcmmF05kL?=
 =?us-ascii?Q?9lYvWk+swVYFTs/vV+sPZg5WVYT2gwrPBOtCxLsDV7VJbky48CSHDTl7Lacd?=
 =?us-ascii?Q?5cQzPIuVo498giNQGOocWEWGK0yhz2iXKk/87JsTUsxuSunsyzLo+ZuhyyS5?=
 =?us-ascii?Q?N6NqciDywazOIhNhCznMUWd0zrwfDVd0b5jtWq68/lyeiZAH56RYyJaRw59C?=
 =?us-ascii?Q?+TBl5PvkALSsuUICPu93t5eGnhi4ml/g00k0PhohKnhP8EbkikFcNWOSSYOy?=
 =?us-ascii?Q?grqSNb8g97mfjl0c7HVn6mw5guGNf27GOlbCZlm41SqONhUt2dmAfp2UJc3r?=
 =?us-ascii?Q?nT+t4iDHq9pBiWu9OsWApkuUH3uqVUi3o4hMGNbRNlx4XJDRDg3vb0WL0a9G?=
 =?us-ascii?Q?jriv+S7zPrxyE+0Uku0Eur5/jls+umgUbb1jqw4ZqqEkhyOFxBG4r0KQgk5E?=
 =?us-ascii?Q?LuF/BRHLuQpAbhlh81vJ5Yn+oAxjBNo0CLiEbCVSA+RelxgiGSl+/+eEw2tO?=
 =?us-ascii?Q?wh42bwJU77w4JUzxgFCXsVk1p4W0RAf2+gaJ66kauKTitL3qvC3UNSKPTyth?=
 =?us-ascii?Q?+RhiouLWMzrxXZA5vjq69kiUWqQcFRFJVx6Oc6GyNBjPXtS/CtaxXQTpIond?=
 =?us-ascii?Q?UsaeSpNzJ4xNgp1B9IVrkpqUSVYWvWJKfAWHTYYa8P5dKwYFu+/IPYd2uiKQ?=
 =?us-ascii?Q?TxkiiP72xjvYbfyQ+STWbdSbT9EPf+XeoLPucVotJqvVPX4D0JyI0irTz1X2?=
 =?us-ascii?Q?OPJ/n3x7z17alCvLLAQMvLrhFU0RKs81PH9SCQgNRugrYT8dq5BUsGahP6cS?=
 =?us-ascii?Q?18JamO2qhx5sXYL8C+NSefR4hUEh8vo+dNIP9rS+0UIbWviu4wIMHUZoNYGl?=
 =?us-ascii?Q?UfmgkonSnXyV8e+y2i3EbtG3XwBe1FodxNsl1VFK/UIdiOeQAFNwiB2VZ4K8?=
 =?us-ascii?Q?8w63joIuqe09jr1TVSMgJwysiG9uwbRH4wD1AS2enQQg8MpqWiWeUETuz/+f?=
 =?us-ascii?Q?ZqZ+Nddd5rAVqC4y3O4qCcEzmlbmS46SDDSBD5OSotEQ0MAzFniqRBPOv2wa?=
 =?us-ascii?Q?RMWGYvAtlU9+Tq4aFUqvtVKWFwOytryIKHoyyIE5ijTqOaQoykaxXNUyPd16?=
 =?us-ascii?Q?7GICnkWlNnqvDvDX5uC/azeNunfpnV6wze6P03kD3pcUK0R3QrtNYFfn9w6b?=
 =?us-ascii?Q?nwoH8JCiPVuaUVdKHYVdaI/V1O4Lw38=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6425e697-30ed-46fc-ea43-08da50037289
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 01:48:16.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+FzZA+gr19Gv15ySk2hy8RxuZuU1xAz8sE13x7s+raoo8jfSj/qfBfR2CvR8ye5Gqjn9U9c5OdRUYhuhrK9tjjwNy2fwWqbOAZf4N/mf64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5621
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_18:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=657 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170006
X-Proofpoint-GUID: gy0pHELY2up0thdguwigKfFv8AqDZTFi
X-Proofpoint-ORIG-GUID: gy0pHELY2up0thdguwigKfFv8AqDZTFi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> Remove #defines as those are not used anywhere in the driver file

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
