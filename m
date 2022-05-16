Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233152932F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbiEPVwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbiEPVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:52:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8729FFC;
        Mon, 16 May 2022 14:52:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o80so9582333ybg.1;
        Mon, 16 May 2022 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzZisX84Vg2OWr0cWG9QgT8yxrNRlR4Nsje6UKglFgA=;
        b=Y/5zvGzWwE7UJ7NOoRGm/nPFyByfyN1daTqIdAMl0+7R5JrwX1iIbjsbhPnV7b6o3j
         slAv+enGD9g/EirCalum1+tvL8frWpiDRcFJ037oXn3Ux1QZOg0hXAXRQ4GBo4D6BLdQ
         94NJ2aHsLDfuobSgx+g/j+0tdagU54bJqTnV/rWNGK9a3/1W/uiAn4UsMO5ciu4GI0Rq
         3OuwXeFqFXvzcIOeiN6Gfksmj3BvcAgQ6g/CdO3mz7zDK6TpGEc3sblyGmH35YaqtUSR
         7iJAL6Nv8WWzwI7A6m1u8mpD014wmNoEVGXYkgQGgpUrxidtpB8fYN6tKJy2DkVR8GcI
         vgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzZisX84Vg2OWr0cWG9QgT8yxrNRlR4Nsje6UKglFgA=;
        b=1QhKVUJVhEckbmFoeflUsdtSfMxSaY7sYcjZoioheNZLSwJi56MzdQDcfJXUrzhVCa
         x1QmhFfhYtFpWzL1faioxuMMBFgtfrza0oFSQBUhj7h9l0aCYr0IUb7RSMdOK8RSPTOD
         gojxY9bmfcgq/mshkYAm6HtnlVMc6ryOlJR5feSBl3G0mbuQA8pAJERKkOgT93QeMoLW
         SgCxPzUfGDSq7TKdwPACbtKanaN9bdMDUTlmAx37BWKJTBgsoFYhe5OHqdqUa3PFMtHr
         S5srYWlJKiuQgR8qachSldXIC9h74H7Gu7mQbwtPXdYC+7kwPil9+d6BKn3ASLfxky0X
         LqBQ==
X-Gm-Message-State: AOAM532LS9AbNcQJqDXigU4H4lIpWKwac6CitqryiAo/OLTwd4iFp19L
        R1Enxum25uE6JFt21cNaNeVSl+GsO8ZlryBVqItoraVF
X-Google-Smtp-Source: ABdhPJzBo5/L9as/VSBWGQya1UD1+Dv9u82vrWD++mHF1+JUNvRZ7+25dViWmzipmM8qTXMmZtX4D2cB/nK9EmfmPm8=
X-Received: by 2002:a25:600b:0:b0:648:ef9b:172d with SMTP id
 u11-20020a25600b000000b00648ef9b172dmr19976789ybb.585.1652737931494; Mon, 16
 May 2022 14:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220511150117.113070-1-pgwipeout@gmail.com> <20220511150117.113070-7-pgwipeout@gmail.com>
 <20220516152651.GA18461@wintermute.localdomain>
In-Reply-To: <20220516152651.GA18461@wintermute.localdomain>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 16 May 2022 17:51:59 -0400
Message-ID: <CAMdYzYp9Yn7VGS3phj+QOP=Bh8+OH3i5oP81Ur_R_egXWYcyig@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] arm64: dts: rockchip: enable sfc controller on
 Quartz64 Model A
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
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

On Mon, May 16, 2022 at 11:26 AM Chris Morgan <macroalpha82@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 11:01:17AM -0400, Peter Geis wrote:
> > Add the sfc controller binding for the Quartz64 Model A. This is not
> > populated by default, so leave it disabled.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3566-quartz64-a.dts      | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > index 71df64655de5..6ec349e7e521 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > @@ -603,6 +603,22 @@ &sdmmc1 {
> >       status = "okay";
> >  };
> >
> > +&sfc {
> > +     pinctrl-0 = <&fspi_pins>;
> > +     pinctrl-names = "default";
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     status = "disabled";
> > +
> > +     flash@0 {
> > +             compatible = "jedec,spi-nor";
> > +             reg = <0>;
> > +             spi-max-frequency = <24000000>;
> > +             spi-rx-bus-width = <4>;
> > +             spi-tx-bus-width = <1>;
>
> This isn't really a concern, just a comment. Did you test this with the
> spi-tx-bus-width of 4 by chance? While I did have to use 1 for my
> implementation (the Odroid Go Advance) the Rockchip engineer I worked
> with couldn't replicate the issue on his end and we ended up chalking
> my issues up to an implementation specific problem. I'm only commenting
> here because I don't want you to think that for this device the tx
> always has to be 1, of course if your implementation does have issues
> with a tx of 2 or 4 that's different...

Yes, and it was a data disaster. Looking into it I found all of the
flash chips that I could find only support 4x RX 1x TX. Some didn't
handle 4x RX terribly well either.

>
> Thank you.
>
> > +     };
> > +};
> > +
> >  /* spdif is exposed on con40 pin 18 */
> >  &spdif {
> >       status = "okay";
> > --
> > 2.25.1
> >
