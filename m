Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF80259ABB8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbiHTG0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTG0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:26:19 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A807A0620;
        Fri, 19 Aug 2022 23:26:17 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id e4so4784531qvr.2;
        Fri, 19 Aug 2022 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=O5H3NCo6c2sI896OI2qUmNcKpYKB6FY4w84s2zmB7Rs=;
        b=Lb0kfgEtqSO3013nnlp+S0yRzBttPC++241BWvhKSn+GXL00V6kt21m4BMWAxRJFK/
         cDxGKgn1kNbrHgBlp7x1BBVvR0s9fsAaBbyaFVpTaBzIboUpiM9orInc/pwJhCy7J9H9
         aTsOwBuqGsxgLo+E40u6uuTEZLe/QA2DjLDg7YddAsJNccTXKX8WywSiuWwVbQpINz2G
         Pf8CzGJtgUPL5sluADNfwvg3QrPBepJ4k8uSQJCJ9ktDX1OGqQyvKbPYkGMWdpTCWKvc
         BlOR/f9Qz0rhCQO1pkBJFI8DjPrpco71I79Nc0frKtRA+FVt50kmQaNiXb6zBipdeVsg
         RTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=O5H3NCo6c2sI896OI2qUmNcKpYKB6FY4w84s2zmB7Rs=;
        b=QMXG+abDdJGtaBioGIchvUdAec3+1A9B5fSnu3ROIgWxkLUB4DJIQUmKVeMEy4Tu37
         BZ9J98I/5MOhGfD7lCqF4GfNwTOy+RPqBWTkQu6JQL8nklxfEDbnwbdm8+/oIA+cGG4j
         BM7gz9QMWpdoA3uPPL2FBSjDvV/9MLfZzAQLS/LPMnpIdPQDdEBUlupimE6rI9UnQDm9
         Bm6Bn1zqFx+w0kMRE1ufgEwjKYZhKO+hdbWZ37Ozi4m7vTDk9l4YrbL/5YtFBkRlh6Yj
         ub8xSQ7/SN3d+/2D/nMTjOjPjuVmphUcKAOdKa2z6CWFyynZSS/XFk/UzkZr5po8oJ9i
         MvaA==
X-Gm-Message-State: ACgBeo32O5X3WV6xwFD5R4eSyPiC2wFLKlaefVmzcQTnAokABGGe4cp6
        QiULS6qAWV0u+XxGe48vrA1kHsqz5/dFoCjbFKIuF1sL4WDUGQ==
X-Google-Smtp-Source: AA6agR5QgnHrLpN2Efk0XEZzPevv0FTuknu/RAE+BFD1IzTaB3gETMoBoPzR8yK4zZhIhIA+6mYmdWUvIMo0dtOZ9N4=
X-Received: by 2002:a05:6214:e69:b0:476:b991:586f with SMTP id
 jz9-20020a0562140e6900b00476b991586fmr8793340qvb.48.1660976776589; Fri, 19
 Aug 2022 23:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com> <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
In-Reply-To: <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 09:25:40 +0300
Message-ID: <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using devm_regulator_*get_enable()
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Sat, Aug 20, 2022 at 9:19 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> On 8/20/22 02:30, Andy Shevchenko wrote:
> > On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:

...

> >>          struct bmg160_data *data;
> >>          struct iio_dev *indio_dev;
> >>          int ret;
> >> +       static const char * const regulators[] = {"vdd", "vddio"};
> >
> > Please, keep this following the "longest line first" rule. Note, in
>
> This was not following the (IMO slightly silly) rule even prior my
> patch. I can for sure move my line up - but that won't give you the
> "reverse X-mas tree".

What do you mean by this? In the above case the rule does exactly give
you "reversed xmas tree order". What did I miss?

> I don't have any real objections on changing the styling though - I
> don't expect this to be merged before the dependency is in rc1 - so I
> guess I will anyways need to respin this for next cycle. I can do the
> styling then.

Fine with me.

> > this case you even can move it out of the function, so we will see
> > clearly that this is (not a hidden) global variable.
>
> Here I do disagree with you. Moving the array out of the function makes
> it _much_ less obvious it is not used outside this function. Reason for
> making is "static const" is to allow the data be placed in read-only
> area (thanks to Guenter who originally gave me this tip).

"static" in C language means two things (that's what come to my mind):
- for functions this tells that a function is not used outside of the module;
- for variables that it is a _global_ variable.

Hiding static inside functions is not a good coding practice since it
hides scope of the variable. And if you look into the kernel code, I
believe the use you are proposing is in minority.

-- 
With Best Regards,
Andy Shevchenko
