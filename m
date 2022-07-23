Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B657ED59
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiGWJxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:53:04 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4E3AE48
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 02:53:02 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8E8512FF80C;
        Sat, 23 Jul 2022 11:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658569980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNO7RVtipUGAzOIXDmnxtQmh3zzXUroxHMpGZOVj0Wg=;
        b=w8VeWKZ0/4T97nKMUTLwsHHmRmrWkMXWh31xeAXv6ZdtpTz6JMVpT1+BfNXaSMqOpplsCz
        F8ZbfswpoWrnGHlYfpaP8GJVYRS9o4YFs8v+j0PFHakd4jzMClHfgnhJ56ipzcnrcw+2ol
        1i2yNRmFBf51UhiqMvFR/9R1HVx6uQeVdMvjap96APdZ3BfdMM6ubOFyfdJQej+zEWXfB/
        IvrVM/uowbv+Mh8AzWs5Z2RhhZXwG01y6mFh0l6pQpLXCaY9aOllgRefZWAPEO1KwD2PrR
        zHf/+oKlbPf7pnwrJIMcoFpO0gehSzgfRTiqXEd0WI/CkBx71AdKhtKgMFzBLQ==
Message-ID: <701b1a29c36633d7464d31648acb2a3b06df4c9f.camel@svanheule.net>
Subject: Re: [PATCH v1 1/2] gpio: realtek-otto: amend ctrl struct docs
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Bert Vermeulen <bert@biot.com>
Date:   Sat, 23 Jul 2022 11:52:59 +0200
In-Reply-To: <778b5c9f05c42c0963a5eca1c1c7e58b588a4bc7.1658477809.git.sander@svanheule.net>
References: <cover.1658477809.git.sander@svanheule.net>
         <778b5c9f05c42c0963a5eca1c1c7e58b588a4bc7.1658477809.git.sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2022-07-22 at 10:19 +0200, Sander Vanheule wrote:
> Commit 512c5be35223 ("gpio: realtek-otto: Support reversed port
> layouts") and commit 95fa6dbe58f2 ("gpio: realtek-otto: Support per-cpu
> interrupts") updated the realtek_gpio_ctrl struct with new fields, but
> the associated kernel-doc comment was not updated accordingly.
>=20
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---

I've just posted another patch to fix a driver issue, which conflicts with =
this
one. The fix should get merged first, we can come back to these patches lat=
er.

Best,
Sander

> =C2=A0drivers/gpio/gpio-realtek-otto.c | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek=
-
> otto.c
> index 63dcf42f7c20..a352fbfc3c28 100644
> --- a/drivers/gpio/gpio-realtek-otto.c
> +++ b/drivers/gpio/gpio-realtek-otto.c
> @@ -43,9 +43,19 @@
> =C2=A0 *
> =C2=A0 * @gc: Associated gpio_chip instance
> =C2=A0 * @base: Base address of the register block for a GPIO bank
> + * @cpumask_base: Base address of the interrupt routing registers
> + * @cpu_irq_maskable: Mask of CPUs that can be individually masked for I=
RQs
> =C2=A0 * @lock: Lock for accessing the IRQ registers and values
> =C2=A0 * @intr_mask: Mask for interrupts lines
> =C2=A0 * @intr_type: Interrupt type selection
> + * @port_offset_u8: Get offset of an 8b port value
> + * @port_offset_u16: Get offset of a 16b port value
> + *
> + * The DIR, DATA, and ISR registers consist of four u8 port values, pack=
ed
> into
> + * a single 32b register. Use @port_offset_u8 to get the correct offset
> inside
> + * that register. The IMR register consists of four u16 port values, pac=
ked
> + * into two 32b registers. Use @port_offset_u16 to get the correct offse=
t for
> + * the u16 value, starting from the first register.
> =C2=A0 *
> =C2=A0 * Because the interrupt mask register (IMR) combines the function =
of IRQ
> type
> =C2=A0 * selection and masking, two extra values are stored. @intr_mask i=
s used to

