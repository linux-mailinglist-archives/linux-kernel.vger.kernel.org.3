Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C994B1D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiBKFO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:14:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBKFOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:14:54 -0500
X-Greylist: delayed 1628 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 21:14:53 PST
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF38273A;
        Thu, 10 Feb 2022 21:14:53 -0800 (PST)
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21B4CVk4004147;
        Thu, 10 Feb 2022 22:47:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=zSet5FsN9a7rqQOjtKaTcm7URg9879iRjiEvcsEBZn0=;
 b=wPoIDj6ZMQEGUlj/QOhPZRZ9v3nF5Fg8jI+LB2i0MzgQO8xI1HO4ek0axWM0Uwb4Fkzq
 2XaPWqGuzpFN8PXI8IEtAo85XGD+RAB+PArc6jkqeOQWYUhfTPKkL9+kcFLf9Ra2gDbf
 9VyV1qImL28gVFFXdUqefy+tQzA+s5G08fMOq7l3dfhE+C1sXutJ/+CjO1nZFqJtE2NU
 FRxhJTWFUTCzZt3/0epNqY6iYDr4bylaKLLsWSMcZMk82HSbjXJ2iyGq8JxIzJia8Fvj
 hZHUNKRS0ApGcj+r7Dg4geZJcccXHftK//j5/phoYAL8HGVbL2LoGWG06UlJRgWQamJg /w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3e4n2fanwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 22:47:43 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnJqVP26x8pmQTntBadlmapK/p60zHUroPzgD+Jf67chJ4O3kAUnxV9YK/ZCFvR0HNKX7TXJkr3o9+G/b/h13U0yaKGXNXQFabNoVOMhM1jAGA7KsHofXaKoVjjr3LFvh0f3zKYi+AB4OjCJ2e1DnEsFHcBZGKuRb+HmEdFh/1OIxR+Dbpb9L8+dGstgtGUkeorsIOG1N4BY1kl6o/3EDzF8SFAyH2MSfD31yvAWUfBiwRjRI8ieXmaQpKB1s1nr8csiqyfShzl94Ovywm3w11qEX1UF/floTQnuB7NgzCdij5Q+KuG2ZUunn5vXzG9aYfCyf5nmdq+dqd/hC2kPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSet5FsN9a7rqQOjtKaTcm7URg9879iRjiEvcsEBZn0=;
 b=f6LYVEmy7UNbOcibZZ2tO1Gx+Q9gPC9uKw089H5UPPaMlRfKmZ7jRuADuvxwjLiYe3hmzypW/HNFP9L7U07SgwN5elA52cR6W+B739j+VYuD5XmEerjjM5NZEIxNFc4fnYmNdsl6BOg6hZqGzW/PmYaLyQwirXZ1j2QbB03IS75602tPwpll4tPwTuaYLv4xu+qNSzIR8l32yQVAjja9tjBXbk189utPPoRHjrC/wJHSG9JjRk6dYBCob4fywJnuOdL0XPYxl9klOZLB+YG56Tzm5T915iC7nWyOzzoVSQ9daIpDfYl+J1r2wIp96tasBDQO4D0l7VgFX+OuuqqbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSet5FsN9a7rqQOjtKaTcm7URg9879iRjiEvcsEBZn0=;
 b=j+gckeOX+1CI8P9BLfDNW4ha+SjABeObtwditdyIp0wnGBzQB9LV0TX8jhQPPDKH9Gp+1nBnHZpv415D4/wIqSPf9HHqaNk8ZvDHfSAVi/VTNUeFQxj1pgyzNDZJPJa+RrrvUrBO+OTRMzhLPvw4dfLElaANA3yHaUFXgFSro7d8EUF7DFW/qPR9nCNNBhDwBSdmdF7CUyupy5yHl2V/PrQYK/0d46YPV0mTsN8bxR6tMEm3QHaJd/3MMoBl9VjbjIXqSnyXPywKDq6xZ8YHpY1CWz+9kc9DC9C/9+TX6S809e+5drWlaslxaSmIjABI/fNF3OWwYWm2w6sdsnConQ==
Received: from DM5PR12CA0063.namprd12.prod.outlook.com (2603:10b6:3:103::25)
 by SJ0PR04MB7728.namprd04.prod.outlook.com (2603:10b6:a03:32d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 04:47:42 +0000
Received: from DM6NAM10FT031.eop-nam10.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::3d) by DM5PR12CA0063.outlook.office365.com
 (2603:10b6:3:103::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Fri, 11 Feb 2022 04:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT031.mail.protection.outlook.com (10.13.152.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 04:47:41 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge3.garmin.com (10.60.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Feb 2022 22:47:39 -0600
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 22:47:41 -0600
Message-ID: <d12b130d-4c79-25bd-36fc-3566bee37173@garmin.com>
Date:   Thu, 10 Feb 2022 22:47:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
To:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
In-Reply-To: <20220126211224.28590-1-Shelby.Heffron@garmin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cv1wpa-exmb1.ad.garmin.com (10.5.144.71) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 365e1abd-8639-4745-02e8-08d9ed19a33f
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7728:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR04MB77285057BBA2A7B3E4D6ED1BF2309@SJ0PR04MB7728.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vICiSK89bAqM1Cm0JY3+RuUtwQYfQ7MRma/1MikZmIJGAsxUham7ipGbVJ5DJ/jSu5+L2S+8b4rAtF/7TLI95eSDo9REYQzot+1KxLzMjTHjEu0X1DYY2QSeRGh3IuW4ESs+7Wv6ifzijKrV0P7aYn5rKiXTKkPFNVz1T8lNsZCq2Dr99ip5HkTq6y383VJPgN/hhhYYCUuXX4Ae/0ucIlgFWzQr/jzIeYPiKkGO4w7Cb9sFu1Xm5dSP7IyC+KwELoxH01gu/CUtoFVRsuzR1t3Hc6bn26/9O3GbLDW998l4L4rSqBLquGIL8hvJNzMOVAVtcBZ7w7dF9v/J6lyup3/vulzVM6B6rlFovUw9dFblKq0D6uCLaLvC6kbe8E8uxW5TkUQlT+JkyXNYag36aqfitA/TfB6GJ4m/Edx2bs/gsHh83c3ohBZOTUuGYHz1edLoO16PhslbVmzJ0wyeD7vtSu5cCLN1JKIdwlgQlNT9y+tsWnb/ZpFNO5pE9jra9r5cFx8AZxd0KOgDYsY/L7jc1thY7ulY/newERSewRIm0K2bRQyax5ZjbMwaLgcVXp/AbbZVAt9R3nYGycxBFssM1iEKljR3KAf61BGE51c48u8XakmhB+eZVejBuAuOk8UubfUJN/nmEgIoHEemZfwzoZQfauZg3v4XuI0r5EHDN7ZLknwYFH9ESqV4/be2/la4VesjnfqnroldgdbaIw==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(40470700004)(46966006)(36840700001)(36860700001)(7636003)(36756003)(40460700003)(82310400004)(31696002)(86362001)(356005)(53546011)(8936002)(8676002)(508600001)(70206006)(70586007)(31686004)(336012)(47076005)(66574015)(16576012)(110136005)(426003)(2616005)(5660300002)(316002)(186003)(26005)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 04:47:41.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365e1abd-8639-4745-02e8-08d9ed19a33f
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT031.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7728
X-Proofpoint-GUID: 5GE86Ttilc0KpH3rAio-lzSbYlVaE_Cn
X-Proofpoint-ORIG-GUID: 5GE86Ttilc0KpH3rAio-lzSbYlVaE_Cn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_01,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=943
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110024
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On 1/26/2022 3:12 PM, Shelby Heffron wrote:
> Add keycodes that are used by marine navigation devices
> 
> Signed-off-by: Shelby Heffron <Shelby.Heffron@garmin.com>
> ---
>   include/uapi/linux/input-event-codes.h | 28 ++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 225ec87d4f22..26b6a2f482ab 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -660,6 +660,34 @@
>   /* Select an area of screen to be copied */
>   #define KEY_SELECTIVE_SCREENSHOT	0x27a
>   
> +/* Toggle the focus in or out */
> +#define KEY_FOCUS_TOGGLE		0x27b
> +
> +/* Move between highlightable items */
> +#define KEY_NEXT_HIGHLIGHT		0x27c
> +#define KEY_PREVIOUS_HIGHLIGHT		0x27d
> +
> +/* Toggle Autopilot enagement */
> +#define KEY_AUTOPILOT_ENGAGE_TOGGLE	0x27e
> +
> +/* Navigate Displays */
> +#define KEY_NEXT_DISPLAY		0x27f
> +#define KEY_PREVIOUS_DISPLAY		0x280
> +
> +/* Shortcut Keys */
> +#define KEY_MARK_WAYPOINT		0x281
> +#define KEY_SOS			0x282
> +#define KEY_NAV_CHART			0x283
> +#define KEY_FISHING_CHART		0x284
> +#define KEY_SINGLE_RANGE_RADAR		0x285
> +#define KEY_DUAL_RANGE_RADAR		0x286
> +#define KEY_RADAR_OVERLAY		0x287
> +#define KEY_TRADITIONAL_SONAR		0x288
> +#define KEY_CLEARVU_SONAR		0x289
> +#define KEY_SIDEVU_SONAR		0x28a
> +#define KEY_NAV_INFO			0x28b
> +#define KEY_BRIGHTNESS_MENU		0x28c

I am looking for some guidance on if this is the proper place for these 
keys to be defined? If not, or if they are too specific, do I have any 
other options?

Thanks.
Shelby

> +
>   /*
>    * Some keyboards have keys which do not have a defined meaning, these keys
>    * are intended to be programmed / bound to macros by the user. For most

