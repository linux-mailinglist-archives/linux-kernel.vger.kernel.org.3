Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FC5AE91F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiIFNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiIFNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:09:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411D8167C5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:09:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r4so15063353edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=88S83VgtdPyH77FG9hMS+SUCEVS9Ip7NvKSaBXxAsxM=;
        b=mAyIh9BL6U13TF8OsThv9eGZVdT6lvAT5c+VkmlaX2Blb9QVFDnzwRqY3DlVOjnVyp
         bF33+Zy3zElL8dojbFmG5JVyijBo+Em15s8Hjp11XZGOsBa4L1JKNshzsdSXlgY5Up3a
         Nz1bq8y6+yl5SuqRWlAnNFwUljDjPrGqMqxqjplClzH1JQZB17kI14cEE0/HY8Ef+Wxz
         KiPmBw815Dl4lsAJxOsiwXYaTYhfnJLsOAo8dSd95m4YSd65uVgNnkTAwSfLYDEGL+Vb
         8lgEK+0gOlk05N5Kv2A96lZMo7AHB8Raxp9OmR4nv8ddpe44e5IcRMYMpyhdq5BLpXXI
         ODuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=88S83VgtdPyH77FG9hMS+SUCEVS9Ip7NvKSaBXxAsxM=;
        b=MKm7x9VljBSRfWI+QUWk2kHQHYuIBDTZU/coVlA4UGbEtnCPvFxkCuC+cvJ34WU+kT
         LT7Z3E1OW94XdkNBbvY3I7UILbgm5QrmnE+nR7D6pWYoE1xwpCTxdLyZ09WYRm8uJ51I
         0TLHJY+uFlpLFq8NU2m6IT1Nx3c8doSubNbTcCvAB/Zcv3h7tGaKabV1BmJWdqwUzFTc
         4+GsKl4vZHEbLLt8wkiT5o0FIovs046hHWcrgfG5ClMzewSIsFHw39WxQz29ko7D/RO7
         q0txrvs3tFFnB/iDN7EG9LppzHzzTcH5gYWiwcOohzuWAKe9dkjswN1cES1qb07w6PlV
         /CJA==
X-Gm-Message-State: ACgBeo0eKEsXEw9TZWhk/oPerdQVu03+OJqWAW8BvXemWLYVLAULFT4U
        iclUzO4qOxuYl2neREALybqhzbyoJ+P1ZRPaBi+Rnw==
X-Google-Smtp-Source: AA6agR4jq9Z8dAf/3EQ95TiI0FXT5EC2lhCOyeBmcWkquxjlowspq2Bm8Wgn4darPlB5Du0MQ8kJI+uN9l2iRtOKLqE=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr11675722edr.32.1662469783678; Tue, 06
 Sep 2022 06:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220815120834.1562544-1-lewis.hanly@microchip.com>
 <20220815120834.1562544-2-lewis.hanly@microchip.com> <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
 <31d2bd0514652685cb87a7c9d17529b9064de2bf.camel@microchip.com>
 <CACRpkdZqvEvqjzTN3oQqrV_CNK+D2+c4FjLiC1_ZoKQ-rMMe5A@mail.gmail.com> <23d74882a69b39025005495886faec3e5b129ba7.camel@microchip.com>
In-Reply-To: <23d74882a69b39025005495886faec3e5b129ba7.camel@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Sep 2022 15:09:32 +0200
Message-ID: <CACRpkdYiLqiK9bzYoOX-fz3cCdojDjQj-amsQYQRcF2HVUWzqg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
To:     Lewis.Hanly@microchip.com
Cc:     linux-riscv@lists.infradead.org, Conor.Dooley@microchip.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com, maz@kernel.org,
        Daire.McNamara@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 12:45 PM <Lewis.Hanly@microchip.com> wrote:
> On Wed, 2022-08-31 at 15:19 +0200, Linus Walleij wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >
> > On Tue, Aug 30, 2022 at 6:51 AM <Lewis.Hanly@microchip.com> wrote:
> >
> > > We had looked at the bpgpio_init, our controller is not fully
> > > memory
> > > mapped to support the bgpio_init() and get all routines for free.
> > > While we have in/out and intr (interrupt state) 32-bit registers,
> > > we
> > > would not get as much free as other generic memory mapped
> > > controllers.
> >
> > You're not really saying what the problem is?
> >
> > Is it that some registers are not one-bit-indexed from 0 per GPIO?
> Yes some of the registers are not one-bit-indexed per GPIO and for this
> reason we had not implemented bgpio_init().

OK that's a valid reason not to use that. Thanks!
The regmap may help though, have a look!

Yours,
Linus Walleij
