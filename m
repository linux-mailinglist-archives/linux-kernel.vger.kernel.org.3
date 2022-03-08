Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB014D1BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbiCHPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiCHPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:38:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF554EA17
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:37:22 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C22B13F621
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646753840;
        bh=+SoAPYrI9AVK4oPXSILcL3dQXENtG2+Idjow9ASKefY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fCxYOSR1o6oSC/WNadgyZ6FmwitvL4kYwwjfPx/kbepgUA4XSv5p7/wNRAxVoTkjH
         Wopj8wZCDTTl9qVKyreaiEDaOCjx11cUSO4hViSoNdELZwdpYjrVG9NtZAyXnK7wwS
         96EQVxvBiQC+wUqFwi80Q/7YNFKgWfYf3eKPoZ7ajRU9jq2yCp6I/oBOsytUN5HU+5
         +ceLNkO3jd+xt36Y2Rtg1AMriy3/GzJG5qZsZjJKgOmzAtlRkSOcN9YEzXItCdNimF
         PsHTzR1wV1GeR5+DrQU4NsXaOzfIE6PLub2oIurqJFKE9EyEEPzLVBiGe2Cnfe5hG/
         kXVhdtuIe/jAg==
Received: by mail-ed1-f71.google.com with SMTP id co2-20020a0564020c0200b00415f9fa6ca8so7348120edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 07:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+SoAPYrI9AVK4oPXSILcL3dQXENtG2+Idjow9ASKefY=;
        b=JVIMvW80VAfhiCkOoY27gle6t2WKmRS76Gu8VR85WVHLZ0T2FBbSvL1yzTZY3aQuwW
         2smQk1pt9X1cLpXZsCmusSU8KfP3GwaxsFcLGfKkTMUCFBmpFqCxnsqRoxGRHaFPfepC
         duJ7HZ2TJg7Uoj/OMTTsMmzW3h3nqxiCuYHxVRocjbJL2Xb+p2fhWyvQO6QUyqPorKEj
         kKi4XD5zh5XpmzZg802a5svOWkWVQpwD7Z0/DIOhxCoNPNvjr8QjOdI3szT5M411SkuV
         13xJTT88eiGE8/av2t69fmEJNE2sV9ggvYLyUBMPUhARFsmhhzt+km8sjHj1AoMH9prP
         cU9g==
X-Gm-Message-State: AOAM532DhKAjzVtdQxziEbd2pGYL8PqNdWUojkHyCMys64PFBVg+DUse
        vwaZSvoItGd0PNiCb7jA6AECNtlR134NU1YDhH8jhfOcdSMeIiTccM9xLXNxQLstY13HZXJulKw
        c/A77KWfRL9irHcVlYkrABQTtzsrUp7MXyKNtBSCcuw==
X-Received: by 2002:a05:6402:278f:b0:410:d242:465e with SMTP id b15-20020a056402278f00b00410d242465emr16782991ede.292.1646753840332;
        Tue, 08 Mar 2022 07:37:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz92daKVL0yFb5mnkxZ7pVOsbSSBLZKj9sYcVlzo06U6i1kLzX6KcggaRKM9ZFJo3msmBRHBA==
X-Received: by 2002:a05:6402:278f:b0:410:d242:465e with SMTP id b15-20020a056402278f00b00410d242465emr16782971ede.292.1646753840170;
        Tue, 08 Mar 2022 07:37:20 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id cf17-20020a170906b2d100b006daa59af421sm5521472ejb.149.2022.03.08.07.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 07:37:19 -0800 (PST)
Message-ID: <b6a5a2c9-84af-5cd3-b411-6e04895f8f67@canonical.com>
Date:   Tue, 8 Mar 2022 16:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] usb: host: add xhci-exynos module
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220307101852epcas2p2639761a90e794f0b4a4a842a17ba534e@epcas2p2.samsung.com>
 <1646648256-105214-5-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646648256-105214-5-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 11:17, Daehwan Jung wrote:
> This is for reference to introduce usb offload as seeing how a user does.
> We only care DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> They are allocated on specific address(SRAM) for Co-Processor.
> Co-processor could use them directly without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h |  150 +++
>  2 files changed, 2175 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
>  create mode 100644 drivers/usb/host/xhci-exynos.h
> 

NAK. I wrote in reply to your v1 - you need an in-tree user. Not
out-of-tree.

Best regards,
Krzysztof
