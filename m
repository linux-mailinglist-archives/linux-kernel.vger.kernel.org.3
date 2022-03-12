Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53F64D6EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiCLM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiCLM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:59:41 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1522FDB4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:58:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j17so16954248wrc.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=SzJcPIpw2JXSwwwvNaXXSXBsRq1AgljXBKYO5oStGHk=;
        b=pO7UtVEDqveP8U1xbSpyJkEwmft9WFMBLT6vqYHN9QjVof9ikVIOopW+wrRwJHdOTr
         LQgBW0ReyV8hSVEtq1/gIPaRY2wYZ9pMin5aLpCyyvfrtxHV0DnsrP1TXBZ05xFVHXPy
         qAtoez1q9BFr645tkh1ban0xu68W1Hgz9RGN06cxo3+k1+H6JrLU5YLJjAQqn9NDKY53
         7DaCqTCQd3qSlzpMAPEaOn6ENZqKLtAdNcPLxHzRkx+DMBSAOv9pvTKc0o4JNTxiu6as
         aHISOPcS0d5YQ1Y9zR+b/FhCWaBz09bsAhhQ8r1dOy5UnmVnspfTwZjDGXEg0dKVlCEk
         z4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SzJcPIpw2JXSwwwvNaXXSXBsRq1AgljXBKYO5oStGHk=;
        b=7RVDF3/E+pqMqh/vPntUioAA/7TgZwl71AdwcoirU07voPTGqqr+BMLFhsJPzZEvoh
         N1Juu9RPtW6kgH+o/i1qJMGoYrwOHSzNTQcw/N4m7edyQSuPFyvbFF/Bv3oesPKA2cso
         ai0Vt72kDEvgfCQN65k2n/e9sKJp2Wf37Unr+TCI5Qrg9Gcom1Z3A8r4gHOlAfDbh5nW
         JqK0D8DK+FTvtlQBBbSNPiMQGm8lspeOpX7D8bFBrH4vLe01+KoR8XpU38E/r1VbV1RU
         /fcTOi/CsZX2am+Os8joGcSeBzhvHef8Pzx8rjGp33o7mZRFFbffLJcpS1ipfoQgky6J
         FZYg==
X-Gm-Message-State: AOAM530vrdHSOhfb9JDAaBAGoA1jN0hXYJyYDo/KAOBMPCUYkJ+rS1Gd
        xldbtKkSKEqhw3Mvjkn6H1o=
X-Google-Smtp-Source: ABdhPJz7XDVCI5t5omhSN7nPqlb4ZQ7TTcueBgnQwIDdowh9jKTk3K4TdanVoNJt8Ke7whyyytj+LA==
X-Received: by 2002:adf:e4cb:0:b0:1f0:3429:8386 with SMTP id v11-20020adfe4cb000000b001f034298386mr10497856wrm.177.1647089910270;
        Sat, 12 Mar 2022 04:58:30 -0800 (PST)
Received: from ?IPv6:2001:a61:13b1:c801:ecd8:aa7c:b70:c2cc? ([2001:a61:13b1:c801:ecd8:aa7c:b70:c2cc])
        by smtp.gmail.com with ESMTPSA id h188-20020a1c21c5000000b00385699a8993sm10531804wmh.11.2022.03.12.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 04:58:29 -0800 (PST)
Message-ID: <8f4a088ffc0fc1d4aa14aa1d0adf575cdc94291b.camel@gmail.com>
Subject: Re: [RESEND V2] ASoC: max98390: Add reset gpio control
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Steve Lee <steve.lee.analog@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org,
        jack.yu@realtek.com, nuno.sa@analog.com,
        ryans.lee@maximintegrated.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Date:   Sat, 12 Mar 2022 13:58:27 +0100
In-Reply-To: <20220312002429.16175-1-steve.lee.analog@gmail.com>
References: <20220312002429.16175-1-steve.lee.analog@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-12 at 09:24 +0900, Steve Lee wrote:
>  Add reset gpio control to support RESET PIN connected to gpio.
> 
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  sound/soc/codecs/max98390.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98390.c
> b/sound/soc/codecs/max98390.c
> index 40fd6f363f35..9a9299e5cc5a 100644
> --- a/sound/soc/codecs/max98390.c
> +++ b/sound/soc/codecs/max98390.c
> @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client
> *i2c,
>  
>         struct max98390_priv *max98390 = NULL;
>         struct i2c_adapter *adapter = i2c->adapter;
> +       struct gpio_desc *reset_gpio;
>  
>         ret = i2c_check_functionality(adapter,
>                 I2C_FUNC_SMBUS_BYTE
> @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>                 return ret;
>         }
>  
> +       reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> +                                            "maxim,reset-gpios",
> GPIOD_OUT_LOW);

A reset GPIO is a standard property so there's no need for a vendor
prefix. This should be devm_gpiod_get_optional(&i2c->dev, "reset",
...). And, as said before, you need to add a reset-gpios property to
the bindings in a different patch.

I'm also not sure why you have this as RESEND...

- Nuno Sá
> 

