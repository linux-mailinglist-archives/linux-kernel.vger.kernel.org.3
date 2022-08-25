Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD27C5A0906
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiHYGnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiHYGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:43:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EBD90183
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:43:36 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0533042013
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661409815;
        bh=ajx+5Tx5Wo3dO3Cmd/MXWykdknYHLv5qSfjoJp1Qfdo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Y+QhG7VjVKKahx8RJXYtn2vi4UoW3C273s8nfK7fyDNp3fz2A+0j+PtYLmYMXYIoY
         DnzGindzdzcR9matXS4YwokUDGaWFmCKQoDhYWt+Ho5pniDiESYbw09Y4+ffXE8/xj
         iHWDYgTU0w6C3r/PazT6N15VgS7VOwGFOYoNho1CT+cw7VwArarnWx7fClBNiQ+qRC
         57bm1jFu3l9QQ34sJpD49yMa7RQN1LvAEw7FeveSXZhRP8RO/0u5yjpTa1zSfEf/l+
         WkM4vO2khWUX1XK6AgxmQ9drjwPmcujocD+ulBLVq8CJV69ZvVJlHrfETxszfpq6ck
         yL2ZPRhHNhrCQ==
Received: by mail-oo1-f70.google.com with SMTP id l28-20020a4a271c000000b00448931ebefeso9330100oof.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ajx+5Tx5Wo3dO3Cmd/MXWykdknYHLv5qSfjoJp1Qfdo=;
        b=2daBS4+21u32sW8Lx9IvNOxFT2F7A8qBZEYRNbR/M3ZKPD5fDdRofrco3Pd0lF0oOI
         7McdNNvUzS7/CsIwyPC/cQLNyFYUEG1DHVL0lLm1DT4aMrwsE5YMwKIAMSLLYmrC4VEX
         KRFBcqoa14yEl/57cPrZ3cCglkiwiaOFhRWD35LiFVJiQzy41sSBUfi++SThxafPPsbB
         xK9tfdi8BZAUlJ1HGyYN0z1l4dvZefEvnBmFiZpylESC6eJKgV8VBu/tqEsbWDYAj6q1
         DryE78u8ua/GyM370OsoSvVqDvPTHR6GwL4hoVL2lpESXB3EJqDczC8pZ7mMkRyvRp+a
         59aA==
X-Gm-Message-State: ACgBeo3JDQvUxDUYy+c0oXSywlZQbq08WTXq7SMuZrreyMwTd73B0f/8
        nXETofBr9Yh7yL+qcPVKCSAQdByarcQZMuIZlfBnSkCYZlSxVD2QO5WkVOTLFqSnuwTKTUqHgvh
        kUZQd/VN8n/Z3yvaVs+uaY8+VfirUMXmONNimTrGRHJxVSC3bYNrqOqCylA==
X-Received: by 2002:aca:2816:0:b0:345:5840:504d with SMTP id 22-20020aca2816000000b003455840504dmr4484140oix.176.1661409813713;
        Wed, 24 Aug 2022 23:43:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56zo51c1diclhcmrZ5kRUhz7rR50lx9EGe3FcoWuMcHm5ab3E2vYHdT5YYCDEGSDdK1kq2xe5ewo0pnhir5mM=
X-Received: by 2002:aca:2816:0:b0:345:5840:504d with SMTP id
 22-20020aca2816000000b003455840504dmr4484130oix.176.1661409813344; Wed, 24
 Aug 2022 23:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220825063852.1120632-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220825063852.1120632-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 25 Aug 2022 14:43:22 +0800
Message-ID: <CAAd53p7PmEp+vWLz+fGdDntGQ2KqgL54fo86Bpy7oy9tKzXsAg@mail.gmail.com>
Subject: Re: [PATCH] tg3: Disable tg3 device on system reboot to avoid
 triggering AER
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

On Thu, Aug 25, 2022 at 2:39 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused a
> reboot hang on one Dell servers so the commit was reverted.

Can you please re-apply commit d60cd06331a3 and give this patch a try? Thanks!

Kai-Heng

>
> Someone managed to collect the AER log and it's caused by MSI:
> [ 148.762067] ACPI: Preparing to enter system sleep state S5
> [ 148.794638] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
> [ 148.803731] {1}[Hardware Error]: event severity: recoverable
> [ 148.810191] {1}[Hardware Error]: Error 0, type: fatal
> [ 148.816088] {1}[Hardware Error]: section_type: PCIe error
> [ 148.822391] {1}[Hardware Error]: port_type: 0, PCIe end point
> [ 148.829026] {1}[Hardware Error]: version: 3.0
> [ 148.834266] {1}[Hardware Error]: command: 0x0006, status: 0x0010
> [ 148.841140] {1}[Hardware Error]: device_id: 0000:04:00.0
> [ 148.847309] {1}[Hardware Error]: slot: 0
> [ 148.852077] {1}[Hardware Error]: secondary_bus: 0x00
> [ 148.857876] {1}[Hardware Error]: vendor_id: 0x14e4, device_id: 0x165f
> [ 148.865145] {1}[Hardware Error]: class_code: 020000
> [ 148.870845] {1}[Hardware Error]: aer_uncor_status: 0x00100000, aer_uncor_mask: 0x00010000
> [ 148.879842] {1}[Hardware Error]: aer_uncor_severity: 0x000ef030
> [ 148.886575] {1}[Hardware Error]: TLP Header: 40000001 0000030f 90028090 00000000
> [ 148.894823] tg3 0000:04:00.0: AER: aer_status: 0x00100000, aer_mask: 0x00010000
> [ 148.902795] tg3 0000:04:00.0: AER: [20] UnsupReq (First)
> [ 148.910234] tg3 0000:04:00.0: AER: aer_layer=Transaction Layer, aer_agent=Requester ID
> [ 148.918806] tg3 0000:04:00.0: AER: aer_uncor_severity: 0x000ef030
> [ 148.925558] tg3 0000:04:00.0: AER: TLP Header: 40000001 0000030f 90028090 00000000
>
> The MSI is probably raised by incoming packets, so power down the device
> and disable bus mastering to stop the traffic, as user confirmed this
> approach works.
>
> In addition to that, be extra safe and cancel reset task if it's running.
>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Link: https://lore.kernel.org/all/b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com/
> BugLink: https://bugs.launchpad.net/bugs/1917471
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index db1e9d810b416..4fe9e2539eac1 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -18077,15 +18077,18 @@ static void tg3_shutdown(struct pci_dev *pdev)
>         struct tg3 *tp = netdev_priv(dev);
>
>         rtnl_lock();
> +
> +       tg3_reset_task_cancel(tp);
>         netif_device_detach(dev);
>
>         if (netif_running(dev))
>                 dev_close(dev);
>
> -       if (system_state == SYSTEM_POWER_OFF)
> -               tg3_power_down(tp);
> +       tg3_power_down(tp);
>
>         rtnl_unlock();
> +
> +       pci_disable_device(pdev);
>  }
>
>  /**
> --
> 2.36.1
>
