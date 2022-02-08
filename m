Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FC4ADCF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380673AbiBHPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiBHPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:38:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CFC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:38:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1961413wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rwKl8ZeyCuycfyHiHNzaCDGxP6pfys7UA7HgC7w51Hk=;
        b=J8rGUAr3VAjmWXmp/ug1dk925Xs2TgqQC98/ubJfOSqot4uI/8l2P/bJGc1BLEFde/
         02w69uACXz87zFLCn4hFgeDAx1K1QiQtuZlfrpZv7l+iMQuGTBsZhC6x5Bwp9n+LlBSE
         q5BvhZLUUptXXiuSUgC7qDp7XPJdSdSc5XsOxhJp9Vejfd/r++x5Rn6HLC0lL30zRLx5
         pit3G4CGM24B/tdxV7ArZb/J4pRtCYc2Tjtm/PmBWM7BoPfQheWViImBTXPtNZpGb2Vm
         fyk5zOkWFUi0zeIbVgSf1iCKyiZ4EHWMmg+gF6KKY6nsWIDBjSFpnjnshFHWFr4OQGjt
         Gisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rwKl8ZeyCuycfyHiHNzaCDGxP6pfys7UA7HgC7w51Hk=;
        b=QjlyzqNYPXTZ+ZyaShoeFzWD2qlzz0oow0hKD2wRAXPUUdjPrIjVbPpztWx/cQGjkj
         iQ8wXb6gj+E3FxMi0ivrC51I2YaGGXTl5XJnuMPPbHO9nR1XljnYoLgsislK2M3cd/bv
         10DCGzzZNkFzvB+4SbI+MGcptNK1bSEptW6MUiGSKO9w/WSYWigeOYb0hXt36h/ALMHt
         e1Eg6UccciE2XAoHrJB+Z5RhkRqINvWktso5Q6Im6PYcJi2Mfe5juMftjS2bLDUG7lvP
         kKj64qrFkVAvEfN55DcsDX74C4rUsgmDZ3jVtR1WV4/85t0x1F0XJ6QjKejH3YI3S6SJ
         h6Yw==
X-Gm-Message-State: AOAM531Bu9la5inQC3knulAi9anNi54vm3U7Gj4lEoDJN1XLtpof1fgL
        mL6ikze9uKsVukTYWZ7jb18gUQ==
X-Google-Smtp-Source: ABdhPJx8NmLR0cLoQwJ+aWrxfCSDB4wpiMqHzFtzKLKpkKQhBC8j92FFvulZ4fHheCC8AjHQmnFOGw==
X-Received: by 2002:a05:600c:4656:: with SMTP id n22mr1630222wmo.85.1644334732007;
        Tue, 08 Feb 2022 07:38:52 -0800 (PST)
Received: from localhost ([2a01:cb19:826e:8e00:bf36:c801:97ea:7f])
        by smtp.gmail.com with ESMTPSA id p27sm2397617wms.39.2022.02.08.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 07:38:51 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: mt6358: add mt6358-keys node
In-Reply-To: <20220121140323.4080640-5-mkorpershoek@baylibre.com>
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
 <20220121140323.4080640-5-mkorpershoek@baylibre.com>
Date:   Tue, 08 Feb 2022 16:38:50 +0100
Message-ID: <87v8xps705.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On ven., janv. 21, 2022 at 15:03, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> This enables the power,home keys on MediaTek boards with a mt6358 pmic.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Since the driver change has been merged [1], can we queue up the DT change?
Or should I resubmit this separately?

Thanks

[1] https://lore.kernel.org/all/YgIE%2F806gDmRJYCn@google.com/
> ---
>  arch/arm64/boot/dts/mediatek/mt6358.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> index 95145076b7e6..98f3b0e0c9f6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2020 MediaTek Inc.
>   */
> +#include <dt-bindings/input/input.h>
>  
>  &pwrap {
>  	pmic: mt6358 {
> @@ -357,5 +358,16 @@ mt6358_vsim2_reg: ldo_vsim2 {
>  		mt6358rtc: mt6358rtc {
>  			compatible = "mediatek,mt6358-rtc";
>  		};
> +
> +		mt6358keys: mt6358keys {
> +			compatible = "mediatek,mt6358-keys";
> +			power {
> +				linux,keycodes = <KEY_POWER>;
> +				wakeup-source;
> +			};
> +			home {
> +				linux,keycodes = <KEY_HOME>;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.32.0
