Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4855DC86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiF0VST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiF0VSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:18:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD618B02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:18:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so14785151wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7fqf134knRgs1GXmfgOSjMnBIhN/vd4XYE5cKns7XrQ=;
        b=HXbtK2wb/8k7BKwx03O3vJd+frVE8kbRJOxAidgzWU3+M46idUPj4JY/ji2or61qN6
         iFQfdI2q9HbabuCUzIKyuCuZZP+svfWOurR7utrBBG8lxHgf64RUya9tYBYoq/IZnb3/
         vASCFCOveG3OPw4M9ElkzqOYoiWkSkXpjjzjUUkhiJcB7Uovli7STe8/BYj4orSkm5AF
         LTlyYI4wyNCu+hgP9xZwpFMXRxL0suMMMq/Wud/F2UCWdoxIQljh+9HLdF+xzDphLUPc
         JhfNdVvIWSYHIRmsF16qeXPK1XW0ExS6lCFXaFznUtqNyynV9EM41UOdeXzlroAzAzkv
         hWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7fqf134knRgs1GXmfgOSjMnBIhN/vd4XYE5cKns7XrQ=;
        b=P/kR8R6joLqa2kI2gb/ONoZuJGe7+a2Eve3Y3V9UChU0uaJADx6VUERwWNOqNyNpko
         IvyMTJmTiTFjFdgH2FUNvVJl6BYP/fGhNdO/BZfbBRjc1kAMIWoEdFauIlM6KR6MLxHp
         vt7M3qvWc/+p6Zw2krMWSh+jJb21t488duO64wjVGYCkTFn/OOsU/ZqXCwUEj/Ldpdo+
         VD5JWFau7no1lLemI4UVi5sH5OxUIGt8vMy9ar4hpMgzXZtv1kQHIJcrSVH5VYUbfiFO
         d4lYi8P3FqLQXsjjgbpOO0IRo4ZxybJcewvpZMR8y5bV4Hp2yTZG4aYfzhCs8zt0TPEp
         5CWA==
X-Gm-Message-State: AJIora8qnyi9EU4GrIcq0dI62LQwxIqf3s/d7MEOBQ72GjmXBx7cb7UT
        gdIhVcLfgvwPUhX9dQuMTGo5RA==
X-Google-Smtp-Source: AGRyM1v3rnjEGEokBmIwXs+uwnFrAQV1ikK8BVpbbLHWxG5jXedwQJfIfb9jsTWa7DY6Tagub7QPEA==
X-Received: by 2002:adf:d1ed:0:b0:21b:c74b:594 with SMTP id g13-20020adfd1ed000000b0021bc74b0594mr8958606wrd.221.1656364689777;
        Mon, 27 Jun 2022 14:18:09 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az14-20020a05600c600e00b003a04c74efd1sm3048630wmb.21.2022.06.27.14.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 14:18:09 -0700 (PDT)
Message-ID: <ed893417-2c5e-c019-04c6-c7c7ee138ef1@conchuod.ie>
Date:   Mon, 27 Jun 2022 22:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 06/16] dt-bindings: timer: add Canaan k210 to Synopsys
 DesignWare timer
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220627194003.2395484-1-mail@conchuod.ie>
 <20220627194003.2395484-7-mail@conchuod.ie>
 <20220627211314.dc2hempelyl5ayjg@mobilestation>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220627211314.dc2hempelyl5ayjg@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 22:13, Serge Semin wrote:
> On Mon, Jun 27, 2022 at 08:39:54PM +0100, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> The Canaan k210 apparently has a Sysnopsys Designware timer but
>> according to the documentation & devicetree it has 2 interrupts rather
>> than the standard one. Add a custom compatible that supports the 2
>> interrupt configuration and falls back to the standard binding (which
>> is currently the one in use in the devicetree entry).
>>
> 
>> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
> 
> Firstly, it's page 51 in the framework of the document pages
> enumeration.

Ah yes, sorry about that.

> 
> Judging by the comment in the document above and what the HW reference
> manual says regarding the IRQ signals, what you really have on K210 is
> the DW APB Timer IP-cores each configured with two embedded timers.
> It's done by the IP-core synthesize parameter NUM_TIMERS={1..8}, which
> in your case equals to 2. A similar situation is on our SoC and, for
> instance, here:
> 
> arch/arm/boot/dts/berlin2q.dtsi
> arch/arm/boot/dts/berlin2.dtsi
> arch/arm/boot/dts/berlin2cd.dtsi
> (Though the Berlin2 APB Timer have been configured with 8 timers.)
> 
> So the correct modification would be:
> 1. Split up the nodes into two ones with one IRQ per each node.
> 2. Make sure I was right by testing the new dts out.
> 3. Update the DT-node only and leave the DT-bindings as is.

Hmm, sounds good. Will give that a whirl tomorrow.
Thanks for the info/suggestions Sergey.

