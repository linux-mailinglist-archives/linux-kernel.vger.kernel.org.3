Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE35B03E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIGM1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIGM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:27:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5AAB418
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:27:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h188so13394887pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6cuL5VnEZ/yRZzjgpFNpylmzRf+vnL1tNUfqg3eDNh0=;
        b=Uo7knmfnpSGc+UHa4pKiYtM8ydw3bIkafAj/hH/xwUkpRRcDRvpbLFTvNprUIjwf+3
         hR/vOPWo74bTDdh05bpDsC11vop7NIXVPOd5IdJqoXPzj99faqVPhRyk1uBBDgGZZE5/
         Y4xp8AsEYWNa8wQaXhHA/Ce3JA2DbwaMxuLum8M3WXYZb4i3jqMXXhc86vLghDu6ycTr
         85PLjHSdXpL6iPsVsafmCaxe9gzZclOE06kITKU6l+2wbnEtFXqEVlPBhf/IZVAhrcw1
         Dhv5EnMmlh7XKuXRHMwkWVMG3HwhUR41QBSCJQVsKs0Wolo/DStN9wytERE+kn5nYvEN
         fuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6cuL5VnEZ/yRZzjgpFNpylmzRf+vnL1tNUfqg3eDNh0=;
        b=vfHB6A1SYjEE4gcnmoaDWjElNhjundd/rdmeyVsDKt4O90Vi7LAcoCDkAh8Gxr69M5
         9Oz/uzcRgq9cnxPanGUOL3CadJnPw/cMnJEwfgeTex/eiYXr4ykvOEVk/LNTuHKCUOvS
         vy50yC2d7X5acE9s/aDMJ8kSO8DDVp547rHSyWCw82pSCCZ2wakJ3bdSTIEaPqrJfMzC
         XNwnVkazvuE68qqmuKTRl5CJ9mvdvxbyNKHJmCb2MDXmpqGskZ6XYD+2r02CGCijtRNF
         5CYD5EGKDnpXY7C8QB54KDsdX5l2bt93FubuSf8Npw5uvQzd5tVV5WHZZJiCDw9/Sm+T
         vMvA==
X-Gm-Message-State: ACgBeo2LlUWHfYEiXJ9QF7MxIlv5dU+wzRH5vu/Wf14a9Y/Sd35ujARC
        m7rU9DdUeXDzGfdWLhzX6FatGgliCFbMX8stOHcBIAOT
X-Google-Smtp-Source: AA6agR5G+AaJAv35pzKRY03IxagEwcexQyPBpB7dTQ3tpQUaPPSM/hF0zFXIG5kdtsFtjg81/rVv0ReXqMgPbVz3Yyc=
X-Received: by 2002:a05:6a00:2999:b0:539:c397:4a5d with SMTP id
 cj25-20020a056a00299900b00539c3974a5dmr3638897pfb.13.1662553646436; Wed, 07
 Sep 2022 05:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220907113927.35305-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220907113927.35305-1-yuanjilin@cdjrlc.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 7 Sep 2022 14:27:15 +0200
Message-ID: <CAMeQTsbAsi-kQYRzWMncnvB2NAiQ3nL45YsAirROHbGJROzerA@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 1:39 PM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
> Delete the redundant word 'for'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Patch applied to drm-misc-next

-Patrik

> ---
>  drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> index 6004390d647a..64761f46b434 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -310,7 +310,7 @@ static void oaktrail_crtc_dpms(struct drm_crtc *crtc, int mode)
>                                                    temp & ~PIPEACONF_ENABLE, i);
>                                 REG_READ_WITH_AUX(map->conf, i);
>                         }
> -                       /* Wait for for the pipe disable to take effect. */
> +                       /* Wait for the pipe disable to take effect. */
>                         gma_wait_for_vblank(dev);
>
>                         temp = REG_READ_WITH_AUX(map->dpll, i);
> --
> 2.36.1
>
