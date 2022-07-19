Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C054579653
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiGSJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiGSJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:28:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F71FCE4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:28:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l23so26046819ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/7HApH+PR8w0pEKdojac5KuzIqTwfUj9SQA/gmxyxw=;
        b=LefLhYBL4JrgNX/sxY+bupgnXlOeBrf+m4khsZIhHuM9DKD1RmZgkRKT+Okgnkfru9
         Fw0iMIFjf1EW8AZKXKxcZvUY2k2cY3eq8C7+zsI6nYDWU1UihioGbvhrn1BpVrHfqWzw
         ayRUuW2K5JqS7bBvO/xRt78vo4h03NpvhM0QP+imEtPp1KeOD8iHmfLmdlMjvGonPlAa
         mJvhTpU5eXL6azKktPK/h24xLcS7Awi+oVwP0JU57SSVz/DlQk6zobFPhsSapmJzwXMv
         snsDopgIsWajuhuU26eOqpUEd//FraZhBWoWAMxhJ1Ky2BgeqGQ0TmbCcGh6Yupj3F6u
         Kb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/7HApH+PR8w0pEKdojac5KuzIqTwfUj9SQA/gmxyxw=;
        b=xhUlXAQmI9XxZQV6zpBRfcNGn+zn5AwGlvdRGIdYlN09o/PgvelWs7bby0vYNsU+i9
         L3XK6Sx0Em+ZmPOAq8UVPYzX/kDF5nUvfeJvC8ZfCPW2JiHXc84RdVtqt5GCLm1mhrJ8
         1hGepr0V69Cy6iVg1MgqUu0hw+Ll0WwMiqpAj3O9KEvQGcq4bC7WyT5VZDT31WwJF/uH
         H3GEx+G6xnfTwtTejsLBuRhE4Qnos9Nh6LtuQxdFtrsm/x7WdOXX5zYpkCk3VToLp2rN
         cz1OTl6oHcZyU+76HhOvPnfGqlCCNpqmpCS1828VLtEimtUvarMS4c3xxt0BKUSz73/P
         zkIA==
X-Gm-Message-State: AJIora9AfgNk0zE2g+JN68w0flkBUC9uurRwbzNj3Maq8Iu16UTQmORj
        hlpoMcu58dvd4F4D+FGKDyc5p789JSZYa6qH88wQks/DQd8=
X-Google-Smtp-Source: AGRyM1uH3ecF4yDXkTHFnhirA/GVW6kvv65cnSZoUrbF7rWVUblE1QLvmtGbS+T3SGIxq2unxBX6nR90kOGotNmUuuk=
X-Received: by 2002:a17:906:98c8:b0:72b:408f:f499 with SMTP id
 zd8-20020a17090698c800b0072b408ff499mr29608720ejb.736.1658222892051; Tue, 19
 Jul 2022 02:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220715140729.136234-1-tsbogend@alpha.franken.de> <CAHp75VeCpUt1HVGnr1C3aKKgRFyo5qzW1aTiPyxSCdzFL=2EoA@mail.gmail.com>
In-Reply-To: <CAHp75VeCpUt1HVGnr1C3aKKgRFyo5qzW1aTiPyxSCdzFL=2EoA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Jul 2022 11:28:01 +0200
Message-ID: <CAMRc=Mfyz9f5hxt7Pb-9wzDqOYvrV6icuuH=KdW9oAvV-POQrg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: remove VR41XX related gpio driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 9:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 15, 2022 at 4:22 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> > for MIPS VR41xx platform, so remove exclusive drivers for this
> > platform, too.
>
> Removing code? This is always the best change ever!
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> (Also may be applied to the v3 of this patch)
>
> --
> With Best Regards,
> Andy Shevchenko

For some reason I don't have v3 in my inbox but fetched it from patchwork.

Bart
