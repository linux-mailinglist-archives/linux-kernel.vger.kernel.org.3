Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7D56256C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiF3Vh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiF3Vhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:37:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330753D23;
        Thu, 30 Jun 2022 14:37:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-317741c86fdso6448747b3.2;
        Thu, 30 Jun 2022 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftr+6PXIS1akRAQTeRzXuJpV+USRlStTYdmwOd5dXsA=;
        b=kmfYoin/phWuLN7gbV2J/cCeZrKiSks9ggJStrEnbtotEw6sbU/scgp/GHBX1jtcto
         1VUVjdjGM2E+Vmc2MiE3jRyOCO4X+ybkGZGHoU6JmMZ4oAIXh65yCp84QM9/eD4INT6P
         YJtMgjd3WgtJ3lyA9042ww//l7pt0MIHyf1gSWb9FFeUS03Ll/tubYJUQUTAa9IjVxwi
         u0Q96ppGLXwhXdHKFWbIVxyL4Rr+th5ql5HYvllu3J8VXxJjZHevjIblmn3rtHO4Zbuh
         5PHDHCjeBwicPWn4PnTqvY8Cbjs79JFLd84xVvYCzK4Ru791VNt8ShG/09VL4Eg+2xcz
         qYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftr+6PXIS1akRAQTeRzXuJpV+USRlStTYdmwOd5dXsA=;
        b=Yq8gAVj18ByytRhFTutwaw6OqLLNGS1z2iJq8CeanoHTHrh4e/kqE/lVWrld2T/s/s
         LXJO0iqpYSLuNzMUqBlhPDtSW05eC5CxLyLv6J4eR9YSoK0X1K4YqVZhglf6tZgoIamz
         JTSioXtdtKzriPOq+S7u29qw5H3KmVGJ8GikyF7QKeER2R5g57EeH3uSnv9Xmem7TCvM
         536NQ6amJtUOnGOVz00JISSpC/7Du7l+R5AjzLGac3AGxaJnVzRfAyUHHUSbpeQJw6xE
         6Yz7IZHNGkShHuJ4DPHmBVZUWBpQtK7EGbon5cYaDe2Ypj5vWVf8tP+xNwa3+HbrEEDb
         G4ew==
X-Gm-Message-State: AJIora9pPrr4oSw0UnJWN0Zesl/qPKX5O5YUKXabiqj4JSg+TXbeEzqT
        uu9HdPAu+rHLruZJkUKRoDrv3e7b6Q9HfjB77eY=
X-Google-Smtp-Source: AGRyM1taj8YM/NIKaCTN/Qq+j+K1Jp1k6ich97k18/4fXh53faX4/Dz6qt7w0Cougrt4XIcxr4C+4ZjDcDTxfiSNGKo=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr12582701ywa.277.1656625072912; Thu, 30
 Jun 2022 14:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
 <20220630162716.GA2842206-robh@kernel.org> <CAHp75VdARCTnpEMyVRAWv7jVSj_+m8_xYiNTwmX6LCzpZT8Tuw@mail.gmail.com>
 <CAL_JsqJH0tngWDCdLdxbbKx2VYG4u26fFJKgq2JC9a+jif50aA@mail.gmail.com>
In-Reply-To: <CAL_JsqJH0tngWDCdLdxbbKx2VYG4u26fFJKgq2JC9a+jif50aA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 23:37:16 +0200
Message-ID: <CAHp75VeKUE3Zqqnb_Smr4ucL7_DN5a6HTxf1zY4aKD8Cb3XZAA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] of: unittest: Switch to use fwnode instead of of_node
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Thu, Jun 30, 2022 at 11:34 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Jun 30, 2022 at 1:03 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jun 30, 2022 at 6:29 PM Rob Herring <robh@kernel.org> wrote:
> > > On Wed, Jun 29, 2022 at 02:50:09PM +0300, Andy Shevchenko wrote:
> > > > GPIO library now accepts fwnode as a firmware node, so
> > > > switch the module to use it.

...

> > > > -     devptr->chip.of_node = pdev->dev.of_node;
> > > > +     devptr->chip.fwnode = dev_fwnode(&pdev->dev);
> > >
> > > Perhaps I want the DT test code to test using the of_node pointer. We do
> > > want that to work, right?
> >
> > Nope. We want to get rid of of_node in GPIO.
>
> I would think there's old PPC users preventing that, but if not, good job.

Recently applied by respective maintainer, so no more PPC GPIO using OF node.

> > > I'm really not a fan of fwnode'ifying things that are DT only. It's
> > > really pointless churn.
> >
> > Other way around, keeping an of_node for just 3 drivers (and counting
> > down) + one test case is pointless churn.
> >
> > But I got that commit message that is unclear about the intentions
> > behind. I will update that if you agree on the rest.
>
> If it is going away, then what choice do I have. :)

Yep, that is the idea.

I interpret this as "go ahead with a better commit message and I will Ack it"!

Thanks, Rob, for your review!

-- 
With Best Regards,
Andy Shevchenko
