Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB80558F60
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiFXD7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFXD7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:59:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80552514;
        Thu, 23 Jun 2022 20:59:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b24so352501qkn.4;
        Thu, 23 Jun 2022 20:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1nNf3XStVvU0zxU2GlC+AY6jj6Sph5Ok2Q3M9aTXj3c=;
        b=Qo1e6VfJl1mAt7its+TcW1KhbQ5FY2hceBuiIwEITJk4hLVY2seInCUcbaOwXZT3UH
         4CjCdYJVMSeXy3i4YBOiF20dtpQ2YAd9XM212xKSqWQhRdXPUkWhmoQxZDI8XmvAP3LY
         iRNAzNu+cTwMrGMn+ogI6aksMwILBTR2rhjn1c3AKQbHWQE/Y+Fj7QW/c+BiNnklhDIL
         TJ5RY8+8ee1xrMlSHgQW5btX8urIXJ8KeoAf9IhLxkPmKtr4ZEASW8Powkdd3A0rmGnx
         P6uoguAH0Iv2LRM1HHrcc0J1en6DMVoMWXJ+6k1gni+vO+4Ym8e+GNgdZCvHT3nZCUud
         5CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1nNf3XStVvU0zxU2GlC+AY6jj6Sph5Ok2Q3M9aTXj3c=;
        b=8IFrRrEQHvMH7VrzYYPBAyybLIG3kIFFd5H7GxbO6pcxkWasr40ez/w+bIvizqt+22
         WrHYaXJL7aPG3MoGNOpU6EYLjKxtYPd/ah6tpJyWq9vs5K/nOCmLrJEbSwMxbbln18M6
         Otjepiz2CVI0SuS45s0BmeaFu1aV0jSjKvVnJ72/N9HTzv/5f1NerPFMru0qbcNsM1qB
         kTaKXugxUBrTiiGyXtGati+fpK6LzpY5K/07xP84vrxUVJ/XiA8qUUhmj3YVS/wNoQxl
         OeF8uypFJpvYAQcunPF1AgkHleLscBXWHucrI3FRKe3rQf8TSRN6h3K5tooLGZyxj2EY
         ncSg==
X-Gm-Message-State: AJIora9FKL2gD8HSJQ0FBD7wezQ1vfrZQIRhQXOU6AORBqRE2MVpiNLr
        V+HO5ntWPk3cJIGf/nGsYEK2iY1UN4cF3w==
X-Google-Smtp-Source: AGRyM1tH74J6QRCCuhGBKAIcA/xDMPL9TX2L/JBNOXXCCFY30JyeLtHWRY4Bsz+l0qlyPHGj/pzhmw==
X-Received: by 2002:a05:620a:244a:b0:6a7:3cb5:98b0 with SMTP id h10-20020a05620a244a00b006a73cb598b0mr8763086qkn.295.1656043170695;
        Thu, 23 Jun 2022 20:59:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:742c:47ee:54c0:bcc7? ([2600:1700:2442:6db0:742c:47ee:54c0:bcc7])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a164d00b006a6a4b43c01sm1009402qko.38.2022.06.23.20.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 20:59:30 -0700 (PDT)
Message-ID: <14a9c8fe-410e-2c85-7d1e-733222d1902c@gmail.com>
Date:   Thu, 23 Jun 2022 22:59:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] of: base: Remove duplicate 'of' in two places.
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621161322.17739-1-jiangjian@cdjrlc.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220621161322.17739-1-jiangjian@cdjrlc.com>
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

On 6/21/22 12:13, Jiang Jian wrote:
> file: drivers/of/base.c
> line: 1152,1177
> * @matches:    array of of device match structures to search in
> changed to
> * @matches:    array of device match structures to search in
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/of/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d4f98c8469ed..f738939cd283 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1149,7 +1149,7 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
>  
>  /**
>   * of_match_node - Tell if a device_node has a matching of_match structure
> - * @matches:	array of of device match structures to search in
> + * @matches:	array of device match structures to search in
>   * @node:	the of device structure to match against
>   *
>   * Low level utility function used by device matching.
> @@ -1174,7 +1174,7 @@ EXPORT_SYMBOL(of_match_node);
>   *		you pass will not be searched, only the next one
>   *		will; typically, you pass what the previous call
>   *		returned. of_node_put() will be called on it
> - * @matches:	array of of device match structures to search in
> + * @matches:	array of device match structures to search in
>   * @match:	Updated to point at the matches entry which matched
>   *
>   * Return: A node pointer with refcount incremented, use

"of of device" looks wrong, but 'of device' means Open Firmeare device.
So technically it is correct.  If Rob wants to accept the patch then
I am ok with the acceptance, to avoid future attempts to fix.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
