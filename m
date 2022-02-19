Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7194BC501
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiBSCoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:44:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiBSCoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:44:09 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD18F6D3A9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:43:51 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s5so5073688oic.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=T6YKxmWEz7AOdGW5A6l/US7/zZ5Y8isivPpi4loytTw=;
        b=YXQoib1cF59dR1Ga68uc3HOYXQPS149MEtMxdda+swZtnY6HhQDt9/fbgprCKLT4yr
         xkRsaBWX7bufF32Md2CRjB86jat7u4T72Ngx6AWxnWONIqPYRtNce8FUZx2wQEjh+FbQ
         Z9I4EiPyRCCiA5ZXaCXpcLxXIl7KlnN6fTHDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=T6YKxmWEz7AOdGW5A6l/US7/zZ5Y8isivPpi4loytTw=;
        b=cNQSa9d0F92px+IGt4e7KVvN09g/24e/7btw9iCebKCZF3CyZ/EI74Bk9Rj4Xq6+Tg
         y8caoI1/YsgckDYxg+2Gc80NanJ0nD1/H1rYBlTPez+x8ACErkg6ezPtw9GHbFNNRniY
         DnGyxu4VepR3MOaAUt+MgoxaQB3VBQNm9ah+KcM+mWc8oWTGS5L+UD46/MHj38nNQc4E
         jWGBRJ01uaHkmDzEI+ETYQZnkVx2nNo18IJ0KDABSh+2VS4oq3EcF1fq+FtvOkVw8Me2
         Ny+i93BGSMzFEH06++PpcT2/ky5wYo6Wj0abJ+FT/JASlw4WTZR0ms8jK7dTC2hBvgJ/
         VBxA==
X-Gm-Message-State: AOAM531t9iIs2IWbv9lKExGp5iD4TFbyjOksho9zx2cKjwWfvZCcD0EK
        CF8FLiC5ZmpOlDF63zDrub+WqfVLC5TwGUPjQ3zNFg==
X-Google-Smtp-Source: ABdhPJz/KsMR5cwJXf4h7firlHqcR38NSaLD0e9vVXsj0n4ovrJXx7T2uNws7j4DG1rO95sIaCLrNdWZrYLYo6BuXoA=
X-Received: by 2002:aca:df44:0:b0:2ce:285f:cb99 with SMTP id
 w65-20020acadf44000000b002ce285fcb99mr6309701oig.40.1645238631013; Fri, 18
 Feb 2022 18:43:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 18:43:50 -0800
MIME-Version: 1.0
In-Reply-To: <1644851994-22732-7-git-send-email-quic_srivasam@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com> <1644851994-22732-7-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 18:43:50 -0800
Message-ID: <CAE-0n533mcROZYQ_6SrH4gMhFXjME=1R9oMknsJDcwLUT1LGPQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] pinctrl: qcom: Add SC7280 lpass pin configuration
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-14 07:19:53)
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> new file mode 100644
> index 0000000..5bf30d97
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * ALSA SoC platform-machine driver for QTi LPASS
> + */
> +
> +#include <linux/clk.h>

Drop unused include.

> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "pinctrl-lpass-lpi.h"

include ../core.h

> +
> +enum lpass_lpi_functions {
> +       LPI_MUX_dmic1_clk,
> +       LPI_MUX_dmic1_data,
> +       LPI_MUX_dmic2_clk,
> +       LPI_MUX_dmic2_data,
> +       LPI_MUX_dmic3_clk,
> +       LPI_MUX_dmic3_data,
> +       LPI_MUX_i2s1_clk,
> +       LPI_MUX_i2s1_data,
> +       LPI_MUX_i2s1_ws,
> +       LPI_MUX_i2s2_clk,
> +       LPI_MUX_i2s2_data,
> +       LPI_MUX_i2s2_ws,
> +       LPI_MUX_qua_mi2s_data,
> +       LPI_MUX_qua_mi2s_sclk,
> +       LPI_MUX_qua_mi2s_ws,
> +       LPI_MUX_swr_rx_clk,
> +       LPI_MUX_swr_rx_data,
> +       LPI_MUX_swr_tx_clk,
> +       LPI_MUX_swr_tx_data,
> +       LPI_MUX_wsa_swr_clk,
> +       LPI_MUX_wsa_swr_data,
> +       LPI_MUX_gpio,
> +       LPI_MUX__,
> +};
> +
> +static int gpio0_pins[] = { 0 };

const?

> +static int gpio1_pins[] = { 1 };
> +static int gpio2_pins[] = { 2 };
> +static int gpio3_pins[] = { 3 };
> +static int gpio4_pins[] = { 4 };
> +static int gpio5_pins[] = { 5 };
> +static int gpio6_pins[] = { 6 };
> +static int gpio7_pins[] = { 7 };
