Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243D520FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiEJIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiEJIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:31:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CD36E0F;
        Tue, 10 May 2022 01:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA5E612E8;
        Tue, 10 May 2022 08:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DAFC385A6;
        Tue, 10 May 2022 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652171225;
        bh=OFrK7CAAs1gsU8WZ3xFwTbQX6JjrB8rkbIgLOwzGskk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bhJYQJtWpSGNWpxUcM+xrY3PtUWDvXz/xPqwDqB6zdhp/GudoGPl7pWYZnQhsBjuQ
         6HIMbvmXyK4x0e5QKfqS3QAP2h6Vz2MmbrR/OkrSm8DOE7apWLeqYgduaynDYsJ5zU
         dnVEMnjVAlhL/8f5kBkr1nAg9Ggg1tVzloQAiRUjTklOyv9VVo9b4w1IlAUBlknMLu
         kypypc+dNG1k47/gKqjkqSXxpf6apcIV96M+PEYHow+YyaHRGyKIYR6UApqclGuEHR
         5p4mS8NcjyPyI+LbWf1yN6EZFdar3ivQtE1Gvb0JIvl7vlJSduoeJsMLtjsS8nGuyn
         YWcoofXg2T/iQ==
Message-ID: <4bee472c-07b1-469a-820a-e11e5c99dabc@kernel.org>
Date:   Tue, 10 May 2022 11:27:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
 ARCH_K3
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
 <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
 <22ed864d-8d71-7042-4d55-2b0b65d4d281@kernel.org>
 <CAMuHMdVFHeJvXAfb-Q1WGvDEuKTeVx-3fmmPu18Ci2yoNinMuA@mail.gmail.com>
 <5cec89ab-76f7-65d5-0b1d-fdd768234f0e@kernel.org>
 <CAMuHMdW6VH-N7gx+YtccexE7jprvigJDstu_00FJXtH3d45Wdg@mail.gmail.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAMuHMdW6VH-N7gx+YtccexE7jprvigJDstu_00FJXtH3d45Wdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert,

On 10/05/2022 11:17, Geert Uytterhoeven wrote:
> Hi Roger,
> 
> On Tue, May 10, 2022 at 10:10 AM Roger Quadros <rogerq@kernel.org> wrote:
>> On 10/05/2022 11:06, Geert Uytterhoeven wrote:
>>> On Tue, May 10, 2022 at 9:40 AM Roger Quadros <rogerq@kernel.org> wrote:
>>>> On 10/05/2022 10:30, Geert Uytterhoeven wrote:
>>>>> On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
>>>>>> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
>>>>>>> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
>>>>>>> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
>>>>>>> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
>>>>>>> asking the user about this driver when configuring a kernel without
>>>>>>> OMAP2+ or K3 SoC family support.
>>>>>>>
>>>>>>> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
>>>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>>> Could you please also add ARCH_KEYSTONE in the 'depends on' list
>>>> as some SoCs in that architecture do have the GPMC block.
>>>
>>> Are you sure? AFAICS, none of the Keystone DTS files have device
>>> nodes that are compatible with the match list in the omap-gpmc driver.
>>
>> Yes, the 66AK2G12 SoC contains the GPMC module. [1]
>>
>>> Or perhaps the GPMC support still has to be added to the Keystone
>>> DTS files (and or driver)?
>>
>> That's most likely the case.
> 
> So would it make sense to compile the omap-gpmc driver on keystone
> yet, or does that need the introduction of e.g. a ti,k2g-gpmc compatible
> value first, and thus should it be postponed?

It doesn't harm to be available for keystone already.
Maybe it will save TI Keystone users some pain as to why OMAP_GPMC is no longer
available for Keystone. Let's not affect such users. Thanks!

cheers,
-roger
