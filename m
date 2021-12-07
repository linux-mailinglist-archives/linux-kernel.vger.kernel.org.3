Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B646BD4B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhLGONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbhLGONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:13:53 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4FC061574;
        Tue,  7 Dec 2021 06:10:23 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j17so14360104qtx.2;
        Tue, 07 Dec 2021 06:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rWh4GBiRuzNmwh/gsENmiXPtC26wfYoa8wQtrZgX0UU=;
        b=aHpprykDI6gmwqP7S27CMn+R4rct5Ps/fXM2+A1KjLZxPXAjB+EQAYIPQuVYMnkLJm
         Li4x2T3M1BROUY9rGDs9iqhNHFZTV5IQa/5jsS2eKa3acWHxaIfcSVBbtRNNx5UwxwHa
         8W9upsTzNlUWp7LAP8OoNgG0LBUK0UZaJTwSwGL2e0Teg4QiHDk6HdX44Bx0R4IEivEh
         R3kCf9SSCnlvMLfXd2MBxJ6M1LNC1/lO5OHlsiLy6v9IS05cndnvfn5LKpW4NqZQkGjn
         N3Joka2aKrPOyDNs7cf3dN0tXu34u3Ym/bdoL9NH+M85NEBJXwchJi+ZYb4TcHPDsB5v
         l4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWh4GBiRuzNmwh/gsENmiXPtC26wfYoa8wQtrZgX0UU=;
        b=SJ2alKcX3SJurKg85/MBlOBmOPRI6EM1CxeyzzyECPjbvEBnQ9t6nRnLfJki5oN3CK
         GszrhHTgPO5DbL+fWjzQGA2ie5SaxBlI2U+ePi1ppXjqRpjKCyOPFxiORmC1pJQWRsD1
         sIoNklfm73hM4pdgeiTamNQ9zFYjBUU3iFrnUvf6uFGOdCUKvUpXs19UlDuss5e3/Xed
         uChISNcs8OLCx6STOGbhIYo3c1PMOtlgjGgCNQTuFf3XddTyNSv0oYwST2ejvt2Ql4V9
         GfDAKEPxRpH2dIGULUIyThtW3H7kVJ4dV+IrNZadVAkkyziv6FkmFpevvDN/LOgBp6Mi
         yTxg==
X-Gm-Message-State: AOAM530s+OPtmKtEY5bk1l9LS+LuzGiSXfNDxRPR9+iIwyyycyjjVemU
        6hfBsaDUImWhddSxpp2taJ0=
X-Google-Smtp-Source: ABdhPJzK+apJL3Bct3auO+WrT/grickqsobS560E4sI21dieqUfv2PCsOADsnt8Q6DGY4wg4L9CtLw==
X-Received: by 2002:ac8:5f13:: with SMTP id x19mr49398743qta.475.1638886222540;
        Tue, 07 Dec 2021 06:10:22 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id k85sm7892012qke.134.2021.12.07.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:10:21 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:10:19 -0500
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
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ya9rSz4KJTwiy830@errol.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for the feedback! Some replies and follow-up questions inline,
below:

On Mon, Dec 06, 2021 at 01:24:49PM +0100, Geert Uytterhoeven wrote:
> On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> >
> > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> > --- /dev/null
> > +++ b/drivers/mmc/host/litex_mmc.c
> 
> > +static void
> > +litex_set_clk(struct litex_mmc_host *host, unsigned int clk_freq)
> > +{
> > +       u32 div = clk_freq ? host->freq / clk_freq : 256;
> > +
> > +       div = roundup_pow_of_two(div);
> > +       div = min_t(u32, max_t(u32, div, 2), 256);
> > +       dev_info(&host->dev->dev, "sdclk_freq=%d: set to %d via div=%d\n",
> > +                clk_freq, host->freq / div, div);
> > +       litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
> > +}
> > +
> > +static void
> > +litex_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +       struct litex_mmc_host *host = mmc_priv(mmc);
> > +
> > +       /* NOTE: Ignore any ios->bus_width updates; they occur right after
> > +        * the mmc core sends its own acmd6 bus-width change notification,
> > +        * which is redundant since we snoop on the command flow and inject
> > +        * an early acmd6 before the first data transfer command is sent!
> > +        */
> > +
> > +       /* update sdcard clock */
> > +       if (ios->clock != host->clock) {
> > +               litex_set_clk(host, ios->clock);
> > +               host->clock = ios->clock;
> 
> It might be better to move the assignment to host->clock into the callee,
> to avoid it becoming out-of-sync when a second caller is introduced.

Good idea, done and ready for v3.

> > +       }
> > +}
> 
> > +static int
> > +litex_mmc_probe(struct platform_device *pdev)
> > +{
> > +       struct litex_mmc_host *host;
> > +       struct mmc_host *mmc;
> > +       struct device_node *cpu;
> > +       int ret;
> > +
> > +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> > +       /* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
> > +        * and max_blk_count accordingly set to 8;
> > +        * If for some reason we need to modify max_blk_count, we must also
> > +        * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
> > +        */
> > +       if (!mmc)
> > +               return -ENOMEM;
> > +
> > +       host = mmc_priv(mmc);
> > +       host->mmc = mmc;
> > +       host->dev = pdev;
> > +
> > +       host->clock = 0;
> > +       cpu = of_get_next_cpu_node(NULL);
> > +       ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
> > +       of_node_put(cpu);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> > +               goto err_free_host;
> > +       }
> 
> This looks fragile.
> Shouldn't the clock be obtained from a clock property in the mmc
> device node, pointing to a clock provider?
> How does the real clock tree look like?

In a full LiteX SoC, the main sys_clock is used for cpu, buses, and as a
input source for peripherals such as LiteSDCard (which then further
subdivides it to obtain a 12.5--50.0 MHz sd_clock.

But since we're considering supporting LiteSDCard as an independent IP
block, the "source clock" frequency should indeed be specified as a DT
property in the MMC device node. (I'll have to add that to the list of
updates for litex_json2dts_linux.py as well, once we settle on what it
will look like -- I'll try to make the change and corresponding update
to the devicetree bindings doc for v3).

LMK what you think.

Thanks,
--Gabriel
