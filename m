Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1929C5AAC25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiIBKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIBKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:13:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8E101A;
        Fri,  2 Sep 2022 03:12:57 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEFE26601F03;
        Fri,  2 Sep 2022 11:12:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662113575;
        bh=uPwA05/mzppSgHqnQObaTSbjueljkx5JGjGCVIFaX/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kPZgY93OKHOGvRZLDJeVcLlegA/q+BYNmivqJPMl9tMwfq9YLFz2qOH+o20c2DOS2
         4NonJ4WJPIP5t4/AHYTQjZY+uI3CNxoUCfT9tpB5bdnXaD6aBTLigNlV6kV6r2vMYA
         c6G7rh66/ZN1N+6E59YhzyEeAARtSivDETcsTmE0T98vaHRgh9mbHCkxbZxqCL5Dxg
         r59DPFah2gscMSGZbPOykzM9xfyOaPy4vHYLRveYWt7XNmwbVYexDh4ZIef0WxWuAP
         p30bjgATWCyhMgg/ODF0W0Yc9YkftjR7F87nc18lduiyNzNcCYVV80yketeeX4uhBa
         2PhCLMGBsoK+g==
Message-ID: <092ed898-dee9-e27f-1f18-3a17b259563e@collabora.com>
Date:   Fri, 2 Sep 2022 13:12:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/3] Enable initial support for StarFive VisionFive V1 SBC
Content-Language: en-US
To:     Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        michael.zhu@starfivetech.com, drew@beagleboard.org, kernel@esmil.dk
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
 <04151f8b-5722-b5a0-a4ab-4958f55b8dec@microchip.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <04151f8b-5722-b5a0-a4ab-4958f55b8dec@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/2/22 09:27, Conor.Dooley@microchip.com wrote:
> On 01/09/2022 23:42, Cristian Ciocaltea wrote:
>> [You don't often get email from cristian.ciocaltea@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> The StarFive VisionFive V1 SBC [1] is similar with the already supported
>> BeagleV Starlight Beta board, both being based on the StarFive JH7100 SoC.
>>
>> In addition to documenting the necessary compatibles, this patch series
>> moves most of the content from jh7100-beaglev-starlight.dts to a new file
>> jh7100-common.dtsi, to be shared between the two boards.
>>
>> No other changes are required in order to successfully boot the board.
> 
> Gave it a go this morning, dts stuff itself looks good to me. No new
> warnings, although that's to be expected, & boots fine.
> 
> I know that most jn7100 stuff is not really wanted upstream, but I'd
> say that the minimal vision5 dts is an exception to that, so with the
> one comment on patch 1 resolved:
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the quick review, I have submitted v2:

https://lore.kernel.org/all/20220902100806.2378543-1-cristian.ciocaltea@collabora.com/

Regards,
Cristian

> Thanks,
> Conor.
> 
>>
>> [1] https://github.com/starfive-tech/VisionFive
>>
>> Cristian Ciocaltea (3):
>>     dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
>>     riscv: dts: starfive: Add common DT for JH7100 based boards
>>     riscv: dts: starfive: Add StarFive VisionFive V1 device tree
>>
>>    .../devicetree/bindings/riscv/starfive.yaml   |   3 +
>>    arch/riscv/boot/dts/starfive/Makefile         |   2 +-
>>    .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +----------------
>>    .../boot/dts/starfive/jh7100-common.dtsi      | 161 ++++++++++++++++++
>>    .../jh7100-starfive-visionfive-v1.dts         |  20 +++
>>    5 files changed, 186 insertions(+), 153 deletions(-)
>>    create mode 100644 arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>>    create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
>>
>> --
>> 2.37.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
