Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235CF4D608A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbiCKL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiCKL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:27:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB9972FD;
        Fri, 11 Mar 2022 03:26:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r29so1341267edc.0;
        Fri, 11 Mar 2022 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN1cmhl+ncZxKyDen+V5dcOQg02w9seP44292qGiJ7c=;
        b=ZGDxim386zG0ppsGHci14yix59pJvvBC/xsFLpSNgtn6mc19bQ81MjKboXM35vOjGX
         QacjvMF/l9xOmMxRmwtYHe+1w7A016RFW02b6TZeFjRuAG4XLLKJmnRdFs6FKqWFUcQr
         5n+n9MKXaJClCXhghMH/eEwdmuSWXtOFKNM75XUvcOcem94+Vqlh4jsxoqMDYv+OEyC9
         EVPnoZRkCWLvZAHBAs6znb2vmZV7SjN9ZqdMKf/7ouno7YylLGxG3fyr71S+huhDZ+Ui
         EqrkMriagLB60j142DixDKMx3Gxbe/VhCfWmWtxfYKlI2zx0tJMNNQXM4fbtyy5omilj
         iSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN1cmhl+ncZxKyDen+V5dcOQg02w9seP44292qGiJ7c=;
        b=HZb8NdDNy5lfLEFz9R0+SZeCY7Gql2GgeWZIc8ae9FA6+aLAA74NPHRCxsx7izFb4P
         ooW2lp7H7QqukmrnEdZFNxsbSkkivXtOm/rg03oS88tsI42LbStn2ZWHkO1iTkE4Tqbs
         MgMSCSUdePvFp1d8y3RGTkmRXWAMOmpiyg/7kaOGbVyRgFhyPKQ+ryA+hyylNa7Q1Qcq
         jAkidU+JGWPQBNVScnyqkvQhT9Bf0uw5jR3Y0H5e4ITvmYbN+RcgPWCaRNTF929E82Oh
         NuesVkb0Sxlm2q39/UySbTUmRV8vfBGlRXP8PBOrNXvBEClUDY9xYXLFQ5/fkjN/B9QB
         NrRQ==
X-Gm-Message-State: AOAM531i4kzH5KmXlxGtXPTrr1bCptV/Upe1J3R5/3q1OS3Qmn7AboLk
        2Unnn6zKesaWpbLhhgqQ42Tj6Qj+YaRkkZg1mTum5HXIvdxG3A==
X-Google-Smtp-Source: ABdhPJwH0kXpCp7EhOQgFULMF7ZsjfMq1lJL5n8aUWMbPhdxiZIHPO/BXR8rfRUJuZnULu6TK6wMnREmkpYOHeFRHyc=
X-Received: by 2002:a50:da89:0:b0:413:adb1:cf83 with SMTP id
 q9-20020a50da89000000b00413adb1cf83mr8304823edj.158.1646997978379; Fri, 11
 Mar 2022 03:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20220310011617.29660-1-kris@embeddedTS.com> <20220310011617.29660-2-kris@embeddedTS.com>
 <CAHp75Vdu1r0S2ZCjH2mjToYZiwQTOiUAvY5v-T7f=u28tVuxcQ@mail.gmail.com>
 <1646933773.2804.1.camel@embeddedTS.com> <CAMRc=MerqLPZSCd8+YSAwJPe1_zpOYQK5C-DXirC6dvR4Yss5g@mail.gmail.com>
 <1646941640.2804.4.camel@embeddedTS.com>
In-Reply-To: <1646941640.2804.4.camel@embeddedTS.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Mar 2022 13:25:42 +0200
Message-ID: <CAHp75VcQz+h45+7_j=QkNfo7L=q1EKRskDCULNwZYjcgwxz5ug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: ts4900: Do not set DAT and OE together
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
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

On Thu, Mar 10, 2022 at 9:47 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> On Thu, 2022-03-10 at 20:30 +0100, Bartosz Golaszewski wrote:
> > On Thu, Mar 10, 2022 at 6:36 PM Kris Bahnsen <kris@embeddedts.com> wrote:

...

> > Hey Kris,
> >
> > I already sent it out to Linus, please create a follow-up patch for that.

> Can you please clarify what that entails since Andy had requested changes to the
> commit message. Should I just create a new patch on top of the commit already on
> master to address the comment changes?

Address the comments.

> How would I address commit message changes,
> or is that not my responsibility at this point?

It's impossible.

-- 
With Best Regards,
Andy Shevchenko
