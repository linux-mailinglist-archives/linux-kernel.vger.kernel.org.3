Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01962473F41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhLNJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:22:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60884 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhLNJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:22:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA87B81823;
        Tue, 14 Dec 2021 09:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E5EC34601;
        Tue, 14 Dec 2021 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639473748;
        bh=wwQR8mwE39ljJ7AGeFIyttvd6OPcslCZZCbHxDE3Chw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCjmb27Cf7J+JFLssI/mlsY3n5/dRIKixPFJbDubHbg4b9RwybK3Lrwk6/98Uzs09
         2SQSdsIw2YmYivGnNx+EUrFH4AFoOVKqeOuAXcDsAK6208Fvikuej71qax/qT58gjb
         ROgdf4+e8d6+8cecWIboWN9fi8WUZmhdgfMiOKfWLw485g8KjZAqBrPocCqWpsrEUK
         Vdz1EXU3y6xZHZa4FDcjE0SKnLI4KoSV/d5VIvybHM8C59QpUiDzQQcGHQqMBDwoMT
         Ahkk351jw6WRvegh5ytEb7yD8vYjEJROVkPp6OX1eTGPrlGXmUUdpR+FQkVEBoN4DD
         BzmhtRs3eauUg==
Date:   Tue, 14 Dec 2021 14:52:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Message-ID: <YbhiT7PTtqaofN5w@matsya>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com>
 <YZxyja2xEkpWvStR@matsya>
 <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YZ8aygJQoxie+Ddn@matsya>
 <DM6PR07MB61549C25EBF70ED2639FBCF6C5699@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YbHuV/LpcZqOTuLV@matsya>
 <DM6PR07MB6154AF51437C535362EC4059C5719@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB6154AF51437C535362EC4059C5719@DM6PR07MB6154.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-21, 09:46, Swapnil Kashinath Jakhade wrote:
> Hi Vinod,
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Thursday, December 9, 2021 5:24 PM
> > To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> > Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> > phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> > govindraju@ti.com
> > Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
> > multilink configuration
> > 
> > EXTERNAL MAIL
> > 
> > 
> > On 02-12-21, 14:12, Swapnil Kashinath Jakhade wrote:
> > > Hi Vinod,
> > >
> > > > -----Original Message-----
> > > > From: Vinod Koul <vkoul@kernel.org>
> > > > Sent: Thursday, November 25, 2021 10:41 AM
> > > > To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> > > > Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de;
> > > > linux- phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> > > > govindraju@ti.com
> > > > Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe +
> > > > QSGMII PHY multilink configuration
> > > >
> > > > EXTERNAL MAIL
> > > >
> > > >
> > > > On 24-11-21, 07:33, Swapnil Kashinath Jakhade wrote:
> > > >
> > > > > > so this is pcie->qsgmii ->ssc/external/internal ... ok
> > > > > >
> > > > > > > +				[NO_SSC] =
> > > > > > &pcie_100_no_ssc_plllc_cmn_vals,
> > > > > > > +				[EXTERNAL_SSC] =
> > > > > > &pcie_100_ext_ssc_plllc_cmn_vals,
> > > > > > > +				[INTERNAL_SSC] =
> > > > > > &pcie_100_int_ssc_plllc_cmn_vals,
> > > > > > > +			},
> > > > > > >  		},
> > > > > > >  		[TYPE_USB] = {
> > > > > > >  			[TYPE_NONE] = {
> > > > > > >  				[EXTERNAL_SSC] =
> > > > > > &usb_100_ext_ssc_cmn_vals,
> > > > > > >  			},
> > > > > > >  		},
> > > > > > > +		[TYPE_QSGMII] = {
> > > > > > > +			[TYPE_PCIE] = {
> > > > > >
> > > > > > now it is reverse! qsgmii -> pcie -> ... why?
> > > > > >
> > > > > > what is meant by pcie->qsgmii and qsgmii-> pcie?
> > > > > >
> > > > >
> > > > > Multi-protocol configuration is done in 2 phases, each for one protocol.
> > > > > e.g. for PCIe + QSGMII case,
> > > > > [TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers
> > > > > for PCIe and [TYPE_QSGMII][TYPE_PCIE] will configure common and
> > > > > lane
> > > > registers for QSGMII.
> > > >
> > > > Then it should be always common + protocol or protocol + common, not
> > > > both please! Pls make an order and stick to it everywhere... If that
> > > > is not possible, I would like to understand why
> > >
> > > Could you please elaborate what do you mean by " common + protocol or
> > > protocol + common, not both please!"?
> > > The order is same everywhere which is common + lane configuration for
> > > protocol 1 and then for protocol 2. For multiprotocol case, PHY
> > > configuration is based on which protocols are operating simultaneously. So
> > e.g.
> > > [TYPE_QSGMII][TYPE_PCIE] -> QSGMII configuration when other protocol
> > > is PCIe Which might be different than [TYPE_QSGMII][TYPE_*] -> QSGMII
> > > configuration with other protocol.
> > 
> > As I said I would like to understand what is the difference b/w
> > [TYPE_QSGMII][TYPE_PCIE] & [TYPE_PCIE][TYPE_QSGMII] and why?
> > 
> 
> This logic is for implementing multi-link PHY configuration.
> Consider a case for a 4 lane PHY with PCIe using 2 lanes and QSGMII other 2 lanes.
> Sierra PHY has 2 PLLs, viz. PLLLC and PLLLC1.
> So in this case, PLLLC is used for PCIe and PLLLC1 is used for QSGMII and
> PHY will be configured in two steps as described below.
> 1. For first step, phy_t1 = TYPE_PCIE and phy_t2 = TYPE_QSGMII
>      So we select registers as
>      [TYPE_PCIE][TYPE_QSGMII][ssc]: 
>               This will configure PHY registers associated for *PCIe* (i.e. first protocol)
>               involving PLLLC registers and registers for first 2 lanes of PHY.
> 2. In second step, the variables phy_t1 and phy_t2 are swapped. So now,
>     phy_t1 = TYPE_QSGMII and phy_t2 = TYPE_PCIE. And we select registers as:
>     [TYPE_QSGMII][TYPE_PCIE][ssc]:
>              This will configure PHY registers associated for *QSGMII* (i.e. second protocol)
>              involving PLLLC1 registers and registers for other 2 lanes of PHY.
> 
> This completes the PHY configuration for multilink operation.
> Above approach enables dividing the large number of PHY register configurations
> into protocol specific smaller groups.
> 
> Please let me know if it answers your question.

Thanks this helps. Can you please add this useful info in the comments
for this, that will help folks understanding why it was done like this

-- 
~Vinod
