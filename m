Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951648027A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhL0QyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:54:14 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:45585 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhL0QyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:54:13 -0500
Received: by mail-qk1-f177.google.com with SMTP id e25so9181781qkl.12;
        Mon, 27 Dec 2021 08:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUQW6IpkyjLukSOt9D0oujpEApqWaV8yZBESVCrJm0c=;
        b=fXJVKFFnKWnpPD/Blj5uUaD1OaslE8u6NgXftFYAy7h1qg9Vop19BbAEInlzeK+9qF
         h8dVx3bEWLN5kqxt84/ZT4tE9CC7V6N5mn2YvetO1hwGnnEcAZKOPWgfnxrJjXkh5OU8
         y8iZdzzHaOHJ9EAVpxIxWtYXhvx5/FmzpGXO4+tayOWN4zlH85W4uFvMhdL9bvTAshIi
         sglhpseqQX0hibFPi4F8Bbs8UUwXggblBGywGNf2z5DqMvGu1dOFachfGyu4T7FKd1JN
         LP5S+ieEcbbxuGrtf3AmxVZL2CoGTmYaF7BH5y/gH+bW4q6tX/BXTkNiOb58A2xBB/N1
         +LYg==
X-Gm-Message-State: AOAM530NpV3IVyrJKNqPdhxg40/zjN5bM+e5IDvpWa7mB7cI35TDjAF4
        KYlbqit93X2goHc+eitJXQ==
X-Google-Smtp-Source: ABdhPJzkM7JmikYM7JLfuijM4GdYFenX1pnv9WJFIE/CT7bFaCiQZlHXnwfhTPsptFlZrKbjp+77FQ==
X-Received: by 2002:a05:620a:2687:: with SMTP id c7mr12225344qkp.473.1640624052589;
        Mon, 27 Dec 2021 08:54:12 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id z8sm14070194qta.50.2021.12.27.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 08:54:12 -0800 (PST)
Received: (nullmailer pid 648280 invoked by uid 1000);
        Mon, 27 Dec 2021 16:54:10 -0000
Date:   Mon, 27 Dec 2021 12:54:10 -0400
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-serial@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH V3] dt-bindings: serial: amlogic, meson-uart: support S4
Message-ID: <YcnvsriW+mHHBIti@robh.at.kernel.org>
References: <20211227054529.30586-1-xianwei.zhao@amlogic.com>
 <1640619206.696540.519387.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640619206.696540.519387.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 11:33:26AM -0400, Rob Herring wrote:
> On Mon, 27 Dec 2021 13:45:29 +0800, Xianwei Zhao wrote:
> > Add serial bindings support meson S4 SoC family.
> > 
> > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > ---
> > V2 -> V3 : fix the type menson->meson
> > V1 -> V2 : update author name
> > ---
> >  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1573297
> 
> 
> serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dt.yaml
> 
> serial@24000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/amlogic/meson-axg-s400.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dt.yaml
> 	arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dt.yaml

These are all due to no reference to serial.yaml. Please fix that. We 
fixed all of these, so this schema must have come in at the same time.

Rob
