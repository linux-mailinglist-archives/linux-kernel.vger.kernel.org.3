Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFD56B11F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiGHDyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHDyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:54:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4C74DE2;
        Thu,  7 Jul 2022 20:54:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w185so18788492pfb.4;
        Thu, 07 Jul 2022 20:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=boMoiQ7O+iidCb90Ajv0DmnlcZVRw9XoN19BAZFvz0Q=;
        b=PAyzN5zd/pXMr0RfDgSRgyz4Ab0+ZK907q7JkXafq6rbA3DcUNwLv5MiOJ1OBvPZ+V
         PVwOxqIDf+vtFY20qOvDzu8QOgWCau6I5AogopFe/fL+KRzzw7fPvgYyfQjaENFMCxhJ
         xLnU5P3XiTqEpk0xes2ZN95I1wdpTFL/r5fwqOTpj1OW5kHdzSVneiInXKAqbFOLXcif
         Rx0w5p3ICf4IeSQO/dC5l5RzTrNu45MfvHpOF+VXMXh30W4oBpxVxTb65yarIDtu2UYR
         dg7BmRy3zDyStQBKIswemyXYyeh+2InZad8Uhd0gu8M0zAWb0SXaAkTX33OP42l7MT1W
         zTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=boMoiQ7O+iidCb90Ajv0DmnlcZVRw9XoN19BAZFvz0Q=;
        b=2Zu7t1R6VC20tw2RcVnLF9f8RFw2Zp1a1lkqjl91oHj+jgUVFIZNd8XMZ9Fc+XG9ID
         J6hhrQj8g02goKSYX5geY47T9w5LnNBjP2fKtKk5G8P3gE7P0MQoO81GzuAJrIHTDERr
         cJ//YMgGDAA6ha00E7CqIZObSYq9q5Ex03DyaDiS6uACnKgDze+NQpUMoP3Y5a7qbjDh
         w5VkoqkVCNWBKf9pNZS6tgl+zGNARbApmIGwqjD1QT6tvEfEDjWtTyNKokUgoz2tVQpo
         F3KYfpsKX4oOwFoiTzHSRKSllKfdCQftsbvuXt0vgiFN7DQeMMRqjJXUu3LXv66TtHrD
         WTNw==
X-Gm-Message-State: AJIora9YIYQYSNki5BgHXVhS8KI7ivB5/PLseu8H4TeGul1DYxWEn0d5
        HD/XJVrmqJqFFeJs7WM9U/A=
X-Google-Smtp-Source: AGRyM1t23AvMiJ2iSX9LEY552bKPo4g7Ld4jiIqNqJH5gcXFwBw4gYJY+WMm0c7ZlvzZqAqDp1aeiQ==
X-Received: by 2002:a63:6d5:0:b0:412:ac9d:814e with SMTP id 204-20020a6306d5000000b00412ac9d814emr1507543pgg.90.1657252454656;
        Thu, 07 Jul 2022 20:54:14 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b0052534ade61dsm27766700pfr.185.2022.07.07.20.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 20:54:14 -0700 (PDT)
Message-ID: <8d42d2f2-1da5-0f23-6e43-a505e9d9d41f@gmail.com>
Date:   Thu, 7 Jul 2022 20:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH] MAINTAINERS: Remove Matt Mackall as his identity is
 obsolete
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-embedded@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20210920080635.253826-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210920080635.253826-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2021 1:06 AM, Uwe Kleine-König wrote:
> The mails I sent to Matt on September 14 and 20 both were refused by the
> MTA responsible for selenic.com (i.e. waste.org) with:
> 
> 	554 5.7.1 <mpm@selenic.com>: Recipient address rejected: This identity is obsolete
> 
> Also the most recent commit that involved him (ignoring "Cc: Matt
> Mackall <mpm@selenic.com>" footers) is commit 330e0a01d54c (MAINTAINERS:
> Theodore Ts'o is taking over the random driver) where he was removed
> from the entry for random number drivers in 2012.
> 
> So drop him completely from the list of maintainers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This has not been applied and we still have entries in MAINTAINERS that 
are bouncing for mpm@selenic.com, can we apply this patch?
-- 
Florian
