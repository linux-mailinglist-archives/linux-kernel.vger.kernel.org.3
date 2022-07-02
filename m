Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D0563EE0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiGBHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGBHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 03:14:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DA11B791
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 00:14:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf9so7776479ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AsRE8YlofhEgLEGxhfUj7r3VBp8VwwZr4Xhnew/B2oY=;
        b=BIHlzh6ZT6m5fjL4lO0QUi9UDT+wWrBthw1L+2/zYQCYF4XxCtt84dkvBbNayGNGqY
         7Sg8xuJzSOIaan7ahw9xk0uk5VVAGBV5X5qLvRzS/unBgrvntXJPAKhCYEew4P7X9kjr
         lZ/fLM4sPNau3Ai2zmoGv8Rm11j/ePgnvw0PPNujm5L3RK2NOSovogU8ZGPMDJPFlEWG
         05YsYklI9FVheuTDCVD+Wf6l+5SLU/WjqeKCq4Mf7v4dAyRvSs1V9iNAaYrvyNlAEeAz
         hNKXUx9sJKo9ISKN+qnCNcA3xnI5v8gMmpOZldhXPHVcPQs1+yG7DJ0i6Srzze9mhMPB
         DmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AsRE8YlofhEgLEGxhfUj7r3VBp8VwwZr4Xhnew/B2oY=;
        b=ZCm+5mnO6IcdsjgOYxnBYi8H449aNclZglFN8IP5EKmthmHmWI6ZD4+Yu/moGELYMT
         OnnEpBsmD4aPaRGdzJPzLJqY/+sDnebhbZHaxECtWO69dycH6IUsUZjm/+V/8X/QTc15
         GuoLikxxYfSEAgtmsZXOtcYFZHAr8BRXvc4IghV4qF5qiL7pSFoNyQlG7GtUXdp8G7vk
         I8YpB+E0BSKrniwO9CEyl4+XGMjfx+b1iuDccI9EVKht2VQhiwMIQG5m2nlHVN6CYcJ+
         YUBmRYXdV0QGeDv0sIO84kMNM4vLbSGuYk9ZEmiJPoBAJd9k0JwZ7V+qzIyA1csOZ49q
         mkUw==
X-Gm-Message-State: AJIora+0fHu2JEFJf8fQn+pyzltq9qv7MaC6vx0e31fdQ8rCYAT5RsKn
        ZlcBzImjMsoydT2gtJIIy4BtctykBoI=
X-Google-Smtp-Source: AGRyM1tFfDDmdJhMtK6SVapbGXWqpGAqi8X1CfpJ4tIwqgtqUYWb6F+HjJpRN+t5LdLQhD/Y8qyrhA==
X-Received: by 2002:a17:907:2bdc:b0:72a:47b5:dbff with SMTP id gv28-20020a1709072bdc00b0072a47b5dbffmr15610811ejc.677.1656746074353;
        Sat, 02 Jul 2022 00:14:34 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906860700b00722d5f07864sm11179354ejx.225.2022.07.02.00.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 00:14:34 -0700 (PDT)
Message-ID: <b3e6cf6e-9185-d9ea-9e2e-15c616e7c76c@gmail.com>
Date:   Sat, 2 Jul 2022 09:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: make ffaddr2pipehdl() static
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220702064626.27506-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220702064626.27506-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/2/22 08:46, Michael Straube wrote:
> The function ffaddr2pipehdl() is only used in usb_ops_linux.c.
> Make it static.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/include/usb_ops_linux.h | 2 --
>   drivers/staging/r8188eu/os_dep/usb_ops_linux.c  | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
> index 641f059ffaf7..966688eedf66 100644
> --- a/drivers/staging/r8188eu/include/usb_ops_linux.h
> +++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
> @@ -26,6 +26,4 @@
>   #define usb_read_interrupt_complete(purb, regs)		\
>   	usb_read_interrupt_complete(purb)
>   
> -unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
> -
>   #endif
> diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> index 0269e602b217..220e592b757c 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> @@ -7,7 +7,7 @@
>   #include "../include/usb_ops_linux.h"
>   #include "../include/rtl8188e_recv.h"
>   
> -unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
> +static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
>   {
>   	unsigned int pipe = 0, ep_num = 0;
>   	struct usb_device *pusbd = pdvobj->pusbdev;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
