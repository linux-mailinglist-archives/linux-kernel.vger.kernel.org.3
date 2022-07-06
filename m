Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D6568886
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiGFMne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGFMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:43:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559971002;
        Wed,  6 Jul 2022 05:43:28 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31cac89d8d6so68956517b3.2;
        Wed, 06 Jul 2022 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5y+ayoqK0xBHDulZ+6Ht1XtHZqZEVyNCk6BdzJd4xM=;
        b=cbH0Na0sFkVOZOYEflwN8I1ccVKKD/HBtf9v+GQTNFmbqelo3sg01Wn8eM6m6P6BXM
         KGeFrHA7F5GjSOdIsQwZ5xoth/YHA1SCnz25FykjOuheRjEXCnqvwWkAXD8Kob0o+egF
         Vddxt3E8TjWXNCZd+JAufe3N99vYj0kbe+5GzE0lH52J818y2OeDVbTcGa4GIzgj1A3f
         1eFgMQ/a7tG1/66qmpCRcWUjv8QEEzsh2ZNj/g7CrfCE3DwJcbA5zcKCrTxW3PjpfMcD
         41Wl4AaNtec5Js7p7n5bXvEgB0Jhg6NmXjOyAgyLmX3XP0CKyUvkt0nWpfpv/0mjoGtE
         AF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5y+ayoqK0xBHDulZ+6Ht1XtHZqZEVyNCk6BdzJd4xM=;
        b=X7J2jKGi2hoo/m/8HikYW0kYu6UIghs1FiQroJcYnCnFoh+gQo1ngNp5fzE3G1XgHw
         WvInpXMt79HN3UWTtLvCQxbug7qjr0xh/E6HPDzKl8n/oVhnm+Pg75ZUfjO7bwd887+Z
         ujWwVx8s+NXJKjI6Q9tx/RCk5AIt4z6B+lLqhaIMglHEwIkHxCKQXnyDUtYAZiCBbTbf
         CIsBYh0HjyIODhz7M2EGq5Z7q6Hrlfwat+CVoh3VlrluO9pzPoAjM9H5TqinxE2UKnAT
         X7fKTfv16cAXjCm4znlQE2gFn+u8AYQ2807jJWUb+roj73XZXnRosXuO5W6ie8pMOye+
         s9Xg==
X-Gm-Message-State: AJIora/8+JZRPWvxeKbAxormrmpuXEtvj4467DlSokdkmNK9JaXVCfgz
        QUs+JtlFdRdFG3IuxeJit86wg8P2Gbe2U8eclz4=
X-Google-Smtp-Source: AGRyM1siTfxLaf7r66f4u0TDghdCwWtcvP3v5siNoDxz16R8JT/URBs3LTW+qbg8jlqFq2bxpjqc833UMpYYtFnA+j8=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr12875568ywa.195.1657111407489; Wed, 06
 Jul 2022 05:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
 <CAHp75VdBv8BJVzBCMzWKpm0RrqX=K_QPQ4cgdshqXP3Uy+hVHQ@mail.gmail.com> <b9280ecbf78424882878ef2ff6c3da6671064ed5.camel@gmail.com>
In-Reply-To: <b9280ecbf78424882878ef2ff6c3da6671064ed5.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 14:42:51 +0200
Message-ID: <CAHp75VcEAtpVsfp2CCtJR_e_eSSFaMkODFwd-ZuHKGsNPcVWfA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Wed, Jul 6, 2022 at 12:51 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> On Mon, 2022-07-04 at 22:08 +0200, Andy Shevchenko wrote:
> > On Mon, Jul 4, 2022 at 2:41 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

...

> > > +               if (unlikely(!data->chip_info->sampling_freq_avail)) {
> >
> > Why unlikely() ? How does this improve code generation / performance?
>
> As Jonathan Cameron sugested on a previous version of the patch, even thought
> this code should be safe (as if we are checking sampling frequency is because
> the sensor is a BMP380 and has that property), it would be better to have a
> sanity check just to be sure the property is really available. I used unlikely
> macro to take into account that the property would be almost always initialized.
>
> Now that you mention, probably this code won't be called too often to make the
> "unlikely" branching hint make a meaningful performance difference
>
> > > +               if (unlikely(!data->chip_info->iir_filter_coeffs_avail)) {
> >
> > Ditto.

Is this really a performance-critical path? How did you check that
unlikely() makes sense?
More evidence, please!

...

> > Why do you need to copy'n'paste dozens of the very same comment?
> > Wouldn't it be enough to explain it somewhere at the top of the file
> > or in the respective documentation (if it exists)?

No answer?

-- 
With Best Regards,
Andy Shevchenko
