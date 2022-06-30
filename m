Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457CE56175A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiF3KLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiF3KLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:11:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CAC44765;
        Thu, 30 Jun 2022 03:11:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso1364714wma.2;
        Thu, 30 Jun 2022 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zVzVBpc51Y9uLu6xYb1G8geSUsvqr31CmHRYh6kJdeM=;
        b=DFA3yU4qhejKdCMs4TdpjF2Aj0jooukDpX5TtP8A8Gc4xLcCd/Rc2fLf5eBOkqqUdP
         g7mE69Fxe8kvgct2cW3EMYPN53rzfAd5DUF972twWYBNHUL2zftlefzZmFE49v4SzNSt
         mzm2SYETieSzwRPtt89tIwbgKEaUtP4KBxiig46iXK2yzniWniWoVzqvN4Zr4JsNnf7f
         4XZdsbBUMqBZQc9V6V0d7u2zZnmZ+Jv08FwQBAHuC1PwvlpGObIjwEPs0orAEc0ZHv9b
         fvbk/yPop5tj34CFFdhgT9IkdExEkRDC6fx7zKh75bB7ASLw4TjtwuCC10QMGcghxGnQ
         3Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zVzVBpc51Y9uLu6xYb1G8geSUsvqr31CmHRYh6kJdeM=;
        b=AFk5JiaifhThv4oFm8n+T6nwhxhWsvYMMB6UjkBgGMvHYtDm0wxXN6V2KvA5exD9BK
         JLfKHGoohA3gk+w0AQ6oTV2kw+ZQHZCjIe8jOEWugptwC4kkVn3LJJVij91cFS1dbwdV
         6Vwq4QrayY+8CojASfSnEAbmLn6WtO4lk/a9/4f1aoyQxmMnIIgpbAI1oONm3zYAN2YH
         7jMJmoCpllAosNpaWY4UqfQLwAZBQCRK2UuwCmCT+hnv5KmdGf3UrBKSnFEmbQ/QvWAj
         jBdj202FvNYIbjxYoa5tPxSdSjdI6ifJyUI/YAGp9gy2Vllj8IxgbS9c7Rf5kMDlNgQJ
         ASQA==
X-Gm-Message-State: AJIora+uGr2EJBR26Z/j+QwWYfhZ0RUaiOS28k9UQR+81tV1g4SYWD0X
        dw7f5pn2rqKJf07stjVf6B2xpjqFSUY=
X-Google-Smtp-Source: AGRyM1u0YDvIyWjrWkHoZVEer/5LPtqoGNI6/VKPd3fOSaHcoI430uzZf+tlslgxXR/z3POMo6dKnA==
X-Received: by 2002:a05:600c:4ecc:b0:3a1:68bf:d17a with SMTP id g12-20020a05600c4ecc00b003a168bfd17amr8719084wmq.154.1656583862544;
        Thu, 30 Jun 2022 03:11:02 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003973ea7e725sm2910107wmq.0.2022.06.30.03.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:11:02 -0700 (PDT)
Message-ID: <c219e966-d282-ed5a-a619-d33d99eee6ca@gmail.com>
Date:   Thu, 30 Jun 2022 11:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/6] media: ov5693: add dvdd into ov5693_supply_names
 array
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-3-tommaso.merciai@amarulasolutions.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20220630074525.481790-3-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


On 30/06/2022 08:45, Tommaso Merciai wrote:
> Add missing "dvdd" (Digital circuit power) entry into ov5693_supply_names
> array
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
> Changes since v3:
>  - Add reviewed-by tag, suggested by Jacopo, Krzysztof
>
>  drivers/media/i2c/ov5693.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index f410333c4c67..9e84468d920e 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -132,6 +132,7 @@
>  static const char * const ov5693_supply_names[] = {
>  	"avdd",		/* Analog power */
>  	"dovdd",	/* Digital I/O power */
> +	"dvdd",		/* Digital circuit power */
>  };
>  
>  #define OV5693_NUM_SUPPLIES	ARRAY_SIZE(ov5693_supply_names)
