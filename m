Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF44A8FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354737AbiBCVXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiBCVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:23:34 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784AC061714;
        Thu,  3 Feb 2022 13:23:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id s6so3715765qvv.11;
        Thu, 03 Feb 2022 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Nnf3nVmTxkGVskxGBVqrk69ahTXdF+y2ZWsyvwOJYU=;
        b=T854qsATAkmmNxLjPIPpNCJ/KqNmWeSsvbhwcMtgsPKlNJbBYzmnO4n6uSqsS7mIhp
         U+Jv15TD90OusNYLEyA35RCgykVRSmqv7TA+wbI3Mhw30PD4ADfqTB5sPP8UR+yxFdl9
         tfgs2UggAIHnhQTR1HBWsUi1pVMJ26VCHbYXMKy8rIpymrGftHfRHhjTm6w7WbR7ZjFk
         a3wxwlSL0WlhXZQ98Scg8hcAubRAqee8jweIKQySWK7Q5IfdPl6Ic3wD/In2VyV5nV78
         tvdugDxUBuGWLcY1fO03h8NDQMu1uwEe/bs3InzZFbQhBeqoAXZthJOi8ZtXtSq/8M9d
         GaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Nnf3nVmTxkGVskxGBVqrk69ahTXdF+y2ZWsyvwOJYU=;
        b=vjctXUZTU/oaBm50ekSJGLj+jyZy1SzdUVMLrxQSl0oRZ+X1mrXXz3QQbWN2RkvMjT
         qg5YxY0YGcEpygPfMze5Nxf3pOb7vpkLTgFoQcsys58XpF1uqQStYyRJjf+G2qhKhh1f
         abAVO2Zk2R/AngqLEkgbcvH4Al0Yl+YdSF5XCieV7jeN2XS2KT4AwK5lnwS5ofg0qVoC
         qWFf5+9SJmCwLrBajaDWkMswIeNWKMzttE4u21mD/jfTRkEePtIz5HbHLr5Kigs2ImFn
         wcCE/w1CnZWGR5R66QLyOlNkhMUAQSYN/8lrtI4b4TvAEJg5P3DX07yq3FUPejLePZoY
         nBLQ==
X-Gm-Message-State: AOAM531grLp9rDRX+y/PgZwuyzNdWfkfk2+sEL7sGP5qThvKwXyZyaWa
        0ee1N0iN2Ty2Zn9wuCyE6J0=
X-Google-Smtp-Source: ABdhPJyfxQj3/Jj+iKADZO+s+aDW2+f4qzZ0JoTEQBJcGO1iJP7Lm0aKdnk/I8HdkgHyqABmZtu12Q==
X-Received: by 2002:a05:6214:da9:: with SMTP id h9mr32294882qvh.3.1643923413291;
        Thu, 03 Feb 2022 13:23:33 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id x18sm29269qta.57.2022.02.03.13.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 13:23:32 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: config option - print pass message at
 same level as fail
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220202194513.2840070-1-frowand.list@gmail.com>
Message-ID: <8044017d-d598-a72d-8cf0-e87829954d9d@gmail.com>
Date:   Thu, 3 Feb 2022 15:23:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220202194513.2840070-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 1:45 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Printing the devicetree unittest pass message for each passed test
> creates much console verbosity.  The existing pass messages are
> printed at loglevel KERN_DEBUG so they will not print by default.
> 
> The test community expects either a pass or a fail message for each
> test in a test suite.  The messages are typically post-processed to
> report pass/fail results.
> 
> The pass messages can currently be reported by enabling KERN_DEBUG
> loglevel for the console, but this also results in other additional
> messages.  Create OF_UNITTEST_SHOW_PASS to enable printing the pass
> messages at the same loglevel as the fail messages.

This approach was NAKed in the email thread that was discussing the
desire to print pass messages for individual unitttest tests.  The
key reason being that additional kernel CONFIG options have some
downsides.

So consider this patch dead.

Another patch has been submitted using a different approach.

-Frank

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/Kconfig    | 10 ++++++++++
>  drivers/of/unittest.c |  5 ++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..6ad05df4f7d4 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -25,6 +25,16 @@ config OF_UNITTEST
>  
>  	  If unsure, say N here, but this option is safe to enable.
>  
> +config OF_UNITTEST_SHOW_PASS
> +	bool "Device Tree runtime unit tests, report each pass"
> +	depends on OF_UNITTEST
> +	help
> +	  The messages reporting an individual test pass are normally
> +	  printed at loglevel KERN_DEBUG.  Enable this option to print
> +	  the PASS messages at the same loglevel as the FAIL messages.
> +
> +	  If unsure, say N here, but this option is safe to enable.
> +
>  config OF_ALL_DTBS
>  	bool "Build all Device Tree Blobs"
>  	depends on COMPILE_TEST
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 70992103c07d..efcec1c6c895 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -44,7 +44,10 @@ static struct unittest_results {
>  		pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
>  	} else { \
>  		unittest_results.passed++; \
> -		pr_debug("pass %s():%i\n", __func__, __LINE__); \
> +		if (IS_ENABLED(CONFIG_OF_UNITTEST_SHOW_PASS)) \
> +			pr_err("pass %s():%i\n", __func__, __LINE__); \
> +		else \
> +			pr_debug("pass %s():%i\n", __func__, __LINE__); \
>  	} \
>  	failed; \
>  })
> 

