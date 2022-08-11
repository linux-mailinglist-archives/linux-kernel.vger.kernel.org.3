Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFB58F89D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiHKHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiHKHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:52:51 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8498E9BB;
        Thu, 11 Aug 2022 00:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LORfbn55JRakKvyDUc4QdryH6pALXHJESZ54Q5PHA9srdq9MbLl3c49YQLkCllVPFgKtyoz3/jN+rXJPyAaqVgMB8d6IFSE3DyoXG81ktTkZP2yWsh8B4dcyBOR2ia0IhuCZHaATDzEf0WtyRLkYw4zIvDfaEyWqI6/KAtJ2GsfVyY0z7hVtGU2kDqzCmi90oc1+vOMIDpwjaOPCeYD0GTTwsMQCu/U2CrRRhNDOgd7D4A0TqegWlqowR9Eps2l07mQukXjO1he6yWxoWMpiPWVZTABQBDhMe1qmeKfANLH/88CMZR5eLk3ziAsTiAl41lxhCjJmqnxtqjf8G7fYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJOq8vAlwaWuC5eTAXIUnrcxkX5tkISkw8D2m+ELZF8=;
 b=EsTtAtyLUZ4gPp7Cu82PRsrvJ4twmlm9+7rYI0ZE2c9/rxpJp32xX7ynmYqfG3dk8OHN8BsB8xaTqxZBpfX4INOe0s3f2PO5K98YVyCRMMXfPTE23M6V7jQqMvGMxNCLSnBDto50QW2Pm6yQJnroUK1pQwjfOvE33C7oxcIriafvWUvUR4Npt4SgI2tkX/pze6nE0Gf1dCqJ5AZ8yHRXYq3Y/qlE9G0Y22POwehusr1kW0JgDUHNb7AQgnJozKechJiZprFaiItnER/jaQfXGzDOOe4V1kkPbvriHLPALV+8XaCJeohGpnMtuj7GTi9RTZMI5fUofzuOEp6XY9meWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJOq8vAlwaWuC5eTAXIUnrcxkX5tkISkw8D2m+ELZF8=;
 b=HnkNxHhH5k3mR2p7wL2xjobOA4Dw3OV+YiGg9BBrR6720sK/vjy05Gvqz9ugzQeptmsMkshyQeyZoCvRfSqAjlD4P+xxa0okX3+rRvQtax8vL5i2BJz6jp2ftVAVA1YOOrzRHENdohUwnLEEwaJhYiw/jNte+7zxzzxvC794Ocw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by HE1PR0802MB2300.eurprd08.prod.outlook.com
 (2603:10a6:3:c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 07:52:43 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 07:52:43 +0000
Message-ID: <9b965d86-9b76-77a1-658e-3675c2138414@wolfvision.net>
Date:   Thu, 11 Aug 2022 09:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/1] pinctrl: rockchip: add support for per-pinmux
 io-domain dependency
Content-Language: en-US
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20220802095252.2486591-1-foss+kernel@0leil.net>
 <20220802095252.2486591-2-foss+kernel@0leil.net>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20220802095252.2486591-2-foss+kernel@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0025.eurprd05.prod.outlook.com
 (2603:10a6:803:1::38) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f36ffa8-4217-418d-ec9f-08da7b6e7900
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbk67MUqzKlNVHu5HvKffZclq1dSwAMIBh9wpumXw+DWk1ff9iwbpS20yKQzWgjYpPo6MZhl1tWkSwo/zBMwMW/UzX3Jdo6bZvj1Acw63dRC7ebP80jU342MxTxsbCkrlViSeuEMIHBEA8BoIO+a71Fs3oCDcCkZILbKXHNPNciz8ED2mXHXvJfEz+5WnHvilKrnOcqAnZa86v7YRP2oAXw38KHvyepsEgAVcLa6Br5GStAMmpqPJQvuTpZZ31sLAWs0Ra7E9aj3YBqKFv64ucRJI6WqRsc/ibzTfZSO0nvLObXQ8rrNV2zWOlyuj4IKkvDZ7QcxogUZ0Sr5xDEX6taN2Frvc3kIuLuY5XJPdB2hC2VN/0aAEyQ1u93Y+fXkug0G21opuY0c/fb3oGS1xcaFOwsbQQLlNrXqIyRxci0K8K8uWxKxmLKDkeIIMcOAO87fweyVhfsGJNIPudejbi0GLaHMtYeCFEYrDjNLYe2yheRT4ZuU68CJTWYA7VszXaKGZwwQWeXFTnAN4Adfz0qApRZz7oJQFOXim/VVvmFGqhx6n3uhoNAxq8nBgsT2aIfznJbbn4i9Tc7BHSF0YJ6XOUUJJpqqT83MT8WD+o20eTvo4wlay23zyXT0+ZQlZ5lSfsDt/gAQe9SiCWZF2EYgIRxcSVuey2cnL2Gi4rc3m8hB/VKB/vOvX5LCX9gICQ+69mR3830brEp6PWFP0fYX4LTg0OBLPyojuh0fFcvSLQi509hh0FiChxXy1q9SWctrZqJlY0idaE4kMCGQZTmQynjDrvEZ14jIFneZbTmpTlpNz+XOlJXF9e4JxlD+J6CJNn5ShYBIzJOVm9YsdqKKLbpcbPyzbG005OuLHwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(44832011)(186003)(41300700001)(2906002)(478600001)(5660300002)(8936002)(2616005)(31696002)(86362001)(53546011)(52116002)(6506007)(36916002)(26005)(6512007)(38350700002)(38100700002)(83380400001)(31686004)(36756003)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRwSEdRb3Y1OWFoS3drMUpnNzcwaW5aSkQwVHFNNk9qeWw3TEVZTnBiZk10?=
 =?utf-8?B?Yy9lYWJTblB0azY3cjdTK2dRbmpYU25PMy8rZFB2aEcwMDNKN0d3Q2JGRVp6?=
 =?utf-8?B?Zk1CMEw3WG5SeC8rTzEwZlp0UEZUR2pxSkF3aUhjMUgvV015SDZYNDI5YmY2?=
 =?utf-8?B?OTJWa0ZjOStTSXlreGQvMlo3QnZGWkZ1a1NZNzNFOXJYTmk1T3pDSGJnRHNO?=
 =?utf-8?B?VTBZK0ZaMDBaZEIvRHA2ODI2Wmk1cWwwZWJJeW8rVE83Sk5qOElnc2NhRnZj?=
 =?utf-8?B?QzJBOGFpSDh5U2RTcFlJTUZPNkU2WXBWeXJLKzJGZTAwVHE3NFQvS0RjMEdo?=
 =?utf-8?B?WFVrWE8yclpwTG9BVGdpWDMzNXh4eFhvVDV0U3R2K3F5VGRTNDdEQVZQYm45?=
 =?utf-8?B?bEtWM0Z6Um5hWXBSbVdjTllLM25YV0dLWnlXblg5cm12OVhRVFpnOEN5SThl?=
 =?utf-8?B?aXYraVdmZVpKNnRrb2g1SkFIemZ2c01qV0F0a0R4aFh6eDF2VW9MM205ckNV?=
 =?utf-8?B?M1pkd2xLL1BIRXV3RC9PS0VCOG5aTXBLVng0eUpHOUxvem9NN0Q5NTBEaDR5?=
 =?utf-8?B?U1g2RVA1cE1Xa09nS1pybWh3SXJVSHFEUlZnbkpMLzZldUpGZU9VYWJjZXQw?=
 =?utf-8?B?OFJEV0xvU2I3bGYydnBKRjZFaUtLOHVhWloxZ0wrUzZtQ3RFTlhvWFcxR3Rq?=
 =?utf-8?B?c05BbC9hQVdoUHpLL1dQUG5YQktqbkxXWXFCOCtSMXdOVTRBZXE5Z3B2Mzgw?=
 =?utf-8?B?OHdnRkRNV3BTSm9VZnI1Sy92U3p5cG04TExHQkNLclNDUlZnbTVIRkNRRDVP?=
 =?utf-8?B?RU1HYXVCRkxhTmJrY3JOZkZpZFp1NG1ES1I5WGVTQ3dDTVRqeFY1dVJ4dkJU?=
 =?utf-8?B?aS9FWUZwdUZmTlJiQ2xCU3lGZVhzRWFMWVBYcUpUazV5R0FNYnpBSE5YMnBQ?=
 =?utf-8?B?VTB2T0FENHI3MTBadTRESHJXRHcwUUxzSlhuanJadW1yc0Jjd0dsRWZZOGdC?=
 =?utf-8?B?TDVDQmtYS3o4YTY1MHV1L3V1S0lCUUNLcGVZSTZpcXVPeEZTQVF4eGVadEJy?=
 =?utf-8?B?MUttREw4WFYrMCtlcXBXSDZqL1FnN0FGM2FYajB0VzFkMzhYaUJtQS9iNDNK?=
 =?utf-8?B?cmdkOUxYY3BKYXhieFpUbFQ1aW8vdHVObXBsd3QzM3Q2cXpWRmo4M3RSTkEx?=
 =?utf-8?B?enpKQlM1c0pPT09ERmZFTDdvRmp1NnlySDBYV0x4S1NkdkJYNGxuS05aOENr?=
 =?utf-8?B?OHJGQWh0SDE4UFVEMjF3aFdSTVpUemwyb1FTTTJxSVF6ZTkyWVREaXVSblMv?=
 =?utf-8?B?Vk9DTzF6TTVzZVFTd0cwQzVXN1VXb1lZOVhDSFlxM0dFdUp5UzVBOFdPcW01?=
 =?utf-8?B?Wm04c2R0ekRQNmNPeWY3MmMyZTZ6ODh3bGNxTzVOQUdIb0JCdVZaa0Nvc1hK?=
 =?utf-8?B?bHlyL0J5THhRcjg4L2lZZ0NQejgrU3ZpMklIZmdISzFGdVlGeHhISE0wcTlU?=
 =?utf-8?B?R3RHODZJdXV4MFFkc0N4UExFQ3F6VHhDRlN0QldidW8yYVR4QXlRWllKNFUv?=
 =?utf-8?B?cFhGRGhKcEg3azlNand2d2VhM1FUaHYrUXVrNlFNOUFCRlZYcDVzOE9Gckpn?=
 =?utf-8?B?Z1BLeXlFUXBPQ2ZmM09JQW9TblE5SVBYcnE4YUNKVWs0cmxDU2IyRE1sNFdk?=
 =?utf-8?B?N2F4Wmh3VmZ2YklkNlpKY280V0oxY0k4S1NXMllTZmhGV0pSeE52OWs0KzJ4?=
 =?utf-8?B?NDl6QWY4dEd3WW9HT3V2b2U1TkFHdWZVRktKSlRGL0VZb081UWVNSk8wUHdP?=
 =?utf-8?B?b3U0NjBmNFVKaXRHZS9rcEVnMWpVMnp2Y21HQlJMM0FWQnIyNm9naDBITmxl?=
 =?utf-8?B?MWpTQ2U1bFZxYlRKdFhEd3FFVFpkYThpZnpvc2JHTEp1V0FmdThMRUVQdUxx?=
 =?utf-8?B?d0M5SXlrTS9KL1VlZXRkbFRiK3VCUzhnODZmcTc1WklFeWk4QTl6M0tKR21H?=
 =?utf-8?B?anlha2RaMHZsV1pxdVgwNUYwRjAwQ0ZDMWtCOTZvOFIrbUtwNUVTTlZvUkdX?=
 =?utf-8?B?ZVlwNWs3ZlBzWG13VmNMczFNaW5rNXAwZVNvWFVnU2xwTEpnQ1k5aUdSb1dF?=
 =?utf-8?B?SmN3N0UrWTg0djhEbzNKb0NOMjU2bDlwNEY0bHFEZzJDWlZBT1B1b0E0VDlJ?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f36ffa8-4217-418d-ec9f-08da7b6e7900
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 07:52:43.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aal4FqnOT92Jw5z1r8Mgk8wiJGu5dbL337W3aVq2604MRevzrOMp6yNtnwbvDAdiRpwKShoJWlaQOvStLraCEFEzGldnK9KHCwn6s4Qu78w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

Thank you for your efforts! This will solve several issues that are
bound to pop up if a board deviates from the Rockchip reference design.
It seems this does not happen very often, though, which would explain
the lack of responses to your initial query... :-/

A few comments inline:

On 8/2/22 11:52, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> On some Rockchip SoCs, some SoC pins are split in what are called IO
> domains.
> 
> An IO domain is supplied power externally, by regulators from a PMIC for
> example. This external power supply is then used by the IO domain as
> "supply" for the IO pins if they are outputs.
> 
> Each IO domain can configure which voltage the IO pins will be operating
> on (1.8V or 3.3V).

Just for the sake of completeness: 2.5V is possibly as well (at least on
RK356x), right?

> There already exists an IO domain driver for Rockchip SoCs[1]. This
> driver allows to explicit the relationship between the external power

...allows to model explicitly...?

> supplies and IO domains[2]. This makes sure the regulators are enabled
> by the Linux kernel so the IO domains are supplied with power and
> correctly configured as per the supplied voltage.
> This driver is a regulator consumer and does not offer any other
> interface for device dependency.
> 
> However, IO pins belonging to an IO domain need to have this IO domain
> correctly configured before they are being used otherwise they do not
> operate correctly (in our case, a pin configured as output clock was
> oscillating between 0 and 150mV instead of the expected 1V8).
> 
> In order to make this dependency transparent to the consumer of those
> pins and not add Rockchip-specific code to third party drivers (a camera
> driver in our case), it is hooked into the pinctrl driver which is
> Rockchip-specific obviously.

This approach seems reasonable. But just for my understanding: Does this
mean we need to edit e.g. rk3568-pinctrl.dtsi, iterate over all entries,
and add rockchip,iodomains = <&corresponding_io_domain>;?

If not, at which place are the rockchip,iodomains properties inserted?

> [1] drivers/soc/rockchip/io-domain.c
> [2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 19 +++++++++++++++++++
>  drivers/pinctrl/pinctrl-rockchip.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 32e41395fc76..c3c2801237b5 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -24,6 +24,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -2370,6 +2372,12 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
>  	dev_dbg(dev, "enable function %s group %s\n",
>  		info->functions[selector].name, info->groups[group].name);
>  
> +	if (info->groups[group].io_domain &&
> +	    !platform_get_drvdata(info->groups[group].io_domain)) {
> +		dev_err(info->dev, "IO domain device is required but not probed yet, deferring...");

Probably this has been left in there for debugging, but should be
removed to avoid spamming dmesg. IIUC this condition could occur several
times.

> +		return -EPROBE_DEFER;
> +	}
> +
>  	/*
>  	 * for each pin in the pin group selected, program the corresponding
>  	 * pin function number in the config register.
> @@ -2663,6 +2671,7 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
>  {
>  	struct device *dev = info->dev;
>  	struct rockchip_pin_bank *bank;
> +	struct device_node *node;
>  	int size;
>  	const __be32 *list;
>  	int num;
> @@ -2684,6 +2693,16 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
>  	if (!size || size % 4)
>  		return dev_err_probe(dev, -EINVAL, "wrong pins number or pins and configs should be by 4\n");
>  
> +	node = of_parse_phandle(np, "rockchip,io-domains", 0);
> +	if (node) {
> +		grp->io_domain = of_find_device_by_node(node);
> +		of_node_put(node);
> +		if (!grp->io_domain) {
> +			dev_err(info->dev, "couldn't find IO domain device\n");
> +			return -ENODEV;

Again just for my understanding: The property is optional in order to
provide compatibility with older device trees, right?

> +		}
> +	}
> +
>  	grp->npins = size / 4;
>  
>  	grp->pins = devm_kcalloc(dev, grp->npins, sizeof(*grp->pins), GFP_KERNEL);
> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
> index ec46f8815ac9..56bc008eb7df 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/pinctrl-rockchip.h
> @@ -434,6 +434,7 @@ struct rockchip_pin_group {
>  	unsigned int			npins;
>  	unsigned int			*pins;
>  	struct rockchip_pin_config	*data;
> +	struct platform_device		*io_domain;
>  };
>  
>  /**

Looking forward to the v1 of this series, which I'd be happy to test.

Best regards,
Michael
