Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2E568723
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiGFLqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiGFLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:46:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD02982C;
        Wed,  6 Jul 2022 04:45:58 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31cf1adbf92so10146167b3.4;
        Wed, 06 Jul 2022 04:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUhZU8l1cSFtEAE9w63tM/F8Nsz8lxaAJecN4EZgch8=;
        b=M8GssJ8J2ueq01HRhYiHBpQQ5huVt+L89qB7xKpQfVPkt8lyodQCKSAWiIldj1PLjr
         GARM8FFg01YfrHADVWtLHmNidrkusZe2+cm0KgSUcZla1jzX3xarHgSg4uxfmd1QzPfv
         /VVMWflu+QQbeaZGnB3ngfiIwHCevulGBiqcqJVYT/FpAqd/tNKwJRDoTr97frvFVLzF
         yue2y/oPhhXcod5riIc2Qo5DgmIkXkQl8bjZ3HVlwtSk8d2KOim2i8lEwCZzpD4s6hOP
         91rTyGz4PEN5xBk0s+NdezjlVZCai/EiCGLWd6BxUAnm+ACDgHIejZy1N5c88/4qsiXB
         VmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUhZU8l1cSFtEAE9w63tM/F8Nsz8lxaAJecN4EZgch8=;
        b=kI3fVbohDxRVtgLSqudCfNFpp+BFrzHOxBtQJVIQXwmPi+Bn+z5wLnfUKZQNGVEqMa
         m4/Y4Kib6JdQ38OrNXlb7toMmOyArX13g8m+V1vQJ9jePJ0Z7kBt7RSjNbSJFBAhaLpx
         TlMTCajkP/lB3uZ3WTPEm8TINYRQOeC3+yjEfy2KdUEDlKADdRG8AH7EYxssgsklIiyt
         sNvJrWDHJaZpHWtrvUJT5MzhzwHVnC1mVVmcZuK2xLwk+Lty5F+vF3BphHYFHhEUXKhY
         CZ2+GGVc+oWBNgNvsqo0AyKrFT2HIgTFmKGiLWomYhmXPooa2/NcgVdc1vGyOvnhU4fg
         8JBQ==
X-Gm-Message-State: AJIora84wJd+B1o6KquHBYog38OUe1Zm+Z5oSNxlIzybEi9/9kRRhSNA
        GWRvMUwaLNKidXc1mJ/ExIUHlbOJoKYo0rniZYZQ/jAufho=
X-Google-Smtp-Source: AGRyM1sL1ab9SfSd+1Z5lpB3AJYYLl4lkjzfKeTr4hpPnkGtSPWE/ENDhVmunkW6L4meti7pQ3T5x0FsqAAliD5/POE=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr20145277ywa.131.1657107956990; Wed, 06
 Jul 2022 04:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com> <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
 <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
In-Reply-To: <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 13:45:20 +0200
Message-ID: <CAHp75Vd9P3Mf75TcXeWB3QE4n_rn7QcWz6g5fDYpPiLVOMsAig@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 1:22 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:

...

> Is that really better than simply using ->to_irq()?

We have Intel PMIC drivers (that are in MFD) and they have respective
GPIO drivers, none of them is using ->to_irq() and all of them provide
IRQ functionality. Can it be taken as an example or is it something
quite different to your hardware?

-- 
With Best Regards,
Andy Shevchenko
