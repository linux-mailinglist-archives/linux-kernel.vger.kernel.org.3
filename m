Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CDF4C84FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiCAH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiCAH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:26:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A07B558
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r8so169091wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lgShEMbe7vRdrN6QBiEdN6/EREpU6sk6kDTuE/CbUr8=;
        b=6tCeTF8VnbDBKafChKUsHY1xHg3YBEdEWOhdMctYjjI4TLxZnqROGWyTQbcOk+GTHS
         05w/0hIuQfeh6ujJOyRC/82r/0+1CEi+/zjdijQCJIq13i/jHWzhcodRkdyKZiF1a8Kt
         FIEQ5i70fzLupBu2lzyp9oOeM9v30LofaIq+M4TgGjjaj7jcIiBz/jZ4SsfbGgFQ9Ypk
         9Y9VgLNWUOe30bOqyEyb71K3YREYy5i1KiCqYnbOrdSNaqMIU3GW7UjnDGWqdNa46R7i
         PDMl0orncBt6FGGVGqX0Ma0lw1vo6U1Bhqm1vclKj3kgVf6Tvu6yKaT4aJ/dD+PDE/jR
         p/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lgShEMbe7vRdrN6QBiEdN6/EREpU6sk6kDTuE/CbUr8=;
        b=7vOrp4KBAazr5gjxRyOfuaCZjE19ev2Ux0G61LvYo0taFmi2I3Uw+21CJFj3FwDUYA
         /qPcIcGTe7zYQtfnOrpzZ6h9P3IO8X85ot6Lavg9T0AWedTxOmmBuGEw5pnIceh+ZQFP
         mCMagl7WZOEK0gXxIHhYSlbPVRKeMUlnJ4+mJ8ajiNgd8y1i7S9rQYz9TypSI221pKb9
         XiiZJgkIkHLTIjw8WNbI/X4E4+RWw5TcoJdPwY1JkcuGJzRD96+VeJHD7GCCbH+Bwg2w
         7SCRBWYFhKweDsHjT2uGEkkBNZX8ZdO9Il/wL96bkvMMvfh9lxW8KkBxmQzSIIwx/D/O
         f/IA==
X-Gm-Message-State: AOAM5339ew1Kr5ywsxxXkDSdmJAGiepYhGZd828LndVL29E/juCU/FZm
        5tMhE08nKBN7Y6AkXmZ2oUQTRQ==
X-Google-Smtp-Source: ABdhPJyNbAr8Cf69lwIdgo4F56uDduS8cdEXP5PZvZfdLySabeTKIbqqWZ+VviQg2Dl9lc2TQrfkDA==
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr15650054wmp.124.1646119543122;
        Mon, 28 Feb 2022 23:25:43 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:f9e4:b6da:2b53:5858? ([2001:861:44c0:66c0:f9e4:b6da:2b53:5858])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b0037c2c6d2a91sm1793781wms.2.2022.02.28.23.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:25:42 -0800 (PST)
Message-ID: <849a95fd-ae81-9a3b-0c06-dd7826af9eb2@baylibre.com>
Date:   Tue, 1 Mar 2022 08:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Content-Language: fr
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <20220225073922.3947-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 25/02/2022 à 08:39, Yu Tu a écrit :
> Using the common Clock code to describe the UART baud rate
> clock makes it easier for the UART driver to be compatible
> with the baud rate requirements of the UART IP on different
> meson chips. Add Meson S4 SoC compatible.
> 
> The test method:
> Start the console and run the following commands in turn:
> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
> 
> Since most SoCs are too old, I was able to find all the platforms myself
> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
> G12A and S4.
> 
> Yu Tu (6):
>    tty: serial: meson: Move request the register region to probe
>    tty: serial: meson: Use devm_ioremap_resource to get register mapped
>      memory
>    tty: serial: meson: Describes the calculation of the UART baud rate
>      clock using a clock frame
>    tty: serial: meson: Make some bit of the REG5 register writable
>    tty: serial: meson: The system stuck when you run the stty command on
>      the console to change the baud rate
>    tty: serial: meson: Added S4 SOC compatibility
> 
> V6 -> V7: To solve the system stuck when you run the stty command on
> the console to change the baud rate.
> V5 -> V6: Change error format as discussed in the email.
> V4 -> V5: Change error format.
> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
> in the email.
> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
> the DTS before it can be deleted
> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
> discussed in the email
> 
> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/
> 
>   drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>   1 file changed, 154 insertions(+), 67 deletions(-)
> 
> 
> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8

Could you send the emails To Kevin, Jerome, Martin & me, and put the various lists in CC instead ? otherwise we are not notified when the patch is accepted by the tty maintainer.

Thanks,
Neil

