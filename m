Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCBF581A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiGZS6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiGZS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:58:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B9A326CA;
        Tue, 26 Jul 2022 11:58:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id oy13so27807404ejb.1;
        Tue, 26 Jul 2022 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpCxpmlQCyedzlNasXRk3F6fZpn0WKk2SVo9s1oYm6s=;
        b=Xu7vR+/HKrmKn7M7OhSBw+AcEeonFYetINX54aNyXSoWWONG5LtW2kGte7JsRv89i2
         0AIMTVY6zDCiNd/KZGPdKQnirToJKaKalj1us/Mf5qg6SGp+aECDX/QPlKvwqF/eYoK9
         6s6puNea3dFjUCR4FCoqnqXO3rOv+Q/WFPAiynaO9Re4HsuDU6Wt9MekXaQt/nOySSig
         4q2cnz3G0tDEHOXSFzH1QUB/dV5G7KiVgcxOabAn7zWKnQBZoXFec5JhCzDd4x0RB/bc
         +XcLRI1gqXoIULYZ3jCXuRNN/aCVTjBRmVL2K8wxJbYFSA1OZepMNsmTyfXnVMQgLZES
         EUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpCxpmlQCyedzlNasXRk3F6fZpn0WKk2SVo9s1oYm6s=;
        b=pIag0VBFeB5NzB7EGO2d+cs3dOWOHXlT7/SfB36cQ3uZHZZ+Xwe4FiUlY+jH0dCEZD
         qNnxIq8sk6Mn85sdJlrB0A+NGuprtkRdna7tz57YH0uo6fIXcZkzunY7OqRaB1gsuMGS
         orRYHZBU6na6fxdjNRZBASxXtFE/45a8J+kRSHjaSH+QkvIuXnK3l7Gi4x3PpSy2AduN
         EwEuoc98WTWSAt1Og5CMvyqQl/SpHT15ZUsL+Q2QQi5QFOfVhT1+zkBWcHYYtzHlfHDk
         Zq9mWzBz6HqxPpli/UtHNkG33thnkS9eCmL6mV7lk0UAze6Wt5oiWzRaB8twEMiU5aS0
         Pxow==
X-Gm-Message-State: AJIora8ntFs2jI2xmLmWOTPnUHI293PsSylJHhetuRWJ0Pof5XlVYw7c
        Odej/lo6938x3JCFdvm0/rHkcSA4k7jCMw/6Fh8=
X-Google-Smtp-Source: AGRyM1sU42+OzTG9svgkqIEbnaGqkvaxb2LXaphAFSmXNb23CBIvyWek8GCjWmfTm+qhid3kWEd5ZKoIcpI+QeDw/0Q=
X-Received: by 2002:a17:907:7255:b0:72b:50b8:82d6 with SMTP id
 ds21-20020a170907725500b0072b50b882d6mr15682244ejc.677.1658861893692; Tue, 26
 Jul 2022 11:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220724212639.29269-1-ismael@iodev.co.uk>
In-Reply-To: <20220724212639.29269-1-ismael@iodev.co.uk>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 Jul 2022 11:58:02 -0700
Message-ID: <CABBYNZ+jim_8KZT-2-9egsCyo9JV26F2A7Ymr=T5tBRVwAd8DQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix opcode format in debug message
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
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

Hi Ismael,

On Sun, Jul 24, 2022 at 2:26 PM Ismael Luceno <ismael@iodev.co.uk> wrote:

Add some description, perhaps the debug output before and after the changes.

> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 351c2390164d..d86d819465e8 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -150,7 +150,7 @@
>         struct sk_buff *skb;
>         int err = 0;
>
> -       bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
> +       bt_dev_dbg(hdev, "Opcode 0x%04x", opcode);
>
>         hci_req_init(&req, hdev);
>
> --
> 2.36.0
>


-- 
Luiz Augusto von Dentz
