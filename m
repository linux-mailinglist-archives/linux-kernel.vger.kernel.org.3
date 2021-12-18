Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED75F479C11
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhLRSgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:36:20 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:16286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232110AbhLRSgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:36:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRbqywRLIufDV3fENEGQICjPWvbGNjD0cO1JpMgPfnjZG31Ax+APAFVpjKWX8lduyaMpi4aBCghgArkCInvTRDW2qAjCLGCI2Sn0okVqueVaxXZBTWKnDfTlwIIDi6Hf4wnb/1ibK7cilVzeBuhdzJa2SsuqARbRpv3OVDhzNU6zRqqaBa8oRjQF/nISEJTIy8mrbLQZoQRLr9CD7X+qcnyXd60h4k4U0ikPLPKwju26hY2+U6v7SXpRtqmwxodjvDk9SCa5K1mI2GXoyuXDXQlxjIiC0x+qFRf2aqNl+sS5I0WaJ0kVySqP7hjffitKZaB+W4BiIOfAIbm4hS3BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5CgJyzNenwusMsbYS5muRRhvS8RBiUVgDw1To/6254=;
 b=LOR7sMQnI5KbvmVpUSn1bkIqWbgjwL7PYRWAcdq1Se3v8v3UtnTems9dKtkvonBDVRmvDsFX/mlYxgGEHtRvGsgC7K58/tbT3L3z0USKwQw5ZzLc6yACffexOdfwBx4M0z14iJWsYuw3D7V7D0/JMk8xZzRalOQ+8bjLcc5RzHa9K1+v4VhBHvu5rLR/AcsWemv7Nq/FK+0R4CTf5uGi2Os79V2ayqaRhTyAC1JsotmG/N12jPPWe1/7/mUlAd7M2UQ/mPjUZGLzKWGhmNcMkHorZjs0tcccjtHJakKi5qMLrBh/VV8WMlsrl4hr+YuFJMbSJq22UkcgMctligLDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5CgJyzNenwusMsbYS5muRRhvS8RBiUVgDw1To/6254=;
 b=fr37VmwLCTtJoF54mz8OkHfjlBWA63LjZvD0wEKfMW068S9JWBP66D29zZ0maAKpepUVuhDJZMp69rF+MLJVeWMlnhB3z8TZ9gmoyaav3jtzozc26DwRT4ZTeN7RJdiDKStY49gnIPHZ4VwvIGSSgVih2nBKqoNr2rfEQrDOY10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4789.eurprd02.prod.outlook.com (2603:10a6:10:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sat, 18 Dec
 2021 18:36:15 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4801.019; Sat, 18 Dec 2021
 18:36:15 +0000
Message-ID: <773b9424-a1c7-1955-886c-de36299a6873@axentia.se>
Date:   Sat, 18 Dec 2021 19:36:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/2] MUX: Add support for mux-states
Content-Language: sv-SE
From:   Peter Rosin <peda@axentia.se>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
 <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
 <af642da8-a9e1-6d3a-a928-8a514f1c5eb0@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <af642da8-a9e1-6d3a-a928-8a514f1c5eb0@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 812ab5b5-bc64-468a-9817-08d9c2554609
X-MS-TrafficTypeDiagnostic: DB7PR02MB4789:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB47897C03894CEF8E0751C746BC799@DB7PR02MB4789.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOuysQ+/z89h/ivTxeANm1WPVooLSLjDJcR48ZgkrmNAGfixjSMYRZMqZaz82rmdYu5Qnm2H2DxQO+h8iOMy3X46VGJ3zbtUghp5e19DjMiO1yaxnJu0FJn4y7Jow4RzeHjWIirIZvWY9k9opSeMnNuEODQTejrk6B2LRru2vkaiQOV6py9qr7wlCYyCtSxP7Th3SqKgrDsyPKTHrvHm/GH8PvJ0M8+pT38mv3FzlFIT2VH7FfqCzxyaVTkfpcaUEW01aBpEBbB8VlzkfwyWkUvQXlqKW6ARZqtfuwLV5NoLzZ9Yka4+DJ5PIae7NTPc6sGd1MBU/dYRHBpX07G5jmZl7xdh1N3GVqq7UYhNWWNyhKxstegiByisOTVcToyjMe7lfm17pL9bBf8ic1Fi+wx24rhPrBCjCwNKJjzCaZ2cGP/Czy7uoG5grmzdYOJMDCtUGUfl7nMyy59FXC7YbjIrhuuEkPCyQLBJe6p4wXylA69DNzgM/hUsCYpJK2jFhKkhFbln+1Ir1XjW/zI5bImzCMGquLsLUQOsnlWajJt8kjg1tk+cyoVGKYbGHWqAEGqYJ3ubI7W+gTu6L/ZJpviyUQdwZK8WN65CD6B+AWKz+2U09PEh+V7KXLh4fVZ5tTQuLC4kKQFfHP0iJSAQSMCjM/ZSY9HbRQ8GB3YY7ieUG2EwqUXS9HgphIyE0qAITRgWIgRDVf89xAr7+5sNWkZtrA/KAjdDGBJOZEphpGdlOp9Hhxp0Stz9XMc0OMZBSliEA9UfZ0V1B1LIuOa6yhPx0dg62/l3sFxrq5PU3VXZVYgV6NoJM8PJwNulfH6x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39830400003)(346002)(376002)(38100700002)(6916009)(966005)(316002)(4326008)(4001150100001)(508600001)(31686004)(6512007)(36916002)(31696002)(186003)(2616005)(6666004)(8676002)(54906003)(83380400001)(2906002)(53546011)(66556008)(8936002)(26005)(66946007)(66476007)(86362001)(5660300002)(6506007)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mit1eFFRb0VhbnRWNE1QS1Fkbi9NWTNWZWVGUitqdUYyUS9OdVNFLy90aTR2?=
 =?utf-8?B?ZDM5WCtuZEo5MEpmOWJ6TUh4RGN0R0R5bk9TZjRuMDJyTVpFRXpZTEd1eUVV?=
 =?utf-8?B?a3ZFb2FBYUlhK09tNzVRekFGSlZPZlFjL2lSSmRaNnJET2JlZ1RyRmJVektj?=
 =?utf-8?B?ckM5VGRQenBEckNkQ0IrSW9SbjYwS3JhZEMrMExlc0R4T3hSSlBEQThyb0M2?=
 =?utf-8?B?akJ1MndRZlYzVXF1Y3FYVHQ3aC9sOTZqemJpSmlNTHpmSHNNWllaNmtxenJB?=
 =?utf-8?B?RTRTNUJ3OHJQUHpYU1NTTDR4ekk5Y21kTno5M2hGcGJua3pveTAzRkdrbGVN?=
 =?utf-8?B?cWpoajk1S3BCbmJzdVZhaW9XbHlrWHFCZWJpVUtFcWZRQXhSdXR1TWp0eU5Z?=
 =?utf-8?B?N0hHamc2R0tXSDdLNFZ4a3pTOXRsQ1pzQTJVNFZLcHFEd3V1RnBvZDlUTElL?=
 =?utf-8?B?ZEFDTVVxRHg3bDlBOVAyWFp6OEtzNUZ1Wnoxd1BUQ0JKZFZmU1lhSjRJa3J2?=
 =?utf-8?B?UnhMbXBBbzUxYmxMbGRKbiswd2FrRURmTzM1MENwaTJuQVU4a0RHQ0ZGbFp2?=
 =?utf-8?B?WUxseEVJQ3BOMkRtME5JcmdZY0tSeFg4QUk2VFhpd3gvUm1ZMC9ZaWd0U0lO?=
 =?utf-8?B?dVpkZmY4OWU5NS9zVDFzZDh0Y3dBY2tKY1pEU1ZZSU9jYllNN0ZVZm1HNU85?=
 =?utf-8?B?Rmt2YVRyOEpKZmFYYlRMN1RRQytrNDUrNWJhMjdzLzQxVGJWUGtvZk9rN2tI?=
 =?utf-8?B?aVBLeVJFNW5Ed1lxZ3hKa3ptQUZIZjZncHdvbko3WUkyN1ZacURYdUJCeFdr?=
 =?utf-8?B?dVhzUWhEdXFTN2psL2phSlNkWStBRUtwSlNpTjJFQkZucVN3bzUvQ29DbCtZ?=
 =?utf-8?B?MVRWK2xoNlRsWm5mcUwvNzVFWHZSRmU3N1hYR2tLRGZ2TG95RVk5ZExyK1Zt?=
 =?utf-8?B?VGo0OVhCUjhkaEFoRkRIaUFVeEk4alp2WnlQeEwzQUEyVERKMUlRbGNScUQv?=
 =?utf-8?B?NjloRnFXUHpFU1BsUzJ0VUs5UXFPSnFUV2VhNHRlNFV2Zjl4Tm8wcUpxUERU?=
 =?utf-8?B?MC8zVHlQNXA3R1dKcTRpTlJ4N3hraWZYYU91Z3lqZkhTOEQvb3h1YnpmN3Ay?=
 =?utf-8?B?Zm9vVUVOZFV1N2tERDJBNHowci92cXBaVm45NHJ6VE10SHVVdTZqY1pwM0tW?=
 =?utf-8?B?UjAzVHFWMmNlSkpqbGEyS3JpU1c3ODdyQzJNcUVjT0FoR2R3TVBFSVF0bDB1?=
 =?utf-8?B?VFpqbzNzSlBQSjhad3BsUHdES0grVFRpQXBhZm5rK05ieEtMZGxQVFlUZk1K?=
 =?utf-8?B?ZWtLcFF0Z3ZqODZ5cTJMb1NCNXNTWU80blBRR3NPMUYwcG5QRUVnYVd2cHNG?=
 =?utf-8?B?bEViTmxxckNzSjQ3N01vQVJFV2lvRUcrV1k5VGVIUGV0aml1QWw4eWJCaHNh?=
 =?utf-8?B?bkNLQjRGRjNZSXBCalQvSHRHdXNMeExSWUtuMktIbllnMzdwcXA3enh3QVpP?=
 =?utf-8?B?aHNQRXl5bU82N1lsZFNsZkVPRlg2UmpUckhReHNTb3o0eWpQbUg4VWN0am5o?=
 =?utf-8?B?WTRZVHk0SFNKc0NQVDhsYVgwOGpSVE9GV01YdEd1UkpmWGtBSDk3ejkvVkJJ?=
 =?utf-8?B?WEVNL1JMazBOSmwwRzR4dkpYdjhhMU9iVG0vUnpCdktrc0FhVFZjMUxtRkxH?=
 =?utf-8?B?c0RCenJ0LzVkbkFVUmUxQTF5VStqclA3NDZCMUNQaCszRmZXMGdPOFZoeGNp?=
 =?utf-8?B?TWcwM0hvd1luN0U0dXlLdk5CV09najBuTUVHQUVKYnJKTnYxT3hoMm5oalZQ?=
 =?utf-8?B?cWN1eWJ2QzF2NjBIM2pNRVUreVdGNjJxenNFYW92WUZIN0hpd1FOWXEvaXdS?=
 =?utf-8?B?b3gxOFBUS3JGUFprWWdTVXc1L1o3dnF3T3JheEJIZGhobzg0YlBXZ0JROUo4?=
 =?utf-8?B?dXRhb1VmSVFmd2thclJyV0RoSElYNjlLSy9kTkdpZko5Y0xJMDFYUVA5a1dK?=
 =?utf-8?B?ckx0VGFTcWtJdlZkb3Jza2FOWGtlYTlHTHU0dERTdUhoM3NmWXlncnNKTVRm?=
 =?utf-8?B?ZUhwL29ONTVVY3pPQUtKY2xIM3lCZHA3c2JFM2ExSUZVQzJoa0RBaWtpZUxq?=
 =?utf-8?Q?khfY=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ab5b5-bc64-468a-9817-08d9c2554609
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 18:36:15.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBwklIyE2GopmH7NLW6yorsxA/bUbIkrcbCZJeOu6McdCqsJpSoG1aU/oPe1lEp8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath!

See below.

On 2021-12-17 07:26, Peter Rosin wrote:
> Hi again.
> 
> On 2021-12-17 06:57, Peter Rosin wrote:
>> Hi Aswath!
>>
>> On 2021-12-02 13:40, Aswath Govindraju wrote:
>>> The following series of patches add support for reading mux
>>> state from the device tree.
>>>
>>> changes since v1:
>>> - Made grammer corrections and added more information
>>>   on the usage for mux-states and mux-controls
>>>
>>> Aswath Govindraju (2):
>>>   dt-bindings: mux: Document mux-states property
>>>   mux: Add support for reading mux state from consumer DT node
>>>
>>>  .../devicetree/bindings/mux/gpio-mux.yaml     |  11 +-
>>>  .../devicetree/bindings/mux/mux-consumer.yaml |  21 ++
>>>  .../bindings/mux/mux-controller.yaml          |  26 ++-
>>>  drivers/mux/core.c                            | 219 ++++++++++++++++--
>>>  include/linux/mux/consumer.h                  |  19 +-
>>>  5 files changed, 271 insertions(+), 25 deletions(-)
>>>
>>
>> I finally found some time to have a last look at this (fingers crossed) and
>> pushed it out for testing in linux-next.
>>
>> I did end up squashing in these trivial changes in patch 2/2, I hope that's
>> fine with you. Just holler if not...
>>
>> Cheers,
>> Peter
>>
>> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
>> index 148e19381b79..5018403fe82f 100644
>> --- a/Documentation/driver-api/driver-model/devres.rst
>> +++ b/Documentation/driver-api/driver-model/devres.rst
>> @@ -368,6 +368,7 @@ MUX
>>    devm_mux_chip_alloc()
>>    devm_mux_chip_register()
>>    devm_mux_control_get()
>> +  devm_mux_state_get()
>>  
>>  NET
>>    devm_alloc_etherdev()
>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>> index 7355c5ad41f7..bf448069ca85 100644
>> --- a/drivers/mux/core.c
>> +++ b/drivers/mux/core.c
>> @@ -30,12 +30,13 @@
>>  #define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
>>  
>>  /**
>> - * struct mux_state -	Represents a mux controller specific to a given device
>> - * @mux:		Pointer to a mux controller
>> - * @state		State of the mux to be set
>> + * struct mux_state -	Represents a mux controller state specific to a given
>> + *			consumer.
>> + * @mux:		Pointer to a mux controller.
>> + * @state		State of the mux to be selected.
>>   *
>> - * This structure is specific to a device that acquires it and has information
>> - * specific to the device.
>> + * This structure is specific to the consumer that acquires it and has
>> + * information specific to that consumer.
>>   */
>>  struct mux_state {
>>  	struct mux_control *mux;
>> @@ -354,7 +355,8 @@ static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
>>   * On successfully selecting the mux-control state, it will be locked until
>>   * there is a call to mux_control_deselect(). If the mux-control is already
>>   * selected when mux_control_select() is called, the caller will be blocked
>> - * until mux_control_deselect() is called (by someone else).
>> + * until mux_control_deselect() or mux_state_deselect() is called (by someone
>> + * else).
>>   *
>>   * Therefore, make sure to call mux_control_deselect() when the operation is
>>   * complete and the mux-control is free for others to use, but do not call
>> @@ -384,16 +386,15 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>>  
>>  /**
>> - * mux_state_select_delay() - Select mux-state
>> - * @mstate: The mux-state to select
>> - * @delay_us: The time to delay (in microseconds) if the mux control
>> - *            changes state on select
>> + * mux_state_select_delay() - Select the given multiplexer state.
>> + * @mstate: The mux-state to select.
>> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>>   *
>> - * On successfully selecting the mux-state, it will be locked until
>> - * there is a call to mux_state_deselect() or mux_control_deselect().
>> - * If the mux-control is already selected when mux_state_select() is
>> - * called, the caller will be blocked until mux_state_deselect() or
>> - * mux_control_deselect() is called (by someone else).
>> + * On successfully selecting the mux-state, its mux-control will be locked
>> + * until there is a call to mux_state_deselect(). If the mux-control is already
>> + * selected when mux_state_select() is called, the caller will be blocked
>> + * until mux_state_deselect() or mux_control_deselect() is called (by someone
>> + * else).
>>   *
>>   * Therefore, make sure to call mux_state_deselect() when the operation is
>>   * complete and the mux-control is free for others to use, but do not call
>> @@ -415,7 +416,7 @@ EXPORT_SYMBOL_GPL(mux_state_select_delay);
>>   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>>   *
>>   * On successfully selecting the mux-control state, it will be locked until
>> - * mux_control_deselect() or mux_state_deselect() called.
>> + * mux_control_deselect() called.
>>   *
>>   * Therefore, make sure to call mux_control_deselect() when the operation is
>>   * complete and the mux-control is free for others to use, but do not call
>> @@ -444,12 +445,12 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
>>  EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
>>  
>>  /**
>> - * mux_state_try_select_delay() - Try to select the mux-state.
>> - * @mstate: The mux-state to select
>> + * mux_state_try_select_delay() - Try to select the given multiplexer state.
>> + * @mstate: The mux-state to select.
>>   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>>   *
>> - * On successfully selecting the mux-state, it will be locked until
>> - * mux_state_deselect() or mux_control_deselect() is called.
>> + * On successfully selecting the mux-state, its mux-control will be locked
>> + * until mux_state_deselect() is called.
>>   *
>>   * Therefore, make sure to call mux_state_deselect() when the operation is
>>   * complete and the mux-control is free for others to use, but do not call
>> @@ -642,26 +643,6 @@ static void devm_mux_control_release(struct device *dev, void *res)
>>  	mux_control_put(mux);
>>  }
>>  
>> -/**
>> - * mux_state_put() - Put away the mux-state for good.
>> - * @mstate: The mux-state to put away.
>> - *
>> - * mux_control_put() reverses the effects of mux_control_get().
>> - */
>> -void mux_state_put(struct mux_state *mstate)
>> -{
>> -	mux_control_put(mstate->mux);
>> -	kfree(mstate);
>> -}
>> -EXPORT_SYMBOL_GPL(mux_state_put);
>> -
>> -static void devm_mux_state_release(struct device *dev, void *res)
>> -{
>> -	struct mux_state *mstate = *(struct mux_state **)res;
>> -
>> -	mux_state_put(mstate);
>> -}
>> -
>>  /**
>>   * devm_mux_control_get() - Get the mux-control for a device, with resource
>>   *			    management.
>> @@ -692,6 +673,26 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>>  
>> +/**
>> + * mux_state_put() - Put away the mux-state for good.
>> + * @mstate: The mux-state to put away.
>> + *
>> + * mux_control_put() reverses the effects of mux_control_get().
> 
> And, a couple of minutes later, I squashed in this on top:
> 
> - * mux_control_put() reverses the effects of mux_control_get().
> + * mux_state_put() reverses the effects of mux_state_get().
> 

And now I notice that there is no mux_state_get. There should be one,
in my opinion, at least if there is an exported mux_state_put.

So, Aswath, can you please test the patch that's coming as a reply
to this message on top of what is currently on its way into linux-next?

I.e. wait for the next linux-next to be released, or
https://gitlab.com/peda-linux/mux.git#for-next

Or, optionally, just grab the mux-state-get branch:

https://gitlab.com/peda-linux/mux.git#mux-state-get

Cheers,
Peter

> 
>> + */
>> +void mux_state_put(struct mux_state *mstate)
>> +{
>> +	mux_control_put(mstate->mux);
>> +	kfree(mstate);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_state_put);
>> +
>> +static void devm_mux_state_release(struct device *dev, void *res)
>> +{
>> +	struct mux_state *mstate = *(struct mux_state **)res;
>> +
>> +	mux_state_put(mstate);
>> +}
>> +
>>  /**
>>   * devm_mux_state_get() - Get the mux-state for a device, with resource
>>   *			  management.
>> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
>> index bf5abf062c21..babf2a744056 100644
>> --- a/include/linux/mux/consumer.h
>> +++ b/include/linux/mux/consumer.h
>> @@ -27,6 +27,7 @@ int __must_check mux_control_try_select_delay(struct mux_control *mux,
>>  					      unsigned int delay_us);
>>  int __must_check mux_state_try_select_delay(struct mux_state *mstate,
>>  					    unsigned int delay_us);
>> +
>>  static inline int __must_check mux_control_select(struct mux_control *mux,
>>  						  unsigned int state)
>>  {
>> @@ -37,6 +38,7 @@ static inline int __must_check mux_state_select(struct mux_state *mstate)
>>  {
>>  	return mux_state_select_delay(mstate, 0);
>>  }
>> +
>>  static inline int __must_check mux_control_try_select(struct mux_control *mux,
>>  						      unsigned int state)
>>  {
>>
