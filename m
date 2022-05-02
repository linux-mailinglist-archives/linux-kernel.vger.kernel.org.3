Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E0516B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383551AbiEBHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbiEBHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:30:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C54183AD;
        Mon,  2 May 2022 00:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWQA53BYKzORJHn9zZjPss6k9ayTv1+xadKc0IqW2i2dyMILVNTCECpOB1V/lMZiV49mOP36O9jioEupdKr6u+ba9kMBOjLKYGAhoahlJotBY/5kUxaVQMzMdt/ld2FPuz+BHRVd+FYe2VQA2rHwPNjpTrge7/fp8ott4A8meIpLusIIw5kiaH0G70L5o9WJctZyVFSd8tI3kT+nLuVfR/eT8FcY7tHgUPYapl8EcMKDFNYM1146d+zSSBGi5SAYM4tlmWrOpKrTvT5sZvrWJ4g7wxYhcnp5ZWAuCe6YBf10bDE/5MWzYkn03D5+z2Ui5LKG+hYTrDe+8Ct0qDjvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rg7W7bsQNHPZKdugTh3aA1iK/3x27X4FW84LJLO5Bw=;
 b=Ce2o+Oo5n2fY78GJ9AIPTY1/6axSqChCPZqG6WLT+YKLc/RV5y2wsJbwUc8hWlj15FyrIGuxd5kPgDWMEfOxJnTTYFrjOPjMXoLNgsZyumAWCmMhg+oFUcduszRUsrjHU0Ct2YzEJ+Znekygdi0R/8LDHuhhg632dIOCuknsRnrHjzfACXkvirWp6Zouw8aGeUCYijXL3Yra8ckyyCIlAmyJj1+cUGw2hVCijz5Vl+Nc93yAqX5eqHLD1dDVfID5z7irQGsBDNBO44ekrbvZ6H+4A6S4XEZX6yNmM0G8li/zkQOfIaMDzS8lhzhXkxmkaJkb1o3KN4CfllN8ZMtm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rg7W7bsQNHPZKdugTh3aA1iK/3x27X4FW84LJLO5Bw=;
 b=caxbv3Q66XlZ51MAOnu7zJaBnwDbv3hbOJLOjyMMNMmC8tx3DRwsXfj4k5twTVn+biqHyLZSe5mFhafAxVRZlwqHmQi6L7/MVuZ5nwwzOvzPGcfAQMb7MRvnqZxJYKj4O8RznxjXEcfugxun1zzwetF17NWVCuZLOZWE3DxLCD8=
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:5:1f4::15)
 by SN6PR02MB5181.namprd02.prod.outlook.com (2603:10b6:805:6d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 2 May
 2022 07:27:23 +0000
Received: from DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::14) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 07:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT060.mail.protection.outlook.com (10.13.4.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 07:27:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 2 May 2022 00:27:22 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 2 May 2022 00:27:22 -0700
Envelope-to: krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 alim.akhtar@samsung.com,
 dinguyen@kernel.org,
 liviu.dudau@arm.com,
 sudeep.holla@arm.com,
 lorenzo.pieralisi@arm.com,
 rjui@broadcom.com,
 sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.254.241.50] (port=36628)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nlQSo-0000yY-8I; Mon, 02 May 2022 00:27:22 -0700
Message-ID: <a838f962-354c-9dcf-c0dc-80d1a6cd4fc3@xilinx.com>
Date:   Mon, 2 May 2022 09:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/9] ARM: dts: zynq-7000: drop useless
 'dma-channels/requests' properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh@kernel.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org>
 <20220430121902.59895-2-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220430121902.59895-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 200947ca-c3f3-4b1c-eeec-08da2c0d3338
X-MS-TrafficTypeDiagnostic: SN6PR02MB5181:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB518132450ECB5457FC1AEE84C6C19@SN6PR02MB5181.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pod1WCZFMImzYC3FhWzIjxO3tJN1O93LT+7ftk5GB/PCEmXbZUB1hoqiNvb0Bz9BwOA9nC6ScPQJAKnpJGoDa0B8gpea1w8PeJi6zyNZSn3WazrC8tV+V8GlCSsRpLTZqSKFJ+7Bki17jVtcYz7SUB8jmJcwxrph0XsY3OtMS3zf/DFRQE7XtV1CuCA7UpdArB6y8srNkq00ephXqUHsQY5w64kdIRgDWrs5vTNb5oRRD966GzhG+csnMuB8EVXTrc7gidKqYw2Gx7pkN4Cp9ZIBcBgpyd/EZmDIsH8EwK9Vw+UaP+TBr+xT9H5QzNLJ404mTnUzV+eSSdLmP9AHPZuITaCDbAVmbun8fclb+ly8nQwFRj80IIQldqdOqDJ3VwbJoCL9od5/doB/L+0ZVck9kHpFI0TNkgTrOW22LUJNZ3m8idk1/vldMojbDEwW37ol1PIEDohFC29iijWEQqGtKTnDZB3esJFeRrR60q4t81rRoQOZ/LUGSIFP008az407ZFLI2vYV52PfsA27EaUMpgP4fEF35aCKT1e7R1V51A/2cAhh2TkXC6yWCMJTTiG0RObJ/mz61bmkp88hktubROATezJZmfEfPiKqRkG87DA2CiuPJeCVdFl4rUjJ6IkrVA/ReP1npejXdHe0hML9gJI94lXyg52wduypPlsktvhKmjJiGvmEs4Dktt6xKEnBULuN2ErMQEC0Q6QxxBDxI32eUomLPM5CQajXHt2HeELNWAT44AGPVLb+/t9yao3Iv0yinhOV5r5f55ZVryw+XXQux7NRYEj3LIoxbXY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(508600001)(9786002)(83380400001)(7416002)(5660300002)(82310400005)(110136005)(186003)(70206006)(44832011)(70586007)(8676002)(36756003)(4326008)(36860700001)(31686004)(26005)(6666004)(7636003)(316002)(2906002)(40460700003)(921005)(356005)(47076005)(426003)(336012)(2616005)(31696002)(53546011)(50156003)(43740500002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 07:27:23.1131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200947ca-c3f3-4b1c-eeec-08da2c0d3338
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5181
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/22 14:18, Krzysztof Kozlowski wrote:
> The pl330 DMA controller provides number of DMA channels and requests
> through its registers, so duplicating this information (with a chance of
> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
> property names which causes DT schema check failures - the bindings
> documented 'dma-channels' and 'dma-requests' properties without leading
> hash sign.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not adding acquired review tag because of significant change.
> ---
>   arch/arm/boot/dts/zynq-7000.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 47c2a4b14c06..c193264a86ff 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -343,8 +343,6 @@ dmac_s: dmac@f8003000 {
>   			             <0 40 4>, <0 41 4>,
>   			             <0 42 4>, <0 43 4>;
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <4>;
>   			clocks = <&clkc 27>;
>   			clock-names = "apb_pclk";
>   		};

Acked-by: Michal Simek <michal.simek@amd.com>

If you can take it via your tree that would be great (easier for me than sending 
pull request with just one patch) but I can also take it.

Thanks,
Michal
