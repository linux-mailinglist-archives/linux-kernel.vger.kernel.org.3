Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22452CC20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiESGpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiESGpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:45:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73D94D9F3;
        Wed, 18 May 2022 23:45:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n13so6109168ejv.1;
        Wed, 18 May 2022 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VoByvcP7bL3erDKZ9eCF52S10ofQGaBH9DmhEc6wMHo=;
        b=o8phvVytMawY11PrJr5yMlH1aL6Pn8rQY9wZFrdDYSPBdSA2V4NdpDC84QfwzjZwYr
         3esgMdEHOGv7ORU93HY591KCBfgicUeJCfIANLy/cl+HJeZyhX7+VxeX5lQw6/2f1gXi
         U/VWhwopUuKCyw9aco0y63LQIB0YeFmm5lUAxSHw8ELflVD4kAmkdGh0uPYRN3T0plBO
         H9LZco+FfksTH4qpXrHF647arG+fi1C56oMrVClhOFQBlIAI4wW66ggpgMEkm9+opho6
         lw77XAw0lY46NIOaRMhNbJbgsprZY18tNqIDNctMV5bx3ikUAX2wO1iyTAoXLHnlk1dV
         W6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VoByvcP7bL3erDKZ9eCF52S10ofQGaBH9DmhEc6wMHo=;
        b=PWMniPTEzhA68bFTQGysScwfhVG6RoUoCOpQr2MmfChrZt05FZHref/2YXAxJfj2Za
         AeMtSNV+DjeBw5BAAR1Immk3Yo7r692OqyDGMcw8+U+MeEmOvYOQTRIoz+mzjcMAw7lr
         5Cvwn2JUulGk5HGhtV4YHC5hv6S0s6QTcFeqkqtAq2ZZ2apxGxNh7viI/o9aofcy1FWE
         E6NIy8pvU1W9/IBdziJISLChc2qCqMTGVIzPzHkiBVZFJVHpqLrfYVkydxrhjwetco3d
         RTXBWyhISHK1VhSmQC555Z70A/LELavcs4LRcrORJC7Dj0MnS0HJOYQNV+KU1e210RJO
         THhg==
X-Gm-Message-State: AOAM532B24KLmbljH6YLmUPhzU8t1NnYX/Ly1SXOuV9XE6MbtMCM+ZrS
        JIUQDCanSy2bCTYpZM2pgMb2rGJvlItxwQ==
X-Google-Smtp-Source: ABdhPJz7jqZbW7qrXuROZxSOH7g/7ZXBK6MixS/PfYcs8i63eOYX4WDZDhZX76R3t5dzfegD4Ubeiw==
X-Received: by 2002:a17:906:4ccc:b0:6fe:9155:47ae with SMTP id q12-20020a1709064ccc00b006fe915547aemr2754046ejt.246.1652942738312;
        Wed, 18 May 2022 23:45:38 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id eo20-20020a1709069b1400b006f3ef214e58sm1739298ejc.190.2022.05.18.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 23:45:37 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Thu, 19 May 2022 08:45:36 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] sign-file: Convert API usage to support OpenSSL v3
Message-ID: <YoXnkIke2xgSuN6F@eldamar.lan>
References: <20220518215129.264872-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518215129.264872-1-keescook@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, May 18, 2022 at 02:51:29PM -0700, Kees Cook wrote:
> OpenSSL's ENGINE API is deprecated in OpenSSL v3.0, along with some
> other functions. Remove the ENGINE use and a macro work-around for
> ERR_get_error_line().
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: keyrings@vger.kernel.org
> Suggested-by: Adam Langley <agl@google.com>
> Co-developed-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20211005161833.1522737-1-lee.jones@linaro.org/
> v2: https://lore.kernel.org/lkml/Yicwb+Ceiu8JjVIS@google.com/
> v3:
>  - Eliminate all the build warnings with OpenSSL 3
>  - Fully remove ENGINE usage, if it can be optional, just drop it.
> ---
>  scripts/sign-file.c | 49 ++++++++++-----------------------------------
>  1 file changed, 11 insertions(+), 38 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index fbd34b8e8f57..2d633c5f57c3 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -52,6 +52,10 @@
>  #include <openssl/pkcs7.h>
>  #endif
>  
> +#if OPENSSL_VERSION_MAJOR >= 3
> +#define ERR_get_error_line(f, l)	ERR_get_error_all(f, l, NULL, NULL, NULL)
> +#endif
> +
>  struct module_signature {
>  	uint8_t		algo;		/* Public-key crypto algorithm [0] */
>  	uint8_t		hash;		/* Digest algorithm [0] */
> @@ -92,16 +96,6 @@ static void display_openssl_errors(int l)
>  	}
>  }
>  
> -static void drain_openssl_errors(void)
> -{
> -	const char *file;
> -	int line;
> -
> -	if (ERR_peek_error() == 0)
> -		return;
> -	while (ERR_get_error_line(&file, &line)) {}
> -}
> -
>  #define ERR(cond, fmt, ...)				\
>  	do {						\
>  		bool __cond = (cond);			\
> @@ -135,35 +129,14 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
>  static EVP_PKEY *read_private_key(const char *private_key_name)
>  {
>  	EVP_PKEY *private_key;
> +	BIO *b;
>  
> -	if (!strncmp(private_key_name, "pkcs11:", 7)) {
> -		ENGINE *e;
> -
> -		ENGINE_load_builtin_engines();
> -		drain_openssl_errors();
> -		e = ENGINE_by_id("pkcs11");
> -		ERR(!e, "Load PKCS#11 ENGINE");
> -		if (ENGINE_init(e))
> -			drain_openssl_errors();
> -		else
> -			ERR(1, "ENGINE_init");
> -		if (key_pass)
> -			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
> -			    "Set PKCS#11 PIN");
> -		private_key = ENGINE_load_private_key(e, private_key_name,
> -						      NULL, NULL);
> -		ERR(!private_key, "%s", private_key_name);
> -	} else {
> -		BIO *b;
> -
> -		b = BIO_new_file(private_key_name, "rb");
> -		ERR(!b, "%s", private_key_name);
> -		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> -						      NULL);
> -		ERR(!private_key, "%s", private_key_name);
> -		BIO_free(b);
> -	}
> -
> +	b = BIO_new_file(private_key_name, "rb");
> +	ERR(!b, "%s", private_key_name);
> +	private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> +					      NULL);
> +	ERR(!private_key, "%s", private_key_name);
> +	BIO_free(b);
>  	return private_key;
>  }

Fixes for us as well the build warnings for sign-file.c (as you noted
the other part is still in extract-cert.c).

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore
