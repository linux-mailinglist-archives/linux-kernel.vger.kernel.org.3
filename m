Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F55477FB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiFLACm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiFLACl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:02:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F8B7D5;
        Sat, 11 Jun 2022 17:02:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r71so2527996pgr.0;
        Sat, 11 Jun 2022 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qlCbmERsrvq9foWWuo9aQIBttb9mEbAqhvDWRZ6oSQQ=;
        b=LUOwWBl2WUW0c8E5DKEdURyPyWBcZLYrOlDkCtu43KdaPin/uxXePQLYVNje4MA1Zw
         owrlkXxR6B2lhjeqQKH4mK/7U7pwELDvONjmE9WhNTBQzwG9D7VpD9bh/duwaVq085j1
         aDcywihszdG0kFvWRmEwezOb0cTUXk4Hs3kbwbEEDW8jBsM/eSGqn6jFYxa5UkQcn+Np
         fBJLv6P0wbyWx74goE79F22rQFjy+LEXk7THgs9oIEbbwWevkl3YJxQAUT7Fse4iWhXN
         QvCJ6CjhV7poOfc+hHKYg71zYojOaecTVa169bHpnaKF5oRMRZH2fbodrwP3hUdI2Wfv
         E+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qlCbmERsrvq9foWWuo9aQIBttb9mEbAqhvDWRZ6oSQQ=;
        b=vpul7NaHBPBSuj9/ZOE1KOMevhZvho3sADL7+c9VkDyRQZE/ZtaSqKZOkwl1KNTOQm
         cXjV3Og9ngj4lM+3aqAPjv7XmB9UNTiD1O149AYMczM07k/lTBEJrR34hKnIb4FtoM1I
         PeGX/LafvwknvrQZNacm6qMDgD7mxPhgdNatIsjeip9rzmoOaoHYPa9m23Hhk0XZ3MQE
         BzgKqrrbLWvYTJRuqbwEXXkzT0mq53r2ithAJZytWGIqR1hp5MhVON1LcX1mJamWK8s1
         gGpWJiJh9HrlocTU9moXQqnPfq6OzIrI5hLy32tSvcqmuSIRy88SV2HYIwnMwxtcN3Do
         Bi/Q==
X-Gm-Message-State: AOAM531ZCRlKCNjSMv/lMxet0TNefJsANtHhHg6dzNeEySnKuij+BQ17
        OauE7rRVvwAmWnZQvzIJsjc=
X-Google-Smtp-Source: ABdhPJwXENdcrMLJ2Rp7LfygdsphfOJNXYIuLbOQkUMLMFtN5VNvw4MeGziCBzGp7jJvQ9OTvni6Cw==
X-Received: by 2002:a63:9c4:0:b0:401:a7b6:ad18 with SMTP id 187-20020a6309c4000000b00401a7b6ad18mr12331093pgj.523.1654992158671;
        Sat, 11 Jun 2022 17:02:38 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b6-20020a62a106000000b0051826824d90sm2189885pff.177.2022.06.11.17.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 17:02:37 -0700 (PDT)
Message-ID: <84cdc48a-feb8-4aa5-7d96-a68f2c556e25@gmail.com>
Date:   Sun, 12 Jun 2022 09:02:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] gpio: Fix kernel-doc comments to nested union
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 13:44:24 +0900, Akira Yokosawa wrote:
> Commit 48ec13d36d3f ("gpio: Properly document parent data union")
> is supposed to have fixed a warning from "make htmldocs" regarding
> kernel-doc comments to union members.  However, the same warning
> still remains [1].
> 
> Fix the issue by following the example found in section "Nested
> structs/unions" of Documentation/doc-guide/kernel-doc.rst.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 48ec13d36d3f ("gpio: Properly document parent data union")
> Link: https://lore.kernel.org/r/20220606093302.21febee3@canb.auug.org.au/ [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
Gentle ping to gpio maintainers.

I thought this fix would go through brgl's tree.

        Thanks, Akira

> ---
>  include/linux/gpio/driver.h | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index b1e0f1f8ee2e..54c3c6506503 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -167,21 +167,24 @@ struct gpio_irq_chip {
>  	 */
>  	irq_flow_handler_t parent_handler;
>  
> -	/**
> -	 * @parent_handler_data:
> -	 *
> -	 * If @per_parent_data is false, @parent_handler_data is a single
> -	 * pointer used as the data associated with every parent interrupt.
> -	 *
> -	 * @parent_handler_data_array:
> -	 *
> -	 * If @per_parent_data is true, @parent_handler_data_array is
> -	 * an array of @num_parents pointers, and is used to associate
> -	 * different data for each parent. This cannot be NULL if
> -	 * @per_parent_data is true.
> -	 */
>  	union {
> +		/**
> +		 * @parent_handler_data:
> +		 *
> +		 * If @per_parent_data is false, @parent_handler_data is a
> +		 * single pointer used as the data associated with every
> +		 * parent interrupt.
> +		 */
>  		void *parent_handler_data;
> +
> +		/**
> +		 * @parent_handler_data_array:
> +		 *
> +		 * If @per_parent_data is true, @parent_handler_data_array is
> +		 * an array of @num_parents pointers, and is used to associate
> +		 * different data for each parent. This cannot be NULL if
> +		 * @per_parent_data is true.
> +		 */
>  		void **parent_handler_data_array;
>  	};
>  
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
