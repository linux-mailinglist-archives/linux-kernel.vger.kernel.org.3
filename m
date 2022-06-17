Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB454F8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382565AbiFQN6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382588AbiFQN6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:58:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5243701C;
        Fri, 17 Jun 2022 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1655474308; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTpuY0oYSZHQ44/dO0MgMZ94JAo9TbzfsR7GSf1Zc+k=;
        b=j4SU46lu6M1TGmh/+r3yaG9ulrjq6iU72dNXVyQmnl+g0c/mqGmv4DuOHs4owK3P/7Xrbg
        RKXqISsQ5QEVuf/Daz3pb4LqPbDq5cQe9Yc7SR1+qzMRtODjEhtbme+CbQNN+IUOkE5lD2
        y0f3lDGy5eatqAXbssKo/kBnt/kdL4c=
Date:   Fri, 17 Jun 2022 14:58:18 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 0/2] pinctrl: ingenic: Convert to immutable irq chip
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, maz@kernel.org,
        andy.shevchenko@gmail.com, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <65KMDR.VTVERMK75O601@crapouillou.net>
In-Reply-To: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
References: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le ven., juin 17 2022 at 13:28:53 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Two cleanup patches for pinctrl-ingenic.
>=20
> v2:
> * Add print_chip callback to avoid changing /proc/interrupts output
> * Add patch to use irqd_to_hwirq()
>=20
> Aidan MacDonald (2):
>   pinctrl: ingenic: Use irqd_to_hwirq()
>   pinctrl: ingenic: Convert to immutable irq chip
>=20
>  drivers/pinctrl/pinctrl-ingenic.c | 64=20
> +++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 24 deletions(-)

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

For the two patches.

Cheers,
-Paul


