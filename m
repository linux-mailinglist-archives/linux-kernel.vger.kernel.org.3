Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1149C3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbiAZG7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiAZG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:59:37 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCBC06161C;
        Tue, 25 Jan 2022 22:59:36 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 9so10951369iou.2;
        Tue, 25 Jan 2022 22:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Na4bm+cu7JRGTZPOYGd5r2oVbdD8v05hD0YB/g3W3g=;
        b=fOOft803n9fgdy7aF/y5gakAQhDLHIdmXki9Cb0hbawX9JEetg5GJfDf7YdyH7eBWh
         y5U4SJTxnZPXJtIdv5CgQ/1eFJBAmsW3Y/dyUi6aU3BGNrveRctxGJXlzacnzjw5ZfCZ
         otUPRGBF9bjEr3UfFkYYkeSwet4VAroGMT9ZfbzwWTUaYkDaTp3UdXxmzn6Q/VsQVREy
         pfI9m897eAcm7S7XobxjsfuV4ZVRRcEcTv89fjCpV6GvFriCUKBVIxebrlhoWSdK0zix
         Wvrg3M5h6+V4mBI7ISHt5VZPb77+oXKdU0fiUVmONZz9DUe6wl3Cao899JGeKQ5iEGCo
         VIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Na4bm+cu7JRGTZPOYGd5r2oVbdD8v05hD0YB/g3W3g=;
        b=58cD41qjYDw0tWgt9gS8XUlsCEGwG3kaoeKiytFCOfefABL+4eurzxFrHRokKckBrm
         nJQoWt6I2vkp4W+WQZS5aJWgUMv04htI4c0d0j/3pc4G2bxZ2IS3IufkZUmSjnPyz8lN
         42cDruFInQd2f9RUw8+mMc80nbRcTXP/ebFAx6Xs3TbgLQrRsdEugcp1xE+gB8wowvZr
         aziTKw9wWJOAp7UogFBDMCq3DRC2Mw7QlCsxih4rIS4F9b5wqJXK2EseAeeU9swwmtpX
         drDXEipIfziXbIDNtsrI7j/0dp7p0Bd48lkaCU71RvfcEgLziTtstezUfG5jxHxT9VKm
         5v7Q==
X-Gm-Message-State: AOAM533hl7qs7djoCnuPp82kHDqIdwxwOQ6MReVMHcA8h3I/aJ9fLW78
        QT65vXK75Cnw5GQyZmadSuQag46aTL+nSTC6cDj8odhr
X-Google-Smtp-Source: ABdhPJzhSvgHHbLS6s5b3LYGE00xQIeldKoFNGqxmHcPsbN4RqhbBNrYKUdM5Xc9wUq5C7GWdTKYPupU8AsIyLE2PeE=
X-Received: by 2002:a5d:9d86:: with SMTP id ay6mr1080738iob.130.1643180376162;
 Tue, 25 Jan 2022 22:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com> <20220123111644.25540-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220123111644.25540-2-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Wed, 26 Jan 2022 12:28:58 +0530
Message-ID: <CAGOxZ51zavNVpvUv0C17Cit+pdkERC70m5Ez3ELGpFh8tGDozQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] arm64: dts: exynos: add USB DWC3 supplies to
 Espresso board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Mon, Jan 24, 2022 at 1:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Add required voltage regulators for USB DWC3 block on Exynos7 Espresso
> board.  Due to lack of schematics of Espresso board, the choice of
> regulators is approximate.  What bindings call VDD10, for Exynos7 should
> be actually called VDD09 (0.9 V).  Use regulators with a matching
> voltage range based on vendor sources for Meizu Pro 5 M576 handset (also
> with Exynos7420).
>

I checked Espresso board schematic, it is 0.9V for the USB and supplied by LDO4

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 5 +++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi         | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 125c03f351d9..4c45e689d34a 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -412,6 +412,11 @@ &ufs {
>         status = "okay";
>  };
>
> +&usbdrd {
> +       vdd10-supply = <&ldo4_reg>;
> +       vdd33-supply = <&ldo6_reg>;
> +};
> +
>  &usbdrd_phy {
>         vbus-supply = <&usb30_vbus_reg>;
>         vbus-boost-supply = <&usb3drd_boost_5v>;
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index c3efbc8add38..01b4210d8b62 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -672,7 +672,7 @@ usbdrd_phy: phy@15500000 {
>                         #phy-cells = <1>;
>                 };
>
> -               usbdrd3 {
> +               usbdrd: usb {
>                         compatible = "samsung,exynos7-dwusb3";
>                         clocks = <&clock_fsys0 ACLK_USBDRD300>,
>                                <&clock_fsys0 SCLK_USBDRD300_SUSPENDCLK>,
> --
> 2.32.0
>


-- 
Regards,
Alim
