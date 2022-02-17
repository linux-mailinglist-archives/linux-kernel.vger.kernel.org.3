Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3D4BAEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiBRBBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:01:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiBRBBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:01:34 -0500
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 17:01:03 PST
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860CE17DBA5;
        Thu, 17 Feb 2022 17:01:03 -0800 (PST)
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HMikKC001743;
        Thu, 17 Feb 2022 17:41:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=f58sBG5KoGCq2CcTuKpccxuX5pLC5MoafCJ+FTutn/o=;
 b=zN7Y6fHRwfYVWP0aOtdHQFnLRl6aSF2rqUGPKzCECEVbr0/H32CvpfiNtkpiZzPsIuH+
 ho3hkHdABuV9hGPX6/SItuR4uPgdlGFSx/+5T1U/xUzTulbGRYf8adl9Ol5lp6jGqAtm
 24oaZXViIDyuP1HTMs6uWWXbuiDU7e3e5nqDAIzu8gNlJ6O8kxMP4cKp2LynarEHEo3l
 lz432bUVHqR3P98L/EsQ6jGFUB84rCc+KgU+mDm6pbJLGrqFJls/wnxK3TpPaVQON8aQ
 rYIFSt7kzZAzCFiBNX56tT0uOfQe3svz+ND/8Zeeg5QWRbaQmRY+7Ga8T0Dbka5l2UQq Zw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3e9n3196dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 17:41:26 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ4pBMSu9Vlg+TwFTLxq4pB8+swmF5uxQwFTHj3iwkpIgiBBNxKoB2w8YIpIYk3Ya3d0u63GkbIfT/p9E38bt5jdbAJKogiVYsZfNwQg7tYOzqXyIO2k3FH9fbpwdKkgU5h6oEoqnjh/+nLDfx0UQdvfV1/2m3zRKQNI4eFrrqNWXNYrTiYkpzE0qQ3Uln0ehWKm72xYEP6M9qzIJJoUS0dw75cEXE77nNw6k/c1489sH6tm0G7M2tq9mgopSWjGe7bbn4f5M51SgvzRXl5L96MIYRWR4TiO6MxsSDAW7CGQAHevkB0nCenl7ZvRjQ32oKzdedmj/h38L62Md+IECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f58sBG5KoGCq2CcTuKpccxuX5pLC5MoafCJ+FTutn/o=;
 b=jT9vFZ89gngPRpWUVw5mR5wer8wYQXtzms6PGVj+4UhdMw5hJI1UVYqb27GX0Wp+E6OFyue+W294oL2hyeb0uVa5lwu5IcEo2hHzqs0aZimAGDS2mOvuEOPEiUrcP3NzsFR4GwjGqx9N/VXt21aADHHDiw3bPjj0Edj/ZLEzCo+hEt2THBui8ruWNFpf7N9D52skrKwW1nJ1PhWb6xkQU5l79i6SZaxEKHoR6KkI8M8MO9s2SJ3RMOOS+t2vEYMx9kINaqucuTDNV+3dHj9bhC87vk2rnQJVCc4N0ojIdADLGep6DbBlnll/JkAHQzPt9A8esDr6TF87mYdFUsqR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f58sBG5KoGCq2CcTuKpccxuX5pLC5MoafCJ+FTutn/o=;
 b=Dg75tt+PiZishQybQuaN+uNo97q+jLykXxn6DsLkcm+UsOqM6CixQc29Bh2mPIz0nqopBLjo72lSxCaAbGW4nUXedi9lVp9uDkuVt4VwcvE7wGtV3UBV0ofWEoJNdypYnpc6p1esgbiNKbBVCWWiQeVe1amhMLUicGyU0R8A9jJqvs0J623LkVIIy1+etnXx5TA8hatrbQMcND7p3x2CzugBK+eH1L69W0q02GHGIT2cj9DpvwydcElVuw4ggNPJpvujA1EAfOdeFVkhHclDeFCfRjW1LtkN4kPBrFc1Zs5QbSjK3ayIStGGYRuA+ZCXcz7ZiT0rPkBqNYCxnrIfQA==
Received: from DM6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:5:80::23) by
 MN2PR04MB6319.namprd04.prod.outlook.com (2603:10b6:208:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 23:41:22 +0000
Received: from DM6NAM10FT056.eop-nam10.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::55) by DM6PR08CA0010.outlook.office365.com
 (2603:10b6:5:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Thu, 17 Feb 2022 23:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT056.mail.protection.outlook.com (10.13.153.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16 via Frontend Transport; Thu, 17 Feb 2022 23:41:21 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 17 Feb 2022 17:41:17 -0600
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 17:41:20 -0600
Message-ID: <61696faf-848a-0a00-63c3-5dacfcc20972@garmin.com>
Date:   Thu, 17 Feb 2022 17:41:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
To:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <d12b130d-4c79-25bd-36fc-3566bee37173@garmin.com>
In-Reply-To: <d12b130d-4c79-25bd-36fc-3566bee37173@garmin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cv1wpa-exmb1.ad.garmin.com (10.5.144.71) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99ca06d7-5442-4837-3608-08d9f26f00ed
X-MS-TrafficTypeDiagnostic: MN2PR04MB6319:EE_
X-Microsoft-Antispam-PRVS: <MN2PR04MB63192C8AAED381B886D5E502F2369@MN2PR04MB6319.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyT/ZeW/6LvWzQB3aww0A/IOKNfCwkxFjU3sNUcRMC8FvWkoqxDSvSFwMKpDe7AjIaw171khpr6tUl/1TIQLGuYzuWtMAgE20w4IUnfYcl1RdH4XAln3E2WQdAbUpMyfY43Nc2I5KHsbSDjnL9mCywc6N8IVkG7H+/Ju68iAyaJ116RuXtMYtIPrO/CvKOprz5mnbouV9ETPTutKr+2qmpr8/7K98sAIt8WllAeQu/upbif5c8SmUaa23CJc3znjxXDvKnUWuRbr0GA9xAIc9AhLYo+kylWKdNXxMZXd/ayRrpprzr1FTAQItoJYy6fZBcEDJTX27admFBwGO3k+jqgQ37CbzzEW35V8QaGTfQbobtLF/rZymcrskBuAVbqw/Si5iGCVrwOpjXP65iLFgLFA6bO1efiSsHfGc1+kM2yGfkbgiZHbN21bn5zNCJ55Hlb8+7GBI0qP/+4lmIYC+MMDMFCEokleUjE/jpcVE1r8E2tMzsxpMSnkP1JzI8RTdB/ieY4O6iB6VVQOMo36udh4w/C1W13GIANP0uUFt/XHzV9VwThOCdwOpX3TMjb9Ep2XfTlex5yN84ThbEvLC0xB+mBYSpiWCEQYlz77FiHxskCCcciyoxXL7JIUPT5cPr+Q7XzoZm9BxZhwvU1fBnFhJXzM9K1TWmfwL+CEEOJrfmZPllpOJCj3mSuHPxdyXI+fGM4YBulNO2tmQNl/Bg==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(2616005)(336012)(36860700001)(26005)(316002)(82310400004)(47076005)(186003)(508600001)(426003)(40460700003)(7636003)(70206006)(36756003)(86362001)(8676002)(70586007)(110136005)(31686004)(558084003)(5660300002)(16576012)(356005)(8936002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 23:41:21.9535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ca06d7-5442-4837-3608-08d9f26f00ed
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT056.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6319
X-Proofpoint-GUID: OEjFrRsj1P1f4YZEHhaSvOhCtfsgi1Ik
X-Proofpoint-ORIG-GUID: OEjFrRsj1P1f4YZEHhaSvOhCtfsgi1Ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_09,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=841 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202170113
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please let me know if you have any feedback or questions about this patch.

Thank you.
Shelby
