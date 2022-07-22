Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E157E6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiGVSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiGVSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:40:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338271738;
        Fri, 22 Jul 2022 11:40:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u12so1838477edd.5;
        Fri, 22 Jul 2022 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=helhsS7vzLr934DMluYubBdIH1//HJd8s4Q2hIp39Ws=;
        b=Cii/4RuD+ML11adBLAM80SJiAicOlQz1ziuDdABc7jFhWp5ieytu0SazBQ7ATHRAuT
         A82hq6dRMoglC4DzTqm2IawoRiPjcDniP5RP7DbUt8qLkdjFrPK+NChY7nwVvmru8871
         X8rTWU+9u7uXJsuIIWJP+atwCUMGFXHKbbTW1Q6A2vV7HoeypG3lK5DQ/+FdvD4fpuaa
         AkpxoibYG7DavixKkGsb8esDbb2Syp9q7UuL6VsHPLw6bKEXmeUSNhhyrIxnlrmjGd3P
         BUzPo/T5u2Z1tcTrQ00Zg71CYLpN15yNbS/gppaYywMwgvRA+KQr2Mf10JIzuWdr7tHu
         +7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=helhsS7vzLr934DMluYubBdIH1//HJd8s4Q2hIp39Ws=;
        b=uJq3GUz9J2oE3KqTjSr6L0WrqaKyif/WlHXOMhNVTmScAedh1GVwqdkmLv06LfEio2
         1dlB8oB/61FHhFe4NX+gPFxgXr+5/c8zquh7vC7mo8aoQDJkn+3T9SxiNJJuvcMohYUN
         o6MS1ceCtT9D7Tbyvk5C5b5f12iRP4qsXTzQ6DgNnas+v9C2cM6gMSfABF77kF6W1dyr
         H2gukGwunJN5pGQwVLS5zZP4i0iuUcdrUzzxwroA7tBNGLu2kL+ZpHuVJtlDtcH+5XKi
         WdYJSbxCYz2REQ5q5iZ/ueUwqx93ts2v9ZIxFNgKZEW6W3UexCkhWULLB1K+EPapgefa
         yqGQ==
X-Gm-Message-State: AJIora9LD7OEskAuWiDxRn8TZ4+i+3ANr78qn8UvWr3VbUfKXqPDgnS4
        SdcRpFfEcLrUYIpuqFdYPM28oTXk7RLSLCoytOBOiAvUN0MObQ==
X-Google-Smtp-Source: AGRyM1ucrgApBQi/wc2u4UJ6XTLd7k2s/bLLRs+88OZwKPkljx4sUSPpxdmOtENtlQdYRDbX7LqjHP4e8+fISFYhPNo=
X-Received: by 2002:a05:6402:5412:b0:435:5997:ccb5 with SMTP id
 ev18-20020a056402541200b004355997ccb5mr1123796edb.167.1658515233780; Fri, 22
 Jul 2022 11:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220720011002.5221-1-faenkhauser@gmail.com> <20220722020100.11221-1-faenkhauser@gmail.com>
In-Reply-To: <20220722020100.11221-1-faenkhauser@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 Jul 2022 11:40:22 -0700
Message-ID: <CABBYNZJVVgS-Ah918LOM0GHxurTpro1V5tU91qztNjRUJJZnmQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921
To:     Fae <faenkhauser@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fae,

On Thu, Jul 21, 2022 at 7:01 PM Fae <faenkhauser@gmail.com> wrote:
>
> Found on HP's website ( https://support.hp.com/us-en/drivers/selfservice/swdetails/hp-envy-x360-15.6-inch-2-in-1-laptop-pc-15-ey0000/2101086013/swItemId/ob-288116-1 )
> Tested on my laptop (an ey0xxx)

Lets have the contents of /sys/kernel/debug/usb/devices like I pointed
out on the last version, also the link is not really useful in fact it
is probably a bad idea to use links since over a long time they tend
to be updated/removed.

> Signed-off-by: Fae <faenkhauser@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e25fcd49db70..973d122c738f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -454,6 +454,9 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x0489, 0xe0c8), .driver_info = BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEECH |
>                                                      BTUSB_VALID_LE_STATES },
> +       { USB_DEVICE(0x0489, 0xe0e0), .driver_info = BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEECH |
> +                                                    BTUSB_VALID_LE_STATES },
>         { USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEECH |
>                                                      BTUSB_VALID_LE_STATES },
> --
> 2.36.1
>


-- 
Luiz Augusto von Dentz
