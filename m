Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE00058A1BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiHDUME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:12:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123337198
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:12:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w19so1254776ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CFe0UOoTCAkxSytuVhyN3o9Glboy3Ar/1a94xydXHAU=;
        b=HkqzuZNZeF82/IruQotWTWj+m/LkRjl8BedqywgWKArBNgbeG4cSgm3o6DeuNQpnbO
         iXsKBNmWxLL5j8wlZW3YHLKGXRN2/VhBAZNDn43TWPj5Llk5syIlPkKIarOUeEexWeNK
         wBFBcXnG5/JOxmtxH9yGRzLAXbGRgIREbDzOSeIYlNiixaN6kyKqkfBC7GkkJ8TF2jYW
         1oAxvDaEe2nXwPaSag8CJHwOBeP31fTaTGjdJwV4h2VXdnOd53Abelw9tria8vIRi3nX
         L9aQ8/hc9s8jZVEwkhOx8yVVlRBWmkvFCbZt9bA5zeqN80rdmskvnCrgDhQZsYrNdknk
         2Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CFe0UOoTCAkxSytuVhyN3o9Glboy3Ar/1a94xydXHAU=;
        b=D5it6rnBNxuNbIEmGax3yVFi2E6Yrc9WwC/LQudsyvx4NQpPzQoIxm5rfkP90k6+BP
         o/1yoeI8lnA1GeROBBhDHnLcA+H43kTImzRxVi70TDfLPnak8K4DoMJiH+F681PoQO+w
         /jkzyLeztGLXFg+Xrj13qjbqvvDcEbQzUk3oAMolaJvd/Zm3gRpcN92eirrSOBtptxJR
         +R0PjdfU+auVKfKmw/l2/YoFrXogGdHBaM57s2iW22xynT+yJgIoO1twD5G/fIm0HHws
         7vL5K/P3jADypGN14G9HyqnITa5oNU0LlyyIBLSQIYEI4mC+Q/3ma7QMzhY1FIqC9/DN
         XH/Q==
X-Gm-Message-State: ACgBeo0BbrQEwl/AK3ebpbdznXnkl7aGV99ZOfh6WA1gxcCxj7pdZGVB
        FZejQnlr/2h0II05Xf5VtpQ=
X-Google-Smtp-Source: AA6agR5PCMokznkJ9u6pJzc+bdIm0KEIT63Ru8c2tuStKZ6ufXcMvK8IGiViutsvLNGXJGwGNaQk4g==
X-Received: by 2002:a17:907:2d90:b0:72f:5bb:1f32 with SMTP id gt16-20020a1709072d9000b0072f05bb1f32mr2660516ejc.758.1659643919821;
        Thu, 04 Aug 2022 13:11:59 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id gt26-20020a170906f21a00b006fef0c7072esm688374ejb.144.2022.08.04.13.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:11:59 -0700 (PDT)
Message-ID: <c3b30433-7231-6ebb-b0ea-44e760c4af69@gmail.com>
Date:   Thu, 4 Aug 2022 22:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] staging: r8188eu: set firmware path in a macro
Content-Language: en-US
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <YuoQ37PIKzWO1zIY@kroah.com>
 <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 00:28, Grzegorz Szymaszek wrote:
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 5bd3022e4b40..5985054da935 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -18,7 +18,7 @@ MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
>   MODULE_AUTHOR("Realtek Semiconductor Corp.");
>   MODULE_VERSION(DRIVERVERSION);
> -MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
> +MODULE_FIRMWARE(FW_RTL8188EU);
>   
>   #define CONFIG_BR_EXT_BRNAME "br0"
>   #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */


It failed to apply your patch as the following line:
MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
is not in the repo. Inserted line in my repo to apply patch.

Why is the coverletter missing?

Tested all three patches.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150



