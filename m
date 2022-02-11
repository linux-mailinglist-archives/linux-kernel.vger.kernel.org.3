Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020664B1A87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbiBKAiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:38:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346419AbiBKAiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:38:04 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E9F5F82
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:38:04 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id o19so20238608ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMPnzVxfJj1VtWTKMGbAXwIHqAsV1gKtRJCewjERM4o=;
        b=KMgLDpZeT1TiAZkobVZRBrLvYCitxb2nXD8+LrvXlEK6Ryd4AR1qebBV1HaGNu2AxT
         hlSL8P8FvZ8fDGvXYFhNuA6q+xJM6DsbrnHPRTnc8Fxa1Cj6ShaV6Gi8/taglJubZgM7
         BNPi9No+g/EEzxIUrxPW0FqcCer80iik4/Cp+c5eBjKXV5mXNPyW8koyDU+3DeXbvJHp
         a008QsQlAAMA5en1KfYTmX4cxwxdS2J5bI62mn0/AaKM3LcZLH7yXn2ZiE7QZB3/ej/I
         d8CTEii3KS5ft417PgFehcsnZewlKzq2fJNM7G8bdGUn+spm7ehuNcro3VW+zOW25yNn
         28lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMPnzVxfJj1VtWTKMGbAXwIHqAsV1gKtRJCewjERM4o=;
        b=c/iHwahgx1G/VPbyDzna8fhjTECXhYnjW6GPi8Zj/iuYUOH31W29pb8hUJt6j4Onhu
         tQtIWtkuN7BcvKjgXvddgQy8hcZv06KApJXNzIvg1PdXfRp9XuXWRTuuWhd8F5OETJzv
         5sdqTgrJF5muKTxC7jRNJV+1AaAGcARyCRLMdlBlbFysCllrG192BR9Q3iPhijoFOxF2
         okwNM8imvxC02l9TzHkefFMMZe2CGW9km7crSz5VKmGPwTGyd26OHOgoORsFLll4u0ky
         hcZV60C6XYzuxSFZcRuJFgGanQ0HekvvsKd4yObrUTCsb4y1SJlECbUlWZApFb/Bef5x
         sT5A==
X-Gm-Message-State: AOAM531wlHpDx62l9CMirZckK8zNtlCb/JWEqStPfqeVHBFCfEsjlkxG
        KkFHxATHajA8S+ELE9jhYR7qju+dp4ptvLs5bq+7Yg==
X-Google-Smtp-Source: ABdhPJxtLNtj+oHf1hWTBuWFp8z77OAm27bFXeZexh7vNq4cq9fNWD41AmYJQ48zxflbuwNpWT6w5W9TceuKoey2hhw=
X-Received: by 2002:a81:b624:: with SMTP id u36mr10535176ywh.437.1644539883886;
 Thu, 10 Feb 2022 16:38:03 -0800 (PST)
MIME-Version: 1.0
References: <1643376903-18623-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1643376903-18623-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:37:52 +0100
Message-ID: <CACRpkdbEBF0Q028GrRuKA2jB2R+Qx4m8eR_vScQqcAtcsDuPMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: uniphier: Add some more pinmux settings
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:35 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> This series includes changes to audio I/O pinmux settings and addition
> to USB device pinmux settings.
>
> - Divide audio I/O pinmux groups so that 1/2/4ch can be specified.
>   The audio I/O function is available for LD11, LD20, PXs2 and PXs3 SoCs.
>   In addition, add the missing pinmux settings for PXs2.
>
> - Add USB device pinmux settings. The USB device function is available
>   for PXs2 and PXs3 SoCs.

This v2 patch set applied!

Yours,
Linus Walleij
