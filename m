Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA364878A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbiAGOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbiAGOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:07:36 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D40C061574;
        Fri,  7 Jan 2022 06:07:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o17so5648130qtk.1;
        Fri, 07 Jan 2022 06:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FJJ1LAlT5E3uZAj6xXc02sELHd35X1xfWRcV/TcHKyQ=;
        b=GzuyF7B38fXpEOReZ1eWI3OqrIeF/bazKd+0TDEoeEIXrl2atlWYSK881D/NSZO64/
         42T+Dgh8Q4ubzsEX4WCQuta+IljJMhcYpxv8VmaweBLPDi930RB5HhMZF4LtXYjAbOTi
         gYJYn7Q76Y5DuLJKEbzI3oFl2HR1cQlvwtVOTzwWxOV6sPKHoef1QQzzG9rTYxGXRl71
         R62squAyfGZv9sCY2stkWcNjaBjvFtQaaYYaUYYaBZTeWeZlhbkB4Sdjpx+uXolZmMSL
         5Qxg7Kx0K/TgcbEfmQN0NJR6f2TTDFVL/BftyrJYRRhN0bGvtEbbhbbZ/O9a5aNNZe+b
         rmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJJ1LAlT5E3uZAj6xXc02sELHd35X1xfWRcV/TcHKyQ=;
        b=zSPoP4/zw6802jsD4J6NvOnJos+qG1AbTAcJoz88hT3AlEl5ZdqbS2X4n9wNcMYI6U
         Ii3ZTyg9Oc/gQrvnkFATaVjxum1g+mXDNsOaD1vQQP4OXRQq0jOs0LGHQHTwIzyPErBp
         BjbAM7uBYGo3ZhQwRG2rG4kyRoqwiyHs19yQw+UUb5etd3v6unz9aafOzvOoV4xfDpVp
         N8yR461VJXEsvSRwwkHOQ3cm/BTBIk/G7kUQpJVtyj9/zrKBcc6cwkxM7ZdKaZk9VxwP
         iIGSJ1AELC2fVyH+G+7lP98dL8Sg9IBfJvv9k8r8vmK6E9RZToU7WdUjeS+M3ZwOArax
         30hw==
X-Gm-Message-State: AOAM530I7idwWpB8W0gmZAHpiTJrqf7oJ62a0JVNKMpQpCryQX4teBdg
        Al5Cai8F4PPEJShpSz+Au64=
X-Google-Smtp-Source: ABdhPJzvnOyS6iYuZgw/Wk2Zl9kVviqNKZNs9DSnyYMpQM6sZCAXyv/eIHQPkylQ0psgdH/+fRvEYA==
X-Received: by 2002:ac8:5bc9:: with SMTP id b9mr55839476qtb.599.1641564455622;
        Fri, 07 Jan 2022 06:07:35 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id n11sm3535247qtk.44.2022.01.07.06.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:07:35 -0800 (PST)
Date:   Fri, 7 Jan 2022 09:07:33 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdhJJd2DJUIKJuv1@errol.ini.cmu.edu>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
 <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu>
 <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
 <YdgSG7t2eG9YzkaG@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdgSG7t2eG9YzkaG@antec>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:12:43PM +0900, Stafford Horne wrote:
> On Fri, Jan 07, 2022 at 10:36:12AM +0100, Geert Uytterhoeven wrote:
> > Hi Gabriel,
> > 
> > On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > On Thu, Jan 06, 2022 at 08:19:39PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jan 6, 2022 at 7:48 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > > > >
> > > > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > > > SDCard core commonly used in LiteX designs.
> > > > >
> > > > > The driver was first written in May 2020 and has been maintained
> > > > > cooperatively by the LiteX community. Thanks to all contributors!
> > > >
> > > > > +config MMC_LITEX
> > > > > +       tristate "LiteX MMC Host Controller support"
> > > > > +       depends on OF
> > > > > +       depends on PPC_MICROWATT || LITEX || COMPILE_TEST
> > > > > +       help
> > > > > +         This selects support for the MMC Host Controller found in LiteX SoCs.
> > > > > +
> > > > > +         If unsure, say N.
> > > >
> > > > What would be the module name if built as a module?
> > >
> > > litex_mmc.ko -- why are you asking? I.e., should I mention that anywhere
> > > in the Kconfig blurb (I don't see other blurbs doing that, fwiw)?
> > 
> > Many (most?) blurbs do mention the module name.
> 
> I was doubting this as well, but I searched and its true.  The text 'module will
> be called' shows up many times, there is also different text.
> 
>  $ grep -r 'module will be called' drivers/ | wc
>    1347    9023   9086
> 
>  $ grep -r 'tristate \"' drivers/ | wc
>    7169   47486  521795

OK, so initially I quickly looked at a few entries before LiteX in the
drivers/mmc/host/Kconfig file, and saw nothing useful, and asked a
follow-up question... :)

Knowing the magic "module will be called" incantation to grep for helped,
and now I created a similar one for LiteSDCard's Kconfig entry, and lined
it up for v7.

Thanks to everyone who chimed in!

Best,
--Gabriel
