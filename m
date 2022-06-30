Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D7560FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiF3DdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiF3Dcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:32:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73D3F3ED1E;
        Wed, 29 Jun 2022 20:32:49 -0700 (PDT)
Received: from [192.168.87.140] (unknown [50.47.106.71])
        by linux.microsoft.com (Postfix) with ESMTPSA id AEA4320C356C;
        Wed, 29 Jun 2022 20:32:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEA4320C356C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656559969;
        bh=/k7/Ios7kMwnOVfXomswkjdfzlVmFyFC8zlXDL/hS7c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=icnBPCjZzmSx/YLBYV6S80B/dKMnpsEtN/EdokHorijjEuD6uHQb/NwcjU+frFkGW
         tYxunl1IfiV2rCdolLl/zSVZG0sIuoWlKuxczI3S2nb7zutD84Eb6eZQmbWtlHm8DO
         vs6v1s5deWk7d/WCzk4mFaR3G1GA1W3nWNQh6vQo=
Message-ID: <845139cd-f2df-3204-8639-297da145fec1@linux.microsoft.com>
Date:   Wed, 29 Jun 2022 20:32:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-3-neal_liu@aspeedtech.com>
 <c24d0e6d-d9ba-68c5-b1c8-13ad31d39ec8@linux.microsoft.com>
 <HK0PR06MB3202B894962013238CB93B2880BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <HK0PR06MB3202B894962013238CB93B2880BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2022 8:17 PM, Neal Liu wrote:
[...]
>> On 6/29/2022 2:44 AM, Neal Liu wrote:
>>> Add HACE reset bit definition for AST2500/AST2600.
>>>
>>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>>> ---
>>>    include/dt-bindings/clock/aspeed-clock.h  | 1 +
>>>    include/dt-bindings/clock/ast2600-clock.h | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/clock/aspeed-clock.h
>>> b/include/dt-bindings/clock/aspeed-clock.h
>>> index 9ff4f6e4558c..06d568382c77 100644
>>> --- a/include/dt-bindings/clock/aspeed-clock.h
>>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>>> @@ -52,5 +52,6 @@
>>>    #define ASPEED_RESET_I2C		7
>>>    #define ASPEED_RESET_AHB		8
>>>    #define ASPEED_RESET_CRT1		9
>>> +#define ASPEED_RESET_HACE		10
>>
>> NAK.
>>
>> I replied to older v5 of this patch, but this v6 also looks incorrect as per HW
>> manual.
>>
>> https://lore.kernel.org/linux-arm-kernel/20220629032008.1579899-1-neal_liu
>> @aspeedtech.com/T/#m000bd3388b3e41117aa0eef10bf6f8a6a3a85cce
>>
>> For both AST2400 and AST2500:
>> SCU04[10] = PECI.
>>
>> It will be best to refactor/split aspeed-clock.h into separate files.
> 
> Hi, based on @Krzysztof mentioned, change these define is not allowed due to breaking ABI.
> So another way is to define a new value(interface), and we can change driver's implementation.
> I know this is not intuitive to hardware register's value, it also confused me at the first time.
> 
> 

This is not SW ABI issue. Each controller in the device-tree needs
correct clock and reset paths. aspeed-clock.h is shared between g4 and 
g5 dtsi. Not sure how you picked bit 10 for HACE, it's for resetting
PECI controller.

See drivers/clk/clk-aspeed.c, which BTW is duplicating same stuff.
         [ASPEED_RESET_MIC]      = 18,
         [ASPEED_RESET_PWM]      =  9,
         [ASPEED_RESET_PECI]     = 10,

FWIW, the reset bit for HACE and MIC are interchanged for AST2400 and 
AST2500 (at least as per HW datasheet).

So this is really fixing what's apparently already broken.

Regards,
Dhananjay
