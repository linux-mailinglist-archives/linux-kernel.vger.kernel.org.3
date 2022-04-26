Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A219D510350
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352991AbiDZQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiDZQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:32:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867A174F7E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:29:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx5so9265638pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ltARllgG8ds3cN0GLOiwmpoS0+4tvqa60Rb1AEL4EMI=;
        b=OkoKronoPXA8siEYw5/r7mzm/o0gnVGR8R6eiX8Nkb3fF5BGIzLU49tx7SmkKSwiAn
         yKJlYtlYwNtomL3oyajbJ7M1NlhddM/Ij1SKQ2aj+0zJdRU21WRsrstSRMsNK4kzh4X1
         cTqqXBbTKqWiWw8mqDK0TF6sUUiWvqvOqSHzcOa9w7/SxXh/A1pIP2gkW/cnpltDFnTE
         HJrmmBzrKGPJipbvg3gi+KdJMEqcpw7/lrYBAP0w7nznJpBGq34es/9HceJmMIFzEFff
         JzagPWJbC6vCbJviwxgZrdQqyU9PV5V0p0C20IoxGBWJXwcox3rPrCgRNJJDwIxl2WvH
         ORvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ltARllgG8ds3cN0GLOiwmpoS0+4tvqa60Rb1AEL4EMI=;
        b=wf+m8Yywyypx7uB8dyh71pFiGN2t/Bv824jcRZwjB3sB0k4JGGoqw97zqPVaG9WRyE
         GhUSg7npxLvx5Vqc7ic+T+qkhLziTllrT8T8ZaMY3UKa8wdyKNyMRikSH155KJo+6Ce6
         PI/+kHvlknK1k+9ghcVoxRfncPCo3cXwg+CCQrLY0jnnxDPHn9wVoBdkNTtWU9tQHml5
         Km1CGBT6EqG4iNU7KbY+F6mBMSF9X+AHfvZac+UqpI+gpZpY12OHlOUOk85w5yKti5Qv
         8v9rq0N5hPckPvcK8JCwHKTV3Jhclc4IRSe1FeHz9+TQUL7fe6JWdwz02C70t0EzH2NS
         XMYw==
X-Gm-Message-State: AOAM530068scCMTNqP2sZmMNcgsAZZPEK5ERN7hxew2SsBP1nDgswvll
        z8Z32C/5ddhniN+nFzTTb8SqOM3ZxA4=
X-Google-Smtp-Source: ABdhPJzwouuzwILIKg7ZDMJpgec99+1TnOuGEoOO2o/Pf+EcVb+dPVX9qk1Q+fZntdXjbyQdocg4UA==
X-Received: by 2002:a17:90a:638e:b0:1d2:b6e3:6e9d with SMTP id f14-20020a17090a638e00b001d2b6e36e9dmr38828721pjj.74.1650990562502;
        Tue, 26 Apr 2022 09:29:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s13-20020aa78d4d000000b0050ab610d9fcsm15560737pfe.33.2022.04.26.09.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 09:29:22 -0700 (PDT)
Message-ID: <861efb61-09c5-d19c-c0ed-327169653156@gmail.com>
Date:   Tue, 26 Apr 2022 09:29:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] ARM: MAX_DMA_ADDRESS fixes
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linus.walleij@linaro.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220324175417.1014562-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220324175417.1014562-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 10:54, Florian Fainelli wrote:
> This patch series clamps the MAX_DMA_ADDRESS to 32-bit in order to fit
> within a virtual address, and also fixes the off by one which was
> suggested by Geert.
> 
> Florian Fainelli (2):
>    ARM: Fix off by one in checking DMA zone size
>    ARM: Clamp MAX_DMA_ADDRESS to 32-bit

Russell, do you have any feedback on these two patches?
-- 
Florian
