Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1A64B1A91
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbiBKAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:40:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbiBKAkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:40:52 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD165F89
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:40:51 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id bt13so20463888ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xj9VW5UsbXXn8hrxLG8NlFrJm7PqJYONQi7gA5wp6vA=;
        b=S3YRL01EFcf3k/rzt7U5WsmZrx14CvaQSXKsLCNTgwPTP7bILrBXAAnkFfsE89reFd
         r78F5jKtlOsYR9cM54WPSNN5toQH8CVxbzReHQGZJwUT1yXCYwp54htU9B+4yMYjWvEO
         MFxiOctNvyloeWvaHQrgNfBBrGPCl4Bh9hNmq8oXnhwpWuRmjqxmofEBQG7cnWmycu9N
         WT/hfjVI6v+6l4sZC/EtaXdQ4dJ+TW2YfKpSAARfO1mhi+R79XR/7FvLmgjqc8GaBc9U
         0PleGfR2FjgrEReBEjaaZQv7DNMT9hajy2jJz0DWx+WtZ3uZADEasb5VY3EZYHQyMpWU
         fCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xj9VW5UsbXXn8hrxLG8NlFrJm7PqJYONQi7gA5wp6vA=;
        b=NxSJIirbhZQqv57nhqjApG9yM3kMUkVPLNsUIrl1MUI27zEwS2jfmZZq0zNQzUBlWg
         Fn1ye7XGY2GQ97min6TNJ/AiCcgjxOi28a2Fx/CzGr/oQetuKZbZxWB1VhGHTqpOmmc3
         /B9SGUoHw2Jb2BmzgZrxlbHhKfqVAXG72F8XbbFpz7gLsWyzTSsjHMs/I9xC3Es0Imev
         9fTHukDDbDQC4F8Z+jnIDGw2PKJsWmQZsxv05oyxrPFva7b7cfI4cLuITfk6bMMg4qQM
         QuRz9ydp/XWVsKgt7zWu4RHXBW1Hh3Ngb4Gz4cHiIyok1bnaYb4E2L2kgjIs0x8VB3Zh
         iPbg==
X-Gm-Message-State: AOAM533dXUUjMkAGysGx50GqNt9b/WjL5D9JGAAQQOMNrVuNDFk1dmSe
        mmAOmLJvreip68G2UvVHkW2XLYRvLJ1LiIPbeZqqTw==
X-Google-Smtp-Source: ABdhPJwhGEqaLnyuw1ENogT4CaBrGxXVjQrO53b0rIWvEMMgI6NBphqpM4BL5gL6Piw4VgURwf/zL0v6QyzNVYi2iyI=
X-Received: by 2002:a81:9f12:: with SMTP id s18mr10328658ywn.448.1644540051033;
 Thu, 10 Feb 2022 16:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20220204153535.465827-1-horatiu.vultur@microchip.com> <20220204153535.465827-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220204153535.465827-2-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:40:40 +0100
Message-ID: <CACRpkdYPWVVhkUejiOB+4qGO2SZ17aXp0Lm4Os+nkbTadCmH=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-microchip-sgpio: Fix example
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 4:33 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> The blamed commit adds support for irq, but the reqisters for irq are
> outside of the memory size. They are at address 0x108. Therefore update
> the memory size to cover all the registers used by the device.
>
> Fixes: 01a9350bdd49fb ("dt-bindings: pinctrl: pinctrl-microchip-sgpio: Add irq support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch (1) applied to the pinctrl tree.

Yours,
Linus Walleij
