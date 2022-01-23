Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78727497233
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiAWOnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:43:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44978 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiAWOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:43:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030BF60D58
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 14:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658E6C340E2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642949023;
        bh=vmsdxzDHqkSuJGXZV8LSxVpbbiGNZxBGyhMxUEVCI0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jk5p+kLgxEWf6ziDvuctQ//gai01m1THaZGnR9j+brVovOiOqwYtnrpfMyecMYzmJ
         6E0UmQXxTwTY6yKZtKP47UPJXYdnfZCrRmD8m3pY/PYnLCbBUq+FLYYTmwQUWm3Dxs
         io/qIeylJ0Qc3YbDb9xkMhzVPxsmkP1xxqPn+ZsDv8Fdq6I5geDaB4VjeJ8NNVnspC
         Wyp83n7NpciQgkvNZRAhfq/KkibOjqVpdpvT6DMDCmWWLEF8uuLPNa0L6NIFq2UDpi
         0rRvNjxT0V0wHxqkwLu6L/RrkiisR1b3wLvPl2QU4+wSpMxjNsxLETnL131/B+zxZX
         iAdkbseCJI1CQ==
Received: by mail-yb1-f178.google.com with SMTP id k31so41441475ybj.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 06:43:43 -0800 (PST)
X-Gm-Message-State: AOAM532uPdEXd2PgIQJUmIGVS9dpPqGJR2c5ufBCEmKN02n2eIzTPpHv
        d+yfN5hDHKO4v7OSOJ9IHYUla/qvGmp7n1bZJHI=
X-Google-Smtp-Source: ABdhPJz9Dq8jOgkAAlTlY2SqF+zqXwPfLoh2CONQSHR1ybwQtDD6+2t5hHq9rmQx1QTd5hrkj5Ki30zz350RaeYHUMg=
X-Received: by 2002:a25:8c86:: with SMTP id m6mr16910738ybl.506.1642949022582;
 Sun, 23 Jan 2022 06:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20220111114724.7987-1-cai.huoqing@linux.dev>
In-Reply-To: <20220111114724.7987-1-cai.huoqing@linux.dev>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 23 Jan 2022 16:43:15 +0200
X-Gmail-Original-Message-ID: <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
Message-ID: <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
>
> The driver don't support the SRAM-to-SRAM translation of DMA,
> so remove 'DMA_SRAM_TO_SRAM'.
>
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> index ef54bad20509..25fbebdc6143 100644
> --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> @@ -36,7 +36,6 @@ enum goya_dma_direction {
>         DMA_SRAM_TO_HOST,
>         DMA_DRAM_TO_HOST,
>         DMA_DRAM_TO_DRAM,
> -       DMA_SRAM_TO_SRAM,
>         DMA_ENUM_MAX
>  };
>
> --
> 2.25.1
>

This is a general spec file in our s/w stack, and therefore a change
in it in the driver will cause our driver to be out of sync with our
user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
the driver and in the user-space stack. I don't know if there will be
any consequences but I prefer not to risk it.

In addition, I prefer to have this value present for completeness,
even if the driver doesn't refer to it.

Oded
