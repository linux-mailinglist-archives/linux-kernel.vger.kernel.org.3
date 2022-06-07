Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48095400BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbiFGOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiFGOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:08:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F46B19;
        Tue,  7 Jun 2022 07:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6dWNsQpWdiFRXdg3q7PhPt/kdkwoZa1EXfb9HlZ7FRiVhihiXw+46aik5Crz+Q1zbY6OkAQZJneZ601e+J3aoHXwGXhbL7K9FguDhvr8FFalBlaVd0mTjimKU5Su+erNAM8wVy65lMXQETxNdMKRKzYlJHPL2+LsPhBdj0D7j4zCWrgvmZDciGbyL3pSkBvzZGu6fO5fP8YPRUm9MAP9L2oDNr5NcDry9yvAkvGxWltncqNV3w1XCoHa98la/c6Ez8vz8Js5tHQOIQjGGs93f3Q/yLzPaYP96hg2oNweW5lV617C7D6Mu6KXoR+XUyukh0o+KCPRChmt/ByvgySWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAv7ILwntnNsPEfp576+sR1pYrnPKoriHPQ0xZYZP6w=;
 b=kY3EvpveukMrvpDX2tt8LM8/LCCMMKsDFgj5PTMMssg9SXVOrtJlxUW+DwJVBBC07UNxqN8w0JWLBDgcUojORJ0CQEBJF8r7Cs/8SBHgRX9/WUs4VN4USUcJTd9/ujlx9mzvqXUhf769p9eeKFIr0Ylce1VqZjfdbKDm/zEdqIR/3GsnEbMnoommRm5+tJxG5u7bhDHxrY5SGpt/YAQnSg317hDX6ROXxRJBejcHRKxlzAwsAdQR+GIcHxnEbzo/yFYGklua57cJV84h5Lb664aztbeFRAMYJfAcM4IeUFBQNfp/hr3slkY2HDQWifYxW42gP9qNQuLXm1j/X2LYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAv7ILwntnNsPEfp576+sR1pYrnPKoriHPQ0xZYZP6w=;
 b=eP4tMO4IVl1vceesU5WVZirC7Ak++rzATthM7ZRmcJFNeZmV7q5oZdAEnOorxiEkCKZT7NWt56+9/SiZSXxBehdyPhkvM5jK26S4E2A/zsgP6skGt74w9NLlLQvyg9eqiqlvG7O5d8MZW0QAqqreQP1WXfYit71fgT18rHTLqhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 14:08:41 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:08:41 +0000
Message-ID: <249907c9-1d59-d8ab-1870-c01e8ace7d18@theobroma-systems.com>
Date:   Tue, 7 Jun 2022 16:08:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/4] media: ov5675: add device-tree support and support
 runtime PM
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220525145833.1165437-1-foss+kernel@0leil.net>
 <20220525145833.1165437-2-foss+kernel@0leil.net>
 <20220531131633.tjkp6q43kwwxtnvk@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220531131633.tjkp6q43kwwxtnvk@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::21) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ca23b0-fc9f-43fd-c078-08da488f399f
X-MS-TrafficTypeDiagnostic: DU0PR04MB9274:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9274A648FCFB0D337E41D64AC2A59@DU0PR04MB9274.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+ciiJP3DHmCBaRA12xJUoTN+g0gDpfC3XToW/jDHdb08uQ1gVMUt6fxmxy0UczWOU+abO7QP0rTNp/XRmPVcleRHY7deGHgNMhduMH8+ggv0cVRsZuPVUa2nLNErK3l0V3FMnK3StS5LGEUixSTZT9lTlswI4kdpKRU1Qp86qAOUVL6b2iRvtlmYX5CB9Q6FKpmpi0EV1qihww6AGs0SNgOzgfPl1OqSOUzdlpt164tbyvFZhDIzW/ZVYQSWiWkux7Tp3NUQyZ+HIwSqF59MPft1shlQDi5bZZSOPtQln/ePFa6Bpx6u8J/TxA5qZqC2RSqFio72B+8OYDg+KI/lKM6AoRA4Ac7LZIalHZfU04fxpgLFaJW3OzL/yW/Ds5tx7nNS1/tYXZ4UI7+E4hYfuDPYLtxRL0MPG9mFwrP5dDmRr+8qUnCCU10uE/btNA/qvkEECteLeFbTDLVJ4OxQ15IApd2O6hH7wrPxXYFs5TVRfJehtNdvY0WVoGvaJ8eEPW+hy4/FuweUkRjUsySIcWDmj1bG6Xna0AqTdOScomADpbjebKOlQKU6Ft9B7hrWLwjl+abw3AOaIIdIhlqUs0DNrTDCelSR+epjHS4NIyWI4gluVgKXyDLdvyhJPLYOhzZ/9THPXMRhz47cKCxW3UsrneMIlw7uKGqCdK76hvGfFCPznZwk9emD+vWLdz3LPGQwnzdFbq6whBaatXa+gOP1a1/c0w6TRKpRKvTF28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(86362001)(38100700002)(31696002)(83380400001)(36756003)(5660300002)(110136005)(8676002)(8936002)(44832011)(316002)(4326008)(2906002)(66476007)(66946007)(66556008)(6506007)(6512007)(53546011)(26005)(31686004)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkpudmE0RHJtdzBCd1FKWkNDZmoxSnY5anJzcUNJWTU5ck9nY1ZOMmJjR1NR?=
 =?utf-8?B?MFJFSzdOeEwyUEovMVhtaHo3VmlRNGhxVXh1L0FrWWlVM2dlc29xaDdkUkxn?=
 =?utf-8?B?TTM2aW5pSDF2LzIrNjdiTkZmb3JzLzV2ZkhCNzVIRVEyL1FpTCtBUHplRm1P?=
 =?utf-8?B?OExVWG9JeEErMjQwUXNVbUQ1ZmxOVWJ5TjlrcFVSbUw4UGRPSElPb3U2MXA5?=
 =?utf-8?B?WmNpT2c0MDk0NUg1cHNMUE5yK0g5clBWczFLZjgwR0xCSmkxVDBYRlpxNTRq?=
 =?utf-8?B?RWpZaGZxcGpCVi9QOUFTOVcrTkVaSHdVbjNLRUFjNUNIMjY2Ritac0p6YlpO?=
 =?utf-8?B?dk9BYldONE5QdUhpSTV0Tktic000Y2VpMGplSDIxajZmNS9VTXBZWVZid1lR?=
 =?utf-8?B?Ymczb3RZL3N0SUdpQkptZ3JsdG9FTGZ0N25HWjE3SmNPM001Z09ISElNZUwv?=
 =?utf-8?B?MXhXWERrNzdTS2tBQnVmNzRTQ2wyeVo1TUZPMS9UT0pCSTUwM2dsT1VPdjg0?=
 =?utf-8?B?TGdoallON3JrcEpEcUVjeU5RSlZxVS9SWTRPL1BSZWYxOHN3dXBDc21zRDFU?=
 =?utf-8?B?UU0xSjRpaEZud29FWm50c3Vhakp6WjFxcGpoMlZMMGRzVU1pelFmdGgzam82?=
 =?utf-8?B?eFR2VlRuWTBEc2VvUHRLZnBuTW1lVHJ4ek5KNGJySk0vSmxPemJhSVQreXF4?=
 =?utf-8?B?RFhnV0dMVm83Yk4xS29waU5aekMzczNGWGNWWjdMY05NdW9tcUh0RlR4NnNv?=
 =?utf-8?B?K2wya3RjeEQzYkprTU9GZTNyL1FKRXpBeSt4NE5VVkhWUW54Ti9jWHY3Yksv?=
 =?utf-8?B?WVB1emI3QjdKa3NlemEwMW0zTW03QUwrQVAvUW81QWF3ZXA1N3dJUXpXMDMw?=
 =?utf-8?B?TkU4MUpEdlNabElhQWZEWGZybmZPRnNjZ2ZTUEVhV3B4UWhZeVN3OEI5TWpk?=
 =?utf-8?B?WFRWRHRlMjBNZDhtaElwL0xlS0hHSVJTNWowSlRHNlp4Zjd3dTVObWpKUVQv?=
 =?utf-8?B?SUl3bGVQREt4YmRyaTA4bDR1ZS9Td3VQWUVFaVYwc1c0Wk04Zmtxbk94SEd0?=
 =?utf-8?B?Q1VMSFpMTHFNeUZFMWdLa3VBN1dHWW0yRzJlQ0l2VkdsNFBDdHFXbmRDbElM?=
 =?utf-8?B?QU1IRWlHZDRYTTdHTm5LdmxyZFE0L3NkS2FpWnB3aFhYTWQrbFgzUWxVeWRj?=
 =?utf-8?B?WHRKaU50R3RGRkNRR2QrL1pRT3RHOUU4RWdBbmFCWVVKTHlOOTFkY0RxU0ZD?=
 =?utf-8?B?dXFjRVdJYS9RbUcwc0VzY1p1bXZPaFRoK0k1K2VJMXZGakwwcjNudWZ1eUR4?=
 =?utf-8?B?R0lwL0tjRVpQeWdsb1hQZjdIR2ZQdFMxWENrTldGR29SRGhVaEhZckxpcERZ?=
 =?utf-8?B?UUE3cmJOYzhpblh6NGpSeVlVaEJOYU9LY3RxaEp1NXhadUdLeUdWN0N3UHhh?=
 =?utf-8?B?K01PNEJKUzdiSWhuQ1NkajlyYVRPQlh5MzUyMG1HelY3RG53N3J3T3FhSjht?=
 =?utf-8?B?QUtKeVQvaFlYL01aalI2MS9mMTZLdlpkTWdzb2xkaElaVzU0SlNKQ3dWSHg4?=
 =?utf-8?B?QkJ6UVhaZTFCKzUrRVB4MUdaNk1NZ3cvNGNMQ29lR3pZSjllWFM1WHpFSHBT?=
 =?utf-8?B?Yk9pY3BHcFpaOXRYODMyLzNMWE10Ymo2WEptdXVJTitCUG5qdkkxSG55a3pk?=
 =?utf-8?B?U1A3T2JCVjdvRmlZQTBJZEtPTS93QndaanNlbW0zano4WEZBOFpocWcxd2VG?=
 =?utf-8?B?SklPSlhRWGlRTTJ0ajNOZVJIWjh4ZXJIUmkxVDlOeDZaVEZubW5oRDdlWldG?=
 =?utf-8?B?RTJ0VXpGb3NLWWlrYm10L3M0VUYySldlaVNlY1lHZHBONDRob1F3RFNESkdS?=
 =?utf-8?B?VVdmbVRtOHE2YlM1V014TmtwUzkyWjZ1Z055dFNEcXVDbDBoYTVrelBuMzZO?=
 =?utf-8?B?TnBXUnRrVVN5V3A5QWxZcm96eVhRcW0rVEFvMS8za20wV0ZIaUJiUTk5VzUw?=
 =?utf-8?B?Rjh1MmE3K012Ryt0WWdYMzdvQmhWTDcvL0w5eVVwOTFpdkJ5V1R5RDBQR1Qv?=
 =?utf-8?B?Ly8wczJYR1RxYjBoTkVod2hQRWVSOVd5QnBTNkZqSEJyUlpEK0o3citySXdM?=
 =?utf-8?B?SXBvZmdGK2IzZ3FOT280OU8zTEZhM0FFQk1GUmdDcmthRGdYaW1ocVhRVlFr?=
 =?utf-8?B?YTZQdkRlcU1Heit0RCtlOGdUTEJ6U29aaFdlT3F5bHd3akVZQzNLaUw5cklk?=
 =?utf-8?B?K0xmR2E5K0k1cVhOWXVZVmNvd1oxRG5FY0psY1VKdHVaRWNpL0NNc0hrZXJy?=
 =?utf-8?B?Q1BpSHRTV0RvVkUxcXhjZGZCVDd5SnRGVFZTei8xWnJicjhDYUR4dGpwMDZz?=
 =?utf-8?Q?lW71y7u1awbbw0ZsFgqrPuPfZVLJqMX/Vk+fB?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ca23b0-fc9f-43fd-c078-08da488f399f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 14:08:41.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBQIWWVpYoN63AR0136T46Yh72bPcANFeO/NtwN6HbhqOVnHsjDhs5BFEHGu5efqCUMYtuVOETXDBmyQ4g8riClNNbSkF/s/Dl4Hz6a2EqX0TbJYsbO1bc6OpCaANZvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 5/31/22 15:16, Jacopo Mondi wrote:
> Hi Quentin,
>     one more question
> 
> On Wed, May 25, 2022 at 04:58:31PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Until now, this driver only supported ACPI. This adds support for
>> Device Tree too while enabling clock and regulators in runtime PM.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>
>> v5:
>>   - fixed -Wdeclaration-after-statement for delay_us,
>>
>> v4:
>>   - added delays based on clock cycles as specified in datasheet for
>>   pre-power-off and post-power-on,
>>   - re-arranged clk handling, shutdown toggling and regulator handling to
>>   better match power up/down sequence defined in datasheet,
>>   - added comment on need for regulator being stable before releasing
>>   shutdown pin,
>>
>> v3:
>>   - added linux/mod_devicetable.h include,
>>   - moved delay for reset pulse right after the regulators are enabled,
>>   - removed check on is_acpi_node in favor of checks on presence of OF
>>   properties (e.g. devm_clk_get_optional returns NULL),
>>   - moved power management out of system suspend/resume into runtime PM
>>   callbacks,
>>   - removed ACPI specific comment since it's not specific to this driver,
>>   - changed devm_clk_get to devm_clk_get_optional,
>>   - remove OF use of clock-frequency (handled by devm_clk_get_optional
>>   directly),
>>   - removed name of clock (only one, so no need for anything explicit)
>>   when requesting a clock from OF,
>>   - wrapped lines to 80 chars,
>>
>> v2:
>>   - fixed unused-const-variable warning by removing of_match_ptr in
>>   of_match_table, reported by kernel test robot,
>>
>>   drivers/media/i2c/ov5675.c | 149 +++++++++++++++++++++++++++++++------
>>   1 file changed, 128 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>> index 82ba9f56baec8..ea801edb8e408 100644
>> --- a/drivers/media/i2c/ov5675.c
>> +++ b/drivers/media/i2c/ov5675.c
>> @@ -3,10 +3,14 @@
>>
>>   #include <asm/unaligned.h>
>>   #include <linux/acpi.h>
>> +#include <linux/clk.h>
>>   #include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/i2c.h>
>> +#include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <media/v4l2-ctrls.h>
>>   #include <media/v4l2-device.h>
>>   #include <media/v4l2-fwnode.h>
>> @@ -17,7 +21,7 @@
>>
>>   #define OV5675_LINK_FREQ_450MHZ		450000000ULL
>>   #define OV5675_SCLK			90000000LL
>> -#define OV5675_MCLK			19200000
>> +#define OV5675_XVCLK_19_2		19200000
>>   #define OV5675_DATA_LANES		2
>>   #define OV5675_RGB_DEPTH		10
>>
>> @@ -76,6 +80,14 @@
>>
>>   #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
>>
>> +static const char * const ov5675_supply_names[] = {
>> +	"avdd",		/* Analog power */
>> +	"dovdd",	/* Digital I/O power */
>> +	"dvdd",		/* Digital core power */
>> +};
>> +
>> +#define OV5675_NUM_SUPPLIES	ARRAY_SIZE(ov5675_supply_names)
>> +
>>   enum {
>>   	OV5675_LINK_FREQ_900MBPS,
>>   };
>> @@ -484,6 +496,9 @@ struct ov5675 {
>>   	struct v4l2_subdev sd;
>>   	struct media_pad pad;
>>   	struct v4l2_ctrl_handler ctrl_handler;
>> +	struct clk		*xvclk;
>> +	struct gpio_desc	*reset_gpio;
>> +	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
>>
>>   	/* V4L2 Controls */
>>   	struct v4l2_ctrl *link_freq;
>> @@ -944,6 +959,56 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
>>   	return ret;
>>   }
>>
>> +static int ov5675_power_off(struct device *dev)
> 
> Does this (and power_on) require __maybe_unused to avoid a warning
> when compiling without CONFIG_PM support ? Have you tried that ?
> 

It does not, because they are called manually in the probe function and 
its error path (but thanks for the heads up, because I definitely forgot 
about this one).

I received some review outside of this mailing list telling me the error 
path is incorrect for pm_runtime so I'll have a look at it before 
sending a v6.

Cheers,
Quentin
