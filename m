Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB375866DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiHAJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:32:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41F31918
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:32:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id uj29so6104317ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JMy4E/ztvPyPIu2vFaZUutGsl9gWHvzFeEWtkrfXhHg=;
        b=KKaQB9R7YLuhLCPfTDSlB6M/w4RrAhDZ2rcdgkcsDMHqvyX3kU6X3L9d1TnagMbbIV
         ZM6xBUZDE3dh34XnGVuV2Op4V0/BWPL0DUUOrFs7hczKCkQqXlziqk9a9RDt80oMwv8S
         gwu0sM6/wCsL/LPNRVp3yN0LpLd1JPnvfxJDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JMy4E/ztvPyPIu2vFaZUutGsl9gWHvzFeEWtkrfXhHg=;
        b=s/sfL1AV+kqNyGWUqhP3yhq5A3UblSkjtvjIv3WoOhg6Nlm9Ia4WSwsx9Hjluo0HnL
         NDdourn/nnb1pa+CSm3BjFNxYg4Nd30ZMp1K7RGmk4O3jKCuJSPxQvlVNa1Z60TgiOU1
         ykFH4UO8ixW6/C5ZbujpnYAAS+ta1+mf2ndNR04ls/DLlcHF2w9svQl0dSHxl0lUUqG+
         5TebJPHrlJ6VRqq7KKpPDpK/AAn3tNXsxzdezUTzJQ3Djvtj2BfdXMp25q5pn8QQ/CY4
         o10dlc4Wa/qvcc6wlVyRi1CWAwN0QRXtE1PTNzanZZsLmUCT++z8Cnb+9o12iQ6uQHv7
         E87w==
X-Gm-Message-State: ACgBeo0hyC/ozM5x/s016GP5x9i1vbu4pG/17BfZ1NdSFC6briVz+nRE
        ijP1l87ZpCywUQbw83l+5RzfCBPBSchzBGreFYG0GQ==
X-Google-Smtp-Source: AA6agR6K7PNaBZMXrL5ffNGGYhxQCNyw8wdKgDHTFzPYoCNydGawG8GjwGXlsjSkYiU1D/UICwVQXLdlijnebaXEKvs=
X-Received: by 2002:a17:907:7b8e:b0:730:7295:fdfd with SMTP id
 ne14-20020a1709077b8e00b007307295fdfdmr4363438ejc.152.1659346324534; Mon, 01
 Aug 2022 02:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220726062057.320342-1-wenst@chromium.org> <91613700-3335-7499-1b48-3d88edd9da36@collabora.com>
 <fc64285e-30c7-44b1-e264-839944105185@roeck-us.net>
In-Reply-To: <fc64285e-30c7-44b1-e264-839944105185@roeck-us.net>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 1 Aug 2022 17:31:53 +0800
Message-ID: <CAGXv+5EHYJBTvXxB-HdqVDzSNU7bqHRSBxKfonVm_p5jjYyMSQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: mtk_wdt: Move mt6589-wdt fallback compatible to
 end of list
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 9:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/26/22 01:37, AngeloGioacchino Del Regno wrote:
> > Il 26/07/22 08:20, Chen-Yu Tsai ha scritto:
> >> The watchdog facility in the MediaTek SoCs are all the same, but the
> >> hardware block also contains a reset controller, which differs in the
> >> number of resets used between different SoCs. This difference is
> >> supported with of_device_get_match_data() supplying the number of reset
> >> lines for the newer compatible strings. The original mt6589-wdt only
> >> covers the watchdog facility.
> >>
> >> of_device_is_compatible(), and by extension of_device_get_match_data(),
> >> works by going through the given list of compatible strings sequentially,
> >> and checks if any of the device node's compatible strings match.
> >>
> >> To avoid early matching on the "mediatek,mt6589-wdt" fallback compatible,
> >> which only provides watchdog functionality and no reset controller, move
> >> the fallback entry to the end of the list, so that other, more specific
> >> compatible strings have a chance at getting matched.
> >>
> >> Fixes: c254e103082b ("watchdog: mtk_wdt: mt8183: Add reset controller")
> >> Fixes: adc318a34066 ("watchdog: mt8192: add wdt support")
> >> Fixes: 8c6b5ea6ac68 ("watchdog: mediatek: mt8195: add wdt support")
> >> Fixes: 4dbabc4d9e8c ("watchdog: mediatek: mt8186: add wdt support")
> >> Fixes: 711a5b25bac9 ("watchdog: mtk_wdt: mt7986: Add toprgu reset controller support")
> >> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Uhm, I don't think that this is an issue?
> >
> > Ordering precedence is given to the list that you specify in devicetree, that's why
> > "the second one" is a fallback, meaning: ("impossible" example below)
> >
> > compatible = "mediatek,mt8195-wdt", "mediatek,mt8183-wdt", "mediatek,mt6589-wdt";
> >
> > This gets walked as per the order in which you wrote the compatibles, so:
> > * Check match for mt8195-wdt, does not exist?
> >   * Check match for mt8183-wdt, exists!
> >   * Put everything into dev->of_node (having mediatek,mt8183-wdt only!)
> >
> > __of_device_is_compatible() gets dev->of_node and compares that to all of the
> > possible matches.
> >
> > struct device_node for this device hence does *not* contain any of the other
> > compatibles that we specified in devicetree, so it does *not* contain any of
> > "mediatek,mt8195-wdt", or "mediatek,mt6589-wdt", because we have previously
> > successfully matches 8183.
> >
> > I don't think that I've misinterpreted this flow, but if I have, let's pull
> > in devicetree people and check with them?
> >
>
> I don't see the problem either. The fallback needs to be listed last in the
> compatible property. If it isn't, having it last in struct of_device_id
> won't help either.

I was probably reading something that wasn't there in the watchdog patch
series I mentioned. I've replied over there. Please ignore this one for
now.

ChenYu

> > Cheers,
> > Angelo
> >
> >> ---
> >>
> >> This change complements the removal of the fallback compatible from the
> >> bindings and DTSI files [1].
> >>
>
> If the fallback isn't listed in the dtsi files, it won't match at all,
> no matter where it is located in struct of_device_id.
>
> Guenter
>
> >> [1] https://lore.kernel.org/linux-mediatek/20220721014845.19044-1-allen-kh.cheng@mediatek.com/
> >>
> >>   drivers/watchdog/mtk_wdt.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> >> index e97787536792..3d5a239b93ba 100644
> >> --- a/drivers/watchdog/mtk_wdt.c
> >> +++ b/drivers/watchdog/mtk_wdt.c
> >> @@ -425,12 +425,13 @@ static int mtk_wdt_resume(struct device *dev)
> >>   static const struct of_device_id mtk_wdt_dt_ids[] = {
> >>       { .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
> >> -    { .compatible = "mediatek,mt6589-wdt" },
> >>       { .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
> >>       { .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
> >>       { .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
> >>       { .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
> >>       { .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
> >> +    /* Fallback compatible string must be last entry */
> >> +    { .compatible = "mediatek,mt6589-wdt" },
> >>       { /* sentinel */ }
> >>   };
> >>   MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
> >
> >
>
