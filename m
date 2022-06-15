Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1E54C8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348060AbiFOMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348482AbiFOMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:44:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E93D492;
        Wed, 15 Jun 2022 05:44:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn20so3544405edb.6;
        Wed, 15 Jun 2022 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+RSNrE+veMSA+ePZlMwQAwMEyJDpDolrSZr72aOZFM=;
        b=Zxhv82eURtXpHqgEW/OY2RIytXiBNvDtS22ktrAupK1xZ6PTsoxfSVboBB77Adz/Ym
         svpO9WiPKmjvCg6E0DuLA/ICoIiBfnbeVbmax3EKTZTZ6E/vq7nJJUlQzKdAzH1ao63H
         87ZR8hKBK2Zjk+/qMl7MgeuGSMb4ko8iBPqhYXzg1538cWUx0Vk+WgZmJLY/SqZ/vwco
         /1d4ehisCAkgU57Qe1lPE1PgO3qMf6rPBl8p0AXvnOtQo6qd+6liYbFPEqstXXRjtrDk
         w4OvkjMeuffrzeIdDBVLaJKfsqm+zYzJgW+OFz1hLvpxM+Gbv+ZlWQUBoYcSrABFuSHK
         4STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+RSNrE+veMSA+ePZlMwQAwMEyJDpDolrSZr72aOZFM=;
        b=TKfDYUOZHOOVbc9zrUk7nwTgYG4+OSDuWQ0IYkjR9M43OsXXN/CRIPASn8MddN5xMz
         +vZSxbOeTyd/VL4tYd476srSmO4A1Qj+WrH+VUbZc73qnR3YiBNc2HRSHKNd6sHa1SeQ
         LBlUQyl0Cukya2VxRybwhebvA/Eq+qGC1cqeffGDqUZqNOclyzkxqQazLYqi6vRLWYXV
         cKKlKa/I08MIykEv+H852NIiYeOM/hHDXTrmfzqISyVl7CgyQp7tlsrAjK6H13SJv0m2
         S2UdPBSAw/IZnWLjJZsO0C749CyQVTNhqprMMEblvtb9HLt7P5miF+rPrQsWMEw3QMrD
         HsCw==
X-Gm-Message-State: AOAM531PBE1sVwNWuD95PMY4CG1VLJzIJk3qSNE66tMUvn/5Mh1l1kBW
        WWyIXprN792xEXxOJQZ3OGBIxmiQ7CbgI87ij6I8ABy6rCgjwQ==
X-Google-Smtp-Source: ABdhPJySOjKcWJFtK1r5qjaUa502RBxjj3CYN6y284bAlAp/TNyj9TCsqjTJjPXP8eqiWFEzZx/0jaRHcjt3rERGq/E=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr12497438edr.209.1655297044080; Wed, 15
 Jun 2022 05:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654118389.git.william.gray@linaro.org> <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
 <YqnIygHDSUbV5yws@fedora> <CAHp75Vcojz1d8uGcR5CMeSFcBDCxqzDbncU2Mp-LT4iDqw_+Pw@mail.gmail.com>
 <YqnOUlE1nEnCC44B@fedora>
In-Reply-To: <YqnOUlE1nEnCC44B@fedora>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 14:43:27 +0200
Message-ID: <CAHp75Vd91GMGUJurGKi2Ve_GM13uLpQFaeYG8Q48yFA6Aq2_ow@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register structures
To:     William Breathitt Gray <william.gray@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Wed, Jun 15, 2022 at 2:19 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
> On Wed, Jun 15, 2022 at 02:00:26PM +0200, Andy Shevchenko wrote:
> > On Wed, Jun 15, 2022 at 1:55 PM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> > > On Wed, Jun 15, 2022 at 11:44:54AM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jun 6, 2022 at 4:27 PM William Breathitt Gray
> > > > <william.gray@linaro.org> wrote:
> > > > >
> > > > > Reduce magic numbers and improve code readability by implementing and
> > > > > utilizing named register data structures.
> > > >
> > > > Can we consider using regmap APIs instead?
> >
> > > The regmap API may be more appropriate here. I'll investigate and see if
> > > I can convert this over to it.
> >
> > I just realized that this driver is for the old PC104 (like?) hardware
> > that most likely uses IO ports, I don't remember if we have support
> > for IO ports in regmap (MMIO -- yes for sure).

> Hmm, I don't see IO ports mentioned in include/linux/regmap.h, so I
> don't think the regmap API directly supports it (maybe someone familiar
> with regmap knows). Although we do get a virtual mapping cookie via
> ioport_map() in this driver, I don't know if we can pass that to the
> regmap functions and have it actually work.

The problem is with accessors which are inconsistent in regmap MMIO
implementation. I think it should be converted to use
ioreadXX()/iowriteXX() in all cases (currently only BE cases use
them). Another variant is to provide read*_be() / write*_be() for all
architectures, replace corresponding ops in regmap MMIO and introduce
regmap IO with inX()/outX. The former seems to me the best option,
while the latter is cleaner.

+Cc: Mark if he knows more about this.

-- 
With Best Regards,
Andy Shevchenko
