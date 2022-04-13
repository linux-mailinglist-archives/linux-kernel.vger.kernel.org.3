Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459774FF73B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiDMM7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiDMM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:59:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB463554AF;
        Wed, 13 Apr 2022 05:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E9BCB82404;
        Wed, 13 Apr 2022 12:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BD2C385A3;
        Wed, 13 Apr 2022 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649854605;
        bh=KY1QcnvyktxSRWr137x4skG3AIinv+0KnvxCF19MUt8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EDn5j0d9jAos2CiGXraQoLtwzqgj+tTDgP434K1hYb0SzcthRJsU3akeC4BD7IFy8
         DwmB5IsXsIxsuOLR41a5OBI/lcdxuwmol6IDpWE7iy+cCngzncJEKpRqWFl4VTGgJ3
         pOaa5s6SmrIKU0XdCw9rDIY7vNpdZM8KpqcjTldXxE+N6xAnj9ZSqgq1441T8HK6Dp
         KDEsGu3X4oO98J/71ubP81LNr0B/qVyZEDLREVN1WW4nyT77sfG6yomrj4/wLmjhN5
         X5SYg/ichVTD9xk+xScxmE0ZMWh/ezhs5BciDGxAU89Tq9xvmVxrWGYPGqwnERMiUo
         QQ4gpGWwRU3nA==
Message-ID: <4681b00e-7f89-d9c4-6361-b781ced72656@kernel.org>
Date:   Wed, 13 Apr 2022 15:56:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
 <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
 <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
 <605268c7-9d0f-83d5-d7e6-850dabb380f0@kernel.org>
 <06852353-9ca1-6f61-7447-b5f1d64ead25@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <06852353-9ca1-6f61-7447-b5f1d64ead25@linaro.org>
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



On 13/04/2022 15:31, Krzysztof Kozlowski wrote:
> On 13/04/2022 13:56, Roger Quadros wrote:
>>
>>
>> On 13/04/2022 14:47, Krzysztof Kozlowski wrote:
>>> On 13/04/2022 13:33, Roger Quadros wrote:
>>>>> Previously it was building with COMPILE_TEST on sparc, so what else changed?
>>>>>
>>>> Previously it was like so
>>>>
>>>> 	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>>>> 	depends on OF_ADDRESS
>>>>
>>>> Means it won't build if OF_ADDRESS is not set even if COMPILE_TEST is set.
>>>>
>>>> And OF_ADDRESS is not set for sparc
>>>>
>>>
>>> Ah, yes, so dropping COMPILE_TEST seems the solution. There are no other
>>> "depends" here.
>>
>> But the build failed at irq_domain_remove() which is only available if IRQ_DOMAIN
>> is enabled.
>>
>> It could be possible that OF_ADDRESS is enabled but IRQ_DOMAIN is not right?
> 
> I must admit I did not dig this that much. OF_ADDRESS has !SPARC
> dependency, so after removing COMPILE_TEST the issue should not happen
> on SPARC. What about other platforms? They should behave I think the
> same as before - fail if they were failing. Nothing gets worse which is
> my main concern here.
> 
> If you have spare time, maybe you could investigate the compile testing
> on other platforms as well and if something fails, fix it. But it seems
> it is separate problem.
> 

I won't be able to test on all platforms. I'm ok to not add more dependency and
just drop COMPILE_TEST.

cheers,
-roger
