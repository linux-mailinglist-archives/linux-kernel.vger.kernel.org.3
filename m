Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA58599BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348611AbiHSMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348963AbiHSMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:10:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CD100F12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:10:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a9so5840882lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/rotPRMyFykIXbEQjK1yUd9+5hjvfQMrFWg8nBVAqTs=;
        b=oiUXuGlaI6xH8x/UtF6sEDlcvS9Wm2oyxdF3yW8iJt0y3msfvBo/3BS3Fcqis1R+K5
         beIMVxWfWNYholJh/B/c8mN4oCAqKvULd7c7UEjZryzGmmuEK0GbnOV7Uijm7t3knQW4
         /it/nYVyovl/yGXcoYGIUOg4ANBqIaaQC+zGyPkNZx5/dfZfIWMQYy6GJwwVooRTcM2L
         l5Vj/Rj2HRRkqLLQ3RAMooDWdPNU8GEry/S3jD+3L/lNn8jxfVxcgV5+HWfx1YQyApOt
         AnNSHcNXhVVh4y6i1FMiEy/BobN5HWmSVfYOPfAhU1dsV+xsMWKMgWtwKA1ACijWq7RX
         bt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/rotPRMyFykIXbEQjK1yUd9+5hjvfQMrFWg8nBVAqTs=;
        b=oKWeLjiy1OfQMQ3y1h65NeV2pdIEt5LO7UmQ550uHq++Ry11DXEv/CCKBdy25tSoa2
         WWi54umMKrLkj8PbcsD9r2YnlfPWdMQCiYL05mcua5KokjGk7LaDr8Di4GaiblqGVn0C
         qcncvyZEnMuFRMxNZuO3+WpvzYbpVCcq6RnsxIxh8rDh0v/C5vF/xIbf61ArNdVc0F4O
         DkjYvvdY/8Q6UadETBzH0SZi+9wKKuh4/42FFT53+Wj5O8RpjnsFAUP433c6+M2IR1iq
         z3PWRBMc8HXaIgC9FjqI1ibFENUNsmUrBj7E3QH7x7kr9iNAot+1kzEu1gdw3yB5GYdK
         d2Sw==
X-Gm-Message-State: ACgBeo1E0BIXRZLgSERLwAYpwymfzDIXTvOrEIgnPEGeVUms+LLuQ7X3
        mwFVz4pAjRv2E2vEEZePuBMseg==
X-Google-Smtp-Source: AA6agR4syKwLDRqEuhqJddk4QS26uPNpz9B/eUtg2l9BcQgQO5jYJ+B4kFiw5IMXuFP8cBdjM9JcDg==
X-Received: by 2002:a05:6512:304c:b0:492:cd69:6cb8 with SMTP id b12-20020a056512304c00b00492cd696cb8mr719471lfb.551.1660911033961;
        Fri, 19 Aug 2022 05:10:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id d11-20020a19384b000000b0048b0975ac7asm616002lfj.151.2022.08.19.05.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:10:33 -0700 (PDT)
Message-ID: <dc03a954-116d-2c41-e9b6-7404652c17af@linaro.org>
Date:   Fri, 19 Aug 2022 15:10:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/3] driver: input: matric-keypad: add reduced matrix
 support
Content-Language: en-US
To:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
 <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 09:59, Gireesh.Hiremath@in.bosch.com wrote:
>  
>  	struct gpio_desc **row_gpios;
>  	struct gpio_desc **col_gpios;
> +	struct gpio_desc **desc_gpios;
>  
> -	unsigned int	num_row_gpios;
> -	unsigned int	num_col_gpios;
> +	unsigned int num_row_gpios;
> +	unsigned int num_col_gpios;

Do not mix up unrelated changes... One logical change, one commit.
Entire patch should be cleanup from this (it's not only here but in
several places). Except that you have build failures to fix...

Best regards,
Krzysztof
