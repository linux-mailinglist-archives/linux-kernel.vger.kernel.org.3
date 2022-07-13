Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74C573A55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiGMPji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGMPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:39:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD9C11472
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:39:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k30so14603797edk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=ghoNfQpu7fqqpTXJ9FbOQJTsibz1KqkkG3UWT76wgg4=;
        b=aIwmYt+9/bObY+nVk+17rVtldDQZUEPfi153zRIHUj0CHLaCdwCeL04imqDS4lHOPA
         C5P7Lc93V5WSz4QKlrSQ6qS/2pEsLilellwSj4glfAce5PQ50LviVno5tboxZnCcemfm
         trye3NqK9/GVr1p2w+Qs5OXsVZ3DL8JacmCoBGqaTw3/09GutQtcm300s4ViI2EbLukF
         KUjIqjdgDD6pySljQwjeaURoxb0VTAaA1gHi8XHNLKypGf4tE0v8IpCTiyqCqdziTX5p
         jnzMxlEJ5gqxsbYnXapSJQTl90i9qgXaxPgyd7fVIEwVkWCzbsbjzxhjF4kSv+BgIrwp
         WRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ghoNfQpu7fqqpTXJ9FbOQJTsibz1KqkkG3UWT76wgg4=;
        b=WXeOnMXaqFo3gGudFZ+wDWFUv9aqMF7QrvwpQCYnM7wW1ZGEBmNZQ8BgZpehGK1Bse
         K9bB/Xs6BUQwr0P1aFCzMKnuR2GnJQi0ncHb9nR1ZUMnKdWvNuM+Me8Rk9hsrvskeuBn
         qEyhUynYf98SsX3qRF7cwxd4RMCWi+ziZma3EYZnYQz3tadDrDVAZWxZlB02AUlU5N8l
         RG1/HTianT2Alm6doUKa8gcqCJXVVRoU8zVPJtWbXu95JMvNfVQOtu74xpG7pHHvXBxJ
         ToLtSmcgvpAEYxdYFlEZ+10fKHQtwW17RMou8FAzc3rB/H0Q1JfjdvUXXtaUjMl+GFWk
         7ykQ==
X-Gm-Message-State: AJIora8NsoHOV+X0wzY3PQfdoL0bSz/MpC4lD/pGiJhdiKsQfvPVplKR
        BYVcvXJnj1ZuMyMSTF71Hsg=
X-Google-Smtp-Source: AGRyM1sLcUkrL/6qnTzZCSJGFHPeclOr5XWWLLDUR+gukRtnZK+s2CUMWKN/rndwmGDxfecZt65tHQ==
X-Received: by 2002:aa7:c84a:0:b0:437:bc9c:af63 with SMTP id g10-20020aa7c84a000000b00437bc9caf63mr5520382edt.370.1657726773486;
        Wed, 13 Jul 2022 08:39:33 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id ec10-20020a0564020d4a00b0043a45dc7158sm8048880edb.72.2022.07.13.08.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:39:32 -0700 (PDT)
Message-ID: <86444849-e80a-6e28-c060-cecb9f07ae75@gmail.com>
Date:   Wed, 13 Jul 2022 17:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RESEND PATCH 1/8] ARM: debug: bcmbca: Replace ARCH_BCM_63XX with
 ARCH_BCMBCA
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220707065800.261269-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.07.2022 08:57, William Zhang wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> DEBUG_BCM63XX_UART depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>   arch/arm/Kconfig.debug | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9b0aa4822d69..792796a348c3 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -271,7 +271,7 @@ choice
>   
>   	config DEBUG_BCM63XX_UART
>   		bool "Kernel low-level debugging on BCM63XX UART"
> -		depends on ARCH_BCM_63XX
> +		depends on ARCH_BCMBCA
>   
>   	config DEBUG_BERLIN_UART
>   		bool "Marvell Berlin SoC Debug UART"

There is no such config symbol (ARCH_BCMBCA) in Linus's tree.

This patchset is going to break builds until code it depends on hits Linus's tree.

All those patches should be hold until that.
