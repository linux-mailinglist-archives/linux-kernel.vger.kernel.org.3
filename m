Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2D513703
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbiD1OjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiD1OjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:39:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A91616F;
        Thu, 28 Apr 2022 07:36:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m23so6951519ljb.8;
        Thu, 28 Apr 2022 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4No/j+RzlQBrNmQzGgnkjFW2pDaZAdEHYz4CfvsYrE=;
        b=gcnnHe/El+IFsFQpKDY7o9V+g4X1WvfQOQ4/XxIdYT3169jm6xf1sxsDfWv8SgVZAk
         wKvLaTzTNJiGp3t5dyKCLKo9wdCuTDLn68WSMU/mfew8fCdyl/kUd20lloLfR4NOLx9l
         Q9HFS14P3w35Mc1/o79XitfRgdBzxf8WOC9IqyIBUOkI41z/xeOdZmkmY34R8+/jAGED
         W18KUtfcSc0Gbw2941A0J0l9edYxSsPOo3+/y6dVO50Y4n1ynV+hpHphGsc/aOQrRKEd
         P/1iW48qvLnE1jV2v0A/CVy1r5r+g5u2bEY0/c8kuoHP9vAJsbv33Oj+56uteCKbMp/t
         SmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4No/j+RzlQBrNmQzGgnkjFW2pDaZAdEHYz4CfvsYrE=;
        b=pHG3OtlzV2NAuMKL5QeTDdpfa0CT3017OoSAegwyyVAtNH4C6HWv1Ui0QXRcZPE57R
         sNqUaTm85uVFcFrPlaT5735xVUROL7JVaUmZpOek9wE3Bz7bh1lyP85jqXqoqHvGwqXZ
         hzVOuOqwDzmzRM52gOvk7t2M/uB2G7b2AWJuPUKIQeGoUCbuBYmVqRUt0aruUseSTJQ3
         myu3AHwQMLAxWJz4g9l1cTmSZK8Z3zoJ4DeNT3Pt0W1XYga3457RFaso3/sCzSuirryD
         jhfe6ZHjDhmjbK1F7OvMItiBwOPb2mcfJD4Fnm0ZtzlqZFdh3EJQ5buKwkjMOUDKpcG4
         xDWg==
X-Gm-Message-State: AOAM532ONKo3lDCvhvqeDn2xN6NOWwJJgcXkMl77/p6o2i1VyrodxcYA
        6RCYO9MXcMpLBg7TvyRWP1E=
X-Google-Smtp-Source: ABdhPJxN4LkQ8j6TLHDihe0I8BBucSz24vJF9zC4H62AnqwYZppWp7H+3sDoFOi+KIHuxL/yKRRRVg==
X-Received: by 2002:a2e:5c6:0:b0:24f:5bd:5f89 with SMTP id 189-20020a2e05c6000000b0024f05bd5f89mr17196690ljf.170.1651156559558;
        Thu, 28 Apr 2022 07:35:59 -0700 (PDT)
Received: from mobilestation.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id p21-20020a056512139500b00447c9b87945sm17212lfa.172.2022.04.28.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:35:59 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:35:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: Re: [PATCH v4 3/3] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <20220428143454.igdqqbbtufrzrizz@mobilestation.baikal.int>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <20220308103331.4116-4-nandhini.srikandan@intel.com>
 <20220413130249.ueisqj5xs3komhmr@mobilestation>
 <SJ0PR11MB58160274EABEA39BFA625F5485FA9@SJ0PR11MB5816.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB58160274EABEA39BFA625F5485FA9@SJ0PR11MB5816.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:51:47AM +0000, Srikandan, Nandhini wrote:
> 
> 
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Wednesday, April 13, 2022 6:33 PM
> > To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; broonie@kernel.org;
> > robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> > Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > Subject: Re: [PATCH v4 3/3] spi: dw: Add support for master mode selection
> > for DWC SSI controller
> > 
> > Hello Nandhini
> > 
> > AFAICS this patch should go before
> > [PATCH v4 2/3] spi: dw: Add support for Intel Thunder Bay SPI controller
> > Thus you'd perform the DWC AHB SSI Master mode conversion first, then
> > introduce the new controller support. Otherwise without this patch applied
> > the DW SPI driver is most likely left broken for the Intel SPI controllers since
> > you drop the DW_SPI_CAP_KEEMBAY_MST macro usage in [PATCH 2/3] while
> > the new DW AHB SSI Master functionality is introduced in the next patch
> > [PATCH 3/3]. So please convert the series to the harmless configuration on
> > each git image state.
> > 
> Sure, I will reorder patch 2/3 and 3/3 so that the master mode conversion happens first followed by new controller support.
> 
> > On Tue, Mar 08, 2022 at 06:33:31PM +0800, nandhini.srikandan@intel.com
> > wrote:
> > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > >
> > > Add support to select the controller mode as master mode by setting
> > > Bit 31 of CTRLR0 register. This feature is supported for controller
> > > versions above v1.02.
> > >
> > > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > ---
> > >  drivers/spi/spi-dw-core.c | 4 ++--
> > >  drivers/spi/spi-dw.h      | 7 +++----
> > >  2 files changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > index ecea471ff42c..68bfdf2c4dc7 100644
> > > --- a/drivers/spi/spi-dw-core.c
> > > +++ b/drivers/spi/spi-dw-core.c
> > > @@ -307,8 +307,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws,
> > struct spi_device *spi)
> > >  		if (spi->mode & SPI_LOOP)
> > >  			cr0 |= DW_HSSI_CTRLR0_SRL;
> > >
> > 
> > > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > > -			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
> > > +		/* CTRLR0[31] MST */
> > > +		cr0 |= DW_HSSI_CTRLR0_MST;
> > 
> > Could you please conditionally set that flag here? That's what we agreed to
> > do in v3:
> > https://lore.kernel.org/linux-
> > spi/20211116191542.vc42cxvflzn66ien@mobilestation/
> > like this:
> > +	/* CTRLR0[31] MST */
> > +	if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> > +		cr0 |= DWC_HSSI_CTRLR0_MST;
> > 

> In case of Keem Bay, though the version of SPI controller is shown as 1.01a from the HW register, it still needs the MST BIT31 to be set in order for controller to work in master mode.
> Also since the older versions of the controller which do not need the BIT31 to be set, the bit was reserved. Hence there is no impact by setting this BIT31 for older versions. 
> So, the condition check was removed.

I am completely confused. Earlier you said that both Keem Bay and
Thunder bay had v1.02a DW AHB SSI IP-core:
https://patchwork.kernel.org/project/spi-devel-general/patch/20210824085856.12714-3-nandhini.srikandan@intel.com/
Now you say they are based on the different versions of the core.
Please clarify.

-Sergey

> 
> > >  	}
> > >
> > >  	return cr0;
> > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > > d5ee5130601e..2583b7314c41 100644
> > > --- a/drivers/spi/spi-dw.h
> > > +++ b/drivers/spi/spi-dw.h
> > > @@ -23,7 +23,7 @@
> > >  	((_dws)->ip == DW_ ## _ip ## _ID)
> > >
> > 
> > >  #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> > > -	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> > > +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ##
> > _ver)
> > 
> > Nice catch. My mistake. Could you please move this change into a dedicated
> > patch with the next fixes tag?
> > Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions
> > interface")
> > 

> Sure, I will convert this to a dedicated patch. Just for confirmation, the patch should be a separate patch with this title "Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interface")" 
> and not part of the current patch set series.

You can add that patch to this series (better to the head of it). The
title can be something like: "spi: dw: Fix IP-core versions macro".
The tag needs to be added in the commit log above the Signed-off-by
tag.

-Sergey

> > >
> > >  #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip,
> > > _ver, ==)
> > >
> > > @@ -31,8 +31,7 @@
> > >
> > >  /* DW SPI controller capabilities */
> > >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> > > -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > > -#define DW_SPI_CAP_DFS32		BIT(2)
> > > +#define DW_SPI_CAP_DFS32		BIT(1)
> > >
> > >  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
> > >  #define DW_SPI_CTRLR0			0x00
> > > @@ -100,7 +99,7 @@
> > 
> > >   * 0: SSI is slave
> > >   * 1: SSI is master
> > >   */
> > > -#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
> > > +#define DW_HSSI_CTRLR0_MST			BIT(31)
> > 
> > Could you please drop the redundant comment above and join the macro
> > with the DW_HSSI_* macros group?
> > 
> Sure, I will remove the comment and group the macros. 
> > -Sergey
> > 
> > >
> > >  /* Bit fields in CTRLR1 */
> > >  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
> > > --
> > > 2.17.1
> > >
