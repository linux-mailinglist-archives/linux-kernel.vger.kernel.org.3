Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C312B4895B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbiAJJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiAJJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:51:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8576C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:51:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k18so25559280wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i4Ie2z98RRkvRgDdmSJjth8vux9u5V+sd3sLTDBOSis=;
        b=1krRpymSaAjyyeMnbtZz5jZKKGExJIwC4guY6I7cTF2xW/MkboKMumpLK4eSzzTGuW
         bPZTPaxJToBl4G2x11WjWahDH49W7/Q0edSYuI/qdyHZhFOy1Vm7xDiWfgRx8oLffr3D
         DL1xV54ytXOgJiIlE6lOlKdZTIKHODyKs9KcpJXkRcZxZ2XGoiEglPWL5wNBxV/t7DPh
         W6G4xXnlCHqjZOKZ1YpYjpFUbdoqBveElYQm9Sx1l6B6f4yGng1L9TnM7Lb5g7IpYt9h
         qQ1xb1oL5XrRbl5jofbG1obd588sjvTqOr+azxbowKwTnh61O+75LnNTeueoJFoxt8en
         WYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i4Ie2z98RRkvRgDdmSJjth8vux9u5V+sd3sLTDBOSis=;
        b=bsuCvp24ON8izmh1KNpH2eCQMubsulT5uxx8inknR1aw66qnPWfnULf/XmG88MRdjp
         Ukkmt5VfCiJ+0j8UM3k6yZiOy8EwXjjB54VlbSW2QZCYElYWnpcUNIwSUCflmuOhiwzj
         o+/0wEwClwrTTMAP8SZoonYgUcwu2JoSNRlajZyLnIhWxZoxqxxltrJ4TzTm1pizugcD
         fWHIt0jCd/5GegYe69ORI6+J9BA4qAdjnlOdGYTdcIWHU50WxawxxQE4PldYKrh6uGZp
         saKPrMFyEONitcRU5ASkkuCEzW1MHgRppcI+mHFXUSO3cVeZzy0DkKK0oAul6ok3ZkRe
         cpJw==
X-Gm-Message-State: AOAM531upk57MXFA6CI4VZ5hmAiVx6cP22v54vYqQNQjsOUKcAEpsK1u
        4ZlIuJ1pfdtkkJIaDuRV5bvbqoRXnG0AQw==
X-Google-Smtp-Source: ABdhPJz++S/4jbXE7vDXl9HrZHXv627zQa2FULE+6/01NUzCxhG1M9h8uHevDIDZfRj10P8GOWOZCw==
X-Received: by 2002:a05:6000:184e:: with SMTP id c14mr62893860wri.265.1641808309947;
        Mon, 10 Jan 2022 01:51:49 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1? ([2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1])
        by smtp.gmail.com with ESMTPSA id p21sm6496370wmq.20.2022.01.10.01.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:51:49 -0800 (PST)
Subject: Re: [PATCH 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220107145515.613009-1-narmstrong@baylibre.com>
 <20220107145515.613009-7-narmstrong@baylibre.com>
 <CAFBinCB3+dSjQFRp5CBpGk5Qi8zoxRDRaobuCtXzU6VtM8+ryQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <508ea2d7-aee3-9409-023c-638b09d733b0@baylibre.com>
Date:   Mon, 10 Jan 2022 10:51:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCB3+dSjQFRp5CBpGk5Qi8zoxRDRaobuCtXzU6VtM8+ryQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 23:49, Martin Blumenstingl wrote:
> Hi Neil,
> 
> some high-level comments from me below.
> 
> On Fri, Jan 7, 2022 at 3:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +/*  MIPI DSI Relative REGISTERs Definitions */
>> +/* For MIPI_DSI_TOP_CNTL */
>> +#define BIT_DPI_COLOR_MODE        20
>> +#define BIT_IN_COLOR_MODE         16
>> +#define BIT_CHROMA_SUBSAMPLE      14
>> +#define BIT_COMP2_SEL             12
>> +#define BIT_COMP1_SEL             10
>> +#define BIT_COMP0_SEL              8
>> +#define BIT_DE_POL                 6
>> +#define BIT_HSYNC_POL              5
>> +#define BIT_VSYNC_POL              4
>> +#define BIT_DPICOLORM              3
>> +#define BIT_DPISHUTDN              2
>> +#define BIT_EDPITE_INTR_PULSE      1
>> +#define BIT_ERR_INTR_PULSE         0
> Why not use BIT() and GENMASK() for these and prefixing them with
> MIPI_DSI_TOP_CNTL_?
> That would make them consistent with other parts of the meson sub-driver.

Yeah it was a lousy copy-paste from vendor driver, and I was lazy, but I'll fix this.

> 
> [...]
>> +static void meson_dw_mipi_dsi_hw_init(struct meson_dw_mipi_dsi *mipi_dsi)
>> +{
>> +       writel_relaxed((1 << 4) | (1 << 5) | (0 << 6),
>> +                      mipi_dsi->base + MIPI_DSI_TOP_CNTL);
> please use the macros from above
> 
>> +       writel_bits_relaxed(0xf, 0xf, mipi_dsi->base + MIPI_DSI_TOP_SW_RESET);
>> +       writel_bits_relaxed(0xf, 0, mipi_dsi->base + MIPI_DSI_TOP_SW_RESET);
> 
> [...]
>> +       phy_power_on(mipi_dsi->phy);
> Please propagate the error code here.
> Also shouldn't this go to a new dw_mipi_dsi_phy_power_on() as the PHY
> driver uses the updated settings from phy_configure only in it's
> .power_on callback?

Good point, let me check that.

> 
> [...]
>> +       phy_configure(mipi_dsi->phy, &mipi_dsi->phy_opts);
> please propagate the error code here as the PHY driver has some
> explicit code to return an error in it's .phy_configure callback
> 
> [...]
>> +       phy_init(mipi_dsi->phy);
> please propagate the error code here
> 
> [...]
>> +       phy_exit(mipi_dsi->phy);
> please propagate the error code here

ok for the 3

> 
> [...]
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       mipi_dsi->base = devm_ioremap_resource(&pdev->dev, res);
> other parts of the meson DRM driver have been converted to use
> devm_platform_ioremap_resource()
> I suggest updating this as well to simplify the code here

Yep, again lazyness

> 
> [...]
>> +       mipi_dsi->phy = devm_phy_get(&pdev->dev, "dphy");
>> +       if (IS_ERR(mipi_dsi->phy)) {
>> +               ret = PTR_ERR(mipi_dsi->phy);
>> +               dev_err(&pdev->dev, "failed to get mipi dphy: %d\n", ret);
>> +               return ret;
> you can simplify this with:
>   return dev_err_probe(&pdev->dev, PTR_ERR(mipi_dsi->phy, "failed to
> get mipi dphy\n");
> 
> [...]
>> +       mipi_dsi->px_clk = devm_clk_get(&pdev->dev, "px_clk");
>> +       if (IS_ERR(mipi_dsi->px_clk)) {
>> +               dev_err(&pdev->dev, "Unable to get PLL clk\n");
>> +               return PTR_ERR(mipi_dsi->px_clk);
> you can simplify this with:
>   return dev_err_probe(&pdev->dev, PTR_ERR(mipi_dsi->px_clk, "Unable
> to get PLL clk\n");
> Also should it say s/PLL clk/px clock/?
> 
> [...]
>> +       top_rst = devm_reset_control_get_exclusive(&pdev->dev, "top");
>> +       if (IS_ERR(top_rst)) {
>> +               ret = PTR_ERR(top_rst);
>> +
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(&pdev->dev, "Unable to get reset control: %d\n", ret);
>> +
>> +               return ret;
> you can simplify this with:
>   return dev_err_probe(&pdev->dev, PTR_ERR(top_rst, "Unable to get
> reset control\n");
> 
> [...]
>> +       mipi_dsi->dmd = dw_mipi_dsi_probe(pdev, &mipi_dsi->pdata);
>> +       if (IS_ERR(mipi_dsi->dmd)) {
>> +               ret = PTR_ERR(mipi_dsi->dmd);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(&pdev->dev,
>> +                               "Failed to probe dw_mipi_dsi: %d\n", ret);
> you can simplify this with:
>   dev_err_probe(&pdev->dev, ret, "Failed to probe dw_mipi_dsi\n");
>

Again 4 lazyness effects, will fix !

Thanks,
Neil


> 
> Best regards,
> Martin
> 

