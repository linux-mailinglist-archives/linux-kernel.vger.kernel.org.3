Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3254B48F7FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiAOQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:47:35 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:44562 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiAOQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:47:33 -0500
Received: by mail-wm1-f52.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so11826058wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UuQGHzFQyjD5NAaAWYOOEzPz/4Y/EXTKf8414g9pUU8=;
        b=CEOzYTJqPlkVBLPCUaEPitRDJ7wWijytUwAAsu0TVRit2/EiTUPZ79ljSRfzUTwv6z
         LtCKP+sSqRlXnax3xe+7l5b/7RG4aNMONAl50/GjyiCrSsFBxI31L7Re/CGdA1znWLem
         uIrYAccLVP4GfcFx1xf6m/Tdp8PpU+CIOLLOVyDTrIahk2cCqwXL2lvbn+FMURVm7Rh1
         wLMvVlo7IUNu0aWOWT6mcjyXz/bs73+Sn6hsxwWXibVSddU/iamjvICJ4lZcCEF8Njl4
         T6DmBXN/VvSOgwBPv7kTTzwA1pi99edAeEqafdQru6wTycjGTWEpY6zI/i6ZWe20V2dj
         Crxg==
X-Gm-Message-State: AOAM530QnsqtLXNcP+TVLJwlkUEuXTBeQPqyW8kBbz8o1BdMNu05Wj5Y
        4RrsHLAll2jy1rUNAV+9aNg=
X-Google-Smtp-Source: ABdhPJxlORzZQY7iTcbV/S0MP9/NfI4WFH8cNy8RCLa9V2TwWR4rOuDc1Ai/+Z5u8aReTE36xXe+pQ==
X-Received: by 2002:a05:600c:3502:: with SMTP id h2mr6286709wmq.166.1642265252499;
        Sat, 15 Jan 2022 08:47:32 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id z15sm8685523wrm.25.2022.01.15.08.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:47:31 -0800 (PST)
Message-ID: <90f2e35d-db4c-fb43-f2ba-a634649889ed@kernel.org>
Date:   Sat, 15 Jan 2022 17:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 08/11] arm64: defconfig: build r8169 as a module
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-9-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220114141507.395271-9-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:15, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build Realtek Gigabit Ethernet driver as a module.
> 
> Network cards based on chipsets this driver supports are ubiquitous both
> in regular PCIe as well as mini-PCIe and nowadays even various M.2
> formats. It is therefore a suitable card to be used for any kind of PCIe
> and/or Gigabit Ethernet testing. As it is not designed in, just enabling
> it as a module seems most suitable.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Explain why enabling it may be a good idea as requested by Krzysztof.
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
