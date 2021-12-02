Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E9466940
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbhLBRlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348288AbhLBRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:41:20 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26565C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:37:58 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso574071otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2oG4aDKM9M42N8WfUbP45bWca4SPQKulMif8VEHB20=;
        b=O2l0vhQM/T1vn0wPo6wapZ97gEl7X2ZZclvcVGbBUEKzmDc3EJFFuZzFD2FwEWPhhS
         w4x4gFKoUChQDaXnNoOD6iPpe+lhBRav2TCUYWEBoGFihK1Bu2k3xcLbgOVAgpKAXA9i
         p7hdPP33kSYFOKhktm18wCmMidh52vL3MQUTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2oG4aDKM9M42N8WfUbP45bWca4SPQKulMif8VEHB20=;
        b=zsYJRa9Kpyk8St2GJFcUKczb3hEKMm2CEiehiv1uOhf1frS6xcL8/wDH4+PUHxi6oF
         VOKyInWLvDw2qaWmOl3WRwuKeWrzUFBYnrjusdujJ1myZPOLQnpS8RUTU0CIDaILD6HV
         Y9JFhqdVs253L5VDwHhEiVcyrNBvr8uq4GDWmZ/KO+7LmalvWdLdaoIu277xkhgYmcdP
         5ULUG+dEqbhnS5AZcECVJCUdKnvkkEdjm5z5CNPv8qHu+TMHUujvmC4f488ZhT+ztRSa
         ORxlwyXMTUW7kwe03wqdZgJrzu21rwYbfmc126tcw1pUoylb3zVq5jhYn3zUWHioHVRs
         fj9A==
X-Gm-Message-State: AOAM532FdVYZGeX5goP3sd/3dE+oI5oMkSJp88JAJ9Hf0t9KJa5VRRYo
        qj7xI85whErptVbwxH5zU5ZAX542gPa6WA==
X-Google-Smtp-Source: ABdhPJwOkLaky5is4VmyzBqLoPuSPjSF09DfOO3WBTTJbz5RgWV/V8f/qjB/H5r4FJA72qY03m21lQ==
X-Received: by 2002:a9d:373:: with SMTP id 106mr12395941otv.127.1638466676799;
        Thu, 02 Dec 2021 09:37:56 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id n26sm125973ooc.48.2021.12.02.09.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:37:55 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id t23so642796oiw.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:37:54 -0800 (PST)
X-Received: by 2002:aca:6c5:: with SMTP id 188mr5362437oig.117.1638466673920;
 Thu, 02 Dec 2021 09:37:53 -0800 (PST)
MIME-Version: 1.0
References: <1638414076-53227-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1638414076-53227-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 2 Dec 2021 09:37:42 -0800
X-Gmail-Original-Message-ID: <CA+ASDXObESfppTw1_B-sfk=orXif5=6733Cd2K5BGMdb8=WhSw@mail.gmail.com>
Message-ID: <CA+ASDXObESfppTw1_B-sfk=orXif5=6733Cd2K5BGMdb8=WhSw@mail.gmail.com>
Subject: Re: [PATCH -next] wireless: Clean up some inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, kuba@kernel.org, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 1, 2021 at 7:04 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warnings:
>
> drivers/net/wireless/marvell/mwifiex/pcie.c:3376
> mwifiex_unregister_dev() warn: inconsistent indenting
> drivers/net/wireless/marvell/mwifiex/uap_event.c:285
> mwifiex_process_uap_event() warn: inconsistent indenting
> drivers/net/wireless/marvell/mwifiex/sta_event.c:797
> mwifiex_process_sta_event() warn: inconsistent indenting

Thanks for looking at the smatch warnings! But I think you've taken
the wrong action on two of them. See below.

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c      | 2 +-
>  drivers/net/wireless/marvell/mwifiex/sta_event.c | 2 +-
>  drivers/net/wireless/marvell/mwifiex/uap_event.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
> index d5fb294..43bdcbc 100644
> --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
> @@ -3373,7 +3373,7 @@ static void mwifiex_unregister_dev(struct mwifiex_adapter *adapter)
>         } else {
>                 mwifiex_dbg(adapter, INFO,
>                             "%s(): calling free_irq()\n", __func__);
> -              free_irq(card->dev->irq, &card->share_irq_ctx);
> +               free_irq(card->dev->irq, &card->share_irq_ctx);
>
>                 if (card->msi_enable)
>                         pci_disable_msi(pdev);
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> index 80e5d44..9a3fbfb 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> @@ -794,7 +794,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
>                                          MWIFIEX_TxPD_POWER_MGMT_LAST_PACKET))
>                                                 adapter->ps_state =
>                                                         PS_STATE_SLEEP;
> -                                       return 0;
> +                               return 0;

Hmm, I have a strong suspicion that the *indentation* was actually
correct, and your stylistic warning actually signals that the braces
are incorrect. See how the assignment to 'ps_state' is clobbered just
a few lines below; I suspect the failure to send a null packet is
supposed to mean we should exit this function immediately, and all
other cases are supposed to continue.

>                         }
>                 }
>                 adapter->ps_state = PS_STATE_AWAKE;
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
> index 2e25d72..e31de7a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
> @@ -282,7 +282,7 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
>                                          MWIFIEX_TxPD_POWER_MGMT_LAST_PACKET))
>                                                 adapter->ps_state =
>                                                         PS_STATE_SLEEP;
> -                                       return 0;
> +                               return 0;

Same here.

Brian

>                         }
>                 }
>                 adapter->ps_state = PS_STATE_AWAKE;
> --
> 1.8.3.1
>
