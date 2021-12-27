Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F315447FEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhL0Pd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:33:57 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41571 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbhL0Pdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:33:31 -0500
Received: by mail-qt1-f177.google.com with SMTP id v22so13750103qtx.8;
        Mon, 27 Dec 2021 07:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FwZQOWeqoj/A63XT5pEn9HZSQ3cY9sRkGGed0FATKDw=;
        b=zAigRwH+Py7cSifJQT9HCZESezc42pJ3FG4PH7dw+WlxykNOTYAx/oAou7jin259KH
         33lFnrhD9y1yY6EJFn1sPDp1QY6F+syqOr2Nbd1allt7eZ3v/BSVnne5zjCTevQP9Iy7
         a0G0bDrfEnbHSW4QjX8LhLKmPnk8fDfszWOuNFgvOn/zEwZUKQMbgGRX7Lr5K0A9+jUy
         VP24YHWd/zl9lOEf+MPI70rsgf5W8Wxsgeqp9le62FRiTficzhIRDQglDqUgx+2VJ7ts
         TuvuHM459sFucic/pS7o3RNawDVz3ngjfSjg37fjGfabzBlTibvnXLrgWaWW4uxaaxkL
         lwcw==
X-Gm-Message-State: AOAM533kQPkNYbCnFwRekhR7jx2tEIcA7GpBB4nNoXCLhirb/We9fFSL
        x88YVsYyle7YlNjiKEf2+w==
X-Google-Smtp-Source: ABdhPJzgNNGYj4jnprOtCG45DZlKE+H4MQBRgoMU8JbLBWjvZgou8p1UtEXaB66csKcw5ySPQu6PmA==
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr15325971qtr.72.1640619210381;
        Mon, 27 Dec 2021 07:33:30 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id d20sm12473326qtg.73.2021.12.27.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 07:33:29 -0800 (PST)
Received: (nullmailer pid 519388 invoked by uid 1000);
        Mon, 27 Dec 2021 15:33:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-serial@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org
In-Reply-To: <20211227054529.30586-1-xianwei.zhao@amlogic.com>
References: <20211227054529.30586-1-xianwei.zhao@amlogic.com>
Subject: Re: [PATCH V3] dt-bindings: serial: amlogic, meson-uart: support S4
Date:   Mon, 27 Dec 2021 11:33:26 -0400
Message-Id: <1640619206.696540.519387.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 13:45:29 +0800, Xianwei Zhao wrote:
> Add serial bindings support meson S4 SoC family.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V2 -> V3 : fix the type menson->meson
> V1 -> V2 : update author name
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1573297


serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dt.yaml

serial@24000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-axg-s400.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dt.yaml

serial@4c0: clock-names:0: 'xtal' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@4c0: clock-names:1: 'pclk' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@4c0: clock-names:2: 'baud' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@4c0: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/meson6-atv1200.dt.yaml
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@4e0: 'uart-has-rtscts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dt.yaml

serial@84c0: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dt.yaml

serial@84c0: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dt.yaml

serial@84c0: clock-names:0: 'xtal' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84c0: clock-names:1: 'pclk' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84c0: clock-names:2: 'baud' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84c0: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/meson6-atv1200.dt.yaml
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84c0: 'uart-has-rtscts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml

serial@84dc: clock-names:0: 'xtal' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84dc: clock-names:1: 'pclk' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84dc: clock-names:2: 'baud' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84dc: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/meson6-atv1200.dt.yaml
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@84dc: 'uart-has-rtscts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/meson8b-ec100.dt.yaml

serial@8700: clock-names:0: 'xtal' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@8700: clock-names:1: 'pclk' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@8700: clock-names:2: 'baud' was expected
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

serial@8700: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/meson6-atv1200.dt.yaml
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
	arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
	arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml

