Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F814A576E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiBAHB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiBAHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:01:55 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF19C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:01:54 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h8so7616695qtk.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofUNs4jZW+VJID8NdJTfJEAl1tXnq8A5FUYSEBgME9I=;
        b=eH3LIHHNXyCf9RgmKlCVQNG1NZjleLL6UXaZM2DzFFaIcOXUZmwDm73n6ljHAV2mBN
         1rEqBBpUdZtVpujfifb5v0L+7HoayDiguh5nRlAlvs9e4SkmENBsLeiq+E0LHfaAHtvT
         cLRCPOoC5oHL87jpqlMxqVK+RPOdCDuqGFA5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofUNs4jZW+VJID8NdJTfJEAl1tXnq8A5FUYSEBgME9I=;
        b=Q1fw4XrXAkS0RtlBXL5A8f+fr15wf/LW05Usn61xBHFzZMSJw9iqctNm52pPlxENkT
         2BwjxRNzqM2KhvyTNMREyVLD/l5RT6aMFp3svIeez9e9N2Pze3k+Un/x+0ATN0SnFnWn
         oWQ1xz1Omh+jdFV9SGCwtutkShcl1JjNKgX48JAvE5WUHUTF/YaxdNIZ4ULqyBdCHlGN
         J9+ZbjPFjklfZk+dCE8HKgCUp/Fn9UXa8kH5lmUlERHMxOPh3r/qmBCFndZnDZVnLW/E
         H7YjBdJ1vn6K6AeNHjV25ZBuz0cHV4XRhGTWL4yyM+7TB3hM1bISyA5erBngj3HAC8cq
         LRfg==
X-Gm-Message-State: AOAM533BHma+TlWlHh3aeXgIap2nSgheQBdTY3IEtvYW6fAhbjXaI+sw
        RtLqz7b3JLaYBv4pUjvsdnfGpHk960QcV9+uV3w=
X-Google-Smtp-Source: ABdhPJzex+T5jB7qh9KAiV5zVNlmmATGRAqu8eaMn8IYJzIjb+7Kt6wQrTHUZuYMeznBLseY5I8oIHuiuQNef/XZOa0=
X-Received: by 2002:ac8:5a93:: with SMTP id c19mr18181843qtc.58.1643698913805;
 Mon, 31 Jan 2022 23:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20220124014351.9121-1-chiawei_wang@aspeedtech.com>
In-Reply-To: <20220124014351.9121-1-chiawei_wang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 1 Feb 2022 07:01:42 +0000
Message-ID: <CACPK8XfzBT3YiMYqH5cKX5jWSSYx45vNzubdUpXOTnE1xy2TXQ@mail.gmail.com>
Subject: Re: [PATCH next] docs/ABI: testing: aspeed-uart-routing: Escape asterisk
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 01:44, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Escape asterisk symbols to fix the following warning:
>
> "WARNING: Inline emphasis start-string without end-string"
>
> Fixes: c6807970c3bc ("soc: aspeed: Add UART routing support")
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>

Thanks Chai-Wei, I've sent this to the soc maintainers to apply as a fix.

> ---
>  Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> index b363827da437..910df0e5815a 100644
> --- a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> +++ b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> @@ -1,4 +1,4 @@
> -What:          /sys/bus/platform/drivers/aspeed-uart-routing/*/uart*
> +What:          /sys/bus/platform/drivers/aspeed-uart-routing/\*/uart\*
>  Date:          September 2021
>  Contact:       Oskar Senft <osk@google.com>
>                 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> @@ -9,7 +9,7 @@ Description:    Selects the RX source of the UARTx device.
>                 depends on the selected file.
>
>                 e.g.
> -               cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> +               cat /sys/bus/platform/drivers/aspeed-uart-routing/\*.uart_routing/uart1
>                 [io1] io2 io3 io4 uart2 uart3 uart4 io6
>
>                 In this case, UART1 gets its input from IO1 (physical serial port 1).
> @@ -17,7 +17,7 @@ Description:  Selects the RX source of the UARTx device.
>  Users:         OpenBMC.  Proposed changes should be mailed to
>                 openbmc@lists.ozlabs.org
>
> -What:          /sys/bus/platform/drivers/aspeed-uart-routing/*/io*
> +What:          /sys/bus/platform/drivers/aspeed-uart-routing/\*/io\*
>  Date:          September 2021
>  Contact:       Oskar Senft <osk@google.com>
>                 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> --
> 2.25.1
>
