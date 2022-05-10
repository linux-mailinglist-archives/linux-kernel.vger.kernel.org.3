Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4C5224E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiEJTiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEJTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:38:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60108.outbound.protection.outlook.com [40.107.6.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678C2173EA;
        Tue, 10 May 2022 12:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSEgEK6u/IsFsg6ZUYzfePPj76YIhaHXS3jd1jxNP7yDTE0hxxDjHJPF7rdxUZlEVCal5OEubGwnd03wnZcN491ZfUtuS1vMQ+rXZNdke7I4DUHvmqU9nbm9yDVxhiDqH7XI46IL5rfLo5++Tq6MTJtJBTZ85j4tiPK8i2zVy0PGNEABXZJolvEzEjZ9oxkQlT1Wje3AuUQLeTXZQBy2tr4hrm8TPt+f0SzU9mTYnbtwhTgn6aXDCzo8quLlHs3vAUKpaPtoAxyqvh9jNonDWjk4Ot/FRMD1S6FHn8Asq7TgNawywj1cLxsvOjzjoWCJTKjx4L6xbO0WUg5x7L95tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lySRanLcdcANNU70k8qosj+unRPfLHMhdtUrclEscNU=;
 b=LHRdOsD97quhuJwUk0gT4icgRpZW3BpyyEaoWO9KnJ/JiCJ/LCj5QNFWu59DrN4UqgMj9j+R1B+UZQsvATaWZh8sr7qsnOYmaoK3rw34UyPct6VfISMaPe15RU0jzkBb6VdapIFdmCDWukFVF7GBxNj2Q5PiqMEawNLs81FVOdFMKLKolapRlPE0kgubpBONSZVqcL+6kHdlnYhmAnOl0lkM20TlGSWgK+GWImAsbyrOyC3xVxQ3F+II11lyJVgBCPXxExFRdZfAVOIJVWJn5QyL7vJE7OFBMUKXtBLDKlMV8n3bO39iWYgLscrYwsoBrprMRBQTRWaaxOBiY4ZsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lySRanLcdcANNU70k8qosj+unRPfLHMhdtUrclEscNU=;
 b=ZSKA1UKM2EexWQtoWRFAv7xiOetD96fzmrm9o4hWGCQ6CmkpAJqprELaI7S3LHt0YxHMjvqJh715tKkQ+mqmsz1AP50gKI7wzeU6OzVsgOWeRgUGgc2W3v03pjgCa/Ok3kml/LWovk1oFx+RmQvjYPoBowlcrv7zTYdS5Wraa/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR02MB3120.eurprd02.prod.outlook.com (2603:10a6:802:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 19:38:08 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 19:38:07 +0000
Message-ID: <59288dbf-bea2-a12e-93d2-c7c95f5568f6@axentia.se>
Date:   Tue, 10 May 2022 21:38:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Content-Language: sv
To:     Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
 <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
 <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
 <CO1PR11MB4865915CFCBA2AA765B932A292C99@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <CO1PR11MB4865915CFCBA2AA765B932A292C99@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::34) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e511a09-2fbd-4580-a675-08da32bc9bb1
X-MS-TrafficTypeDiagnostic: VI1PR02MB3120:EE_
X-Microsoft-Antispam-PRVS: <VI1PR02MB312058E9CB0F475FA3E4A2EBBCC99@VI1PR02MB3120.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJ8ZNXv9ftIbx9EQhGlRTFtROCQv4wXcKzhMqV6l9nwE6PR+Ac+7YZUn1bp2oZPyvce6zdO/XFslTHGjtHGO5A4AW3WFVEM62a+ncHC/pkN7BDMeOc/84fJiz/M/hs+y2KawUoBWHlT7whMu0vqCNoSqqrYxQVoMP4LyyMBT+YLBa2JhDs6AGRu5/efOiQP0LMliqe/GMf5WKDsSuA26EU6IEvO6XHf8FP2kdKkOLSqJD7vbJPgcXwhDCTf6k+mBwvYaTc+mGCF1NzZaNyZ5uRuOAb5b7Vrt2jAI658yYL84SL+WH1FyFi7QyudhQVcbAQuCwkBYs0x4mRKvTIGoC1iuYPJsjTXI15KQ/nTpfiLDfxbh/7SriAt/b9L66W5jjdj3GbnGgtkiUk3jwsEFPUEkB/Gsbh76WM0Mnj5HQToPUtoGfmdln6bNDM6kEIE+U/1/DGrEDZUx8g29jQUBSW6XttFpNSNuYgs2Xn9bE00LSKy9CeWrSZISC2OmWM/6El6zDWwu0gf7myTS9eU/VgpxDu7gMdQR4GXtjgbfQOMR0mpPLEAAbyexLElvWBt4NO0rpGJ3pqGMxefUqHOLLW9Pm7x0M4gMAnLsRcb9v8Is1e308nlfVyd0uvPDNj3/MeNxAMPY5Z1w5b5kWe0/Gx64GogIVB3Qeni1bvf0PoS1pb/MWziKjLsPLoryZxCSWFZWqLhIu5jwvlEzW0KOlSIoRwq/6Nr2hmFzRGsKbiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39830400003)(376002)(396003)(346002)(31686004)(26005)(6506007)(31696002)(6512007)(86362001)(30864003)(6916009)(83380400001)(2906002)(7416002)(8936002)(66946007)(66556008)(66476007)(4326008)(38100700002)(8676002)(36756003)(5660300002)(508600001)(316002)(6486002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRPdVhtYk9kRGJrUlV3MzI4VmZIOUUwcTEyU1ZnUDN2L2Z0cUFraWtNR3ZM?=
 =?utf-8?B?aG9BT1ZQdWxxaTRTcmhwYzhHQWxETGtGMFZrRWQ5YkJ5OWJCdWx4RldNNHUx?=
 =?utf-8?B?eFVuZ1lSNEpsK2tEVWFHNEExSVJzM0NaUXJGbHkzR0tzaXVhZWl1WmFyb3pS?=
 =?utf-8?B?T2Z0RGhZLzV0MXBqdU9qV1lqSFkveFVvcktDREJ2bDBoTUVLMlk3eit0NDY4?=
 =?utf-8?B?b0UwUklOU2EyMVVmd0o1bzhWenhzQ0l2UUJVQlh4VFNWYkZnVE5HdWoyZzl0?=
 =?utf-8?B?RTlxVEhxWE5hTXM0ZHlObnFvTjdjcWNxQUN2eFl5dzJXenB1SnBqM3RyNzho?=
 =?utf-8?B?cU9HUjl2UldBSVc5QWpnb1gvZGVOb2J6cjR5dVpqOW4rTVR1QWVmY1BNbzQ1?=
 =?utf-8?B?cnFpL3BXeGF5WlZaZVZIL0xwWGl5YkpoZUF6bVE4TDlqZTY0cEhaUEhvV0or?=
 =?utf-8?B?U3R1TG5VVTZSVTlSSGJQSlZ0UVloWnBicEdabytpaWVzUkdWMHRCUDQ5Nk9B?=
 =?utf-8?B?Q3JFR1JjYng2RzNCTlFJdHJIWlM1bHVYOXpUMDhiaUV3emhYQTBVaEluZWZJ?=
 =?utf-8?B?RXRsOEJqbmlmbGNpcmNNTGxsenI3NWsrN2cycy92VU1uYWF1NW4yMStEV1Bl?=
 =?utf-8?B?cUlLUE15L1FaRUpRSnRhTXkzSmN3TEFKL0xFUmUxSEo5STlKbUtSSzdGMHZO?=
 =?utf-8?B?L2hHYnB6WE9SbC81MzFpQzZCVEp5U2tFT1NvU1d3STVubjdXMnBiYmVuVU5u?=
 =?utf-8?B?VDFLMDYxelFsbEZucEVORXZBb2xxQ2VhYnJHOHlLRGhaR3laWWQzQ2YxblAr?=
 =?utf-8?B?MXo5dDBaN1lyeDdOMjRxaUtHR1F0bDF4Wm1yV3dRV0RVb2hMNVhNR09JdGxh?=
 =?utf-8?B?U2NvSm5UYnFvUWFzUlZuUlBReWs2dTc2a0p6MUpUeldmQ29kUVpma0g2WmtT?=
 =?utf-8?B?MGg1VGR2V0ZTK3F4U0REUmEvTWlRNk55eVRiUnZETEZtbThRYWhtSFlrRUlN?=
 =?utf-8?B?V3ZVOGZxOGl4MTVPckpqUDczUkxXai9TQ0pwVVg4TjlhOEtmTTRFbzdkd0RH?=
 =?utf-8?B?b2ZDdnc1UUJFN1g5ZU8wdXBia0dSdTZPL1ZCOEY4b1JtNlNJL0tNc1NFVzJT?=
 =?utf-8?B?VmZ3dWczZ0hmdG1WOEZqNmxJb0xBQ0xaS0NJVnNOdVkzdEhCR0lFUWgxeEty?=
 =?utf-8?B?VUV5NkJCbk9vMzRMNHJJdnBCZmVZNUhtL05YTlA5dDhKY1dxR1VwMFZMMUJs?=
 =?utf-8?B?UU9pNG0xQmNqMGNScUl2M3dzMGg2Njc4bjA2cUZObzNMVUp5UVJzRjlwc25n?=
 =?utf-8?B?ZVlTVHptTUJSNFRlVGVIc21jbC9XMFR0OWFmc084OHltaXZFS1hKYlZISW1m?=
 =?utf-8?B?WFUvL1NiTFRJV1czSk1mbzFTenczSmR3TENBOU5mYnJrbU5OYzczNW5oaGNO?=
 =?utf-8?B?YlBNU1I2Q3NndUNUa0dXcmpoUDlJbDFUUGlwTGVLcjRZMjNtUkJtL25PTDRK?=
 =?utf-8?B?YSt1TUU3dHVwODlXcEpRVEZ2c2ZyT20ybGdVZnlJdWYwSUpNbEhTbEl3T05E?=
 =?utf-8?B?eUlNM1pZdDdTTTlPL25QZWhMa3FtVERKR1l3SWJxUFo0WGZhZEdFREh4cHhO?=
 =?utf-8?B?b0hncFZpWitTd1k2TCsxNHJVSkFHZ29JK0ltZXNKMVhuWGVYb0Q1L1lwYkI5?=
 =?utf-8?B?cmxWWlVUKytERUNNZ0k2Z0piYmRMVndXSytUeWloaHpUeDFHQnh0Z3R5eHNY?=
 =?utf-8?B?MnFDditvNlIwYjFGR0NJRzgwQ1Y1M0N1YjdXRTgzYTBlNnhtZjJwR2hjczI2?=
 =?utf-8?B?MzJqYmQyUFYybGV0NU1iVCtVVlJVQmtrc0hKTlhSMno2Vi9PQWpBSEg5Ritq?=
 =?utf-8?B?TlIxVGhlSnh6bGJXWkpsMFlRNWp4cGVtVzNWc0wvVlFDR0UxNWQvN3I4UXJG?=
 =?utf-8?B?QVlkb3hYdkE0TkxwbkhTbVRRRVRkMURISUU2VUlhallWTVViQnJxMU1HbUR4?=
 =?utf-8?B?Y2FoUkdyYVF2dDM4UWduRTFGOHM5TFZlVmdvVkJxN2ZWRDZCREhUZUticmdO?=
 =?utf-8?B?WHZ0UTVkTTRqUVhGRUZEbXlGS0N3Wkc5MVlTSDUwMlZSOGF3cDR6QUluMXN0?=
 =?utf-8?B?ZVlZM25rdVNybkJhSnJZQWJwd0w5ZGc5QWh0cEpSa3NrNll6SnJSaUoyN25h?=
 =?utf-8?B?QURBOVg2Z0ZWQXBXaTlNK1lzSDVMZkR0K09GY04xV3UxYzErTXpRTktIQys5?=
 =?utf-8?B?WEp1YmJkUVU4Tmt3UlJsU1doMnprR3RRYmU0Y2RNMlR3ckwvdUlpYWlxR1Fl?=
 =?utf-8?B?bENvYWZpdUdBeml6ODd4aEFUek9SblowWWRRRmNiL1RGOGdSU0VVQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e511a09-2fbd-4580-a675-08da32bc9bb1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 19:38:07.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anGaoCEt5mI6a0byOc4EgJAf/uYnBIIRw/4qZXZ83ta0QBBjCnwfZ2+eiL3VJKaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3120
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-05-10 at 16:59, Kavyasree.Kotagiri@microchip.com wrote:
>>> LAN966 SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
>>> For each chip select of each flexcom there is a configuration
>>> register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
>>> configuration register is 21 because there are 21 shared pins
>>> on each of which the chip select can be mapped. Each bit of the
>>> register represents a different FLEXCOM_SHARED pin.
>>>
>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>> ---
>>>  arch/arm/mach-at91/Kconfig  |   2 +
>>>  drivers/mfd/atmel-flexcom.c |  55 +++++++++++++++-
>>>  drivers/mux/Kconfig         |  12 ++++
>>>  drivers/mux/Makefile        |   2 +
>>>  drivers/mux/lan966-flx.c    | 121
>> ++++++++++++++++++++++++++++++++++++
>>>  5 files changed, 191 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/mux/lan966-flx.c
>>>
>>> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
>>> index 279810381256..26fb0f4e1b79 100644
>>> --- a/arch/arm/mach-at91/Kconfig
>>> +++ b/arch/arm/mach-at91/Kconfig
>>> @@ -74,6 +74,8 @@ config SOC_LAN966
>>>       select DW_APB_TIMER_OF
>>>       select ARM_GIC
>>>       select MEMORY
>>> +     select MULTIPLEXER
>>> +     select MUX_LAN966
>>>       help
>>>         This enables support for ARMv7 based Microchip LAN966 SoC family.
>>>
>>> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
>>> index 559eb4d352b6..7cfd0fc3f4f0 100644
>>> --- a/drivers/mfd/atmel-flexcom.c
>>> +++ b/drivers/mfd/atmel-flexcom.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/io.h>
>>>  #include <linux/clk.h>
>>>  #include <dt-bindings/mfd/atmel-flexcom.h>
>>> +#include <linux/mux/consumer.h>
>>>
>>>  /* I/O register offsets */
>>>  #define FLEX_MR              0x0     /* Mode Register */
>>> @@ -28,6 +29,10 @@
>>>  #define FLEX_MR_OPMODE(opmode)       (((opmode) <<
>> FLEX_MR_OPMODE_OFFSET) &  \
>>>                                FLEX_MR_OPMODE_MASK)
>>>
>>> +struct atmel_flex_caps {
>>> +     bool has_flx_mux;
>>> +};
>>> +
>>>  struct atmel_flexcom {
>>>       void __iomem *base;
>>>       u32 opmode;
>>> @@ -37,6 +42,7 @@ struct atmel_flexcom {
>>>  static int atmel_flexcom_probe(struct platform_device *pdev)
>>>  {
>>>       struct device_node *np = pdev->dev.of_node;
>>> +     const struct atmel_flex_caps *caps;
>>>       struct resource *res;
>>>       struct atmel_flexcom *ddata;
>>>       int err;
>>> @@ -76,13 +82,60 @@ static int atmel_flexcom_probe(struct
>> platform_device *pdev)
>>>        */
>>>       writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
>>>
>>> +     caps = of_device_get_match_data(&pdev->dev);
>>> +     if (!caps) {
>>> +             dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     /* Flexcom Mux */
>>> +     if (caps->has_flx_mux && of_property_read_bool(np, "mux-controls"))
>> {
>>> +             struct mux_control *flx_mux;
>>> +             struct of_phandle_args args;
>>> +             int i, count;
>>> +
>>> +             flx_mux = devm_mux_control_get(&pdev->dev, NULL);
>>> +             if (IS_ERR(flx_mux))
>>> +                     return PTR_ERR(flx_mux);
>>> +
>>> +             count = of_property_count_strings(np, "mux-control-names");
>>> +             for (i = 0; i < count; i++) {
>>> +                     err = of_parse_phandle_with_fixed_args(np, "mux-controls",
>> 1, i, &args);
>>> +                     if (err)
>>> +                             break;
>>> +
>>> +                     err = mux_control_select(flx_mux, args.args[0]);
>>> +                     if (!err) {
>>> +                             mux_control_deselect(flx_mux);
>>
>> This is suspect. When you deselect the mux you rely on the mux to be
>> configured with "as-is" as the idle state. But you do not document that.
>> This is also fragile in that you silently rely on noone else selecting
>> the mux to some unwanted state behind your back (mux controls are not
>> exclusive the way e.g. gpio pins or pwms are). The protocol is that
>> others may get a ref to the mux control and select it as long as noone
>> else has selected it.
>>
>> The only sane thing to do is to keep the mux selected for the whole
>> duration when you rely on it to be in your desired state.
>>
> 
> Yes, mux is kept selected until configuring register is done. Please see below log where
> I added debug prints just for understanding:
> # dmesg | grep KK
>  [    0.779827] KK: Func: atmel_flexcom_probe ***** [START flx muxing] ********
> [    0.779875] KK: Func: atmel_flexcom_probe i = 0 args[0] = 0
> [    0.779890] KK: Func: mux_control_select [Entered]
> [    0.779902] KK: Func: mux_lan966x_set [Entered] state = 0
> [    0.779977] KK: Func: mux_lan966x_set [Read] = 0x1fffef   <<<----- setting mux_lan966x[state].ss_pin "4" which is passed from dts
> [    0.779992] KK: Func: mux_lan966x_set [Exit]
> [    0.780002] KK: Func: mux_control_select [Exit]
> [    0.780011] KK: Func: mux_control_deselect [Entered]
> [    0.780021] KK: Func: mux_control_deselect [Exit]

You misunderstand. The mux control is only "selected" between the call 
to mux_control_select() and the following call to 
mux_control_deselect().

After that, the mux control is "idle". However, in your case the 
"idle-state" is configured to "as-is" (which is the default), so the 
mux control (naturally) remains in the previously selected state while 
idle. But you are not documenting that limitation, and with this 
implementation you *must* have a mux control that uses "as-is" as its 
idle state. But that is an unexpected and broken limitation, and a 
much better solution is to simply keep the mux control "selected" for 
the complete duration when you rely on it to be in whatever state you 
need it to be in.

>>> +                     } else {
>>> +                             dev_err(&pdev->dev, "Failed to select FLEXCOM mux\n");
>>> +                             return err;
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>>       clk_disable_unprepare(ddata->clk);
>>>
>>>       return devm_of_platform_populate(&pdev->dev);
>>>  }
>>>
>>> +static const struct atmel_flex_caps atmel_flexcom_caps = {};
>>> +
>>> +static const struct atmel_flex_caps lan966x_flexcom_caps = {
>>> +     .has_flx_mux = true,
>>> +};
>>> +
>>>  static const struct of_device_id atmel_flexcom_of_match[] = {
>>> -     { .compatible = "atmel,sama5d2-flexcom" },
>>> +     {
>>> +             .compatible = "atmel,sama5d2-flexcom",
>>> +             .data = &atmel_flexcom_caps,
>>> +     },
>>> +
>>> +     {
>>> +             .compatible = "microchip,lan966-flexcom",
>>> +             .data = &lan966x_flexcom_caps,
>>> +     },
>>> +
>>>       { /* sentinel */ }
>>>  };
>>>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>>> index e5c571fd232c..ea09f474bc2f 100644
>>> --- a/drivers/mux/Kconfig
>>> +++ b/drivers/mux/Kconfig
>>> @@ -45,6 +45,18 @@ config MUX_GPIO
>>>         To compile the driver as a module, choose M here: the module will
>>>         be called mux-gpio.
>>>
>>> +config MUX_LAN966
>>> +     tristate "LAN966 Flexcom multiplexer"
>>> +     depends on OF || COMPILE_TEST
>>> +     help
>>> +     Lan966 Flexcom Multiplexer controller.
>>> +
>>> +     The driver supports mapping 2 chip-selects of each of the lan966
>>> +     flexcoms to 21 flexcom shared pins.
>>> +
>>> +     To compile the driver as a module, choose M here: the module will
>>> +     be called mux-lan966.
>>> +
>>>  config MUX_MMIO
>>>       tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>>>       depends on OF || COMPILE_TEST
>>> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
>>> index 6e9fa47daf56..53a9840d96fa 100644
>>> --- a/drivers/mux/Makefile
>>> +++ b/drivers/mux/Makefile
>>> @@ -7,10 +7,12 @@ mux-core-objs                       := core.o
>>>  mux-adg792a-objs             := adg792a.o
>>>  mux-adgs1408-objs            := adgs1408.o
>>>  mux-gpio-objs                        := gpio.o
>>> +mux-lan966-objs                      := lan966-flx.o
>>>  mux-mmio-objs                        := mmio.o
>>>
>>>  obj-$(CONFIG_MULTIPLEXER)    += mux-core.o
>>>  obj-$(CONFIG_MUX_ADG792A)    += mux-adg792a.o
>>>  obj-$(CONFIG_MUX_ADGS1408)   += mux-adgs1408.o
>>>  obj-$(CONFIG_MUX_GPIO)               += mux-gpio.o
>>> +obj-$(CONFIG_MUX_LAN966)     += mux-lan966.o
>>>  obj-$(CONFIG_MUX_MMIO)               += mux-mmio.o
>>> diff --git a/drivers/mux/lan966-flx.c b/drivers/mux/lan966-flx.c
>>> new file mode 100644
>>> index 000000000000..2c7dab616a6a
>>> --- /dev/null
>>> +++ b/drivers/mux/lan966-flx.c
>>> @@ -0,0 +1,121 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * LAN966 Flexcom MUX driver
>>> + *
>>> + * Copyright (c) 2022 Microchip Inc.
>>> + *
>>> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>
>> Looks like it is based on mmio.c?
>>
> Yes, I took mmio.c  driver as reference.
> 

So, then the above copyright and authorship info is not complete.

>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/property.h>
>>> +#include <linux/mux/driver.h>
>>> +#include <linux/io.h>
>>> +
>>> +#define FLEX_SHRD_MASK               0x1FFFFF
>>> +#define LAN966_MAX_CS                21
>>> +
>>> +static void __iomem *flx_shared_base;
>>
>> I would much prefer to store the combined address (base+offset)
>> in the mux private data instead of only storing the offset and
>> then unnecessarily rely on some piece of global state (that
>> will be clobbered by other instances).
>>
> Ok. I will try to see if this is relevant and change accordingly.
> 
>>> +struct mux_lan966x {
>>
>> Why is the file named lan966, but then everything inside lan966x?
>>
>>> +     u32 offset;
>>> +     u32 ss_pin;
>>> +};
>>> +
>>> +static int mux_lan966x_set(struct mux_control *mux, int state)
>>> +{
>>> +     struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
>>> +     u32 val;
>>> +
>>> +     val = ~(1 << mux_lan966x[state].ss_pin) & FLEX_SHRD_MASK;
>>> +     writel(val, flx_shared_base + mux_lan966x[state].offset);
>>
>> This reads memory you have not allocated, if you select a state
>> other than zero.
>>
> Ok. I will return error condition in case of trying to access none existing entry.
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct mux_control_ops mux_lan966x_ops = {
>>> +     .set = mux_lan966x_set,
>>> +};
>>> +
>>> +static const struct of_device_id mux_lan966x_dt_ids[] = {
>>> +     { .compatible = "microchip,lan966-flx-mux", },
>>> +     { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, mux_lan966x_dt_ids);
>>> +
>>> +static int mux_lan966x_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device_node *np = pdev->dev.of_node;
>>> +     struct device *dev = &pdev->dev;
>>> +     struct mux_lan966x *mux_lan966x;
>>> +     struct mux_chip *mux_chip;
>>> +     int ret, num_fields, i;
>>> +
>>> +     ret = of_property_count_u32_elems(np, "mux-offset-pin");
>>> +     if (ret == 0 || ret % 2)
>>> +             ret = -EINVAL;
>>> +     if (ret < 0)
>>> +             return dev_err_probe(dev, ret,
>>> +                                  "mux-offset-pin property missing or invalid");
>>> +     num_fields = ret / 2;
>>> +
>>> +     mux_chip = devm_mux_chip_alloc(dev, num_fields,
>> sizeof(*mux_lan966x));
>>
>> I might be thoroughly mistaken and confused by the code, but it seems
>> very strange that a subsequenct select is not undoing what a previous
>> select once did. Each state seems to write to its own register offset,
>> and there is nothing that restores the first register offset with you
>> switch states.
>>
>> Care to explain how muxing works and what you are expected to do to
>> manipulate the mux? Is there some link to public documentation? I did
>> a quick search for lan966 but came up with nothing relevant.
>>
> LAN966 has 5 flexcoms(which can be used as USART/SPI/I2C interface).
> FLEXCOM has two chip-select I/O lines namely CS0 and CS1
> in SPI mode, CTS and RTS in USART mode. These FLEXCOM pins are optional.
> These chip-selects can be mapped to flexcom shared pin [0-21] which can be
> done by configuring flexcom multiplexer register(FLEXCOM_SHARED[0-4]:SS_MASK[0-1])
> Driver explanation:
> "flx_shared_base" is used to get base address of Flexcom shared multiplexer
> "mux-offset-pin" property is used to get cs0/cs1 offset and flexcom shared pin[0-21] of a flexcom.
> state value passed from atmel-flexcom is used to configure respective 
> FLEXCOM_SHARED[0-4]:SS_MASK[0-1] register with offset and flexcom shared pin.

Ok, let me try to interpret that. You wish enable a "fan out" of these
two chip-selects for any of the 5 flexcoms (in SPI mode?) such that
these 10 internal chip-selects can be connected to any of 21 external
pins?

If that's correct and if you wish to interface with e.g. 20 chips,
then it would be possible to have 20 states for one mux control and
then reach the 20 chips using only CS0 from FLEXCOM0, or it would be
possible to have 2 states for 10 mux controls, one each for CS0/CS1 of
all five flexcoms and also reach 20 chips. Or any wild combo you
imagine is useful.

Is that correctly understood?

Assuming so, then you can have a maximum of 10 mux controls, and for
each mux control you need a variable number of legitimate states. Each
mux control would also need to know at what address/offset its SS_MASK
register is at and what pins/states are valid.

But your code does not implemnent the above. You allocate num_fields
mux controls, which is what confuses the hell out of me. num_fields is
the number of states, not the number of mux controls! And you also
need to specify an individual offset for each state, and that makes no
sense at all, at least not to me.

So, instead, I think you want to have:

struct mux_lan966x {
	u32 ss_mask;
	int num_pins;
	u32 ss_pin[];
};

And then do:

	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_lan966x) + num_pins * sizeof(u32));

(or however that size is best spelled, I haven't kept up)

The set operation would be along the lines of:

static int mux_lan966x_set(struct mux_control *mux, int state)
{
	struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
	u32 val;

	if (state < 0 || state >= mux_lan966x->num_pins)
		return -1;

	val = ~(1 << mux_lan966x->ss_pin[state]) & FLEX_SHRD_MASK;
	writel(val, flx_shared_base + mux_lan966x->ss_mask);

	return 0;
}

Because, one mux control should only ever need to know about one offset,
as it should only ever write to its own SS_MASK register. And you will
need some private space such that you can keep track of which states
are legit.

I would also separate out the SS_MASK offset from the mux-offset-pin
property and have one property for that value and then a straight
array for the valid pin numbers in another property (no longer named
mux-offset-pin of course).

Or something like that and assuming I understand how the FLEXCOMs work
and what you want to do etc.

Cheers,
Peter


>>> +     if (IS_ERR(mux_chip))
>>> +             return dev_err_probe(dev, PTR_ERR(mux_chip),
>>> +                                  "failed to allocate mux_chips\n");
>>> +
>>> +     mux_lan966x = mux_chip_priv(mux_chip);
>>> +
>>> +     flx_shared_base = devm_platform_get_and_ioremap_resource(pdev,
>> 0, NULL);
>>> +     if (IS_ERR(flx_shared_base))
>>> +             return dev_err_probe(dev, PTR_ERR(flx_shared_base),
>>> +                                  "failed to get flexcom shared base address\n");
>>> +
>>> +     for (i = 0; i < num_fields; i++) {
>>> +             struct mux_control *mux = &mux_chip->mux[i];
>>> +             u32 offset, shared_pin;
>>> +
>>> +             ret = of_property_read_u32_index(np, "mux-offset-pin",
>>> +                                              2 * i, &offset);
>>> +             if (ret == 0)
>>> +                     ret = of_property_read_u32_index(np, "mux-offset-pin",
>>> +                                                      2 * i + 1,
>>> +                                                      &shared_pin);
>>> +             if (ret < 0)
>>> +                     return dev_err_probe(dev, ret,
>>> +                                          "failed to read mux-offset-pin property: %d", i);
>>> +
>>> +             if (shared_pin >= LAN966_MAX_CS)
>>> +                     return -EINVAL;
>>> +
>>> +             mux_lan966x[i].offset = offset;
>>> +             mux_lan966x[i].ss_pin = shared_pin;
>>
>> This clobbers memory you have not allocated, if num_fields >= 1.
>>
>> Cheers,
>> Peter
>>
>>> +
>>> +             mux->states = LAN966_MAX_CS;
>>> +     }
>>> +
>>> +     mux_chip->ops = &mux_lan966x_ops;
>>> +
>>> +     ret = devm_mux_chip_register(dev, mux_chip);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static struct platform_driver mux_lan966x_driver = {
>>> +     .driver = {
>>> +             .name = "lan966-mux",
>>> +             .of_match_table = of_match_ptr(mux_lan966x_dt_ids),
>>> +     },
>>> +     .probe = mux_lan966x_probe,
>>> +};
>>> +
>>> +module_platform_driver(mux_lan966x_driver);
>>> +
>>> +MODULE_DESCRIPTION("LAN966 Flexcom multiplexer driver");
>>> +MODULE_AUTHOR("Kavyasree Kotagiri
>> <kavyasree.kotagiri@microchip.com>");
>>> +MODULE_LICENSE("GPL v2");
>>> +
