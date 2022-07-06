Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC88568E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiGFPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiGFPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:49:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41766206;
        Wed,  6 Jul 2022 08:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXbrbycBQtqXIB5inxUEGf1G6laJLSbqBzhthSArONvPY/TtcUkluya9w5LX1DZad0/oWSxz3/vt4Z+zKYvJ28lATlNbxEaGvVIQHdS6nUlK26fgm1ilAaWfTsf/omEbZ5o9utpTbcLwje9cFpvusWE4c+/+9/7vUgZOlDD1Up+FhFkdS0qQPnd3xx4QAMbEDpgISqPpFuwVl2RsmN4QQRApbhiu8pQlTcpxi+aYn8uvJckoGoLXS3dEweZ3aCtrH9rO/w6qTxebDsxHBPa5dA/9aDp7yBhn7+dadFY2SiPHLR/CXQW3VTvbQ/cBDoJ7kJaN8REFse1fr3ATGQ6OrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/KP6WBbxZk7T2q4KhCof8ij7WCX+ughu7Jgun4py2I=;
 b=JW7N227jS1pZpYVKOtIBg5HDqbpXJALewhtdtg/7bvIZnoUm321T8VdDA89ms90eKow/bYTD272xZ6ZK5Rq5hoYZ8pOFvENpMF+OCMiCbwug8WOWuX5vjOmq6CRXW9cT+KuCRa4qwm9wbi6xS2Tkh5sgGzBhCHV9VYgQzubAy1q0utk5En/hZfD1kCGLcm8FZi/l+qKEUQ2yaI5QLQbbwU4r/+whPA42z0Z7XgN4TJo+r99GJF+Cjkf3rt8Ye+57yLkylOdJcUujq8+0yXcYtesGQpbxzs47EvHue6QFSdunGgUBzlqEVAyJI9yJZruxt8DjPDyphlyIwae1CNIJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/KP6WBbxZk7T2q4KhCof8ij7WCX+ughu7Jgun4py2I=;
 b=ZozFTwT10oPauIq9CR7WeKPcLO1VWX7VLukpq6PFZAkRjcAcO/e4FWqSm9dhnql3ismEi74tBWWQBJ3K9mTOtPmUpmBi/CJqF/xlmoX7Nk3vu6dvq59bpwGBSpzOSFIyZal9LgIQhsYGZKd92/uTITKQ7hXLcrToFqxR5FQWeok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM0PR04MB4292.eurprd04.prod.outlook.com (2603:10a6:208:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 15:42:14 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f%7]) with mapi id 15.20.5395.017; Wed, 6 Jul 2022
 15:42:14 +0000
Message-ID: <6f64e6c5-3562-4abd-2746-a9e4dd6ba16b@theobroma-systems.com>
Date:   Wed, 6 Jul 2022 17:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 2/4] media: ov5675: add device-tree support and support
 runtime PM
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608134420.1750530-1-foss+kernel@0leil.net>
 <20220608134420.1750530-2-foss+kernel@0leil.net>
 <20220706073022.3mk3i46y5msjn2xk@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220706073022.3mk3i46y5msjn2xk@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94c90d5d-a18e-48f5-99b2-08da5f66190c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4292:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfaAWahYjrg3ZVx4Ya/7sQPDrqIVKYnGR5u0Y/DmdmNXgvQev4fGuKpqWrdmWhuWbvT1VfXt4EBVO/qu3eciJLIELJ9+UQnrSt3pK4e4cnRzuTxFZmb2MtynJUnqxjcAEhYh0+UX+rsrDp96N92xZYovnocfdCSH3i7GPc3b5wzGmvRoswT2AqMkiUPMK8rWjuZEbHAhB61P1r66epaxMs0d7OmFttp1sAMnLLx7MsJ27FRlC3FHfgJE35tHnCY2CyK2lj8l9c1pf1AVEK5sYKDNJ5dZjkXLqjZEOKyCePcy/BTI4ajV/O9JsWKiZAEIFBMXXHngCxiapNbsR81szk/8Afwfirmd64gXwPpHzLp0XL8HriyZznwjrwwzsA3c1eR64i0vb+odjN/Lkj273zGePgijHjWClcwD7hpPkEDMPZmN2oROqotLf0c35g72MWpi3BHCwmI7YvEF4BAhpW+4niQEZrke776eG3avq+fEtRGWZL/DWUiruPXAvV1DxJGUbVNbd/VeAcet9xvBZF0ekCisNUCZxVEhtnqtoy5FUIsA+IK/2pMS50hGBPjEtJxiGPdCtPEAASuLhNJAKiSaDiIXRz+wDkDRMN7D8rTvce1bGiZHCXG8YZmWS9ZHOiWGTX/auhxzi1fLaiVgJgNzz60ZIJ18E2UwFmgyl6AqQaRQVF1nccM1vjLjZOF2a8FlJKvT17NfHKWSjGNMD3rq3gsA0fFFmKTrURDfHJ729xey9/osQoIhBB4vAIJ9SiuTpMEp/s7dsFP9bF1tmXqJkuC6saW8XeWrTTL8qlaE6/AaMTFoHC0GzhRnw+Rbx7CjXEEHdPl99tPRvagGMtFmpeKiXBCc5Mk2PloZ2o9jIVP52saIe8YfG/A2vWrr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(376002)(366004)(39850400004)(6506007)(36756003)(31686004)(31696002)(53546011)(316002)(110136005)(86362001)(38100700002)(2906002)(8676002)(41300700001)(4326008)(44832011)(6486002)(966005)(5660300002)(66476007)(83380400001)(66556008)(6512007)(26005)(30864003)(66946007)(186003)(8936002)(2616005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0YxSFBZeU10MXhIeXpndUZQSVpQYStENVM5dW5QcmVvS21uaWZOQmpUUUVr?=
 =?utf-8?B?WjY3ektpSkJxaTJlSlRaRjR6d0dzSlRiM0ErdURNQXFDR1Y0WTExUDg0bURQ?=
 =?utf-8?B?YXp4R1VxS1JORDZNdzVuNDh6ZElkK0dKaS9RV0pxVVhhb3dVWUhkY0xmeUg3?=
 =?utf-8?B?SFB5MGxvUWdMai9ndGdOSjJDdGk0YkhNZHh4RDRoWjdId3dtdmsvWG4reGwx?=
 =?utf-8?B?NUZVZXdiUWoyclpDRzJlTkxTUlZPZGphRXVQaitLY0sxdnVlMkM5UXRQY3ZQ?=
 =?utf-8?B?UXYzS2JzSHFVL3Rzb0RsNU5GWTFEMDdUZThqWHo5VExUa1hxQVFDc3VqdEZ6?=
 =?utf-8?B?QUhlT1J2Qis4dzdIeFZHNkxhZGNjTDJwYkhMMS9ScGhaQkEwSXEwakRRY1JL?=
 =?utf-8?B?OTM3bEhXODQvSjI5V0p6WFNxb0RvdWFQVTlTU3VBODVub3NCVjJHVTV2NFlY?=
 =?utf-8?B?S0poaHJEeU1JRFdCdU1KWGQvVyttTUtBcTJsRndTNGprK3hVWkYzNFZSUmZI?=
 =?utf-8?B?eDFIb1RWMjJydVdEM1kvNnNuM2VuVzEvSCtNWUdZWXpkbzFsZDVWUmx6SVV5?=
 =?utf-8?B?L3ZBdFJRREdxV3dhOUNiQmRwMjlOYy9uaUJnVlZkN1JQWWtCTlNyWkloOE9L?=
 =?utf-8?B?MXp0K2djOEZnTnAzdm45SlRNV2xEMzBHR1dwcEdBb3Iyb3JhcGtUVm1wZEEv?=
 =?utf-8?B?bUk2S3ZPeTdOSlZQbUdLa1RmdG03eEExYThrWHpFNVE2UWw3N1ZENE5NeWNm?=
 =?utf-8?B?SUltTVRIajF5UDhBbzRpVSswOHVKazUxTnROZlp5V013U1RLQXMwaGZJemVM?=
 =?utf-8?B?OFV4T0padnZnTXZzQVBLK0I1b3E5ZUNCdFdmZml6ZzJ6djhhbGNGa1VaejZR?=
 =?utf-8?B?ZGFLSzIrT2MwSGRia2N1S1pnU09NNGJIT3EyalVQcElLaEgzejhEODN6ZkNR?=
 =?utf-8?B?dTdWSlQvc2FOMVlidjRnbmZHU2hJMWx5cml5WlB3dUhTWW96NGJzRFRZWHNr?=
 =?utf-8?B?Ymsxd2J6OU5FcDFreENxR05VOW54RXVSakd5cWhKdUd3Zlg1VCtyb21uVE9W?=
 =?utf-8?B?WFN5STVMcnNGVXROSHEyL1RlcGF1ZjJnSHVFYjZtcjBLY2FyM2wzNDM4Smts?=
 =?utf-8?B?Y3ByMHowWHU2RDA0MXNjOFJDanlaZUFqVWFsaFpMbTdlN255OS9nWG9ua01p?=
 =?utf-8?B?YUY4TmZBeUtuallyUDhpV1V0RER3aWcva0JrNU03cmxsM0NjeTR6R21VaXNu?=
 =?utf-8?B?VjdjcnVYTU93Q2pNR3hCa0JCd0t1eFMxdnV0aWpnZFNuSHdWTHBWV0VIeDFv?=
 =?utf-8?B?S0JGS1gwMlVMbnBpVDNHWlk1QjJwMFQzMm1tR2RnRENaUzAzcWFxbDlPbGVS?=
 =?utf-8?B?bElENnR6ZjI4Y04vSnFFeEQrNEZIRUdjbmM4RDk5d0NzZEhKMjJYZmttRnk0?=
 =?utf-8?B?dUZjVXBtS1J4QTlJSXU3ZjMrZ1pNWGptYUJxUUo4d3RUNUY0bG5HeWlreFNM?=
 =?utf-8?B?N0U2OG5UbVpHWkkrN1h1V25aNWNNSEZ3VEpqaU9xWlRYeXVCaTRuZ1BhTVVT?=
 =?utf-8?B?UVB3c2h1eTIrOWlNM1dKdW15TmZ3cTVCNXN3V3FTRWQ4cXNXall3a2VSaS9M?=
 =?utf-8?B?dFNITTN1MmF4RFdDeHlyYnl3YkQ2akpvemdwZnNIOVFmRktnbUVVYUY5NWlk?=
 =?utf-8?B?U21qNlh0SWZwLzRPc3pLNUVRRE5maHN4QlU3OGl3MXJsTG9IWWhsREFjdmdr?=
 =?utf-8?B?UUxHT0JLZG9NTW9FMUQ4MHRYTDhsU1pMaGtqQlhHZDNqM2M0U0cwdjV3Q1JB?=
 =?utf-8?B?WkE5N0J1eTVXTWVPSmI5UGgyY1dLZjJ2bkdpT0wxTXlnT3p6QnFNQm93aGNT?=
 =?utf-8?B?YXpoOERGN2VySmw5aEJsblBEa2o0c21TMzVtUVE3L3VZSlBhQ0RFTnZyV21x?=
 =?utf-8?B?dkFhUVFZVnhPSnhoS1NkcTRaNHp3ZXA3UkRhbXJJM3h3cCtadWdXZjZHVEFa?=
 =?utf-8?B?RWY2WjBnVjhJM2pFZEYzWGFsaTRhUUtrUUVwUVJMZnp1ODEyNUxHWGd1VVpn?=
 =?utf-8?B?NU1Rc0tDQUsvOHdXUkp1N3hnMHhNcGhzQ3VaKzBrYys0VVZPbmlyVnJoQmVW?=
 =?utf-8?B?UzBnVXJWM0NFQjRVQ05qNzBER2tPSkk3bnJkOVZhOVJ4UUt6OFlEdHRDVUtG?=
 =?utf-8?Q?FFFUhaUuB8g59vcbFWub80E=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c90d5d-a18e-48f5-99b2-08da5f66190c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 15:42:14.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HuUQoUnuf7adgCK7Vl3nLCTFRALXmmTgVTuIdyiueuCIgoFGMAoMWzrL9MfdAqBg4fiVP5zYrVKn0ETmtQHRbJ8zoQ2nbb7sdMogreTB7Heoohz1UCiu8Mk6ydF6OwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4292
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 7/6/22 09:30, Jacopo Mondi wrote:
> Hi Quentin,
> 
> On Wed, Jun 08, 2022 at 03:44:18PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Until now, this driver only supported ACPI. This adds support for
>> Device Tree too while enabling clock and regulators in runtime PM.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>
> 
> seems like my r-b tag has been dropped from v7.
> 
> Any major change or it just slipped ?
> 

No change at all, should have been there. Sorry for the oversight.

Cheers,
Quentin

> Thanks
>     j
> 
>> v6:
>>   - inverted-xmas-tree ordering,
>>   - space alignment instead of tab after data type for clk and
>>   reset_gpio,
>>   - added pm_runtime_set_suspended to remove callback as suggested by
>>   Tommaso (please cc the mailing list next time too so everyone can
>>   benefit from your reviews :) ),
>>   c.f. https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.linuxfoundation.org_pipermail_linux-2Dpm_2012-2DJuly_034705.html&d=DwIBaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=UUADoiN42MXp9pWA9wFQ7vAh8Y0-KlDmQVDA99hi5PBxa7lQPePNq2BuvpIeouvb&s=-NnrgHuWYBKbBeigK_pvYkeHUm1rGSe0l0Gb0HajSUc&e=
>>   - added Reviewed-by,
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
>>   drivers/media/i2c/ov5675.c | 150 +++++++++++++++++++++++++++++++------
>>   1 file changed, 129 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>> index 82ba9f56baec..e671fb24ebb4 100644
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
>> +	struct clk *xvclk;
>> +	struct gpio_desc *reset_gpio;
>> +	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
>>
>>   	/* V4L2 Controls */
>>   	struct v4l2_ctrl *link_freq;
>> @@ -944,6 +959,56 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
>>   	return ret;
>>   }
>>
>> +static int ov5675_power_off(struct device *dev)
>> +{
>> +	/* 512 xvclk cycles after the last SCCB transation or MIPI frame end */
>> +	u32 delay_us = DIV_ROUND_UP(512, OV5675_XVCLK_19_2 / 1000 / 1000);
>> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> +	struct ov5675 *ov5675 = to_ov5675(sd);
>> +
>> +	usleep_range(delay_us, delay_us * 2);
>> +
>> +	clk_disable_unprepare(ov5675->xvclk);
>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>> +	regulator_bulk_disable(OV5675_NUM_SUPPLIES, ov5675->supplies);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ov5675_power_on(struct device *dev)
>> +{
>> +	u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
>> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> +	struct ov5675 *ov5675 = to_ov5675(sd);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(ov5675->xvclk);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to enable xvclk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>> +
>> +	ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
>> +	if (ret) {
>> +		clk_disable_unprepare(ov5675->xvclk);
>> +		return ret;
>> +	}
>> +
>> +	/* Reset pulse should be at least 2ms and reset gpio released only once
>> +	 * regulators are stable.
>> +	 */
>> +	usleep_range(2000, 2200);
>> +
>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
>> +
>> +	/* 8192 xvclk cycles prior to the first SCCB transation */
>> +	usleep_range(delay_us, delay_us * 2);
>> +
>> +	return 0;
>> +}
>> +
>>   static int __maybe_unused ov5675_suspend(struct device *dev)
>>   {
>>   	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> @@ -1106,32 +1171,60 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
>>   	.open = ov5675_open,
>>   };
>>
>> -static int ov5675_check_hwcfg(struct device *dev)
>> +static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
>>   {
>>   	struct fwnode_handle *ep;
>>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>   	struct v4l2_fwnode_endpoint bus_cfg = {
>>   		.bus_type = V4L2_MBUS_CSI2_DPHY
>>   	};
>> -	u32 mclk;
>> +	u32 xvclk_rate;
>>   	int ret;
>>   	unsigned int i, j;
>>
>>   	if (!fwnode)
>>   		return -ENXIO;
>>
>> -	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
>> +	ov5675->xvclk = devm_clk_get_optional(dev, NULL);
>> +	if (IS_ERR(ov5675->xvclk))
>> +		return dev_err_probe(dev, PTR_ERR(ov5675->xvclk),
>> +				     "failed to get xvclk: %ld\n",
>> +				     PTR_ERR(ov5675->xvclk));
>>
>> -	if (ret) {
>> -		dev_err(dev, "can't get clock frequency");
>> -		return ret;
>> +	if (ov5675->xvclk) {
>> +		xvclk_rate = clk_get_rate(ov5675->xvclk);
>> +	} else {
>> +		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
>> +					       &xvclk_rate);
>> +
>> +		if (ret) {
>> +			dev_err(dev, "can't get clock frequency");
>> +			return ret;
>> +		}
>>   	}
>>
>> -	if (mclk != OV5675_MCLK) {
>> -		dev_err(dev, "external clock %d is not supported", mclk);
>> +	if (xvclk_rate != OV5675_XVCLK_19_2) {
>> +		dev_err(dev, "external clock rate %u is unsupported",
>> +			xvclk_rate);
>>   		return -EINVAL;
>>   	}
>>
>> +	ov5675->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>> +						     GPIOD_OUT_HIGH);
>> +	if (IS_ERR(ov5675->reset_gpio)) {
>> +		ret = PTR_ERR(ov5675->reset_gpio);
>> +		dev_err(dev, "failed to get reset-gpios: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < OV5675_NUM_SUPPLIES; i++)
>> +		ov5675->supplies[i].supply = ov5675_supply_names[i];
>> +
>> +	ret = devm_regulator_bulk_get(dev, OV5675_NUM_SUPPLIES,
>> +				      ov5675->supplies);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
>>   	if (!ep)
>>   		return -ENXIO;
>> @@ -1186,6 +1279,10 @@ static int ov5675_remove(struct i2c_client *client)
>>   	pm_runtime_disable(&client->dev);
>>   	mutex_destroy(&ov5675->mutex);
>>
>> +	if (!pm_runtime_status_suspended(&client->dev))
>> +		ov5675_power_off(&client->dev);
>> +	pm_runtime_set_suspended(&client->dev);
>> +
>>   	return 0;
>>   }
>>
>> @@ -1195,25 +1292,31 @@ static int ov5675_probe(struct i2c_client *client)
>>   	bool full_power;
>>   	int ret;
>>
>> -	ret = ov5675_check_hwcfg(&client->dev);
>> +	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
>> +	if (!ov5675)
>> +		return -ENOMEM;
>> +
>> +	ret = ov5675_get_hwcfg(ov5675, &client->dev);
>>   	if (ret) {
>> -		dev_err(&client->dev, "failed to check HW configuration: %d",
>> +		dev_err(&client->dev, "failed to get HW configuration: %d",
>>   			ret);
>>   		return ret;
>>   	}
>>
>> -	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
>> -	if (!ov5675)
>> -		return -ENOMEM;
>> -
>>   	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
>>
>> +	ret = ov5675_power_on(&client->dev);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to power on: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	full_power = acpi_dev_state_d0(&client->dev);
>>   	if (full_power) {
>>   		ret = ov5675_identify_module(ov5675);
>>   		if (ret) {
>>   			dev_err(&client->dev, "failed to find sensor: %d", ret);
>> -			return ret;
>> +			goto probe_power_off;
>>   		}
>>   	}
>>
>> @@ -1243,11 +1346,6 @@ static int ov5675_probe(struct i2c_client *client)
>>   		goto probe_error_media_entity_cleanup;
>>   	}
>>
>> -	/*
>> -	 * Device is already turned on by i2c-core with ACPI domain PM.
>> -	 * Enable runtime PM and turn off the device.
>> -	 */
>> -
>>   	/* Set the device's state to active if it's in D0 state. */
>>   	if (full_power)
>>   		pm_runtime_set_active(&client->dev);
>> @@ -1262,12 +1360,15 @@ static int ov5675_probe(struct i2c_client *client)
>>   probe_error_v4l2_ctrl_handler_free:
>>   	v4l2_ctrl_handler_free(ov5675->sd.ctrl_handler);
>>   	mutex_destroy(&ov5675->mutex);
>> +probe_power_off:
>> +	ov5675_power_off(&client->dev);
>>
>>   	return ret;
>>   }
>>
>>   static const struct dev_pm_ops ov5675_pm_ops = {
>>   	SET_SYSTEM_SLEEP_PM_OPS(ov5675_suspend, ov5675_resume)
>> +	SET_RUNTIME_PM_OPS(ov5675_power_off, ov5675_power_on, NULL)
>>   };
>>
>>   #ifdef CONFIG_ACPI
>> @@ -1279,11 +1380,18 @@ static const struct acpi_device_id ov5675_acpi_ids[] = {
>>   MODULE_DEVICE_TABLE(acpi, ov5675_acpi_ids);
>>   #endif
>>
>> +static const struct of_device_id ov5675_of_match[] = {
>> +	{ .compatible = "ovti,ov5675", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ov5675_of_match);
>> +
>>   static struct i2c_driver ov5675_i2c_driver = {
>>   	.driver = {
>>   		.name = "ov5675",
>>   		.pm = &ov5675_pm_ops,
>>   		.acpi_match_table = ACPI_PTR(ov5675_acpi_ids),
>> +		.of_match_table = ov5675_of_match,
>>   	},
>>   	.probe_new = ov5675_probe,
>>   	.remove = ov5675_remove,
>> --
>> 2.36.1
>>
