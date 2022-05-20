Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9216852EA82
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348405AbiETLIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348381AbiETLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:08:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01945E158;
        Fri, 20 May 2022 04:08:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h11so9192792eda.8;
        Fri, 20 May 2022 04:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=wlQFcAca27d557iyLHKZteGlwX1770hELz16/xPa+8Q=;
        b=bklKJ6UXW0xCPulf0dQx92suPVOMuz5yaRi7JTRNFJ7r4rIggcoMihm4zRWqbP8F5x
         9m3fANlOUQwSl7ioBZzNZBTs5jfsrLLwTTR96TwMQr1Mcat07nhwNMTja/igVl+wL/kQ
         PH03npVCT599dBx5BJe6bOQmfUACCoPKRfWG/44qMo+V3RAXVEl4WjxJdT17n67vwB7k
         ojWj8SNTvlWzIw/suxss3I4oPViyocM9sBbm3OaQKx8qi6TKMHOf9l5rPiUJYrwwcfsF
         x0G5lNy5dV17oAX2BbBEdNMK0PNrzNiR3amGgoRqnc8V78uLRpdziYwemlzLMi1w78cT
         703w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=wlQFcAca27d557iyLHKZteGlwX1770hELz16/xPa+8Q=;
        b=5xi5RGOTyk3rFoUncNC9yx7x11QFtrS+9Ym8KY7X1BXKg6kRaU3+eSZxPkv1Q6lDzx
         r03oUWw/JlRNxaN5II3HoP0RHldwtyZmDwnypqmbyLH8rLCqnWPkThcHVTu0b7/g2cx8
         bElBUC1/scZZGng4ogZtIuNso53XQDHxZay102Au9ICMAvbgfmK5Ol9TjiBYZ7yXY9x8
         obc0lYXW90Jv7G8G00Io66bgL1GVdc1H0GZukYSFiLxoONbepD2trmM6yUBdENvsh34V
         CTTYiqPt603z9mE6gtNDqOtUcP0ShFl7Rus8ptSnvl7pDufG9t0EvbsEp6o7pYe1nodr
         8Szg==
X-Gm-Message-State: AOAM531HXPgFXs5569sTzFmP+N6OA4lTb7HxT4AvhGTuhGuPyOCT6Aon
        NyMpsPA3YcgUkmBH5IRcbneGUoWGQl3FoTFN
X-Google-Smtp-Source: ABdhPJxf/pqeax60rE9s5Nx9mijIV86CCyBP/x+MpqXmCQE5BL3CUFZiZs7lK9NHw5gJl382GO8pjA==
X-Received: by 2002:aa7:d911:0:b0:42a:af69:e167 with SMTP id a17-20020aa7d911000000b0042aaf69e167mr10106367edr.54.1653044921181;
        Fri, 20 May 2022 04:08:41 -0700 (PDT)
Received: from yassine-HP ([2001:1670:c:db50:2f51:85b4:f668:c64f])
        by smtp.gmail.com with ESMTPSA id eo20-20020a1709069b1400b006f3ef214e58sm3038018ejc.190.2022.05.20.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:08:40 -0700 (PDT)
Date:   Fri, 20 May 2022 15:08:26 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock drivers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Miles Chen <miles.chen@mediatek.com>, bgolaszewski@baylibre.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        ikjn@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sam.shih@mediatek.com,
        sboyd@kernel.org, tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        wenst@chromium.org, y.oudjana@protonmail.com,
        ~postmarketos/upstreaming@lists.sr.ht
Message-Id: <2MH6CR.16DFWCVHBCV@gmail.com>
In-Reply-To: <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
References: <NJC6CR.M4CF312LSXXV1@gmail.com>
        <20220520093501.28758-1-miles.chen@mediatek.com>
        <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 20 2022 at 12:26:25 +0200, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 20/05/22 11:35, Miles Chen ha scritto:
>> 
>>>> 
>>>> Thanks for submitting this patch.
>>>> 
>>>> I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
>>>> and other clk files are using macros to make the mtk_pll_data array
>>>> more readable.
>>> 
>>> I'd actually argue that macros make it less readable. While reading
>>> other drivers I had a lot of trouble figuring out which argument
>>> is which field of the struct, and had to constantly go back to the
>>> macro definitions and count arguments to find it. Having it this
>>> way, each value is labeled clearly with the field it's in. I think
>>> the tradeoff between line count and readability here is worth it.
>> 
>> It is easier for multiple developers to work together if we have a 
>> common style.
>> 
>> How do you think?
>> 
> 
> In my opinion, Yassine is definitely right about this one: unrolling 
> these macros
> will make the code more readable, even though this has the side 
> effect of making
> it bigger in the source code form (obviously, when compiled, it's 
> going to be the
> exact same size).
> 
> I wouldn't mind getting this clock driver in without the usage of 
> macros, as much
> as I wouldn't mind converting all of the existing drivers to 
> open-code everything
> instead of using macros that you have to find in various headers... 
> this practice
> was done in multiple drivers (clock or elsewhere), so I don't think 
> that it would
> actually be a bad idea to do it here on MediaTek too, even though I'm 
> not aware of
> any *rule* that may want us to do that: if you check across 
> drivers/clk/*, there's
> a big split in how drivers are made, where some are using macros 
> (davinci, renesas,
> samsung, sprd, etc), and some are not (bcm, sunxi-ng, qcom, tegra, 
> versatile, etc),
> so it's really "do it as you wish"...
> 
> ... *but:*
> 
> Apart from that, I also don't think that it is a good idea to convert 
> the other
> MTK clock drivers right now, as this would make the upstreaming of 
> MediaTek clock
> drivers harder for some of the community in this moment... especially 
> when we look
> at how many MTK SoCs are out there in the wild, and how many we have 
> upstream:
> something like 10% of them, or less.
> 
> I see the huge benefit of having a bigger community around MediaTek 
> platforms as
> that's beneficial to get a way better support and solidity for all 
> SoCs as they
> are sharing the same drivers and same framework, and expanding the 
> support to more
> of them will only make it better with highly valuable community 
> contributions.
> 
> 
> That said, Yassine, you should've understood that you have my full 
> support on
> unrolling these macros - but it's not time to do that yet: you 
> definitely know
> that MediaTek clock drivers are going through a big cleanup phase 
> which is, at
> this point, unavoidable... if we are able to get the aid of scripts 
> (cocci and
> others), that will make our life easier in this cleanup, and will 
> also make us
> able to perform the entire cleanup with less effort and in less 
> overall time.
> 
> With that, I'm sad but I have to support Miles' decision on this one, 
> and I also
> have to ask you to use macros in this driver.
> 
> 
> I am sure - and it is my wish - to see MediaTek clock drivers 
> open-coding stuff
> instead of using macros, but that's something for the future - which 
> will happen
> after the more important cleanups.
> 
> After all, it will be just about running "gcc -E xxxx.c" and 
> copy-pasting the
> unrolled macros to the clock drivers, which will be pretty fast and 
> straightforward.
> 
> Sorry for the wall of text, by the way.
> 
> Cheers,
> Angelo

Fair enough. I'll switch to macros in the next version.

Thanks,
Yassine


