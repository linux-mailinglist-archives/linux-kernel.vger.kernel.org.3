Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413EE54D000
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355970AbiFORfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357701AbiFORdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:33:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B122AE3E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l18so14050030lje.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKNf0k9l6gLrV2AI3VWWdOaW+620gEpiFjUyyJCX0Cs=;
        b=tlKGen7zMe6cWxtE6Iq+6NS/TFHumGCzRMFTXeyJUE8ztpNiY3hvE1iAKl/OlX9X9O
         HzsFVwv9ypNae7Z3mFrO0XyV4Y4pj6Iipdr8THGhJaqduTvEbbXSXByop1C7Mds0rAah
         kGzShX4Mub0mOxuiyIFNvOWa8m4UIpsQUaHfbKJDq5oIQWtC4N7TNdT396lcETQxXcKp
         AYMOlMAHjYjsA7V5u65u9GxDqq5MOFmy9QYT2YywcsjKOAhn1qsjIZZeSbMX0PpZAiZJ
         3rCXRaol3umGZRlUj8Y2dD7Hlpy6sN4xAXyW6YHvQjoJxBHMiFJz6N2vJtT77rr+UL19
         P37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKNf0k9l6gLrV2AI3VWWdOaW+620gEpiFjUyyJCX0Cs=;
        b=WvB88SjkCd0LrJndCCzG8jVU5m8L/e3KKfBMHRUHGNxr1A4QmK5aH1mb0vXkHksM1d
         SQ3RhjXIzH4tlXqdbfWdWFL0Jf3LWQpXEGxQYmgngBVuWOtVamZ9EcRUyfJAp2HfmRj9
         ZwuAumYCGebagrM06tMF5iQ+B+bpElDROf9uYcnK5A6ATr+LoACTP/mmflmul8kttNDn
         a2c4yNDMgS6w0qR7ksN+STjhyTMod1em/tmG0FdDhr1C4Fhj/Zq38ZTbyAkDgPPR5gpq
         JP6fm/wIemIPScw9W/K6Wp0j1p/juS8KqoQFrnopgb151rrk5xdXZcWDWC5UHU82/GsD
         6i/g==
X-Gm-Message-State: AJIora+3+aERC4h/NqK6317N/+/l+DhRR44YvY34CCEbJRuXHXPE19SE
        XtCBD0+AOLjcP+ed44d20TcGka7LRamd2BSvyEg8zpo/Ftc8Ew==
X-Google-Smtp-Source: AGRyM1tarJ3RmYGZi4Bh/Sn0M/lEpQDAsmJjikNL+iLfDgMeV5j+niJz7+d8G8zHnwmUFIHeOkjT3b9W/eOOBPc6Vxg=
X-Received: by 2002:a2e:808e:0:b0:255:be23:1372 with SMTP id
 i14-20020a2e808e000000b00255be231372mr454884ljg.4.1655314398304; Wed, 15 Jun
 2022 10:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608130847.46359-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220608130847.46359-1-wangxiang@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:40 -0700
Message-ID: <CAPDyKFobyJS-7j7C0x-FwV6zdqR9gOtpr-HWn8zcLkFd-gMAeg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux@armlinux.org.uk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 06:12, Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'is'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 01159eaf8694..012aa85489d8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -762,7 +762,7 @@ int mmci_dmae_setup(struct mmci_host *host)
>
>         /*
>          * If only an RX channel is specified, the driver will
> -        * attempt to use it bidirectionally, however if it is
> +        * attempt to use it bidirectionally, however if it
>          * is specified but cannot be located, DMA will be disabled.
>          */
>         if (dmae->rx_channel && !dmae->tx_channel)
> --
> 2.36.1
>
