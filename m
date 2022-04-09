Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3A4FA941
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiDIP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbiDIP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:28:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBF33A;
        Sat,  9 Apr 2022 08:26:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id d138so19976066ybc.13;
        Sat, 09 Apr 2022 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cR2pF5s8t+OdbSSxVuJNcvAN3V/unWJTiAFDdZ/69qU=;
        b=GiGHHDgOsTCZkVZ3qA13Sb6FvHIZGDKjASv/UYR1gRUxpg4ro6pgjjruE+1alUxjvw
         9c/GDyeCONs+IqKo2Ih6w8bnMsIo3HpqNprf4VdbfduInTTJVOYRdlsuQNfouTh3AD+W
         oOafjH2YZ3EJJU8zCNpPqoWpjPHxfyXlgRhWtfbj801Fd8hgas74RpAPB0r1aO7h0fiu
         wyajkNmZl/hfF9qj8hc5k/C3IQLGwg5B1AkVm1FtHRV1RkaOF0L02PV+pU2fgqHzLGyu
         qLpT8KDMV5s7LckQ8unn6h6/eZdhs2+bxCxX/tMdPRnPWl+Z1U11qi8OZamegXOW0g7y
         skmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cR2pF5s8t+OdbSSxVuJNcvAN3V/unWJTiAFDdZ/69qU=;
        b=iJ+uQul/Ovvp+DXj4e50WT/rQhXc95FNEGTueFEgG3QqO/wM+UqlL7bGUUH9DJOEXR
         i/0AYwhISxYOq+beAmBJTn/iitPxmgW5h1daD6mCDmDZhLNSOPCt5VGorYYDw1DXw3DK
         xuLq2nzH0os8pEiLmapWTkrON6snZWgljDpRmRS3rdJNTwHr5XMvSfCFyHT2uJc5tqeU
         bYIMwbN6ujlzNQx6gAfgVJbIuoA0W63wcp/piU9tSRhXQgTW6BnulRmJJhj9C0khqrob
         Edd4QZ2VR2SUs9i7GjsdERu+GG/kPN22gkCfdTfuqKb9Jg3hJHgy70QSu2aWz9VF4x1u
         WapQ==
X-Gm-Message-State: AOAM533YwFlrhrIsAnMrXEgUtyr8HHMud28Uf/2EV+rYOQDv6Siq07vB
        19lwMdKCzskk68NMOahjPej3QXJi1aDAE1wRjso=
X-Google-Smtp-Source: ABdhPJwy9sT5pq4yY8qB+CnoQCmzTDVQInXJDJPL7q9XcmDqn8nFU9sVdEpR/0bq+uPrEm63H0VHbIoKc8s4gNZqods=
X-Received: by 2002:a05:6902:143:b0:628:7cf1:f2a9 with SMTP id
 p3-20020a056902014300b006287cf1f2a9mr16357436ybh.51.1649517972377; Sat, 09
 Apr 2022 08:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220409075147.136187-1-linux@fw-web.de> <CAMdYzYqx1iUuEe9FPpUTgL0L2i=Q5Sq2+0oiSYzqkV6noQ8BFw@mail.gmail.com>
 <CAMdYzYqaGe9_GbRCvG3kvLpNsVfVqGNkg=YYgbVR90Qtcs9YSA@mail.gmail.com>
 <4232341.5fSG56mABF@phil> <trinity-da7d86cc-5703-4657-858c-f241e5f0a6fd-1649505409042@3c-app-gmx-bap35>
In-Reply-To: <trinity-da7d86cc-5703-4657-858c-f241e5f0a6fd-1649505409042@3c-app-gmx-bap35>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 9 Apr 2022 11:26:01 -0400
Message-ID: <CAMdYzYpK-RTf_8FVte2QLJawCKCjU6efgkRjsBj6quWGSSE6xA@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Apr 9, 2022 at 7:56 AM Frank Wunderlich <frank-w@public-files.de> wrote:
>
> Hi,
>
> so to not break the binding and other boards the right Patch should be like this
>
> +++ b/drivers/usb/dwc3/core.c
> @@ -1691,17 +1691,17 @@ static int dwc3_probe(struct platform_device *pdev)
>                  * Clocks are optional, but new DT platforms should support all
>                  * clocks as required by the DT-binding.
>                  */
> -               dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
> +               dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
>                 if (IS_ERR(dwc->bus_clk))
>                         return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
>                                              "could not get bus clock\n");
>
> -               dwc->ref_clk = devm_clk_get_optional(dev, "ref");
> +               dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
>                 if (IS_ERR(dwc->ref_clk))
>                         return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
>                                              "could not get ref clock\n");
>
> -               dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
> +               dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
>                 if (IS_ERR(dwc->susp_clk))
>                         return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
>                                              "could not get suspend clock\n");
>
> but this needs fixing dts using the new clock names
>
> this is a link to the series moving from bulk_clk to named clocks:
>
> https://patchwork.kernel.org/project/linux-usb/patch/20220127200636.1456175-3-sean.anderson@seco.com/
>
> regards Frank

I've submitted a fix for the backwards compatibility issue.
https://patchwork.kernel.org/project/linux-rockchip/patch/20220409152116.3834354-1-pgwipeout@gmail.com/

This fix is standalone and necessary no matter which route we decide
to go with this series (and the rk3328/rk3399 support as well).
With this patch, dwc3 is functional on the rk356x as the series was
submitted, so if we decide to fix everything all at once, that is a
viable option.
