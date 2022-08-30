Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD145A6166
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3LNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3LN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226EAD9D40;
        Tue, 30 Aug 2022 04:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9641B61515;
        Tue, 30 Aug 2022 11:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A89BC433C1;
        Tue, 30 Aug 2022 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661858006;
        bh=jNG2gCWSllTupgHvGrYYT7PSUlHkq8MWcYG0y8EZTnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VR/Gg2PqVwxfODQVdOPHed+GMSCt5kWnEOktkTVShuBRbNw4+W2AdvwACXwYlXtUy
         yKhhnDH3iUR4R1Ln8FBX9pW+2qIRzQHA0XTmbVvAPvLIhc3wzYt2gdqh96O2M5JwDP
         bq2j+W2pWJ9ThC8IhytZUcY53oBRlq4qlQB0FJ+YAAvesw8IGKKRWs/NBWtFwqg69K
         5adafvTT6LbEuBFaPXC7M4edfbdCHQUDkl85dfEAWvSvUMVDdWB0fcqIF8lqmcX9PJ
         oGSeUx41CIJ9ldgBbO0fx8ms722Axin+RFflkcu1yWi8YGc0VxkgQU//oGEpNJVYW/
         wkH91MtjMrKwQ==
Message-ID: <7dff961e-908d-48de-fff1-8b6029d28eed@kernel.org>
Date:   Tue, 30 Aug 2022 14:13:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] phy: ti: gmii-sel: Add support for CPSW5G GMII SEL
 in J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20220822065631.27933-1-s-vadapalli@ti.com>
 <20220822065631.27933-3-s-vadapalli@ti.com>
 <655c39a3-cf5f-6dd7-3c1a-61ebeae915bd@kernel.org>
 <7dd27795-11d0-3147-ed86-959ff3e89df4@ti.com>
 <8ef8b2f8-a1c1-b277-22b1-6e951e8dfc72@kernel.org>
 <533a4186-62b1-ce7b-e097-9fb04be8f018@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <533a4186-62b1-ce7b-e097-9fb04be8f018@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddharth,

On 30/08/2022 07:31, Siddharth Vadapalli wrote:
> Hello Roger,
> 
> On 29/08/22 18:13, Roger Quadros wrote:
>> Siddharth,
>>
>> On 29/08/2022 07:53, Siddharth Vadapalli wrote:
>>> Hello Roger,
>>>
>>> On 25/08/22 13:11, Roger Quadros wrote:
>>>> Hi Siddharth,
>>>>
>>>> On 22/08/2022 09:56, Siddharth Vadapalli wrote:
>>>>> Each of the CPSW5G ports in J7200 support additional modes like QSGMII.
>>>>> Add a new compatible for J7200 to support the additional modes.
>>>>>
>>>>> In TI's J7200, each of the CPSW5G ethernet interfaces can act as a
>>>>> QSGMII or QSGMII-SUB port. The QSGMII interface is responsible for
>>>>> performing auto-negotiation between the MAC and the PHY while the rest of
>>>>> the interfaces are designated as QSGMII-SUB interfaces, indicating that
>>>>> they will not be taking part in the auto-negotiation process.
>>>>>
>>>>> To indicate the interface which will serve as the main QSGMII interface,
>>>>> add a property "ti,qsgmii-main-ports", whose value indicates the
>>>>> port number of the interface which shall serve as the main QSGMII
>>>>> interface. The rest of the interfaces are then assigned QSGMII-SUB mode by
>>>>> default.
>>>>
>>>> Can you please describe here why you are using "ti,qsgmii-main-ports" instead
>>>> of "ti,qsgmii-main-port" as there can be only one main port per PHY instance?
>>>
>>> Thank you for reviewing the patch. I am using "ports" instead of "port"
>>> because I plan to add support for CPSW9G on TI's J721e device in the
>>> future patches. CPSW9G (8 external ports) supports up to two QSGMII main
>>> ports. For CPSW9G, by specifying the two main ports in the device tree,
>>> it is possible to configure the CTRLMMR_ENETx_CTRL register for each of
>>> the 8 ports, with the two QSGMII main ports being configured as main
>>> ports in the CTRLMMR_ENETx_CTRL register and the rest of them being
>>> configured as sub ports. Since I will be using the same property
>>> "ti,qsgmii-main-ports" for CPSW9G as well, the property will be an array
>>> of 2 values for CPSW9G. Therefore, I am using "ports" instead of "port".
>>> Please let me know if this is fine.
>>>
>>
>> OK. Please mention this in commit message.
> 
> I will mention that the property ti,qsgmii-main-ports is used to
> configure the CTRLMMR_ENETx_CTRL register and that it is possible
> depending on the device for there to be more than one main port which is
> why the property is an array of values.
> 
> Would it be sufficient to mention the above in the commit message?
> Please let me know.

This is fine. Thanks.

cheers,
-roger
