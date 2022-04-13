Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348424FF562
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiDMLEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiDMLEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0188527FA;
        Wed, 13 Apr 2022 04:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C92F61BBE;
        Wed, 13 Apr 2022 11:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D309BC385A3;
        Wed, 13 Apr 2022 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649847715;
        bh=rrm2ErL60KzXsdvNT5DxTs1wy1pJhhiMDLhHjhX/QCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZqvSremG8E0HySuXcqwiAdDgmBeK6aGqd8NXNU/NjoVhQG7ZNa7+1F/me9fXGvdXr
         STtrQLhcVX7njW3MB6u5pGAbS1GVOQNItSKEwphK5vY/VG1fIRTj0FZl9Bet+ceIdF
         ZCu4ixWGCMgdrRv5wcqOH6QXKc5BOYLOrQxyZ/ziWW4uyV+8XIFqoTlBgzBAIm6qIb
         PLVtnG6Eien22LQwtC4jt5z4SRz52P7ta03bI4n0El2g+fPJ/uc0oeoJDBi9c6QEyi
         yKw0OBM8DLCJEl4mbLovYP2UGNkBomCkmKgOlCGRABVZ+yCyzki+1UdcS8M5aoBbqd
         qeJmQJOxkKAJw==
Message-ID: <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
Date:   Wed, 13 Apr 2022 14:01:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzk@kernel.org
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 13:20, Krzysztof Kozlowski wrote:
> On 13/04/2022 11:50, Krzysztof Kozlowski wrote:
>> On 13/04/2022 11:43, Krzysztof Kozlowski wrote:
>>> On Mon, 11 Apr 2022 12:55:14 +0300, Roger Quadros wrote:
>>>> These patches allow OMAP_GPMC config to be visible in menuconfig
>>>> and buildable as a module.
>>>>
>>>> Changelog:
>>>> v3:
>>>> - Remove not required MODULE_ALIAS
>>>> - Mention in commit message why we need to remove of_match_node() call
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
>>>       commit: 656d1be692be78b825954e0a2a47fcae81834633
>>> [2/2] memory: omap-gpmc: Allow building as a module
>>>       commit: eb55c7180be67774aa728a3c450de441e0dedb5d
>>
>> And dropped. You have a checkpatch issue:
>>
>> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module:
>> Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
>> #127: FILE: drivers/memory/omap-gpmc.c:2664:
>> +MODULE_LICENSE("GPL v2");
> 
> I kept your first patch (visible/selectable) but I think it should be
> dropped as well. You need to test it more:
> 
> https://krzk.eu/#/builders/63/builds/162
> 
> 
>>  config OMAP_GPMC
>> -	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>> -	depends on OF_ADDRESS
>> +	bool "Texas Instruments OMAP SoC GPMC driver"
>> +	depends on OF_ADDRESS || COMPILE_TEST


Looks like include/linux/irqdomain.h does not have fallbacks if
CONFIG_IRQ_DOMAIN is not enabled.

I'll have to drop COMPILE_TEST and add depends on IRQ_DOMAIN.
Is that OK?

cheers,
-roger
