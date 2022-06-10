Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C35468A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiFJOoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiFJOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:44:39 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD51F1296;
        Fri, 10 Jun 2022 07:44:38 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3137c877092so74398897b3.13;
        Fri, 10 Jun 2022 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qb0dJUAgFFXX4Dg6+w1YYRuiD/eZfRK5F9qQcEX45xM=;
        b=k4qvTyrZGhV7+NAh4OXu5yRhfp0e+S3P5nlRXt21GAvFBHxtH29hcS0MxO1WYwYQ41
         Gf573kp9Q5jy/nxGCb+nfMJgYapk42mSetkiwbKtFM18qIwq0kjFwvwIxhrhjOmk7s/8
         FC6NLu5VAjXR++7FsPlJ3av2bQu/c75Tkc2RDrx0LDz5FtAXY9nv+zIAyMJxn16/7yFv
         IkSFcEHecg81Oc9CIF0zbBA0IUz6CXW16dA/coIne0+OggQkpHjgPd/uoff9lH/+FdtI
         duZUtd+pKk4/opzrrpQppLdl9YlLWnbiqDH9NjMVKkOMKNmQ/UmecphkToa946HCHB4a
         7eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qb0dJUAgFFXX4Dg6+w1YYRuiD/eZfRK5F9qQcEX45xM=;
        b=w+BBW0VEGin6CIB1hpjwlkAQjYgeIMpA23+XFi/G6QCjg+PX7FjwZBAlHYjCmfYdhd
         P0FcbSesesVNNIu11aec7Rt/pD1O4fcNWimQ9eKxhBHzAD1XVC+7kf4LikVwyvOYdo/2
         x8IBOdaXDQ3rwN3ug1XOX/8whAk5t5IjmOUjXYFvJXrQEDchO0f+CL1elSDDWNoSe5TE
         QAdHbSJCe+J8AGgL6v2E4PTNzvhtB5n1CYNv7iftSgjchmASoqGecrTaOSAZ4gt6IVWz
         kjivYNZ9gNrv4rcS3sBs2qwanm1N/OntYFHgBRCExfefVnZa1hsH1cZqDwEpM2QkyE0Z
         JF7w==
X-Gm-Message-State: AOAM531eAfGMPbH90mhCCoGXQS0eZeIbkagm4ixW9LBfm33BNWSJ70Mo
        W+kUaXv69jItLOkPKL2qxfaH6OywIyscGUPGsCg=
X-Google-Smtp-Source: ABdhPJyustZFV7Nw6780j32l4lEe73oN8XdNN/IxZJ73iS3S7npKgY1mfGpredBDvi5ka701E9cDxLYZFVb4jz4QJqs=
X-Received: by 2002:a81:5294:0:b0:30c:7780:d0e2 with SMTP id
 g142-20020a815294000000b0030c7780d0e2mr49875426ywb.241.1654872277737; Fri, 10
 Jun 2022 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220610132601.160088-1-pgwipeout@gmail.com>
In-Reply-To: <20220610132601.160088-1-pgwipeout@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 10 Jun 2022 10:44:23 -0400
Message-ID: <CAMdYzYqJ2S8K2NCH1uQ2xDjTfLmePPv5TzgeXZa0EG6XdGQzBQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SoQuartz CM4IO usb
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
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

On Fri, Jun 10, 2022 at 9:26 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> The SoQuartz CM4-IO should support otg mode, however it currently
> defaults to device mode when otg is enabled. Force it to host mode to
> retain the previous behavior.

It would seem the role-switch issue is more widespread than originally
thought, affecting other boards where automatic control should work.
Please hold this patch while I investigate further.

Thanks!

>
> Fixes: bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x")
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> index e00568a6be5c..56764fae9f9d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> @@ -169,6 +169,7 @@ &usb2phy0_otg {
>  };
>
>  &usb_host0_xhci {
> +       dr_mode = "host";
>         status = "okay";
>  };
>
> --
> 2.25.1
>
