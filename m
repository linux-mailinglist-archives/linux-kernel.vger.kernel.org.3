Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8E48BAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbiAKWta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAKWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:49:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC67C06173F;
        Tue, 11 Jan 2022 14:49:28 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id f17so982117qtf.8;
        Tue, 11 Jan 2022 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iTcC7ukfxrtH+w7Bwnh+J1yNooIJCj1oppyVXmV9pHg=;
        b=LXprke5L/5ujM8g45DpQKFSR8YKLrm+AjgO0EvFDO03LYRKaL8xP5E6l2vnVewYEg9
         sL3R8uwL5kWxPPaT1j6IHq4zBXYEIOrAfeNxfCPaCAZXXFiYwpawDrlxzWEA7R0yTzm7
         4qCQ5r1E6sS6HpP3G3Ya9m425Yxd/G4IL20wIop7ZMQ3JPAKtN5hpctvIxz4VD3DIu1V
         hLugQ2apCvzUxtJ9hgA9pWfryssgTXH1xrVQcJL2rOSzbL5tE8Kc8n8KkfMW/X2fgBYl
         Ls02pcYiSSAbs+iS1rUIjyvP5a9JVLByLfgQir18FeBZgeJzMTAEm2cZjSe87oVfgo1x
         IeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iTcC7ukfxrtH+w7Bwnh+J1yNooIJCj1oppyVXmV9pHg=;
        b=qYMsmgrevDSmkBajm+8GIdLGNgmGBFlrPrWSRG7AOMO3pEU2WoEUGCOGE9GFFkznan
         E8dR34p1yYNYgh3WnSIaPufxAOpHcg6/3lBb1+HR+ylimHOARTBOQjzylGopeoiyPL4w
         4fucoYykddkfMjr40BTz2pP4f9iQm/7CZPDqk57hpYWoFFsEBj7L1YUxwLX9DIqt8CNN
         lBKr18ys3Lo/4+yrlnoCqd81e9Z0XcRrdvVdvrI0Q7EpbNmbXsmjKHQZuRYbxuBkrsc6
         PfPWP7ojo55Hgc7AAHsXvxICgS9IL3GWAP6nfCXBdcPYv40vCzMOWn049st8FXL1Muua
         WAug==
X-Gm-Message-State: AOAM532HcuKZoAnqykzRLyxjwuFJgGoxcQT8dYyP+mOY1LebR/tujZhO
        b7iw6AOIFLka7gP/Rpd4w2A=
X-Google-Smtp-Source: ABdhPJyE9e8DDpNlk542pc33EmxHDARJ1PAGTN7UYA3Tgk5mJGsgQK1gwlIMRDd4zMaELWS3GBQw8w==
X-Received: by 2002:a05:622a:1b20:: with SMTP id bb32mr2284572qtb.291.1641941368026;
        Tue, 11 Jan 2022 14:49:28 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id j14sm7513544qkp.28.2022.01.11.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:49:27 -0800 (PST)
Date:   Tue, 11 Jan 2022 17:49:24 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Yd4JdBArPn9rBj5b@errol.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
 <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
 <CAPDyKFohOHYu_bdXsAYvDmMLqnGUW=9pG+yJDwP5-db1B6F1Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFohOHYu_bdXsAYvDmMLqnGUW=9pG+yJDwP5-db1B6F1Dw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On Tue, Jan 11, 2022 at 04:47:07PM +0100, Ulf Hansson wrote:
> [...]
> 
> > > > +
> > > > +static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > > > +{
> > > > +       struct litex_mmc_host *host = mmc_priv(mmc);
> > > > +       struct device *dev = mmc_dev(mmc);
> > > > +       struct mmc_command *cmd = mrq->cmd;
> > > > +       struct mmc_command *sbc = mrq->sbc;
> > > > +       struct mmc_data *data = mrq->data;
> > > > +       struct mmc_command *stop = mrq->stop;
> > > > +       unsigned int retries = cmd->retries;
> > > > +       unsigned int len = 0;
> > > > +       bool direct = false;
> > > > +       u32 response_len = litex_mmc_response_len(cmd);
> > > > +       u8 transfer = SD_CTL_DATA_XFER_NONE;
> > > > +
> > > > +       /* First check that the card is still there */
> > > > +       if (!litex_mmc_get_cd(mmc)) {
> > > > +               cmd->error = -ENOMEDIUM;
> > > > +               mmc_request_done(mmc, mrq);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       /* Send set-block-count command if needed */
> > > > +       if (sbc) {
> > > > +               sbc->error = litex_mmc_send_cmd(host, sbc->opcode, sbc->arg,
> > > > +                                               litex_mmc_response_len(sbc),
> > > > +                                               SD_CTL_DATA_XFER_NONE);
> > > > +               if (sbc->error) {
> > > > +                       host->is_bus_width_set = false;
> > > > +                       mmc_request_done(mmc, mrq);
> > > > +                       return;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (data) {
> > > > +               /* LiteSDCard only supports 4-bit bus width; therefore, we MUST
> > > > +                * inject a SET_BUS_WIDTH (acmd6) before the very first data
> > > > +                * transfer, earlier than when the mmc subsystem would normally
> > > > +                * get around to it!
> > >
> > > This means that you may end up trying to switch bus-width, to a width
> > > that isn't supported by the card, for example.
> > >
> > > As also stated above, I wonder how this conforms to the SD spec from
> > > the initialization sequence point of view. Have you verified that this
> > > isn't a problem?
> >
> > During litex_mmc_probe(), I have:
> >
> >         ...
> >         ret = mmc_of_parse(mmc);
> >         if (ret)
> >                 goto err;
> >
> >         /* force 4-bit bus_width (only width supported by hardware) */
> >         mmc->caps &= ~MMC_CAP_8_BIT_DATA;
> >         mmc->caps |= MMC_CAP_4_BIT_DATA;
> >         ...
> >
> > This ensures no bus-width switches to anything other than 4-bit data
> > should ever occur. As far as I understand the SDcard spec, it's legal
> > to both send multiple redundant bus-width-set commands, and to start
> > doing so before the very first data transfer request is processed
> > (regardless of the fact that linux typically does a few 1-bit-wide
> > data transfers during card initialization before switching to a wider
> > mode, if available).
> >
> > This driver simply ensures that any time we ever have a data transfer,
> > the bus width is set to 4 *before* said transfer is acted upon.
> >
> > As I mentioned earlier, if we get a "weird" SDcard that can't support
> > 4-bit data transfers, its initialization should fail shortly after
> > detection, and that's all there is to it, as far as I can tell.
> 
> Alright, I get the point. I guess it should work. I will have another
> closer look at the corresponding code from your last submitted
> version.

Thanks -- it's now on v12 :)
 
> >
> > > > +                */
> > > > +               cmd->error = litex_mmc_set_bus_width(host);
> > > > +               if (cmd->error) {
> > > > +                       dev_err(dev, "Can't set bus width!\n");
> > > > +                       mmc_request_done(mmc, mrq);
> > > > +                       return;
> > > > +               }
> > > > +
> > > > +               litex_mmc_do_dma(host, data, &len, &direct, &transfer);
> > > > +       }
> > > > +
> > > > +       do {
> > > > +               cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->arg,
> > > > +                                               response_len, transfer);
> > > > +       } while (cmd->error && retries-- > 0);
> > > > +
> > > > +       if (cmd->error) {
> > > > +               /* card may be gone; don't assume bus width is still set */
> > > > +               host->is_bus_width_set = false;
> > > > +       }
> > > > +
> > > > +       if (response_len == SD_CTL_RESP_SHORT) {
> > > > +               /* pull short response fields from appropriate host registers */
> > > > +               cmd->resp[0] = host->resp[3];
> > > > +               cmd->resp[1] = host->resp[2] & 0xFF;
> > > > +       } else if (response_len == SD_CTL_RESP_LONG) {
> > > > +               cmd->resp[0] = host->resp[0];
> > > > +               cmd->resp[1] = host->resp[1];
> > > > +               cmd->resp[2] = host->resp[2];
> > > > +               cmd->resp[3] = host->resp[3];
> > > > +       }
> > > > +
> > > > +       /* Send stop-transmission command if required */
> > > > +       if (stop && (cmd->error || !sbc)) {
> > > > +               stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->arg,
> > > > +                                                litex_mmc_response_len(stop),
> > > > +                                                SD_CTL_DATA_XFER_NONE);
> > > > +               if (stop->error)
> > > > +                       host->is_bus_width_set = false;
> > > > +       }
> > > > +
> > > > +       if (data) {
> > > > +               dma_unmap_sg(dev, data->sg, data->sg_len,
> > > > +                            mmc_get_dma_dir(data));
> > > > +       }
> > > > +
> > > > +       if (!cmd->error && transfer != SD_CTL_DATA_XFER_NONE) {
> > > > +               data->bytes_xfered = min(len, mmc->max_req_size);
> > > > +               if (transfer == SD_CTL_DATA_XFER_READ && !direct) {
> > > > +                       sg_copy_from_buffer(data->sg, sg_nents(data->sg),
> > > > +                                           host->buffer, data->bytes_xfered);
> > > > +               }
> > > > +       }
> > > > +
> > > > +       mmc_request_done(mmc, mrq);
> > > > +}
> > > > +
> > >
> > > [...]
> > >
> > > > +
> > > > +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > >
> > > I noticed that you use these hard coded values and don't really care
> > > to manage voltage changes via ->set_ios().
> > >
> > > Rather than doing it like this, I would prefer if you can hook up a
> > > fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
> > > to fetch it from here, which will let the mmc core create the
> > > mmc->ocr_avail mask, based upon the voltage level the regulator
> > > supports.
> > >
> > > This becomes more generic and allows more flexibility for the platform
> > > configuration.
> >
> > The LiteSDCard "hardware" (i.e., *gateware*) does not allow modification
> > or selection of voltage from the software side. When a CMD8 is issued,
> > the "voltage supplied" bit pattern is expected to be '0001b', which per
> > the spec means "2.7-3.6V".
> 
> If you provide a range (2.7-3.6V), that means that your hardware
> supports the entire range, not just one single part of it.

The "gateware" (open source migen/verilog at
https://github.com/enjoy-digital/litesdcard)
supports any value provided by the underlying FPGA dev board
(typically 3.3v) -- by not attempting to manage it in any way.

SD media presumably doesn't care as long as voltage is somewhere
within 2.7-3.6V (at least that's how I read the spec, there's only
one register value representing anything within that range).

> >
> > I tried adding this to the overall DTS:
> >
> >         vreg_mmc: vreg_mmc_3v {
> >                 compatible = "regulator-fixed";
> >                 regulator-min-microvolt = <3300000>;
> >                 regulator-max-microvolt = <3300000>;
> >         };
> >
> > and then added a reference to it to the LiteSDCard "mmc0" node in DTS,
> > like so:
> >
> >         mmc0: mmc@12005000 {
> >                 compatible = "litex,mmc";
> >                 reg = <0x12005000 0x100>,
> >                         <0x12003800 0x100>,
> >                         <0x12003000 0x100>,
> >                         <0x12004800 0x100>,
> >                         <0x12004000 0x100>;
> >                 reg-names = "phy", "core", "reader", "writer", "irq";
> >                 clocks = <&sys_clk>;
> >                 vmmc-supply = <&vreg_mmc>; /* <-------- HERE !!! */
> >                 interrupt-parent = <&L1>;
> >                 interrupts = <4>;
> >         };
> >
> > Finally, I replaced the hardcoded setting of `mmc->ocr_avail` with a
> > call to `mmc_regulator_get_supply(mmc)`. Now, I get a bunch of timeouts
> > during attempts to send e.g., CMD8 and CMD55.
> > (going for 3200000 and 3400000 for min- and max-microvolt, respectively,
> >  -- or anything else in the allowed 2.7-3.6 range -- doesn't help either).
> >
> > I might be doing something subtly wrong in the way I set things up
> > above, but it feels a bit overengineered, and IMHO fragile.
> 
> At a quick glance, the above looks correct to me. Maybe there is
> something wrong with the code in the driver instead?

After some more hacking, I learned that:

	- an additional `regulator-name` line
	  (e.g. `regulator-name = "vreg_mmc";`) is required

	- setting `regulator-always-on;` seems to help reduce attempts
	  by the kernel to "manage" the regulator, but does not appear
	  to be required

In other words:

	...
        vreg_mmc: vreg_mmc {
                compatible = "regulator-fixed";
                regulator-name = "vreg_mmc";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;
                regulator-always-on;
        };
	...

Additionally, CONFIG_REGULATOR=y and CONFIG_REGULATOR_FIXED_VOLTAGE=y
*MUST* be enabled in the kernel's .config file, to prevent either
litex_mmc_probe() from being deferred, or mmc_regulator_get_supply()
from simply returning 0 without having set mmc->ocr_avail to anything
at all!

Presumably this would also mean either `select REGULATOR_FIXED_VOLTAGE`
or `depends on REGULATOR_FIXED_VOLTAGE` in the mmc driver's Kconfig
entry.

Predictably, the "regulator-[min|max]-microvolt = <3300000>" setting
gets us

	ocr_avail == MMC_VDD_32_33 | MMC_VDD_33_34

> >
> > OTOH, going all out and setting:
> >
> >         /* allow for generic 2.7-3.6V range, no software tuning available */
> >         mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
> >                          MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
> >                          MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
> >
> > seems to work just fine... :) Please do let me know what you think!
> 
> No, this isn't the way we want it to work. That's because it means
> that we would lie to the card about what voltage range the HW actually
> supports.
> 
> It's better to let the DTS file give that information about the HW.

I may be needlessly concerned, but it feels a bit weird to me to drag
in CONFIG_REGULATOR_FIXED_VOLTAGE as an added dependency for what is
ultimately a roundabout way of setting a constant... :)

Thanks in advance for any additional clue!

Best,
--Gabriel
