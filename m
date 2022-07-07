Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39256A7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiGGQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGGQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:22:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85B2CC84
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:22:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g126so5976100pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mLbZSQ9bODcgasUNI61Zcm8EfxeBwGZWHzpdpat/CYo=;
        b=NkyKxeH4uONU1ORaVub6eKl0NxphgfX4t2qzCBXKG+/e3KVjyMRrXC6d2Dstjcxlii
         AiYYVZu3KRWX+ieFirEKh0fPt3un2dmkN/fx+lg4aFELHzwtZyj+1k/FR3glYfn1cBCc
         BXtylnGuV8Mwq1PwcAKtKyajjO4SznRp1D2cJC2Gqh1rW4XMF+S4HEvPWd32g3l6Emyn
         My+B76zsoO57XHpvj+i9KNNQYrO9eQp0ACcliuWuLNDMJ6AEK4R2iSNSQ2B9a4qtlmnc
         yOG9g1aD+F++90r7eUXIpZgRNMthWJ6k4LLSLZmft998gZ2vsQCkcoLsNpHBYt9VmtUa
         w/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mLbZSQ9bODcgasUNI61Zcm8EfxeBwGZWHzpdpat/CYo=;
        b=MXjbQGO2tsktwj5V68J+pUEvbsFrb3TkQqaFoGp6Vhyk9+0mgQ5SSfhJPwphmDXbUy
         T6TLxSX9OAs0M9/dZfZQPS2MtvlobVJB7VP9Fa/g4buLcgZ5eqR5QeLWBAzTxDals/6X
         qoYZwzooR8aGxswwiFrGaTNlg0yu8MPXeTNoKbNc6ShkLDbEFmuuEUdu/3socNIdv5zk
         /syKaLxqYr9L3lmREWLErFDDKafGRi0PhCVBwbO91uzVPMHHFKgFZYXyVdPSNZ0Hk0Tr
         iKQhMBhHXGLRy2cl+WjvmMNMzkpli8v9XIeC7q1QxpDPzXQxgrfklXhEE71z/cKr+f6G
         3b6A==
X-Gm-Message-State: AJIora/lAyY3Tpji+1pZLUbOvSoGsJorEkClhCxl0+1UZu43b0RMuhzE
        flr5MX/9naghh1sA3RGUZ/A=
X-Google-Smtp-Source: AGRyM1vZ6aKeNQ/gzwgVHfo+LB3Sbcw+VHqLkFo45VEazYX5U8BtAJi2CTyOM6smyysAha6fqhz4DA==
X-Received: by 2002:a17:902:7b88:b0:16b:d9a5:7a94 with SMTP id w8-20020a1709027b8800b0016bd9a57a94mr28033840pll.173.1657210961797;
        Thu, 07 Jul 2022 09:22:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d11-20020a170903230b00b0016a5384071bsm28308326plh.1.2022.07.07.09.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:22:41 -0700 (PDT)
Message-ID: <40dd83a8-1196-c5b7-cac1-3521bf532792@gmail.com>
Date:   Thu, 7 Jul 2022 09:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 1/8] ARM: debug: bcmbca: Replace ARCH_BCM_63XX with
 ARCH_BCMBCA
Content-Language: en-US
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-1-william.zhang@broadcom.com>
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

On 7/6/22 23:57, William Zhang wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> DEBUG_BCM63XX_UART depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

This patch belonged in your v2 series:

https://lore.kernel.org/linux-arm-kernel/20220707070037.261532-1-william.zhang@broadcom.com/

but that is fine, I will pick it up from there.
-- 
Florian
