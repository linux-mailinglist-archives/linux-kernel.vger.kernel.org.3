Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B259C487540
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiAGKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiAGKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:12:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24EC061245;
        Fri,  7 Jan 2022 02:12:45 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 8so5054830pgc.10;
        Fri, 07 Jan 2022 02:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvY4vt56fm3e5p8Ggdgh9xo2+Oq2fCsoWWoisZ3FiqE=;
        b=RxXldgoyRe2ydVKDlBCwp7yrOL5ePCqb2mWoEgq87tul7KsMtCf/G0sd08pYxmCEMZ
         3shiQbTYdEM6rwxjQvQvxQVRJ4irXPDWbhdQfE5IGEcdC5IFZ2+dOawla54S9LUDxnx6
         q7ZRP6lPfEwfc8jfkG+hG6KY1YVTvPiOMWZe4AxrZmxlEiZ0vIIghQZyUgKhRubmJUQI
         DQbrbsZZFSKTR2v6TBUstupmUyNwcaYMU7LM5uTOsQd+JRN3zieh2yLjqsyA38OC+wMi
         lw9iv3ijZ/xyXjez17/cdXmBzYrMVXiIQj8tcv8fCIjDtTnb2hjN1ecG5rCWznc6PXEP
         NRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvY4vt56fm3e5p8Ggdgh9xo2+Oq2fCsoWWoisZ3FiqE=;
        b=S9lBi1ls9oczta0V+Xu2/+D9qed7t/mJBFnlvKTtbbguyzKHkRosoGV/leOBOtwWw/
         dEAMgXAsJEgg8Yc0YtaQ8Zz/4ypr4qohn0E3onTx5iQjR2E9kLDIVHOZdunmCucKu9YZ
         WphC3kLQSot6IVi1gCa14BOZ+qJUkW/JGpYTPbg8TtVcxmvtnt/VrTAPY6+5MiQ0i1Sd
         NnAHl65RZtqZ++kRcSa2zGdoztw4XQ0EBGXtG/j/C1VeRBTSKaFDX3FHzw8rW8iFgP42
         jS8Z0JLWQlTCVmsqIcSGAvoepk6MUJfnpBzwwx88uxSuUB3M7YtYr3lpLn2Pjt/vcDW4
         /WNw==
X-Gm-Message-State: AOAM532MWhzK8FBuLn9Cm2b7Z6lvfMtqkO6xDOb1pQkLLse7uzmRqVH6
        gsXrxRQzT3C6+xdOv/6J8lc=
X-Google-Smtp-Source: ABdhPJxEe59R7f1yd0nnfNfbIgTGjP5ENry+WrsJM7dMmtP1jgE8n03JXguNJ0J2hWSFFLyGJdf+TA==
X-Received: by 2002:a05:6a00:17a7:b0:4ba:baf6:995f with SMTP id s39-20020a056a0017a700b004babaf6995fmr63792605pfg.68.1641550365384;
        Fri, 07 Jan 2022 02:12:45 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g6sm5751665pfj.156.2022.01.07.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:12:44 -0800 (PST)
Date:   Fri, 7 Jan 2022 19:12:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Gabriel L. Somlo" <gsomlo@gmail.com>,
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
Message-ID: <YdgSG7t2eG9YzkaG@antec>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
 <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu>
 <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:36:12AM +0100, Geert Uytterhoeven wrote:
> Hi Gabriel,
> 
> On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Thu, Jan 06, 2022 at 08:19:39PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 6, 2022 at 7:48 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > > >
> > > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > > SDCard core commonly used in LiteX designs.
> > > >
> > > > The driver was first written in May 2020 and has been maintained
> > > > cooperatively by the LiteX community. Thanks to all contributors!
> > >
> > > > +config MMC_LITEX
> > > > +       tristate "LiteX MMC Host Controller support"
> > > > +       depends on OF
> > > > +       depends on PPC_MICROWATT || LITEX || COMPILE_TEST
> > > > +       help
> > > > +         This selects support for the MMC Host Controller found in LiteX SoCs.
> > > > +
> > > > +         If unsure, say N.
> > >
> > > What would be the module name if built as a module?
> >
> > litex_mmc.ko -- why are you asking? I.e., should I mention that anywhere
> > in the Kconfig blurb (I don't see other blurbs doing that, fwiw)?
> 
> Many (most?) blurbs do mention the module name.

I was doubting this as well, but I searched and its true.  The text 'module will
be called' shows up many times, there is also different text.

 $ grep -r 'module will be called' drivers/ | wc
   1347    9023   9086

 $ grep -r 'tristate \"' drivers/ | wc
   7169   47486  521795

So maybe >10% have module name in the blurb.  Example:

          To compile this driver as a module, choose M here: the
          module will be called tifm_sd.

Thanks,

-Stafford
