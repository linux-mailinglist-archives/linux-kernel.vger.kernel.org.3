Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714244880EB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiAHCcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiAHCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:32:02 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2CBC061574;
        Fri,  7 Jan 2022 18:32:02 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q4so7285646qvh.9;
        Fri, 07 Jan 2022 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zwce6Y6LiC7xeLzUlyWYquQQoyewMIp2UN+OcTh2Quk=;
        b=LdkohyL4b29l0AeKqR4Z2TLupazfq5Re/LBbwz6rVPeOG9sCJFTHX/xf3CkrStNp3L
         glsopY0ug+CM+z/Gyd0GT7rRtibj3jsr1voiXO7sZonmUTDuOaDlHvfUx0fD4zyiYpCg
         L1gEMzshb/1q8w1DnZTrLGB3Oo8uEIcvD0GAioM8ZOwKmBVWGOs2y2oBE5klWHrPD3+E
         tO8zL7ZunJfoEG4YqGEhT+r0PzTOD1H+YO4aQ/QWG3BQXaLweFvRh784HrZG9va5gGVa
         pa7Zjuo4j14CVz48y4+gGE4LNCIKMft1Dnj7NEFLxAIkhWc+wh+qSV9NTpJvb5DY88I+
         3gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zwce6Y6LiC7xeLzUlyWYquQQoyewMIp2UN+OcTh2Quk=;
        b=YFYdOQn5mMl1qkr1HG9gYDPgW9Nney2nV+0tWWxPGtYpa91Yei+SC1mtWVpYMMEWfI
         SLc9qFMtB82o84pDzLkJtOVv3NO6hKlpZVzvOeS7fWzCfNWa3rTDRaLLwVHnh6w4z90h
         vtR0YcN4vxaTLYCo5ICFqSYdXqIo+AGlFBNVlGx25SQTVnmhEGNXF2f9iQ7+le5bkoM/
         Tdwx5JKy6D8+Z0ijU4jSsN0iZh8iNg00+4bwYa4HAO0poUs7LrSH//NHXPCngFxIOG4f
         sdMQS2hnNUasEEMlaIFXj1Fz/BmVqt3IrjiJg7HLflkEPTU5YSid+QLN/qorxC5mc5V0
         /kTA==
X-Gm-Message-State: AOAM530KibFCBHkWzJ0LPOgjaUChV4sNbWONXLtdDLk92yovg0O6/2gG
        7Jbc9cEMHXBEI0CDgh6uOhiPR2HgNpQ+ww==
X-Google-Smtp-Source: ABdhPJyTimWGtSXKjSWhyfdQu+NMfMwxq9Ljohhp9YIo4/uinlwXuoqEsdMXUJyb/NqItH+HcwFJmQ==
X-Received: by 2002:a05:6214:2304:: with SMTP id gc4mr40949835qvb.33.1641609121260;
        Fri, 07 Jan 2022 18:32:01 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id v7sm193438qkp.30.2022.01.07.18.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 18:32:00 -0800 (PST)
Date:   Fri, 7 Jan 2022 21:31:54 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgugala@antmicro.com" <kgugala@antmicro.com>,
        "mholenko@antmicro.com" <mholenko@antmicro.com>,
        "krakoczy@antmicro.com" <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        "florent@enjoy-digital.fr" <florent@enjoy-digital.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ydj3mmdWILBWHkAh@glsvmlin.ini.cmu.edu>
References: <20220107233458.2326512-1-gsomlo@gmail.com>
 <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com>
 <YdjvlA7rqQoZe44F@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdjvlA7rqQoZe44F@errol.ini.cmu.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:57:43PM -0500, Gabriel L. Somlo wrote:
> Hi Andy,
> 
> On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > 
> > 
> > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:
> > 
> >     LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> >     that targets FPGAs. LiteSDCard is a small footprint, configurable
> >     SDCard core commonly used in LiteX designs.
> > 
> >     The driver was first written in May 2020 and has been maintained
> >     cooperatively by the LiteX community. Thanks to all contributors!
> > 
> >     Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> >     Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> >     Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> >     Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> >     Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> >     Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> >     Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> >     Reviewed-by: Joel Stanley <joel@jms.id.au>
> >     ---
> > 
> >     New in v8:
> >       - remove `Cc:` lines from commit blurb
> >     drivers/mmc/host/litex_mmc.c:
> >       - fix file header comment (for real, this time)
> >       - add explicit `bits.h` include
> >       - remove `of_match_ptr()` wrapper from around .of_match_table argument
> >       - fix devm ordering issues: use `devm_request_irq()`, which precludes
> >         the need to call `free_irq()` on `probe()` error path or from `remove()
> >     `
> > 
> > 
> > 
> > Almost
>   
> That's encouraging! Thanks for your ongoing time and attention! :)
>  
> > 
> >     >New in v7:
> >     >drivers/mmc/host/Kconfig:
> >     >  - added module name in LiteSDCard Kconfig entry
> >     >drivers/mmc/host/litex_mmc.c:
> >     >  - fixed comment formatting, ordering, and capitalization throughout
> >     >    the entire file
> >     >  - sorted header #include statements
> >     >  - removed redundant parantheses in readx_poll_timeout() condition
> >     >  - explicit handling of readx_poll_timeout() timeout scenarios
> >     >  - dev_err() used in litex_mmc_sdcard_wait_done()
> >     >  - use memcpy_fromio() to grab command response
> >     >  - no need to apply 0xffff mask to a 32-bit value right-shifted by 16
> >     >    (host->resp[3])
> >     >  - use clamp() instead of min(max(...)...)
> >     >  - reworked platform_get_irq_optional() error handling logic
> >     >  - no need to explicitly zero host->irq, kzalloc() does that already
> >     >  - added missing free_irq() in litex_mmc_probe() error path
> >     >  - reordered calls inside litex_mmc_remove() (calling mmc_free_host()
> >     >    before free_irq()
> >     >
> >     >>New in v6:
> >     >>  - fix handling of deferred probe vs. platform_get_irq_optional()
> >     >>  - don't #ifdef dma_set_mask_and_coherent(), since it automatically
> >     >>    does the right thing on both 32- and 64-bit DMA capable arches
> >     >>  - remove MMC_CAP2_FULL_PWR_CYCLE, add MMC_CAP2_NO_MMC to list of
> >     >>    hardcoded capabilities during litex_mmc_probe()
> >     >>  - hardcode mmc->ocr_avail to the full 2.7-3.6V range allowed by the
> >     >>    SDCard spec (the LiteSDCard device doesn't accept software
> >     >>    configuration)
> >     >>
> >     >>>New in v5:
> >     >>>  - shorter #define constant names (cosmetic, make them less unwieldy)
> >     >>>  - picked up reviewed-by Joel
> >     >>>
> >     >>>>New in v4:
> >     >>>>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
> >     >>>>    no holes on either 32- or 64-bit builds
> >     >>>>  - litex_mmc_set_bus_width() now encapsulates check for
> >     >>>>    host->is_bus_width_set
> >     >>>>  - litex_mmc_request() - factor out dma data setup into separate
> >     >>>>    helper function: litex_mmc_do_dma()
> >     >>>>
> >     >>>>> New in v3:
> >     >>>>>   - fixed function signature (no line split), and naming
> >     (litex_mmc_*)
> >     >>>>>   - more informative MODULE_AUTHOR() entries
> >     >>>>>     - also added matching "Copyright" entries in file header
> >     >>>>>   - fixed description and dependencies in Kconfig
> >     >>>>>   - removed magic constants
> >     >>>>>   - removed litex_map_status(), have sdcard_wait_done() return *real*
> >     >>>>>     error codes directly instead.
> >     >>>>>   - streamlined litex_mmc_reponse_len()
> >     >>>>>   - call litex_mmc_set_bus_width() only once, and ensure it returns
> >     >>>>>     correct error code(s)
> >     >>>>>   - use readx_poll_timeout() -- more concise -- instead of
> >     >>>>>     read_poll_timeout()
> >     >>>>>   - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
> >     >>>>>   - litex_mmc_setclk() will update host->clock before returning
> >     >>>>>   - separate irq initialization into its own function,
> >     >>>>>     litex_mmc_irq_init()
> >     >>>>>   - document rationale for f_min, f_max
> >     >>>>>   - use dmam_alloc_coherent(), which simplifies cleanup significantly
> >     >>>>>   - bump dma_set_mask_and_coherent() to 64-bits on suitable
> >     >>>>>     architectures
> >     >>>>>   - clock source picked up from dedicated DT clock reference property
> >     >>>>>   - remove gpio card-detect logic (needs testing and a dt binding
> >     >>>>>     example before being eligible for upstream inclusion)
> >     >>>>>   - large `if (data) { ... }` block in litex_mmc_request() left
> >     as-is,
> >     >>>>>     there are too many variables shared with the rest of the parent
> >     >>>>>     function body to easily separate (e.g., `len`, `transfer`,
> >     `direct`).
> >     >>>>>     If this is indeed a blocker, I can take another shot at
> >     refactoring
> >     >>>>>     it in a future revision!
> > 
> >      drivers/mmc/host/Kconfig     |  10 +
> >      drivers/mmc/host/Makefile    |   1 +
> >      drivers/mmc/host/litex_mmc.c | 666 +++++++++++++++++++++++++++++++++++
> >      3 files changed, 677 insertions(+)
> >      create mode 100644 drivers/mmc/host/litex_mmc.c
> > 
> >     diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >     index 5af8494c31b5..a24561b74f18 100644
> >     --- a/drivers/mmc/host/Kconfig
> >     +++ b/drivers/mmc/host/Kconfig
> >     @@ -1093,3 +1093,13 @@ config MMC_OWL
> > 
> >      config MMC_SDHCI_EXTERNAL_DMA
> >             bool
> >     +
> >     +config MMC_LITEX
> >     +       tristate "LiteX MMC Host Controller support"
> > 
> >  
> > 
> >     +       depends on OF
> > 
> > 
> > It looks like functional dependency rather than compilation one. So, there two
> > options:
> > - drop it
> > - unify with the below like
> > 
> >   depends on ((ArchA || ArchB) && OF) || Compile_test
> 
> OK, went with option b) (unify with line below), will be in v9.
> 
> > 
> >     +       depends on PPC_MICROWATT || LITEX || COMPILE_TEST
> >     +       help
> >     +         This selects support for the MMC Host Controller found in LiteX
> >     SoCs.
> >     +
> >     +         To compile this driver as a module, choose M here: the
> >     +         module will be called litex_mmc.
> >     diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> >     index ea36d379bd3c..4e4ceb32c4b4 100644
> >     --- a/drivers/mmc/host/Makefile
> >     +++ b/drivers/mmc/host/Makefile
> >     @@ -101,6 +101,7 @@ obj-$(CONFIG_MMC_CQHCI)                     += cqhci.o
> >      cqhci-y                                        += cqhci-core.o
> >      cqhci-$(CONFIG_MMC_CRYPTO)             += cqhci-crypto.o
> >      obj-$(CONFIG_MMC_HSQ)                  += mmc_hsq.o
> >     +obj-$(CONFIG_MMC_LITEX)                        += litex_mmc.o
> > 
> >      ifeq ($(CONFIG_CB710_DEBUG),y)
> >             CFLAGS-cb710-mmc        += -DDEBUG
> >     diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> >     new file mode 100644
> >     index 000000000000..38952f169a27
> >     --- /dev/null
> >     +++ b/drivers/mmc/host/litex_mmc.c
> >     @@ -0,0 +1,666 @@
> >     +// SPDX-License-Identifier: GPL-2.0
> >     +/*
> >     + * LiteX LiteSDCard driver
> >     + *
> >     + * Copyright (C) 2019-2020 Antmicro <contact@antmicro.com>
> >     + * Copyright (C) 2019-2020 Kamil Rakoczy <krakoczy@antmicro.com>
> >     + * Copyright (C) 2019-2020 Maciej Dudek <mdudek@internships.antmicro.com>
> >     + * Copyright (C) 2020 Paul Mackerras <paulus@ozlabs.org>
> >     + * Copyright (C) 2020-2021 Gabriel Somlo <gsomlo@gmail.com>
> >     + */
> >     +
> >     +#include <linux/bits.h>
> >     +#include <linux/clk.h>
> >     +#include <linux/delay.h>
> >     +#include <linux/dma-mapping.h>
> >     +#include <linux/interrupt.h>
> >     +#include <linux/iopoll.h>
> >     +#include <linux/litex.h>
> >     +#include <linux/module.h>
> >     +#include <linux/mmc/host.h>
> >     +#include <linux/mmc/mmc.h>
> >     +#include <linux/mmc/sd.h>
> > 
> >  
> > 
> >     +#include <linux/of.h>
> > 
> > 
> > Is it used anywhere? Or you meant mod_devicetable.h?
> 
> Not used since I dropped `of_match_ptr()`, so I'm removing the
> include in v9 as well -- thanks for catching that!
> 
> > 
> >     +#include <linux/platform_device.h>
> >     +
> >     +#define LITEX_PHY_CARDDETECT  0x00
> >     +#define LITEX_PHY_CLOCKERDIV  0x04
> >     +#define LITEX_PHY_INITIALIZE  0x08
> >     +#define LITEX_PHY_WRITESTATUS 0x0C
> >     +#define LITEX_CORE_CMDARG     0x00
> >     +#define LITEX_CORE_CMDCMD     0x04
> >     +#define LITEX_CORE_CMDSND     0x08
> >     +#define LITEX_CORE_CMDRSP     0x0C
> >     +#define LITEX_CORE_CMDEVT     0x1C
> >     +#define LITEX_CORE_DATEVT     0x20
> >     +#define LITEX_CORE_BLKLEN     0x24
> >     +#define LITEX_CORE_BLKCNT     0x28
> >     +#define LITEX_BLK2MEM_BASE    0x00
> >     +#define LITEX_BLK2MEM_LEN     0x08
> >     +#define LITEX_BLK2MEM_ENA     0x0C
> >     +#define LITEX_BLK2MEM_DONE    0x10
> >     +#define LITEX_BLK2MEM_LOOP    0x14
> >     +#define LITEX_MEM2BLK_BASE    0x00
> >     +#define LITEX_MEM2BLK_LEN     0x08
> >     +#define LITEX_MEM2BLK_ENA     0x0C
> >     +#define LITEX_MEM2BLK_DONE    0x10
> >     +#define LITEX_MEM2BLK_LOOP    0x14
> >     +#define LITEX_MEM2BLK         0x18
> >     +#define LITEX_IRQ_STATUS      0x00
> >     +#define LITEX_IRQ_PENDING     0x04
> >     +#define LITEX_IRQ_ENABLE      0x08
> >     +
> >     +#define SD_CTL_DATA_XFER_NONE  0
> >     +#define SD_CTL_DATA_XFER_READ  1
> >     +#define SD_CTL_DATA_XFER_WRITE 2
> >     +
> >     +#define SD_CTL_RESP_NONE       0
> >     +#define SD_CTL_RESP_SHORT      1
> >     +#define SD_CTL_RESP_LONG       2
> >     +#define SD_CTL_RESP_SHORT_BUSY 3
> >     +
> >     +#define SD_BIT_DONE    BIT(0)
> >     +#define SD_BIT_WR_ERR  BIT(1)
> >     +#define SD_BIT_TIMEOUT BIT(2)
> >     +#define SD_BIT_CRC_ERR BIT(3)
> >     +
> >     +#define SD_SLEEP_US       5
> >     +#define SD_TIMEOUT_US 20000
> >     +
> >     +#define SDIRQ_CARD_DETECT    1
> >     +#define SDIRQ_SD_TO_MEM_DONE 2
> >     +#define SDIRQ_MEM_TO_SD_DONE 4
> >     +#define SDIRQ_CMD_DONE       8
> >     +
> >     +#define LITEX_MMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
> >     +                      MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
> >     +                      MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)
> >     +
> >     +struct litex_mmc_host {
> >     +       struct mmc_host *mmc;
> >     +       struct platform_device *dev;
> >     +
> >     +       void __iomem *sdphy;
> >     +       void __iomem *sdcore;
> >     +       void __iomem *sdreader;
> >     +       void __iomem *sdwriter;
> >     +       void __iomem *sdirq;
> >     +
> >     +       void *buffer;
> >     +       size_t buf_size;
> >     +       dma_addr_t dma;
> >     +
> >     +       struct completion cmd_done;
> >     +       int irq;
> >     +
> >     +       unsigned int ref_clk;
> >     +       unsigned int sd_clk;
> >     +
> >     +       u32 resp[4];
> >     +       u16 rca;
> >     +
> >     +       bool is_bus_width_set;
> >     +       bool app_cmd;
> >     +};
> >     +
> >     +static int litex_mmc_sdcard_wait_done(void __iomem *reg, struct device
> >     *dev)
> >     +{
> >     +       u8 evt;
> >     +       int ret;
> >     +
> >     +       ret = readx_poll_timeout(litex_read8, reg, evt, evt & SD_BIT_DONE,
> >     +                                SD_SLEEP_US, SD_TIMEOUT_US);
> >     +       if (ret)
> >     +               return ret;
> >     +       if (evt == SD_BIT_DONE)
> >     +               return 0;
> >     +       if (evt & SD_BIT_WR_ERR)
> >     +               return -EIO;
> >     +       if (evt & SD_BIT_TIMEOUT)
> >     +               return -ETIMEDOUT;
> >     +       if (evt & SD_BIT_CRC_ERR)
> >     +               return -EILSEQ;
> >     +       dev_err(dev, "%s: unknown error (evt=%x)\n", __func__, evt);
> >     +       return -EINVAL;
> >     +}
> >     +
> >     +static int litex_mmc_send_cmd(struct litex_mmc_host *host,
> >     +                             u8 cmd, u32 arg, u8 response_len, u8
> >     transfer)
> >     +{
> >     +       struct device *dev = mmc_dev(host->mmc);
> >     +       void __iomem *reg;
> >     +       int ret;
> >     +       u8 evt;
> >     +
> >     +       litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
> >     +       litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
> >     +                     cmd << 8 | transfer << 5 | response_len);
> >     +       litex_write8(host->sdcore + LITEX_CORE_CMDSND, 1);
> >     +
> >     +       /*
> >     +        * Wait for an interrupt if we have an interrupt and either there
> >     is
> >     +        * data to be transferred, or if the card can report busy via DAT0.
> >     +        */
> >     +       if (host->irq > 0 &&
> >     +           (transfer != SD_CTL_DATA_XFER_NONE ||
> >     +            response_len == SD_CTL_RESP_SHORT_BUSY)) {
> >     +               reinit_completion(&host->cmd_done);
> >     +               litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
> >     +                             SDIRQ_CMD_DONE | SDIRQ_CARD_DETECT);
> >     +               wait_for_completion(&host->cmd_done);
> >     +       }
> >     +
> >     +       ret = litex_mmc_sdcard_wait_done(host->sdcore + LITEX_CORE_CMDEVT,
> >     dev);
> >     +       if (ret) {
> >     +               dev_err(dev, "Command (cmd %d) error, status %d\n", cmd,
> >     ret);
> >     +               return ret;
> >     +       }
> >     +
> >     +       if (response_len != SD_CTL_RESP_NONE) {
> >     +               /*
> >     +                * NOTE: this matches the semantics of litex_read32()
> >     +                * regardless of underlying arch endianness!
> >     +                */
> >     +               memcpy_fromio(host->resp,
> >     +                             host->sdcore + LITEX_CORE_CMDRSP, 0x10);
> >     +       }
> >     +
> >     +       if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
> >     +               host->rca = (host->resp[3] >> 16);
> >     +
> >     +       host->app_cmd = (cmd == MMC_APP_CMD);
> >     +
> >     +       if (transfer == SD_CTL_DATA_XFER_NONE)
> >     +               return ret; /* OK from prior litex_mmc_sdcard_wait_done() *
> >     /
> >     +
> >     +       ret = litex_mmc_sdcard_wait_done(host->sdcore + LITEX_CORE_DATEVT,
> >     dev);
> >     +       if (ret) {
> >     +               dev_err(dev, "Data xfer (cmd %d) error, status %d\n", cmd,
> >     ret);
> >     +               return ret;
> >     +       }
> >     +
> >     +       /* Wait for completion of (read or write) DMA transfer */
> >     +       reg = (transfer == SD_CTL_DATA_XFER_READ) ?
> >     +               host->sdreader + LITEX_BLK2MEM_DONE :
> >     +               host->sdwriter + LITEX_MEM2BLK_DONE;
> >     +       ret = readx_poll_timeout(litex_read8, reg, evt, evt & SD_BIT_DONE,
> >     +                                SD_SLEEP_US, SD_TIMEOUT_US);
> >     +       if (ret)
> >     +               dev_err(dev, "DMA timeout (cmd %d)\n", cmd);
> >     +
> >     +       return ret;
> >     +}
> >     +
> >     +static int litex_mmc_send_app_cmd(struct litex_mmc_host *host)
> >     +{
> >     +       return litex_mmc_send_cmd(host, MMC_APP_CMD, host->rca << 16,
> >     +                                 SD_CTL_RESP_SHORT,
> >     SD_CTL_DATA_XFER_NONE);
> >     +}
> >     +
> >     +static int litex_mmc_send_set_bus_w_cmd(struct litex_mmc_host *host, u32
> >     width)
> >     +{
> >     +       return litex_mmc_send_cmd(host, SD_APP_SET_BUS_WIDTH, width,
> >     +                                 SD_CTL_RESP_SHORT,
> >     SD_CTL_DATA_XFER_NONE);
> >     +}
> >     +
> >     +static int litex_mmc_set_bus_width(struct litex_mmc_host *host)
> >     +{
> >     +       bool app_cmd_sent;
> >     +       int ret;
> >     +
> >     +       if (host->is_bus_width_set)
> >     +               return 0;
> >     +
> >     +       /* Ensure 'app_cmd' precedes 'app_set_bus_width_cmd' */
> >     +       app_cmd_sent = host->app_cmd; /* was preceding command app_cmd? */
> >     +       if (!app_cmd_sent) {
> >     +               ret = litex_mmc_send_app_cmd(host);
> >     +               if (ret)
> >     +                       return ret;
> >     +       }
> >     +
> >     +       /* LiteSDCard only supports 4-bit bus width */
> >     +       ret = litex_mmc_send_set_bus_w_cmd(host, MMC_BUS_WIDTH_4);
> >     +       if (ret)
> >     +               return ret;
> >     +
> >     +       /* Re-send 'app_cmd' if necessary */
> >     +       if (app_cmd_sent) {
> >     +               ret = litex_mmc_send_app_cmd(host);
> >     +               if (ret)
> >     +                       return ret;
> >     +       }
> >     +
> >     +       host->is_bus_width_set = true;
> >     +
> >     +       return 0;
> >     +}
> >     +
> >     +static int litex_mmc_get_cd(struct mmc_host *mmc)
> >     +{
> >     +       struct litex_mmc_host *host = mmc_priv(mmc);
> >     +       int ret;
> >     +
> >     +       if (!mmc_card_is_removable(mmc))
> >     +               return 1;
> >     +
> >     +       ret = !litex_read8(host->sdphy + LITEX_PHY_CARDDETECT);
> >     +
> >     +       /* Ensure bus width will be set (again) upon card (re)insertion */
> >     +       if (ret == 0)
> >     +               host->is_bus_width_set = false;
> >     +
> >     +       return ret;
> >     +}
> >     +
> >     +static irqreturn_t litex_mmc_interrupt(int irq, void *arg)
> >     +{
> >     +       struct mmc_host *mmc = arg;
> >     +       struct litex_mmc_host *host = mmc_priv(mmc);
> >     +       u32 pending = litex_read32(host->sdirq + LITEX_IRQ_PENDING);
> >     +
> >     +       /* Check for card change interrupt */
> >     +       if (pending & SDIRQ_CARD_DETECT) {
> >     +               litex_write32(host->sdirq + LITEX_IRQ_PENDING,
> >     +                             SDIRQ_CARD_DETECT);
> >     +               mmc_detect_change(mmc, msecs_to_jiffies(10));
> >     +       }
> >     +
> >     +       /* Check for command completed */
> >     +       if (pending & SDIRQ_CMD_DONE) {
> >     +               /* Disable it so it doesn't keep interrupting */
> >     +               litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
> >     +                             SDIRQ_CARD_DETECT);
> >     +               complete(&host->cmd_done);
> >     +       }
> >     +
> >     +       return IRQ_HANDLED;
> >     +}
> >     +
> >     +static u32 litex_mmc_response_len(struct mmc_command *cmd)
> >     +{
> >     +       if (cmd->flags & MMC_RSP_136)
> >     +               return SD_CTL_RESP_LONG;
> >     +       if (!(cmd->flags & MMC_RSP_PRESENT))
> >     +               return SD_CTL_RESP_NONE;
> >     +       if (cmd->flags & MMC_RSP_BUSY)
> >     +               return SD_CTL_RESP_SHORT_BUSY;
> >     +       return SD_CTL_RESP_SHORT;
> >     +}
> >     +
> >     +static void litex_mmc_do_dma(struct litex_mmc_host *host, struct mmc_data
> >     *data,
> >     +                            unsigned int *len, bool *direct, u8 *transfer)
> >     +{
> >     +       struct device *dev = mmc_dev(host->mmc);
> >     +       dma_addr_t dma;
> >     +       int sg_count;
> >     +
> >     +       /*
> >     +        * Try to DMA directly to/from the data buffer.
> >     +        * We can do that if the buffer can be mapped for DMA
> >     +        * in one contiguous chunk.
> >     +        */
> >     +       dma = host->dma;
> >     +       *len = data->blksz * data->blocks;
> >     +       sg_count = dma_map_sg(dev, data->sg, data->sg_len,
> >     +                             mmc_get_dma_dir(data));
> >     +       if (sg_count == 1) {
> >     +               dma = sg_dma_address(data->sg);
> >     +               *len = sg_dma_len(data->sg);
> >     +               *direct = true;
> >     +       } else if (*len > host->buf_size)
> >     +               *len = host->buf_size;
> >     +
> >     +       if (data->flags & MMC_DATA_READ) {
> >     +               litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
> >     +               litex_write64(host->sdreader + LITEX_BLK2MEM_BASE, dma);
> >     +               litex_write32(host->sdreader + LITEX_BLK2MEM_LEN, *len);
> >     +               litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 1);
> >     +               *transfer = SD_CTL_DATA_XFER_READ;
> >     +       } else if (data->flags & MMC_DATA_WRITE) {
> >     +               if (!*direct)
> >     +                       sg_copy_to_buffer(data->sg, data->sg_len,
> >     +                                         host->buffer, *len);
> >     +               litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
> >     +               litex_write64(host->sdwriter + LITEX_MEM2BLK_BASE, dma);
> >     +               litex_write32(host->sdwriter + LITEX_MEM2BLK_LEN, *len);
> >     +               litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 1);
> >     +               *transfer = SD_CTL_DATA_XFER_WRITE;
> >     +       } else {
> >     +               dev_warn(dev, "Data present w/o read or write flag.\n");
> >     +               /* Continue: set cmd status, mark req done */
> >     +       }
> >     +
> >     +       litex_write16(host->sdcore + LITEX_CORE_BLKLEN, data->blksz);
> >     +       litex_write32(host->sdcore + LITEX_CORE_BLKCNT, data->blocks);
> >     +}
> >     +
> >     +static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request
> >     *mrq)
> >     +{
> >     +       struct litex_mmc_host *host = mmc_priv(mmc);
> >     +       struct device *dev = mmc_dev(mmc);
> >     +       struct mmc_command *cmd = mrq->cmd;
> >     +       struct mmc_command *sbc = mrq->sbc;
> >     +       struct mmc_data *data = mrq->data;
> >     +       struct mmc_command *stop = mrq->stop;
> >     +       unsigned int retries = cmd->retries;
> >     +       unsigned int len = 0;
> >     +       bool direct = false;
> >     +       u32 response_len = litex_mmc_response_len(cmd);
> >     +       u8 transfer = SD_CTL_DATA_XFER_NONE;
> >     +
> >     +       /* First check that the card is still there */
> >     +       if (!litex_mmc_get_cd(mmc)) {
> >     +               cmd->error = -ENOMEDIUM;
> >     +               mmc_request_done(mmc, mrq);
> >     +               return;
> >     +       }
> >     +
> >     +       /* Send set-block-count command if needed */
> >     +       if (sbc) {
> >     +               sbc->error = litex_mmc_send_cmd(host, sbc->opcode, sbc->
> >     arg,
> >     +                                               litex_mmc_response_len
> >     (sbc),
> >     +                                               SD_CTL_DATA_XFER_NONE);
> >     +               if (sbc->error) {
> >     +                       host->is_bus_width_set = false;
> >     +                       mmc_request_done(mmc, mrq);
> >     +                       return;
> >     +               }
> >     +       }
> >     +
> >     +       if (data) {
> >     +               /*
> >     +                * LiteSDCard only supports 4-bit bus width; therefore, we
> >     MUST
> >     +                * inject a SET_BUS_WIDTH (acmd6) before the very first
> >     data
> >     +                * transfer, earlier than when the mmc subsystem would
> >     normally
> >     +                * get around to it!
> >     +                */
> >     +               cmd->error = litex_mmc_set_bus_width(host);
> >     +               if (cmd->error) {
> >     +                       dev_err(dev, "Can't set bus width!\n");
> >     +                       mmc_request_done(mmc, mrq);
> >     +                       return;
> >     +               }
> >     +
> >     +               litex_mmc_do_dma(host, data, &len, &direct, &transfer);
> >     +       }
> >     +
> >     +       do {
> >     +               cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->
> >     arg,
> >     +                                               response_len, transfer);
> >     +       } while (cmd->error && retries-- > 0);
> >     +
> >     +       if (cmd->error) {
> >     +               /* Card may be gone; don't assume bus width is still set */
> >     +               host->is_bus_width_set = false;
> >     +       }
> >     +
> >     +       if (response_len == SD_CTL_RESP_SHORT) {
> >     +               /* Pull short response fields from appropriate host
> >     registers */
> >     +               cmd->resp[0] = host->resp[3];
> >     +               cmd->resp[1] = host->resp[2] & 0xFF;
> >     +       } else if (response_len == SD_CTL_RESP_LONG) {
> >     +               cmd->resp[0] = host->resp[0];
> >     +               cmd->resp[1] = host->resp[1];
> >     +               cmd->resp[2] = host->resp[2];
> >     +               cmd->resp[3] = host->resp[3];
> >     +       }
> >     +
> >     +       /* Send stop-transmission command if required */
> >     +       if (stop && (cmd->error || !sbc)) {
> >     +               stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->
> >     arg,
> >     +                                                litex_mmc_response_len
> >     (stop),
> >     +                                                SD_CTL_DATA_XFER_NONE);
> >     +               if (stop->error)
> >     +                       host->is_bus_width_set = false;
> >     +       }
> >     +
> >     +       if (data) {
> >     +               dma_unmap_sg(dev, data->sg, data->sg_len,
> >     +                            mmc_get_dma_dir(data));
> >     +       }
> >     +
> >     +       if (!cmd->error && transfer != SD_CTL_DATA_XFER_NONE) {
> >     +               data->bytes_xfered = min(len, mmc->max_req_size);
> >     +               if (transfer == SD_CTL_DATA_XFER_READ && !direct) {
> >     +                       sg_copy_from_buffer(data->sg, sg_nents(data->sg),
> >     +                                           host->buffer, data->
> >     bytes_xfered);
> >     +               }
> >     +       }
> >     +
> >     +       mmc_request_done(mmc, mrq);
> >     +}
> >     +
> >     +static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int
> >     freq)
> >     +{
> >     +       struct device *dev = mmc_dev(host->mmc);
> >     +       u32 div;
> >     +
> >     +       div = freq ? host->ref_clk / freq : 256U;
> > 
> >  
> > 
> >     +       div = roundup_pow_of_two(div);
> >     +       div = clamp(div, 2U, 256U);
> > 
> > 
> > Logically seems to me that you may join these two together, because clamped
> > range is power-of-2 one.
> 
> `div` needs to be a power-of-2 when written to the LITEX_PHY_CLOCKERDIV
> register (below). And clamp() will just enforce a min/max range, so if
> (div = ref_clk / freq) ends up e.g., 5, I need both roundup_pow_of_two()
> to bump it to 8, and clamp() to enforce that it's between 2 and 256. 
> 
> Unless you mean I should simply write it like:
> 
> 	div = clamp(roundup_pow_of_two(div), 2U, 256U);
> 
> ... as a single line?
>  
> >     +       dev_dbg(dev, "sd_clk_freq=%d: set to %d via div=%d\n",
> >     +               freq, host->ref_clk / div, div);
> >     +       litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
> >     +       host->sd_clk = freq;
> >     +}
> >     +
> >     +static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >     +{
> >     +       struct litex_mmc_host *host = mmc_priv(mmc);
> >     +
> >     +       /*
> >     +        * NOTE: Ignore any ios->bus_width updates; they occur right after
> >     +        * the mmc core sends its own acmd6 bus-width change notification,
> >     +        * which is redundant since we snoop on the command flow and inject
> >     +        * an early acmd6 before the first data transfer command is sent!
> >     +        */
> >     +
> >     +       /* Update sd_clk */
> >     +       if (ios->clock != host->sd_clk)
> >     +               litex_mmc_setclk(host, ios->clock);
> >     +}
> >     +
> >     +static const struct mmc_host_ops litex_mmc_ops = {
> >     +       .get_cd = litex_mmc_get_cd,
> >     +       .request = litex_mmc_request,
> >     +       .set_ios = litex_mmc_set_ios,
> >     +};
> >     +
> >     +static int litex_mmc_irq_init(struct litex_mmc_host *host)
> >     +{
> >     +       struct device *dev = mmc_dev(host->mmc);
> >     +       int ret;
> >     +
> >     +       ret = platform_get_irq_optional(host->dev, 0);
> >     +       if (ret < 0 && ret != -ENXIO)
> >     +               return ret;
> >     +       if (ret > 0)
> >     +               host->irq = ret;
> >     +       else {
> >     +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> >     +               goto use_polling;
> >     +       }
> >     +
> >     +       host->sdirq = devm_platform_ioremap_resource_byname(host->dev,
> >     "irq");
> >     +       if (IS_ERR(host->sdirq))
> >     +               return PTR_ERR(host->sdirq);
> >     +
> >     +       ret = devm_request_irq(dev, host->irq, litex_mmc_interrupt, 0,
> >     +                              "litex-mmc", host->mmc);
> >     +       if (ret < 0) {
> >     +               dev_warn(dev, "IRQ request error %d, using polling\n",
> >     ret);
> >     +               goto use_polling;
> >     +       }
> >     +
> >     +       /* Clear & enable card-change interrupts */
> >     +       litex_write32(host->sdirq + LITEX_IRQ_PENDING, SDIRQ_CARD_DETECT);
> >     +       litex_write32(host->sdirq + LITEX_IRQ_ENABLE, SDIRQ_CARD_DETECT);
> >     +
> >     +       return 0;
> >     +
> >     +use_polling:
> >     +       host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> >     +       return 0;
> >     +}
> >     +
> >     +static int litex_mmc_probe(struct platform_device *pdev)
> >     +{
> >     +       struct litex_mmc_host *host;
> >     +       struct mmc_host *mmc;
> >     +       struct clk *clk;
> >     +       int ret;
> >     +
> >     +       /*
> >     +        * NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=
> >     512,
> >     +        * and max_blk_count accordingly set to 8;
> >     +        * If for some reason we need to modify max_blk_count, we must also
> >     +        * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;
> >     `
> >     +        */
> >     +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> > 
> > 
> > Should be devm or you may not use devm at all. See hint in one of the previous
> > messages in v7 discussion.
> 
> And here I think I'm in trouble... :)
> 
> None of the examples retrieved via
> 
> `git log --no-merges --grep devm_add_action_or_reset`
> 
> are from "drivers/mmc/host/*", and *all* of the mmc drivers there,
> including the ones that make extensive use of devm_*, use
> mmc_alloc_host(), and there doesn't appear to be a devm-ified version
> of mmc_alloc_host() available! How do they all get away with it?
> 
> I'm really confused now -- any additional clue(s) much appreciated!
 
I found drivers/mmc/host/meson-mx-sdhc-mmc.c, which uses
devm_add_action_or_reset() right after mmc_alloc_host() to enlist the
subsequent call to mmc_free_host(), see here:

https://github.com/torvalds/linux/blob/master/drivers/mmc/host/meson-mx-sdhc-mmc.c#L791

This would mean that I no longer have to call mmc_free_host(), neither
on probe()'s error path, nor during remove().

Does that count as canonically correct, or am I still missing
something?

Thanks, as always,
--Gabriel
  
> >     +       if (!mmc)
> >     +               return -ENOMEM;
> >     +
> >     +       host = mmc_priv(mmc);
> >     +       host->mmc = mmc;
> >     +       host->dev = pdev;
> >     +
> >     +       /* Initialize clock source */
> >     +       clk = devm_clk_get(&pdev->dev, NULL);
> >     +       if (IS_ERR(clk)) {
> >     +               ret = dev_err_probe(&pdev->dev,
> >     +                                   PTR_ERR(clk), "can't get clock\n");
> >     +               goto err;
> >     +       }
> >     +       host->ref_clk = clk_get_rate(clk);
> >     +       host->sd_clk = 0;
> >     +
> >     +       /*
> >     +        * LiteSDCard only supports 4-bit bus width; therefore, we MUST
> >     inject
> >     +        * a SET_BUS_WIDTH (acmd6) before the very first data transfer,
> >     earlier
> >     +        * than when the mmc subsystem would normally get around to it!
> >     +        */
> >     +       host->is_bus_width_set = false;
> >     +       host->app_cmd = false;
> >     +
> >     +       /* LiteSDCard can support 64-bit DMA addressing */
> >     +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >     +       if (ret)
> >     +               goto err;
> >     +
> >     +       host->buf_size = mmc->max_req_size * 2;
> >     +       host->buffer = dmam_alloc_coherent(&pdev->dev, host->buf_size,
> >     +                                          &host->dma, GFP_DMA);
> >     +       if (host->buffer == NULL) {
> >     +               ret = -ENOMEM;
> >     +               goto err;
> >     +       }
> >     +
> >     +       host->sdphy = devm_platform_ioremap_resource_byname(pdev, "phy");
> >     +       if (IS_ERR(host->sdphy)) {
> >     +               ret = PTR_ERR(host->sdphy);
> >     +               goto err;
> >     +       }
> >     +
> >     +       host->sdcore = devm_platform_ioremap_resource_byname(pdev, "core");
> >     +       if (IS_ERR(host->sdcore)) {
> >     +               ret = PTR_ERR(host->sdcore);
> >     +               goto err;
> >     +       }
> >     +
> >     +       host->sdreader = devm_platform_ioremap_resource_byname(pdev,
> >     "reader");
> >     +       if (IS_ERR(host->sdreader)) {
> >     +               ret = PTR_ERR(host->sdreader);
> >     +               goto err;
> >     +       }
> >     +
> >     +       host->sdwriter = devm_platform_ioremap_resource_byname(pdev,
> >     "writer");
> >     +       if (IS_ERR(host->sdwriter)) {
> >     +               ret = PTR_ERR(host->sdwriter);
> >     +               goto err;
> >     +       }
> >     +
> >     +       /* Ensure DMA bus masters are disabled */
> >     +       litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
> >     +       litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
> >     +
> >     +       init_completion(&host->cmd_done);
> >     +       ret = litex_mmc_irq_init(host);
> >     +       if (ret)
> >     +               goto err;
> >     +
> >     +       /* Allow full generic 2.7-3.6V range; no software tuning available
> >     */
> >     +       mmc->ocr_avail = LITEX_MMC_OCR;
> >     +
> >     +       mmc->ops = &litex_mmc_ops;
> >     +
> >     +       /*
> >     +        * Set default sd_clk frequency range based on empirical
> >     observations
> >     +        * of LiteSDCard gateware behavior on typical SDCard media
> >     +        */
> >     +       mmc->f_min = 12.5e6;
> >     +       mmc->f_max = 50e6;
> >     +
> >     +       ret = mmc_of_parse(mmc);
> >     +       if (ret)
> >     +               goto err;
> >     +
> >     +       /* Force 4-bit bus_width (only width supported by hardware) */
> >     +       mmc->caps &= ~MMC_CAP_8_BIT_DATA;
> >     +       mmc->caps |= MMC_CAP_4_BIT_DATA;
> >     +
> >     +       /* Set default capabilities */
> >     +       mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> >     +                    MMC_CAP_DRIVER_TYPE_D |
> >     +                    MMC_CAP_CMD23;
> >     +       mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT |
> >     +                     MMC_CAP2_NO_SDIO |
> >     +                     MMC_CAP2_NO_MMC;
> >     +
> >     +       platform_set_drvdata(pdev, host);
> >     +
> >     +       ret = mmc_add_host(mmc);
> >     +       if (ret < 0)
> >     +               goto err;
> >     +
> >     +       return 0;
> >     +
> >     +err:
> >     +       mmc_free_host(mmc);
> >     +       return ret;
> >     +}
> >     +
> >     +static int litex_mmc_remove(struct platform_device *pdev)
> >     +{
> >     +       struct litex_mmc_host *host = platform_get_drvdata(pdev);
> >     +       struct mmc_host *mmc = host->mmc;
> >     +
> >     +       mmc_remove_host(mmc);
> >     +       mmc_free_host(mmc);
> >     +
> >     +       return 0;
> >     +}
> >     +
> >     +static const struct of_device_id litex_match[] = {
> >     +       { .compatible = "litex,mmc" },
> >     +       { }
> >     +};
> >     +MODULE_DEVICE_TABLE(of, litex_match);
> >     +
> >     +static struct platform_driver litex_mmc_driver = {
> >     +       .probe = litex_mmc_probe,
> >     +       .remove = litex_mmc_remove,
> >     +       .driver = {
> >     +               .name = "litex-mmc",
> >     +               .of_match_table = litex_match,
> >     +       },
> >     +};
> >     +module_platform_driver(litex_mmc_driver);
> >     +
> >     +MODULE_DESCRIPTION("LiteX SDCard driver");
> >     +MODULE_AUTHOR("Antmicro <contact@antmicro.com>");
> >     +MODULE_AUTHOR("Kamil Rakoczy <krakoczy@antmicro.com>");
> >     +MODULE_AUTHOR("Maciej Dudek <mdudek@internships.antmicro.com>");
> >     +MODULE_AUTHOR("Paul Mackerras <paulus@ozlabs.org>");
> >     +MODULE_AUTHOR("Gabriel Somlo <gsomlo@gmail.com>");
> >     +MODULE_LICENSE("GPL v2");
> >     --
> >     2.31.1
> > 
> > 
> > 
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
