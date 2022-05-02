Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF57516DCA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351004AbiEBKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384856AbiEBJ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:59:53 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA84DF55;
        Mon,  2 May 2022 02:54:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ebf4b91212so142143877b3.8;
        Mon, 02 May 2022 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rm5y2VGJTWFrVHSZWCzBm857+oeS1xdAmQKPrG4us9c=;
        b=G4/pFOkcv8dblCepyt5JRYdgApZbRixM4pMGN8R7c3Aw9LSLIbbel8p7kMM7yYzkxz
         W/tXW3d9FgqOjIXpMLHnTKtv5/M9rvMsgp+jdD+rHrA9Vv/TSfWqarHaIpGyxAiwObc+
         BshyAPoUfHprooVB3xaQZoC1LmuEYmYgTUiECXmk3sqxW1LUFUrymx4ehnSQVK53hgDG
         7sD6hDk/aV91/+YGShTmD6LXlIVgeyhok7SscsTNTnem5O/ulAzuaG8pLtySHsXjfew6
         HLIDj5Rzau5qZ95pmZs+vSEKeFQP6sNmqQik+uZkY0T1NLd9Palt8tdwT89mH7BWPfSP
         RhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rm5y2VGJTWFrVHSZWCzBm857+oeS1xdAmQKPrG4us9c=;
        b=OjT45lgm0XAselfeYUYAABu1xINzl4MvPYTdGZUiP/op8j9+BerxrioHDLBRLwqVDY
         39LHq/PGH2HHFgQhZJbiDc3mRBuaBnu1mGpJaSVDk0qM9qYDhGzS4gz0bg85GqU1iJ8Y
         nVh4BNcxCq71GpY9gorW7PqFMyv3ptHCM/HjhyCc3at1CH2fjei0Q4N1Q0mB/dpeghot
         gRpJoBqPl6xpbEN3tnGbDD1xGmlnlUIh6ARylES07ZH9NWqXPT6ejapUC9yrJV5JDVg0
         W5gXsSOtqfWauDbcnsJHpWMhJwkYJKeNbcZjT8KFkhPkujYOOxdCTTTPg0Rn1eW0aDak
         0y7w==
X-Gm-Message-State: AOAM530JMQWq+Y1C1SM6fzSgtgFdEAnmezaVZo6z4k9d91G14spJtZpy
        25RzAnFIAyDmO1k2uGaEpKVUwM++U/PYKQ+0sPE=
X-Google-Smtp-Source: ABdhPJwPlRu37+zQnM1BhvYdKxzN7inRAlkIq4zm7BUcA5W8k7fS4Li/wTQfp6NyJ2HNdki8VA8XGdm5L/vKve6OQmM=
X-Received: by 2002:a0d:d953:0:b0:2f7:d5ce:f204 with SMTP id
 b80-20020a0dd953000000b002f7d5cef204mr10337039ywe.502.1651485263663; Mon, 02
 May 2022 02:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220502064551.202613-1-michael.riesch@wolfvision.net>
In-Reply-To: <20220502064551.202613-1-michael.riesch@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 2 May 2022 05:54:12 -0400
Message-ID: <CAMdYzYrChKVwuGj=VEc=T4Gez-Bs647GxaeMsdbgvU_6p3FeEg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable otg/drd operation of
 usb_host0_xhci in rk3568
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
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

On Mon, May 2, 2022 at 2:46 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> This USB 3.0 controller of the Rockchip RK3568 is capable of OTG/DRD
> operation. Enable it in the device tree.

I think I missed a conversation here, the xhci0 controller is the otg
port for both rk3566 and rk3568. The only difference is on rk3566 it
is a usb2 only controller, where on rk3568 it is also a usb3
controller. It was set to host only because my original phy patches
didn't support otg mode. Since then Samuel's series fixed that.

Your original patch was correct.

Always,
Peter

>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> v2:
>  - As pointed out by Nicolas, this is RK3568 specific. Moved change to
>    rk3568.dtsi.
>
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5eafddf62edc..bbfe8f3d68b7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -134,6 +134,7 @@ power-domain@RK3568_PD_PIPE {
>  };
>
>  &usb_host0_xhci {
> +       dr_mode = "otg";
>         phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
>         phy-names = "usb2-phy", "usb3-phy";
>  };
> --
> 2.30.2
