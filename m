Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE92580599
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiGYU3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiGYU33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:29:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04519BC9B;
        Mon, 25 Jul 2022 13:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9C57B810FE;
        Mon, 25 Jul 2022 20:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D78C341CD;
        Mon, 25 Jul 2022 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658780965;
        bh=iX8wr1hPKTneg9a+eBJXq4+wGlRNsgbD59/7wwnN1xA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BDA+ZjuwJ6YdcVR2XPmFe4pShoa4H+Zcpn7U6V/Ix1dgzNGEloHb5vdd8/wO70L+x
         dmoAklJ3de20NXW8/c1SvEqWtNPSZmTxNVok6Vx0s/+Zw0jpYkx3XGenQLgosEryb4
         b7FmR+giTmLriHFGB32w/DJlloD/yVi4+PyBNpwXGpojoEs1OjFhNa7zGiDazeLjNb
         KwXm8hORhBKdXbnAl9JjndzW06JMOGMwYmhrjmfeisJa/LVYJKDlPavdh4T9PJ9091
         KinrbzXh2VjhmJ96M1uUsh94oYzYhhN9MbQ6mwQEnoB03ZiDfkNYdOW6Tf/1ztj7jC
         kmc/MV6KkW/8A==
Received: by mail-vs1-f44.google.com with SMTP id 129so4221098vsq.8;
        Mon, 25 Jul 2022 13:29:25 -0700 (PDT)
X-Gm-Message-State: AJIora82RbxpP4yubCHsY22wS6mr092cAojQ03S1COJT0oMYZAsWk5hD
        NGYvwCz/j+mOJRuVHb7/b/MoWrDka30UFiU/Cw==
X-Google-Smtp-Source: AGRyM1vzsYMyTaGYF4X1r/77zbG7V68gqLcEpGiz0JYOkMPOFCFcjdJ4Vx5gxnBVP+8Ji/5BOwHBtGdQcDtcAk0fGGI=
X-Received: by 2002:a05:6102:162b:b0:358:418a:4e57 with SMTP id
 cu43-20020a056102162b00b00358418a4e57mr4344243vsb.26.1658780964277; Mon, 25
 Jul 2022 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220725180916.2850228-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220725180916.2850228-1-bhupesh.sharma@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Jul 2022 14:29:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UaXgCFH5azZoHDSSqagEcRf9f6-ZucWAHuYZi0HaHgA@mail.gmail.com>
Message-ID: <CAL_Jsq+UaXgCFH5azZoHDSSqagEcRf9f6-ZucWAHuYZi0HaHgA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Set maximum documented operating
 frequency as 384MHz
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 12:09 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:
>
> As Ulf noted in [1], the maximum operating frequency
> documented in the mmc-controller device-tree bindings
> should be updated to the maximum frequency supported
> by the mmc controller(s).

Please send DT patches to the DT list so checks run and they are in
the review queue.

> Without this fix in place, the 'make dtbs_check' reports
> issues with 'max-frequency' value for ipq8074 sdhci node:
>
>   arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>    max-frequency:0:0: 384000000 is greater than the maximum of 200000000
>
> [1]. https://www.spinics.net/lists/kernel/msg4442049.html
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> - Rebased on linux-next/master
>
>  .../devicetree/bindings/mmc/mmc-controller.yaml          | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index ff5ce89e5111..c49f3060c24a 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -87,12 +87,19 @@ properties:
>      enum: [1, 4, 8]
>      default: 1
>
> +  # Maximum operating frequency:
> +  # - for eMMC, the maximum supported frequency is 200MHz,
> +  # - for SD/SDIO cards the SDR104 mode has a max supported
> +  #   frequency of 208MHz,
> +  # - some mmc host controllers do support a max frequency
> +  #   upto 384MHz,
> +  # so lets keep the maximum supported value here.

Add to the description instead of a comment.


>    max-frequency:
>      description:
>        Maximum operating frequency of the bus.
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 400000
> -    maximum: 200000000
> +    maximum: 384000000
>
>    disable-wp:
>      $ref: /schemas/types.yaml#/definitions/flag
> --
> 2.35.3
>
