Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD57583249
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiG0SpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiG0Soy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:44:54 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E569BA0E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:41:23 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j1-20020a4ab1c1000000b0043576bcb9b1so3328846ooo.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VXHqyZDYmIQ3rpqxptc15nYDRULliBEgKqonht7y21s=;
        b=KfA5hlXNMKatVFo7kjZB6fHQZh0bPOashrO56ytvMrdaUFnESzhb+pcJ+HV9wGgvTx
         kqumxc/h9xexjEi+9nIHmPtpScepB1PhfpoECzSoYSpAq10qe+ymLX1uW2pAK2UOvYEm
         FZrnEPUti3VwIjw5wkUf5iyeDr4pgPc56E5GeR3S363LfneRFu7x+tV5vJgSZ3f0FZhR
         1eYYuIZpj2AwNqV/pDnzFK6pMtXYr21A/4/f90mzGYGzCJYF1OQa3omqkt0qlMyYJM78
         hRmi6DMT/mfbpm1/hTgSJOIk9Y2FJAfWN9RFUR3WNyxsBd4pDQLjqW7OXqcT2DRmNIN/
         9h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXHqyZDYmIQ3rpqxptc15nYDRULliBEgKqonht7y21s=;
        b=2haRk5Yd50tNot2eCt+9q/7J35cji1sOG/rSSgiKs6pRmQoS2qyMaMARtQ6iuRNrX7
         UrQZADsF926ToSo1osko9fNCqHK0EBG5n0aLcArRoL7zydttcGtnYLgMl9cvBPg4iBAU
         63EIt2rH+mFXsBntQ/EajT/S5iC1y8wJdMxz1Y03/BK/5396hOMu1xI7leksO05wZ5GN
         zBYQTZkzO1ce4VHbi+b/4JcwF0E4H1BXtXrCWar5L0Ha0tZIh8X33WJLUO2sXYJgpWxt
         /dU5pgwN452oxm/JIRoCx4bObGQonuBtr0oOcitBQs0PFTLN/QlDu3ZeF0n4N+hqU6Kc
         nLlw==
X-Gm-Message-State: AJIora+nISYxUvRvg9wM/kQO4+3UNHDjUAV3nR+HTcTlJktXA+Md+Lu/
        6OG6Gp1prvwz13VDa3dxKIiuc1ykBANJ0Led0zsJhQ==
X-Google-Smtp-Source: AGRyM1uObxFbk/OdalJ5bp779OxgIf3N8kPgC9BFL6XJs+LvsaPS3cBTKwyifuXYvvSAj9WSxRlU6+FIFIz5WVAJV4s=
X-Received: by 2002:a4a:6550:0:b0:435:f3e8:8d3e with SMTP id
 z16-20020a4a6550000000b00435f3e88d3emr3987894oog.13.1658943682324; Wed, 27
 Jul 2022 10:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064321.2953971-1-mw@semihalf.com> <20220727064321.2953971-7-mw@semihalf.com>
 <20220727143147.u6yd6wqslilspyhw@skbuf> <CAPv3WKc88KQN=athEqBg=Z5Bd1SC3QSOPZpDH7dfuYGHhR+oVg@mail.gmail.com>
 <CAHp75Vfn+tfuzxU31kVxp3sMAoT=ve3tcfDv84Omm-1tqvW3+w@mail.gmail.com>
In-Reply-To: <CAHp75Vfn+tfuzxU31kVxp3sMAoT=ve3tcfDv84Omm-1tqvW3+w@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 27 Jul 2022 19:41:10 +0200
Message-ID: <CAPv3WKdyFWgqfObCU=0e29BT8Lq_cQ6WMkvXCDT-DRCueDsGFw@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 6/8] net: core: switch to fwnode_find_net_device_by_node()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 lip 2022 o 19:00 Andy Shevchenko <andy.shevchenko@gmail.com> n=
apisa=C5=82(a):
>
> On Wed, Jul 27, 2022 at 5:24 PM Marcin Wojtas <mw@semihalf.com> wrote:
> > =C5=9Br., 27 lip 2022 o 16:31 Vladimir Oltean <olteanv@gmail.com> napis=
a=C5=82(a):
> > > On Wed, Jul 27, 2022 at 08:43:19AM +0200, Marcin Wojtas wrote:
>
> ...
>
> > > > +     dev =3D class_find_device(&net_class, NULL, fwnode, fwnode_fi=
nd_parent_dev_match);
> > >
> > > This needs to maintain compatibility with DSA masters that have
> > > dev->of_node but don't have dev->fwnode populated.
> >
> > Do you mean a situation analogous to what I addressed in:
> > [net-next: PATCH v3 4/8] net: mvpp2: initialize port fwnode pointer
> > ?
> >
> > I found indeed a couple of drivers that may require a similar change
> > (e.g. dpaa2).
> >
> > IMO we have 2 options:
> > - update these drivers
>
> Not Vladimir here, but my 2cents that update is best and elegant, it
> can be done even before this series.
>

In general I agree it's desired, but I'm not sure if we can catch all
cases just by reading code or rather base on regression reports
later...

Best regards,
Marcin
