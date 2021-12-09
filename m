Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7146F55C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhLIVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLIVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:01:42 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D173C061746;
        Thu,  9 Dec 2021 12:58:08 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id kl8so6267785qvb.3;
        Thu, 09 Dec 2021 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/WyWSC2YtM3cDUHS9kzZYwAFpru5cbBUBJ8qwTc/wi4=;
        b=DM3MGj0fQ3LesrSQ2yAwTf/GBpGv020HhiV85FT2JMg9VzK7y0T9H6ytvgGPVB0w5h
         eEZFoqIsZRuh6GPouv3YnXbiB9tGP5vE1nG62+rROCCkxFSq5nEmlyq0UzHLR6cVRHpW
         RMIn2t2PknAUM5k3S9F7qAKU1qS0VCFa7aNSc/dWCf1U+inrCY1Z32Uqv0NHgi9ZZGkh
         cVF0HE75Npt74+UekHakng+i6EZwjV5QvbGR1sD3jhv+iOptr+hep5C5nlCY2qN8obju
         UuE9BJW1vx/rSO2CY/smQ0zORUOYkoOKvOloZWMRts4KUwwkgGu8V9iPRnSi4T7+wLqA
         uoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/WyWSC2YtM3cDUHS9kzZYwAFpru5cbBUBJ8qwTc/wi4=;
        b=b1mqVdwyZU0RR47gYrbivkNUZK3zyl7FPJWEkuP4lNsAo1MTkVzIKie2n5y1qfFRmn
         PiMAigIYkkpzYQ7j4O5xVly6986gRqYF9D29k4JV2hCAvZERLVigzRxWRZDsXyXz5/1O
         IEoA12TawXuUSZH3XRSjuBFdyj6Rm/vIpx2OhXBLk8mBp2vjEd9f4f7aI3u+DoHOR7BD
         Tw4MO8e2QGyujfvw5LV5DFUG4rw+kowB+NpmQLaSzINWPZxG1Z79WfW8HODbXqwWwG6E
         rphd/yfufYLHKZOdZwrWI0bbUz7GxOO6078gKnea+sToHn013qo7BlF3dZoOxU8IW2GL
         S1Yw==
X-Gm-Message-State: AOAM533M6fTPZX2QyMNFxQPeM+4f6T45tXONrs2tn/hEYRHjHF3nSVaS
        EO7+kge7rkbF9hp3TdtyaZk=
X-Google-Smtp-Source: ABdhPJwz2i7GVDppYMLqDPKpuLgs6D27v/T6htkLgqZ2LjS8oWEexUOuMvLfun7c9pbd+M3uvb9D4A==
X-Received: by 2002:a05:6214:20ee:: with SMTP id 14mr20556590qvk.94.1639083487357;
        Thu, 09 Dec 2021 12:58:07 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id u9sm568402qta.17.2021.12.09.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:58:06 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:58:04 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YbJt3NLU9KPO+ERu@errol.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com>
 <YbESHK06Tpw3typS@errol.ini.cmu.edu>
 <CAMuHMdV6fttX6Jn06WJacNh+1pLz1RfYf82B2fB1D+=Kb9FmMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV6fttX6Jn06WJacNh+1pLz1RfYf82B2fB1D+=Kb9FmMA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:31:49AM +0100, Geert Uytterhoeven wrote:
> Hi Gabriel,
> 
> On Wed, Dec 8, 2021 at 9:14 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > I did *some* of this for v3, but since figured out how to use `pahole` :)
> 
> Right, pahole.
> 
> > On Mon, Dec 06, 2021 at 11:07:56AM +0100, Geert Uytterhoeven wrote:
> > > > +struct litex_mmc_host {
> > > > +       struct mmc_host *mmc;
> > > > +       struct platform_device *dev;
> > > > +
> > > > +       void __iomem *sdphy;
> > > > +       void __iomem *sdcore;
> > > > +       void __iomem *sdreader;
> > > > +       void __iomem *sdwriter;
> > > > +       void __iomem *sdirq;
> > > > +
> > > > +       u32 resp[4];
> > > > +       u16 rca;
> > > > +
> > > > +       void *buffer;
> > > > +       size_t buf_size;
> > > > +       dma_addr_t dma;
> > > > +
> > > > +       unsigned int freq;
> > > > +       unsigned int clock;
> > > > +       bool is_bus_width_set;
> > > > +       bool app_cmd;
> > > > +
> > > > +       int irq;
> > > > +       struct completion cmd_done;
> > >
> > > You may want to reorder the members to avoid implicit gaps
> > > (i.e. structs first, followed by integral types in decreasing size).
> >
> > So, for v4, I'll have it looking like this, which `pahole` says is
> > optimally packed:
> >
> > struct litex_mmc_host {
> >         struct mmc_host *          mmc;                  /*     0     8 */
> >         struct platform_device *   dev;                  /*     8     8 */
> >         void *                     sdphy;                /*    16     8 */
> >         void *                     sdcore;               /*    24     8 */
> >         void *                     sdreader;             /*    32     8 */
> >         void *                     sdwriter;             /*    40     8 */
> >         void *                     sdirq;                /*    48     8 */
> >         void *                     buffer;               /*    56     8 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         size_t                     buf_size;             /*    64     8 */
> 
> size_t is 32-bit on RV32, so you may want to move it below cmd_done.
> 
> >         dma_addr_t                 dma;                  /*    72     8 */
> >         struct completion          cmd_done;             /*    80    32 */
> >         int                        irq;                  /*   112     4 */
> >         unsigned int               ref_clk;              /*   116     4 */
> >         unsigned int               sd_clk;               /*   120     4 */
> >         u32                        resp[4];              /*   124    16 */
> >         /* --- cacheline 2 boundary (128 bytes) was 12 bytes ago --- */
> >         u16                        rca;                  /*   140     2 */
> >         bool                       is_bus_width_set;     /*   142     1 */
> >         bool                       app_cmd;              /*   143     1 */
> >
> >         /* size: 144, cachelines: 3, members: 18 */
> >         /* last cacheline: 16 bytes */
> > };

After a bit of a fight, I managed to wrestle `pahole` to display useful
information for 32-bit (rv32imac) builds:

struct litex_mmc_host {
	struct mmc_host *          mmc;                  /*     0     4 */
	struct platform_device *   dev;                  /*     4     4 */
	void *                     sdphy;                /*     8     4 */
	void *                     sdcore;               /*    12     4 */
	void *                     sdreader;             /*    16     4 */
	void *                     sdwriter;             /*    20     4 */
	void *                     sdirq;                /*    24     4 */
	void *                     buffer;               /*    28     4 */
	size_t                     buf_size;             /*    32     4 */
	dma_addr_t                 dma;                  /*    36     4 */
	struct completion          cmd_done;             /*    40    16 */
	int                        irq;                  /*    56     4 */
	unsigned int               ref_clk;              /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               sd_clk;               /*    64     4 */
	u32                        resp[4];              /*    68    16 */
	u16                        rca;                  /*    84     2 */
	bool                       is_bus_width_set;     /*    86     1 */
	bool                       app_cmd;              /*    87     1 */

	/* size: 88, cachelines: 2, members: 18 */
	/* last cacheline: 24 bytes */
};

Looks like even with `size_t buf_size` where it is right now, there
still are no holes. I like it where it is, as it's related to the
field immediately preceding it (`buffer`). I'd rather not move it,
particularly since we're not actually eliminating any additional
holes.

What do you think (i.e., is there a configuration where there's still
a chance we may run into trouble)?

Thanks,
--Gabriel
