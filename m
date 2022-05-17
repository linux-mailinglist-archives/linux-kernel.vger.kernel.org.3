Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604B3529CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiEQIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiEQIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:48:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3F43ADB;
        Tue, 17 May 2022 01:48:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r23so7711587wrr.2;
        Tue, 17 May 2022 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=dYNmO9yR7Q7576xbxhOmOadNAWD8PBDUv92pl5HZCXs=;
        b=F7g+xOm9FjaBFZkKHw9RG5giyrBniDa8HRlmwqzWRkPCGsgNMH0x3OgIgl6IHGcOu2
         m5iLNUOMlW+ZmanHnMaDUteT2t44SS4tMBmYlCBKLAMjyLPu3bCp3b1MMGoMSFNRYwUw
         GpdSvsmuxvpq7qXdxaWfZ+IEJVECVYTSRTHzHUDuZYmI3UFLsatDN9lYH0gWsy97yh4j
         UUYx7Ef9njEUVlgDrCQiPzJ9losGprQp0PSr2hKETLIs1i8oB73P300tJaQBpKx57Fj6
         xDoLCZfm/lttrhl62hal3RZB/yGZMeQTqnDv3jrBg+45yWqhjyVRzgcnZz9+yEwgs1Wz
         JdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=dYNmO9yR7Q7576xbxhOmOadNAWD8PBDUv92pl5HZCXs=;
        b=4VuYjc8LT5Tn9P2jq+8rxfwMUNePyCfJZv+WUhESlBk0JFQerXmisoXgZOG2d4iZfb
         LkF6557EJLVbO7gLo7r5iY3zi49YdO6vac83yShCUO1cKPShkGDYtO1jEtedxWe3Q07s
         1mvsfGBqKhX60mohCrRsgZ7vKZZe8U3mFPLgKOHRd91RPSKEYz6QuTFKqDVHStpLe+ZD
         yk9TPNhgVvL3NTK+MzAhD4+nqQur5of04lPx4MKS8dDo7/1Ad6+B8hknXFQdCB08F6gv
         4ltyWMX2Zp+wV9yFyKckiG1YaFkjLFw+gEbM+/ThYZS3QLGMpu93NjnreK8dZUeKV38Z
         6rNA==
X-Gm-Message-State: AOAM532lxQHPZt9mdY53AJ/PwQNgiKWrPwQ8lqcN9WUf/Bd/+AZ4frVQ
        xdCxMYXETNdk+qT/+ufZErs=
X-Google-Smtp-Source: ABdhPJyaSqlxkH+LHr5o/GxH2V7qOXxrecaZtXgSeCb5eYOvJdleQWKpRLslqOZqBFpTRdyVakQ1/A==
X-Received: by 2002:a5d:6351:0:b0:20d:1028:3c32 with SMTP id b17-20020a5d6351000000b0020d10283c32mr4847625wrw.331.1652777286426;
        Tue, 17 May 2022 01:48:06 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a25-20020adfb519000000b0020c5253d90asm11324560wrd.86.2022.05.17.01.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:48:05 -0700 (PDT)
Message-ID: <739b3ccc-e8ac-2748-9d40-0666a4038876@gmail.com>
Date:   Tue, 17 May 2022 10:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <20220513165050.500831-6-angelogioacchino.delregno@collabora.com>
 <8177c547-2a38-691b-0a32-bc7e6ba1e2ed@gmail.com>
 <b65546e1-2d3a-d525-b664-1730dc06994f@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 5/5] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
In-Reply-To: <b65546e1-2d3a-d525-b664-1730dc06994f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On 17/05/2022 10:07, AngeloGioacchino Del Regno wrote:
> Il 16/05/22 13:30, Matthias Brugger ha scritto:
>>
>>
>> On 13/05/2022 18:50, AngeloGioacchino Del Regno wrote:
>>> Add the clock drivers for the entire clock tree of MediaTek Helio X10
>>> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
>>> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>
>> Thanks a lot for taking care of this!
>> I just wonder if we couldn't build most of the clock drivers as modules like 
>> done for the mt6779. It would help us to keep the kernel image smaller.
>>
> 
> Hello Matthias!
> 
> You're welcome!
> ...but I simply couldn't stand at seeing partially working (..or actually, not
> really working) SoCs upstream. If something is upstream, it must work, or it
> shouldn't be here for real :-)
> 
> Regarding your question about the clock drivers as module... I believe we can,
> but that'd be only for {vdec,venc}sys and *maybe* MFG (gpu clocks): I don't know
> if it'd be worth to do, as these are about... 8 clocks out of... I haven't counted
> them, but more than 250, I think?
> 
> It *should* be straightforward though, just about giving them a tristate in Kconfig
> instead of a bool, but that would still be limited to just those three...
> 

I think you could guide yourself by looking at
f09b9460a5e4 ("clk: mediatek: support COMMON_CLK_MT6779 module build")


I think having clocks as modules is a criteria to be part of Android's Generic 
Kernel Image. Not that we target this here, just for your information (in case 
you didn't know).

> The reason for me excluding clk-mt6795-mm from this choice is that - at least for
> me - my development platform is a commercial smartphone, where the only thing that
> "saves you" is having some display output... I mean - I *do* have a UART port, but
> that's only because I've been able to solder thin wires on 0.2mm pads... you surely
> agree on the fact that this isn't a common practice, even across developers.
> 

Yes I was wondering if you got some development smartphone or you did the 
soldering. I have some solder knowledge but I think not enough to solder 
something like this :D

> Besides, if you think that clk-mt6795-mm should indeed be a module by default,
> well, that.. is.. possible - I don't see why it shouldn't be... obviously keeping
> in mind that this will largely slow down the boot process, which isn't a big issue.
> 

Well I don't want to bother you with minor details, most important thing is that 
we get support upstream... but ;) you can always mark the modules as compiled 
in, even if it's tristate, which in your case you want to do.

> In any case, it is *not* possible to compile as module *any* of the clock drivers
> that I have included in the CONFIG_COMMON_CLK_MT6795 (apmixed, infra, peri, topck)
> as.. you know.. these are "a bit critical" on older platforms :-)
> 
> 
> How would you proceed?
> 

I'd make all the drivers that theoretically can be build as modules tristate, 
you can then define for your development environment to make them build-in.

Sounds good?

Regards,
Matthias
