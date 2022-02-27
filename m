Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C454C5924
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiB0D3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiB0D3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:29:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1886C21F5D0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:29:04 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ba20so9927373qvb.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uVsTdS9A3VvM3V9jvyobaIfl/vvSxzX/obLWEqItyo=;
        b=Gus3oS9RSn7V1sr7kHl81y1aya0zl1pkxCw11w+XDvu9TPjWigg3K7tlfZovWKB4ae
         LoFSKEOnw1/CPf1ue5bg4+ZnXYbF9Y+zkicAyImn/QMeG0xf8RkYkMwE7td7V+XucgUg
         0gDiET8OWcLiR/uTHn2wUh3WcY8POKYYZw/O/qikdZt/B8Oxa+/h0kWL0zlh0jNugHBG
         Rv5B++uhoDoF5bNd2dF70oz4vn2VMV+FnUr/zAIOwkrn52j00Kfgxx5zPdTqm8q/d8vi
         I5UERrNvI3oCAHu2jLszQfE2Ir4z01/zstiDc3a//KS3VlYN7Eft03BJzMvOQq3z/VZH
         WOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uVsTdS9A3VvM3V9jvyobaIfl/vvSxzX/obLWEqItyo=;
        b=g5seU3HeC5Hfl0VlALtqJ8huXx8KJzcpIST0VtPGHwRhX0+8nozFKO2xWmbE4nJ9KV
         X2RTvCrrlC/CdtZ/P+oBCt3LXIntqtxKJ734bKr0xFp+vcrJiDm19Du8MX8HKh29R2j5
         ZJhZW/Ir8fOH9a0NkTWU0n8AzLHfLCKwRBJQxDQpMXxz/zaAXgZb3wtsst9Vzl4EGB7J
         IOWpAate9O+AtZiWbasduJ86zn1HzSN1UdFDFz+bf5au6XZSHNvy7vPD8PFj0NqMAN9x
         WrJYkfD7SyJ1vZfef5YzkzJ/xpJZYhpD+9pBTzcVpvtBU3UZV+K66APiaOD9By7xKoZR
         ywrQ==
X-Gm-Message-State: AOAM532OV/usnSVqaTdlzy/EUKWe7mjEOj9qTHkk4aifuBKzGUw3wIQL
        dXa8D+uBRg+1qp7TcUy/x2cfKjOkCzq8xqJwvNtMoqhOimxFiw==
X-Google-Smtp-Source: ABdhPJy7XFThPExoHd3VFYJIkPak1UpwZE6oPWxM0M9mvJOEkCCe6XwmadvukE4ueQzyWqWGH926oT69VQqrOB0s4xU=
X-Received: by 2002:a0c:d807:0:b0:42c:1ff7:7242 with SMTP id
 h7-20020a0cd807000000b0042c1ff77242mr10578010qvj.119.1645932543232; Sat, 26
 Feb 2022 19:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20220226200911.230030-1-marijn.suijten@somainline.org> <20220226200911.230030-2-marijn.suijten@somainline.org>
In-Reply-To: <20220226200911.230030-2-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 27 Feb 2022 06:28:52 +0300
Message-ID: <CAA8EJppH2AKe7DK7mPhtz2CCW19WdJ0-NJihmFPDswRwTtKcfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: qcom: Fix sorting of SDX_GCC_65 in Makefile
 and Kconfig
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 02:38, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> In order to keep at least the list of `CONFIG_SM_` drivers sorted
> alphabetically, SDX_GCC_65 should have been moved one line up.  This in
> turn makes it easier and cleaner to add the followup SM_DISPCC_6125
> driver in the right place, right before SM_DISPCC_8250.
>
> Fixes: d79afa201328 ("clk: qcom: Add SDX65 GCC support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/Kconfig  | 14 +++++++-------
>  drivers/clk/qcom/Makefile |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index f5b54bfc992f..161b257da9ca 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -574,13 +574,6 @@ config SDX_GCC_55
>           Say Y if you want to use peripheral devices such as UART,
>           SPI, I2C, USB, SD/UFS, PCIe etc.
>
> -config SM_CAMCC_8250
> -       tristate "SM8250 Camera Clock Controller"
> -       select SM_GCC_8250
> -       help
> -         Support for the camera clock controller on SM8250 devices.
> -         Say Y if you want to support camera devices and camera functionality.
> -
>  config SDX_GCC_65
>         tristate "SDX65 Global Clock Controller"
>         select QCOM_GDSC
> @@ -589,6 +582,13 @@ config SDX_GCC_65
>           Say Y if you want to use peripheral devices such as UART,
>           SPI, I2C, USB, SD/UFS, PCIe etc.
>
> +config SM_CAMCC_8250
> +       tristate "SM8250 Camera Clock Controller"
> +       select SM_GCC_8250
> +       help
> +         Support for the camera clock controller on SM8250 devices.
> +         Say Y if you want to support camera devices and camera functionality.
> +
>  config SM_DISPCC_8250
>         tristate "SM8150 and SM8250 Display Clock Controller"
>         depends on SM_GCC_8150 || SM_GCC_8250
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index d96d6793fc7d..3e4eb843b8d2 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -84,8 +84,8 @@ obj-$(CONFIG_SDM_GPUCC_845) += gpucc-sdm845.o
>  obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
>  obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
>  obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
> -obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>  obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
> +obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>  obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
>  obj-$(CONFIG_SM_GCC_6115) += gcc-sm6115.o
>  obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
