Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C451D939
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392586AbiEFNft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392576AbiEFNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:35:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D083A5C64C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:32:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g6so14518062ejw.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=R4CyzEN8tLV5ATPkFyhAbooF+416jc4wAhU9LceDppk=;
        b=RWpp4fSQmVX9lauE5W+eJIrDkmzEAhlSAXFaR9lYNG5LRla9bgV7ttNm3SdujqSzJ0
         wejeoWTstFYS6G2gd0dzzeIXl6gZXAKNbRshCorFXoA5JxwmrJKgrUGbukTtQhStsKVQ
         rlSojUx+iU2wAefEq2rgBJ8lZ4Us0Pju4OTLG6SoXwF4j2f5PX1F1Py/cdCyOJRYcpyM
         IOVh9z5PCaXGpqNd0B/0Ff3tuK0JyO5ZiLRlBtNAacsYkVuDu7dY0HGXS2VrNZSkk6DI
         ZcYflo+UPhciXMQX4BWbVdVx9vyKYEydu8LWrbEn6/alV20VOXu+b0gohq9nhYQWuZ6g
         Np4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R4CyzEN8tLV5ATPkFyhAbooF+416jc4wAhU9LceDppk=;
        b=d45k1xsBu3qZfPDEqvC9avNGWG6rgTEldQ4zWvGxo44V3uuKcUgCsSr75qyM/Fy3zc
         o+mSuZYJuiPKxWsljZDFmT19SFPsdqJdiI5LRT+3++3OLPyKa97w0jpW29nktzaJM6kO
         8yNqcWZcIzicIUKd0dqWwCCI6oVfwwm+W8+P/dVummPOlvl8r3wMy3tyjiCdj88RvCR9
         Skck0uTgTFo1MLzU7l4tWNIZShSFopGX/K7/qRbrnS8ntPaWSOU/sTxoRS1BgEkR2efP
         6F9XDFsKigInvliNwn/DybJmY3v+k81RzKncjSdwmlLOBwfTlAxN+p9rhQclu8bpozF1
         M4+Q==
X-Gm-Message-State: AOAM531SjOteb6yfsHl+TZH28R42eVVEmuU+JoGxFBFOlU4HIjBioTX5
        vsXp5hWOuS12JOyKdGrgGPk5aQ==
X-Google-Smtp-Source: ABdhPJwfvnvKzo7nRTAaRzuWfBHprTMGdHBk/gr0Gv/Nn2OrD/wsxB5bYGldt46iZGyAiUxtBaVcWg==
X-Received: by 2002:a17:906:29c2:b0:6f3:da29:8304 with SMTP id y2-20020a17090629c200b006f3da298304mr3062189eje.569.1651843921399;
        Fri, 06 May 2022 06:32:01 -0700 (PDT)
Received: from [192.168.0.227] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lr9-20020a170906fb8900b006f3ef214dd9sm1926617ejb.63.2022.05.06.06.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:32:01 -0700 (PDT)
Message-ID: <4cfe150a-e5c0-8864-552e-afa454bfff43@linaro.org>
Date:   Fri, 6 May 2022 15:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] i2c: s3c2410: change return type of
 'i2c_s3c_irq_nextbyte' from 'int' to 'void'
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220506122639.2544-1-hanyihao@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220506122639.2544-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 14:26, Yihao Han wrote:
> Since ret is a redundant variable, and none of the callers check
> for return, so remove ret variable and change return type of
> 'i2c_s3c_irq_nextbyte' from 'int' to 'void'
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
> v2: add return in STATE_IDLE case
> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index b49a1b170bb2..d2a1fd2aa7a0 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -381,17 +381,16 @@ static inline int is_msgend(struct s3c24xx_i2c *i2c)
>  /*
>   * process an interrupt and work out what to do
>   */
> -static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
> +static void i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)

This still should not compile... are you sure you run all the checks on it?

Please do not cc non-working addresses (kernel@vivo).

Best regards,
Krzysztof
