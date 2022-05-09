Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3051F5E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiEIHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiEIHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:40:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C74A1461;
        Mon,  9 May 2022 00:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntMR60SvsoJLKcTAyc54LvAUEa5B3qw7DjcMfaEhwwsbpw9vG+F8ejYm0eMdRDgGx0ZFlB7grBxnueXNV6MEzyZpB+WcCZwAmI6zEdcTd51i7tmfzsWYTkZRnLoxayd4UH4o0ChxHGlNwtygoUAPr/hf8SLweqA8WsYU0QkgC60yPkxd/o8YQJfaP/6U4QfkMBYd2qFaLIxp+8+XPUU8kmL6GqWs0srawzTZ3h2qpMpwLT77OyhR6PnGfVw6iWrQqgtFRgrmC78qImbrAt4DilvQTw38jUeZCX64PJp5Cmx40AwLxpYBv+8FJLaYQbRtUUOqPuCTk8pjOtZDN6M6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvqJ02TnpENRUTIsplNLQCWRqp3jILwdvV62G90TeRo=;
 b=iNkSzLH6H04PDdvaW+m1aCqG7EUuaiOnZnmChmgp7jJcbTBy6LN6R0tVvxF8GF+fxP8n5BXwg9PpFMVdUxKPe6Z31ZC/hsONXkEbTxC3IR2FFlr8kJVqQN0drMnK2dt2zPeloFHg16gvihkJ76OjH6S0pdy2cw+5aWeBgRnLk4Ei8KK+s74ranB3SrK7xGHqP7kb8ZfGT0CfwKilQtTIqjIotlBTXda6hH61Rx3PlKw4wosFoq5Xsqete8eFR1spyJ9OR8+29jRBCQAtwicBjctQSql6Y1mJeYEc02IWAHMPzJUVuuSoIl1fBYf6iDs5Uuo8Fa75ZdhCp6FYH1LQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvqJ02TnpENRUTIsplNLQCWRqp3jILwdvV62G90TeRo=;
 b=XbWMuxiaIdpRdCxjTnAHh+Mfy0lqLdcs83sO99xH7/de0QvlwLvNC5b2daaQ8Q2WZFz7LWpTjh8quwdRQN29QQ6JL6Bcb1uNgL+uKdKJ9WOm2m0JiJjslukIzIs9hgDkfGYCSnBLxj4jP837yxVOTjsFsyW6byB+FrXTK21b6XQ=
Received: from DM6PR04CA0006.namprd04.prod.outlook.com (2603:10b6:5:334::11)
 by BY5PR02MB6082.namprd02.prod.outlook.com (2603:10b6:a03:1fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 07:35:01 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::4b) by DM6PR04CA0006.outlook.office365.com
 (2603:10b6:5:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 9 May 2022 07:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 07:35:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 9 May 2022 00:35:00 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 9 May 2022 00:35:00 -0700
Envelope-to: cgel.zte@gmail.com,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 lv.ruyi@zte.com.cn,
 zealci@zte.com.cn
Received: from [10.254.241.50] (port=37252)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nnxv2-000Dyx-11; Mon, 09 May 2022 00:35:00 -0700
Message-ID: <c19cce8d-ca99-4993-435d-1a4e53543713@xilinx.com>
Date:   Mon, 9 May 2022 09:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iio: adc: fix return error variable
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC:     <anand.ashok.dumbre@xilinx.com>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220509072405.1118019-1-lv.ruyi@zte.com.cn>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220509072405.1118019-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5258545a-1ca4-4769-fdf5-08da318e6d05
X-MS-TrafficTypeDiagnostic: BY5PR02MB6082:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB608274A308DB13E3406CADE9C6C69@BY5PR02MB6082.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eErOMalYHkTq9dS4ox707RxnQhXZ+1yS5buprsdu3kh0EG7oM+br1X9J139fQUkuxQI7je3GvX8qnRxpJ9avK1VPUxnbDrTzQ0liTf+LibApF5UrWJbUeXfaOIUs4QyFjwt1xPIBstT97/9Gevp6U+sESn78ehwWyuKYX5IZyINrg/6TrJUzO9cYYwLLGDii/1z5txiIlsM2AXrOKkJMM4vfbX8LttvMxea6foYkRP3C8bKR3neQRr/9D7kJ4wZDQqMn/Yfa+mSmGfWSR2ZBewj8YphhpbCpkX93ixOu0jffDvQEaQb9Ysw3pIrq8gwjf+E/qKzuYfc6YGRW594ka9c6bcWRWD4oMQVDg1QxN7IiRJJWAb/YRi5GRyvOy4Ws1NrIpwpHEDMP6ofdVy+1T0ey52KO1Oi47Db7LyNksw17tT4LfQKyk4KuCahD0p5fBtweyv1cfT8TbI9tx0d4BAi00dRDU4S90Ig8rjAu1H7IuC9goUrHfoeODiAawticFHn8yF7D/i5ZpszEGcDFOn8wc3lPYruV6rariHNEOwWQU0RcpCNt5VpBZkB4vLyqtbF74APOy0BLRum0ng0cgofsvUtalsE0kQyD/7SUeqot01yF9iPii7ET0LXhUZ/KxV+jhHBorcObcaCM/lLpvEptpYjH289B/K9oLgJ74BkfraIfOz034kX+33z54EZ7oW2tyL3JQHPD7k117cPhYxvv2jEXHVUf9/XnDeYJV1I=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(44832011)(36756003)(356005)(7636003)(31696002)(2616005)(4744005)(83380400001)(8936002)(53546011)(110136005)(9786002)(70586007)(70206006)(54906003)(4326008)(8676002)(31686004)(336012)(36860700001)(26005)(426003)(40460700003)(47076005)(508600001)(2906002)(5660300002)(6666004)(186003)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:35:00.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5258545a-1ca4-4769-fdf5-08da318e6d05
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6082
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/22 09:24, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Return irq instead of ret which always equals to zero here.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>   drivers/iio/adc/xilinx-ams.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index a55396c1f8b2..a7687706012d 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1409,7 +1409,7 @@ static int ams_probe(struct platform_device *pdev)
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
> -		return ret;
> +		return irq;
>   
>   	ret = devm_request_irq(&pdev->dev, irq, &ams_irq, 0, "ams-irq",
>   			       indio_dev);

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
