Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4151AD61
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377400AbiEDS7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377500AbiEDS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:59:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF5205CD;
        Wed,  4 May 2022 11:55:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so4643389ejb.4;
        Wed, 04 May 2022 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtj3kM23Q+DPPlGR5wpXCN7V8AfMLAVbykig0+rvwrQ=;
        b=UH6Ta6W44ExCTUoM11nmWUGcXNzNXr6eSMG6xgz/VLSDuxvHk4TxueHl5IojELPqZq
         Lt0MDCfaWL8yTjMlJGxbmloy9MPbnQwagScezzZVAoSaVJS32y7cnxqnr+CO51YBQMXZ
         a2Jy/I9JSm6Ym9Rq8MJ05Iz2Ib6QjEN4vrRl+guWsFneVGcTYF645Lay6TdkmNHXigU2
         wgimM8GhKfY9N8UckyEqExMZoQzK7+/yp12vcFeyJVDs9UR4sXxbENLIY4mvml7W3sRx
         exQj7M2e0dMYQW3IOn9dTYDYZuOIB3EjhQyeVTTpDjWRVsEVkawL6JTPrd4pyf8xvuwF
         n0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtj3kM23Q+DPPlGR5wpXCN7V8AfMLAVbykig0+rvwrQ=;
        b=rmXGqopftbApLzgJE0IpkShi5eDMIIqsX5ZW3RMh5ThBmvD+x+bcCEZPBxoYlD+CXj
         JLSo4L48uupzvCoMYGTyQN6Jgr2c8hCS1UCvWdZ4zirlaNZWTP1PaD9iagkuxvJ8MfIZ
         pxb3GQIZsXJUQ7bxoU8nZYoOJcMetUU/A9aei/HJgjgc0yy6qiKZzy1704KVE+6kQfJ9
         n4YuVgrhYLYKpYEvIuYbU5pfJrhKBlRihmSIm0BEyMOsL/IsdS2CMcEVq8+E6z2ulMJi
         OjvzAcgmoTk2drEpzx2fI9o3c+ZSr4ak5/cg9NQQxcdiNVLEt3DdIzf/8TjlM+j/Vs5V
         hTjA==
X-Gm-Message-State: AOAM531HCBtHFRcw+DSeeOB0/115udXpzaNqKNPPIyGsdPoeyADfwU2V
        BY1HxC6RVrw/VbZgwLR1MfxN1iNvjaatXkS4ZIc=
X-Google-Smtp-Source: ABdhPJxOL8YqtOqnXGwVkqYA2gOLeZnIQddYIpWAjllRDaI2rIW3zYjkOhuqL7tjQzCNdLzkQO+MqfBPgDzp4Xf2/eE=
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id
 mp27-20020a1709071b1b00b006e47fac6ce0mr21594175ejc.617.1651690548672; Wed, 04
 May 2022 11:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <1651685100-44687-1-git-send-email-justinpopo6@gmail.com> <1651685100-44687-2-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1651685100-44687-2-git-send-email-justinpopo6@gmail.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 4 May 2022 11:55:37 -0700
Message-ID: <CAJx26kV+15rs0=YcRj6z5ZbKU4=u9MHyuOdo=EfJwAXYKAdbBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: pca953xx: Add support for pca6408
To:     Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 10:25 AM Justin Chen <justinpopo6@gmail.com> wrote:
>
> Add support for pca6408 which is the 8-bit version of the pca6416.
>
> https://www.nxp.com/docs/en/data-sheet/PCA6408A.pdf
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index d2fe76f..2d0b080 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -71,6 +71,7 @@
>  #define PCA_CHIP_TYPE(x)       ((x) & PCA_TYPE_MASK)
>
>  static const struct i2c_device_id pca953x_id[] = {
> +       { "pca6408", 8  | PCA953x_TYPE | PCA_INT, },
Apologies, typo here. Should be capital "x". Will send a v2.

Justin
>         { "pca6416", 16 | PCA953X_TYPE | PCA_INT, },
>         { "pca9505", 40 | PCA953X_TYPE | PCA_INT, },
>         { "pca9506", 40 | PCA953X_TYPE | PCA_INT, },
> @@ -1198,6 +1199,7 @@ static int pca953x_resume(struct device *dev)
>  #define OF_957X(__nrgpio, __int) (void *)(__nrgpio | PCA957X_TYPE | __int)
>
>  static const struct of_device_id pca953x_dt_ids[] = {
> +       { .compatible = "nxp,pca6408", .data = OF_953X(8, PCA_INT), },
>         { .compatible = "nxp,pca6416", .data = OF_953X(16, PCA_INT), },
>         { .compatible = "nxp,pca9505", .data = OF_953X(40, PCA_INT), },
>         { .compatible = "nxp,pca9506", .data = OF_953X(40, PCA_INT), },
> --
> 2.7.4
>
