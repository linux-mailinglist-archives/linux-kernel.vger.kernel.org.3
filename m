Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3134658F979
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiHKIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiHKIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:45:14 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F626D0;
        Thu, 11 Aug 2022 01:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc0RFPaH2Lf0VeKii6vxW4C9TujGbEsSiI6KtH//le13h6oBJNa2ZV80DT8wTmoSL5gwzynaNn/N7dlnBJ0eMKdCqPQLjv85/Q7mArxwlMpqn0dR3e/b/aasPOOTQtfb07ICFdjpMdNWLwd9+bnzdrwvQNj12DvnD0YgSJicH1Eo2tiaWet3Ac5UcwI7ihuN1jIio/YgBsAa8l41m/OPFUOfGSwZdsqhJ5q4rrsI4GUr0YV1ROlHmNyr7VzNMzr0WGRVpYMXXpCBwYXP4Q/9F9kPNGrEVX/pxZG1/iEyRZa95id3yPEbx4SbjxKYBxjnXqUUab+NvSmM+8FcmBCHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCJSHpf8EtC/tN2OmufmxkafghEywjhfeUwNX7t0JhY=;
 b=QLF77OOSUi/XwEL1MR/6Co//eKFvLK6PLxkvGWkLovGGwItDxvsOAtIMEQ1hrSxO25vaVwhqFB35jRbZ8jfRIF0gSntNBziTsiDh/ptac/KTDeKRyuqpDdr0Tds5YZl2oNIxEMQ+NwdGCyckbmDIQxZoH/nNKm6UzK/xNWvu0Uso+Q9vMp8C2NUYN9MKNN4/kMPHhxZLcExOJ36SfOLBZWTNDIz4AqVOuYNs6KKp4wSJ+kT/sNI6ypZ21dp0NnPqR7VH2ub/bNsHXsreReJJIyoWLVMdPMePpT8KxK8trFF8tZrJqr2kCuxm4bnqDD7qVL86sn4M+pRlXD5P6f88sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJSHpf8EtC/tN2OmufmxkafghEywjhfeUwNX7t0JhY=;
 b=VZz4md2zOnLErB/HOZYBeAutQqEfwWRMjJvoqW36SO1u6d9fSCF5uu8QTqMAkfg3LeU1KrUMOh3VVFnivEcefGVYShP55IObNTxzzAn6tsbn8WDw3hD0E7ySeoC0WKBLZIF4hC0l3AEQq+bBGzEZ+Yx1YmJeUQ/88mnz+IYLb3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VI1PR0402MB3424.eurprd04.prod.outlook.com (2603:10a6:803:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 08:45:09 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::81a8:1bbf:5e16:9b4e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::81a8:1bbf:5e16:9b4e%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 08:45:08 +0000
Message-ID: <7353767b-0c38-a5a1-d3ac-3d9151140fb8@theobroma-systems.com>
Date:   Thu, 11 Aug 2022 10:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 1/1] pinctrl: rockchip: add support for per-pinmux
 io-domain dependency
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220802095252.2486591-1-foss+kernel@0leil.net>
 <20220802095252.2486591-2-foss+kernel@0leil.net>
 <9b965d86-9b76-77a1-658e-3675c2138414@wolfvision.net>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <9b965d86-9b76-77a1-658e-3675c2138414@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7819982d-5144-4f5a-7ba1-08da7b75cbd2
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3424:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6X1lb+B5Vs4fIJaFQNj1Dbc7smQdC3Hv07WzjgFRm0QtejepLQM5oA99tUnVpxjI0fKzb8PvBCkwGffmQ5ythjLvtTa+VG8l6kjhhDXQ4yv25l+KNmuytyRmZ8qgI1YkzmHco9d5CXA+6PZ3o5Ibvs3F4/77ZIi7yNn+hwkkjypVCoSeC9oxJoL1p3SOr/DKQ77DeI0v8yYR/X779dov0sZ07E1MOO/nYjygkkXL/T+NuJcmkV3+/rU74pwYYWfBfq1IHZMW+4io1cppdF0m2O8zvbItVk+Pc+qPL9cYoB/wss6U3RVPrZ4Y2x69MWiL4OGYM1GavwuAY5cCsoGhCae7anOW6hp5nnY6kw3Tl9olu6EM+GiuoBwTwYsZTi2lmpJQv+BL/zCzgPuendJFxS0JaWr+RQ/Dwd4GvCUGXhm3g4jtIKkND4zwAcjeRxY70Db5yg/Y5ayW9jjaRDPvYEqQYoBnEj7lB3uPwtyed1gsmZ/f8awybRWKfQaP3nEHAJuYrwpvOJ38Evu83TtP7GGW/b/3Ny/ytesxHr9hc0mDdPMKbLStK5LOPLrt4o5GKubwdughUP7ttVzuZsfyNPyN/B+NEafwBc0EE6FqcEyOHUCfKKcJTtbAIQGojPvFP0AUJPdRWVSaSdzHKRJJbuSbzM/aDmjhAa38Ammg7/SlCOwOo09ktJmFcI0u0HSm32jFgi0E0HHnVTKo3Fal1hHjYQ4hAv4jMFv07g6ynCYGTjvFutlPxSwAX1zCB4iNtrTxp/okjL7Yg/4lUixp+g0U4JjQoMtkMIlBRm0veqEnQdBlSkFbGGH4u6Z4zAmHMID1wS25H+aL35OWzJBw0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(136003)(39850400004)(376002)(4326008)(66946007)(66476007)(66556008)(8676002)(5660300002)(316002)(110136005)(8936002)(44832011)(2906002)(38100700002)(86362001)(36756003)(31696002)(6506007)(478600001)(41300700001)(6512007)(26005)(6486002)(83380400001)(53546011)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCs0RjRDTjRvSkdyV0JYT3VGOWxURmxVZERJcHFHN1hXSFQveUxqUWtuUDJv?=
 =?utf-8?B?REhZQ2RQZHc2YmJVdXFwV1NsdEhveVpZRjdVWEpKOE1maDQ4RU9TbGhrZFBq?=
 =?utf-8?B?c0gyOTZ6Ri9UWWgyeC9ESzNhcUNhOGNhTnhpNW9wTUhZa3pHSFB5UE8wc090?=
 =?utf-8?B?Tk5UUk1KK3Q3WDZUS3A5TXJQZGMwQXJsMFpqVnpqVzhicWZSRlJPWGs4TW0v?=
 =?utf-8?B?aWFVbUdHbURhMk1vdDMwaXQwVksxZTlheGx2ZmJxbkJaZHQ3ZVgxQlRwNDdM?=
 =?utf-8?B?SC8rdStNb0JtRWZEVVRHVkxOalovcHo1NkpZRUVTQ2x4V3llemNPbTlQdm81?=
 =?utf-8?B?R3VVZnZXTExxL0pNMkF0b3FseVdMVmRXRTFnWWZ3M0QzRkR3Y1NEeUpuQzNi?=
 =?utf-8?B?czN0SGRjUWxHTk5TNEREd0h1NGgxbE9ZVkdNdjR1ZFFJL3hWaEJlNUoydVl0?=
 =?utf-8?B?RHNCU29UNFlqR2s0Z292RXVYTXpPeGo1U2RSaW1SbFRFcmZtYlBvYWFDZUp2?=
 =?utf-8?B?a3VEQ2ZCOUZLdm80aVFxaTh5RnoxRXg0b0FkazV4MlF2QWZldkFYR3paUHhX?=
 =?utf-8?B?cmQ5Qi9UT3VaTHBZZ2NZVnVlZDFqVnNWTWVkSGt2UFgwR05WTkM0Qm1YMUxK?=
 =?utf-8?B?UStNenBDK3huSjc0U0QybjhCYmVsV2swai9jNjNrZ1R3NEtLVHo3bnZOTVBC?=
 =?utf-8?B?S2s5aXJQRGpmVmhDTFM5aTVveGNWRW85SUVrbTBTTUtxVlZQN2VkTmlDbGVH?=
 =?utf-8?B?eHBxZjZFVDJOR2dmaFdnME1DWnZSd1dKbXM2WlI5eklodHc1Q09SWE9LYVhO?=
 =?utf-8?B?Rkk2ek9QL1BSM2xscStGTmxBVzEyS1ovaDFyckRQZ1RVbkZwRjAxbFdOcTRv?=
 =?utf-8?B?cHFsbUxrYnIxMFJUVEwyZkpVNU4zQWR3RlNPSDh6YTdVMU8wSGRFTFhFUHBx?=
 =?utf-8?B?Um4xUFhMVG9ueDVjdjlUaXA0bnlpWHh5UTJOdkRDUzdHRkU0YjhqZ25UMHhV?=
 =?utf-8?B?aTlJNWdCcm9hNS96cnlLR1dqZ01GSVl5WHYxU0pRcnpuL1FkNDlVdkpERFVG?=
 =?utf-8?B?QTg3UVNUWmZET3RvT0lSOTZWVUZxdStPaDlzeDZUUWJvbUxLL24zRlNxMjRT?=
 =?utf-8?B?YnFETmkrcVAyWUY0ZlRDaW5QSERRMUJ5KzkvKzdCbDFZeFFydEZWb25JTlpQ?=
 =?utf-8?B?cG52OXhWZU5WUDF6N2phRkZsN1BOcWRVQUFqSDFRMkpLT1JuVWRmUXF6TmdR?=
 =?utf-8?B?UVdhUjF5MzM2b01IbmdrY3plc2hyYzJCMXFVMndSQnRUaUhEVUo4MGUwL3Uz?=
 =?utf-8?B?Smk3WGZQY1R1WkRjMnZ0M0laRUc1TFZLblRKRVQ4dWludENaTVg3emJzRGZj?=
 =?utf-8?B?SmdGenBBTmx0eE13eWVNSmJDU1R2L0xaYis1R1V6MURTTHNSSklDNTRVaUhD?=
 =?utf-8?B?VmoyNSsxbWFXRENHVWFBZThZcjJsaUZYbHN5d2RHVTk5ZUJ2K2ZzdUVnRzhr?=
 =?utf-8?B?MUVxYk1ZaWNPWjlWVUtUbGFoaDVDV0pRNWw0cVJFdUx5RDN2NWEram92eW04?=
 =?utf-8?B?bzQyOXIzZ0ljRU0zN2o1V2JCMHdYS29wQmlSNXBMMlNONnhjSjc4VGNuQzE3?=
 =?utf-8?B?WTJPVWhaNkV4RWhydlIreTZQaUdsVnZEb3Q1QVBIdFlOV2RoQTJ6QngzSUpL?=
 =?utf-8?B?dDdYanFHM1JMOEJYTWxVc2ZwYzhWc1dMZ0NIZk14WkVkcE9Pd3RWOXVnUWpu?=
 =?utf-8?B?d0RlcGFWdnkxNHgxayt3NXBtYVlSOG5hOXg2eVgyTUJkQ25rVXZqYnVuWG1o?=
 =?utf-8?B?YlkrT3dyeS9zMUtPOXhqdXZpcEFxakhxTW1Ja2tJUzVPOWxTNWJscDJTN1Jw?=
 =?utf-8?B?R1c1NXl0Z04rVURlaEtDVmhmeXgwa2d0c0ViZXdYblFKdjZKNWY2OG5MZ0Rw?=
 =?utf-8?B?QXpIeFZibWYwY2VnblhRazlyalBaQnhXckZ3WjQ4VmNVUkFsaFZHOURUb05z?=
 =?utf-8?B?L3czdW1SRERiTHhKbmt1OEJ5eFBCbDFQOEhiYkQ5MHAvU0Q2NDRwbFdnQnVU?=
 =?utf-8?B?Lzl6QmgrdlN1MVV5ZzltZ04yQWRqTEg3eVMrMmVpL2xTTEZoY0NxdDU4QVZT?=
 =?utf-8?B?cFVKWWlSOEdyMWExeWEwN2pPVElvc2ZkTDg5cjRhM3hsbVhnTmhFaEoyaXh5?=
 =?utf-8?Q?rS+C6TXK9v/LVf8ZdyqwCO8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7819982d-5144-4f5a-7ba1-08da7b75cbd2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 08:45:08.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ4P0SmOIP4aFJ6RQbe08DRpkNtJ+8uWpWwdEBGokb+HrOzqXVJHzNwKGG542g59xRgJj4qsajj5/wsHDd5g43SfU4SdQELRBmXW0o/6JbwVEStFXXQqcXmJsfxO2I8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3424
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 8/11/22 09:52, Michael Riesch wrote:
> Hi Quentin,
> 
> Thank you for your efforts! This will solve several issues that are
> bound to pop up if a board deviates from the Rockchip reference design.

Actually, most of the devices could work by chance. If you have any IO 
domain running at anything but the default value (3V3 on PX30 and 
RK3399), it won't work until configured by the IO domain driver.

If the IO domain driver is probed before the device requiring it is 
probed, it'll work flawlessly.

Also, we actually hit this issue because the camera driver (ov5675.c) is 
doing an i2c transfer in its probe function. I assume devices where no 
interaction with the device is required during probe (e.g. no 
I2C/SPI/whatever transfer or clock enabling) of the driver, will also 
work just fine if their subsystem don't call callbacks before the IO 
domain device is probed.

So, I think it mostly work by luck today.

> It seems this does not happen very often, though, which would explain
> the lack of responses to your initial query... :-/
> 

Might also be thanks to "custom" bootloaders (our upstream U-Boot does 
it already for another IO domain) setting this up before Linux boots.

> A few comments inline:
> 
> On 8/2/22 11:52, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> On some Rockchip SoCs, some SoC pins are split in what are called IO
>> domains.
>>
>> An IO domain is supplied power externally, by regulators from a PMIC for
>> example. This external power supply is then used by the IO domain as
>> "supply" for the IO pins if they are outputs.
>>
>> Each IO domain can configure which voltage the IO pins will be operating
>> on (1.8V or 3.3V).
> 
> Just for the sake of completeness: 2.5V is possibly as well (at least on
> RK356x), right?
> 

If you say so :) This patch has no knowledge of it and does not require 
it, it just makes sure it probes the IO domain devices before any device 
use the pins.

>> There already exists an IO domain driver for Rockchip SoCs[1]. This
>> driver allows to explicit the relationship between the external power
> 
> ...allows to model explicitly...?
> 
>> supplies and IO domains[2]. This makes sure the regulators are enabled
>> by the Linux kernel so the IO domains are supplied with power and
>> correctly configured as per the supplied voltage.
>> This driver is a regulator consumer and does not offer any other
>> interface for device dependency.
>>
>> However, IO pins belonging to an IO domain need to have this IO domain
>> correctly configured before they are being used otherwise they do not
>> operate correctly (in our case, a pin configured as output clock was
>> oscillating between 0 and 150mV instead of the expected 1V8).
>>
>> In order to make this dependency transparent to the consumer of those
>> pins and not add Rockchip-specific code to third party drivers (a camera
>> driver in our case), it is hooked into the pinctrl driver which is
>> Rockchip-specific obviously.
> 
> This approach seems reasonable. But just for my understanding: Does this
> mean we need to edit e.g. rk3568-pinctrl.dtsi, iterate over all entries,
> and add rockchip,iodomains = <&corresponding_io_domain>;?
> 

That would have been my hope yes, but it is not possible for one of the 
boards we have based on PX30.

All pinmux listed in the px30.dtsi today belong to an IO domain. This 
includes the I2C pins for the bus on which the PMIC is.
Adding the rockchip,io-domains on each pinctrl will create the following 
circular dependency:
pinctrl depends on the io-domain device which depends on
regulators from a PMIC on i2c which requires the i2c bus pins to be
muxed from the pinctrl

Since the PMIC powering the IO domains can virtually be on any I2C bus, 
we cannot add it to the main SoC.dtsi, it'll need to be added per board 
sadly.

The RFC mail contains a bit more info about the pitfalls and what's 
needed to use it.

> If not, at which place are the rockchip,iodomains properties inserted?
> 

In your board dts(i) :/

This would probably be what's required for PCIe to work on our Puma 
Haikou (I tested this patchset for a camera extension board, which isn't 
upstreamed yet, nor mass-produced):

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts 
b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 04c752f49be98..21d2aa46d9553 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -160,7 +160,7 @@ &pcie0 {
  	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
  	num-lanes = <4>;
  	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	pinctrl-0 = <&pcie_clkreqn_cpm>, <&pcie_ep_gpio>;
  	status = "okay";
  };

@@ -189,6 +189,14 @@ sd_card_led_pin: sd-card-led-pin {
  		};
  	};

+	pcie {
+		pcie_ep_gpio: pci-ep-gpio {
+			rockchip,pins =
+				<4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,io-domains = <&io_domains>;
+		};
+	};
+
  	usb2 {
  		otg_vbus_drv: otg-vbus-drv {
  			rockchip,pins =


>> [1] drivers/soc/rockchip/io-domain.c
>> [2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   drivers/pinctrl/pinctrl-rockchip.c | 19 +++++++++++++++++++
>>   drivers/pinctrl/pinctrl-rockchip.h |  1 +
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
>> index 32e41395fc76..c3c2801237b5 100644
>> --- a/drivers/pinctrl/pinctrl-rockchip.c
>> +++ b/drivers/pinctrl/pinctrl-rockchip.c
>> @@ -24,6 +24,8 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>>   #include <linux/pinctrl/machine.h>
>>   #include <linux/pinctrl/pinconf.h>
>>   #include <linux/pinctrl/pinctrl.h>
>> @@ -2370,6 +2372,12 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
>>   	dev_dbg(dev, "enable function %s group %s\n",
>>   		info->functions[selector].name, info->groups[group].name);
>>   
>> +	if (info->groups[group].io_domain &&
>> +	    !platform_get_drvdata(info->groups[group].io_domain)) {
>> +		dev_err(info->dev, "IO domain device is required but not probed yet, deferring...");
> 
> Probably this has been left in there for debugging, but should be
> removed to avoid spamming dmesg. IIUC this condition could occur several
> times.
> 

Considering that the deferred probing mechanism is to retry the 
to-be-deferred device after all other devices have been tried, it is 
very likely to not spam dmesg.

We could remove it though, no strong opinion on this.

>> +		return -EPROBE_DEFER;
>> +	}
>> +
>>   	/*
>>   	 * for each pin in the pin group selected, program the corresponding
>>   	 * pin function number in the config register.
>> @@ -2663,6 +2671,7 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
>>   {
>>   	struct device *dev = info->dev;
>>   	struct rockchip_pin_bank *bank;
>> +	struct device_node *node;
>>   	int size;
>>   	const __be32 *list;
>>   	int num;
>> @@ -2684,6 +2693,16 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
>>   	if (!size || size % 4)
>>   		return dev_err_probe(dev, -EINVAL, "wrong pins number or pins and configs should be by 4\n");
>>   
>> +	node = of_parse_phandle(np, "rockchip,io-domains", 0);
>> +	if (node) {
>> +		grp->io_domain = of_find_device_by_node(node);
>> +		of_node_put(node);
>> +		if (!grp->io_domain) {
>> +			dev_err(info->dev, "couldn't find IO domain device\n");
>> +			return -ENODEV;
> 
> Again just for my understanding: The property is optional in order to
> provide compatibility with older device trees, right?
> 

Of course (at least that's the intent). If it is omitted, 
of_parse_phandle will return NULL and we'll not be executing this part 
of the code. However, if one phandle is provided and the device does not 
actually exist (IIUC, the phandle points to a DT-valid node but the 
device pointed at by the phandle is either disabled or its driver is not 
built). That being said, I don't know how this would work with an IO 
domain driver built as a module. That would be a pretty dumb thing to do 
though.

>> +		}
>> +	}
>> +
>>   	grp->npins = size / 4;
>>   
>>   	grp->pins = devm_kcalloc(dev, grp->npins, sizeof(*grp->pins), GFP_KERNEL);
>> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
>> index ec46f8815ac9..56bc008eb7df 100644
>> --- a/drivers/pinctrl/pinctrl-rockchip.h
>> +++ b/drivers/pinctrl/pinctrl-rockchip.h
>> @@ -434,6 +434,7 @@ struct rockchip_pin_group {
>>   	unsigned int			npins;
>>   	unsigned int			*pins;
>>   	struct rockchip_pin_config	*data;
>> +	struct platform_device		*io_domain;
>>   };
>>   
>>   /**
> 
> Looking forward to the v1 of this series, which I'd be happy to test.
> 

Nothing prevents you from trying it out right now :)

I might be tempted to resend it in a few weeks as v1 to force a 
discussion since this isn't really getting the attention I'd like it to 
receive (and we really need it, though we can work around all this and 
do it in the bootloader). Well.. it's also summer and people usually 
take long holidays or are busy with life :)

Thanks for the review, looking forward to having people use this.

Cheers,
Quentin
