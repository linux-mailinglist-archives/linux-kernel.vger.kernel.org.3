Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9053430A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbiEYSeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiEYSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:34:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B21B2244;
        Wed, 25 May 2022 11:34:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m11so13987860ljc.1;
        Wed, 25 May 2022 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uLCxwXmuTwQ8C9070PRskofFlyqWbZ6vlVTSeVYHQj0=;
        b=jN7fM96z/L77Nuens9WkcAd9bhAHI0LWawwzLDmEQdUnoJUZbD0cpFTGqiZ3qKZ6Cn
         PUaWssfsHCBi3GpfEFGPYBqyRUciE0WnBmkRF73GIxYyCu5qGbSTQveRKPZfSx3E0ibs
         9/mVWbeOYTjTiIYSt+KH6T+9MPRt6anCdxbQjqUYLwWw9+r8VQFcJhI5gwa+zZFMzuLS
         uB6YjsvMsb7xPG+QAEnePND7D2C+7vxnyR8Bct3e5Kx9YH63tduAyKAivRigqoPk90NJ
         STYO2zVv+0dqW3Wx/94p3lpXsoQvTGoT8ajdgCyzJjLdiU7hvDgBleUZiwOA8p3ezck2
         x+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uLCxwXmuTwQ8C9070PRskofFlyqWbZ6vlVTSeVYHQj0=;
        b=ax/jFzfgx5sAEgzoemFaX5s24w5FEJwg5xd8bODPZXeYP2GfYgAXfy06J19kMFL5/R
         QQakKNx+T6J6T+Ud5/EYyuhLXRWgYE3AJdbeHcKbp0xR1Km6c9aXrSK8AA53WZASHnvf
         WWWuX7ck6nXG6Y7O24VRyb19BOMONy/uIOcYOc7ITDrkTPL8EWN06gUjZ9Y1kMx/lvu5
         OOnS3hsDzL5RUZzmlgSIv38Gxl3RFFtXP4PGHfQ2RkWj2co4/pQKT8k4jMhQi0Ph0Le0
         COi7TFqBqysSYniSCxtdPXiURVBDCeom3sOQGneH6p+sCwyevZYcX8cjzJIbgfV51zxA
         6rWw==
X-Gm-Message-State: AOAM531U2c1rs1UMdPCA4xpxxzCuuXMbx+PE5TgTfBzLAjyh8ESYB/Ke
        nNAPEh9EdsE521gcneW2ySazivIAuqs=
X-Google-Smtp-Source: ABdhPJy9ygyklvsU/x9oaDw/g7iaKhq9nfD38vAqYxsCJpNGeCJCPspFsf23AwrTecxOJ6LK1Ziv2w==
X-Received: by 2002:a2e:b78e:0:b0:253:cee8:629e with SMTP id n14-20020a2eb78e000000b00253cee8629emr18750228ljo.244.1653503650947;
        Wed, 25 May 2022 11:34:10 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.139])
        by smtp.gmail.com with ESMTPSA id u7-20020ac251c7000000b00477a97cb50bsm3229072lfm.32.2022.05.25.11.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 11:34:10 -0700 (PDT)
Subject: Re: [PATCH 3/4] sh/boards: Kconfig: Fix indentation
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
 <20220525124007.45328-4-juerg.haefliger@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <c371fcc7-08ad-7de7-cb9a-aa316a98047c@gmail.com>
Date:   Wed, 25 May 2022 21:34:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220525124007.45328-4-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 3:40 PM, Juerg Haefliger wrote:

> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While at it, remove stray tabs/spaces from a seemingly empty line.

   That prolly counts as trailing whitespace which you're also removing
in the 1st hunk...

> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  arch/sh/boards/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index 83bcb6d2daca..fbdb3fbfb976 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -36,7 +36,7 @@ config SH_SOLUTION_ENGINE
>  	select CPU_HAS_IPR_IRQ
>  	depends on CPU_SUBTYPE_SH7705 || CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7710 || \
>  	  CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
> -	  CPU_SUBTYPE_SH7750R 
> +	  CPU_SUBTYPE_SH7750R
>  	help
>  	  Select SolutionEngine if configuring for a Hitachi SH7705, SH7709,
>  	  SH7710, SH7712, SH7750, SH7750S or SH7750R evaluation board.
[...]

MBR, Sergey
