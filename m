Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AA46E7C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhLILxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:53:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51492 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhLILxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:53:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9137DCE2588;
        Thu,  9 Dec 2021 11:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAA8C004DD;
        Thu,  9 Dec 2021 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639050606;
        bh=sBa+Bn2lEzC030SisKGwQNUM8a1a5LDRVe2Ox9/ASSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jW/+essi26wXLAgU7bzuIphWkJKKp2sQOC+u5v4CAOSeYsaFn96SUD/zpp/1YNw38
         p2O/7qW3ODmfqCqFqeFifmnRFYU8KzkbhfnI4//KA3ZNly+rhkAjQS2hCM5sHEjl4I
         MolNsHJkRtFsE1cONF89sC+webx+ZnTZdJGCNoAgtVk+2gjumpfPpAKPiWaixHlea5
         zSWaKU6ScpFwUCOkPdEDU3uM64JzL9jo1uXIccs06Kyne6EoWLxTVvpi20Y980+k89
         rBLqUdeCr6yN7IJx1HfQH/C6uNoVwiRNVDwHFhNco9nyBYyho6/tWmtTNZ929w518s
         aSJWH0TOm8dIA==
Date:   Thu, 9 Dec 2021 17:20:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Milind Parab <mparab@cadence.com>
Cc:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Message-ID: <YbHtanITI9I/cONn@matsya>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com>
 <YZxyja2xEkpWvStR@matsya>
 <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YZ8aygJQoxie+Ddn@matsya>
 <DM6PR07MB61549C25EBF70ED2639FBCF6C5699@DM6PR07MB6154.namprd07.prod.outlook.com>
 <MW2PR07MB7899EC5A08D975E646F48A96D3709@MW2PR07MB7899.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR07MB7899EC5A08D975E646F48A96D3709@MW2PR07MB7899.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-21, 06:11, Milind Parab wrote:
> Hi Vinod,
> 
> Do you have any further comments on this.
> The implementation follows the same approach as is done for Cadence Torrent multiprotocol Phy

Pls do *not* top post!

Sure i will look into it soon..

> 
> Regards,
> Milind
> 
> >-----Original Message-----
> >From: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> >Sent: Thursday, December 2, 2021 7:43 PM
> >To: Vinod Koul <vkoul@kernel.org>
> >Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> >phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> >devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> >govindraju@ti.com
> >Subject: RE: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
> >multilink configuration
> >
> >Hi Vinod,
> >
> >> -----Original Message-----
> >> From: Vinod Koul <vkoul@kernel.org>
> >> Sent: Thursday, November 25, 2021 10:41 AM
> >> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> >> Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> >> phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> >> devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> >> govindraju@ti.com
> >> Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII
> >> PHY multilink configuration
> >>
> >> EXTERNAL MAIL
> >>
> >>
> >> On 24-11-21, 07:33, Swapnil Kashinath Jakhade wrote:
> >>
> >> > > so this is pcie->qsgmii ->ssc/external/internal ... ok
> >> > >
> >> > > > +				[NO_SSC] =
> >> > > &pcie_100_no_ssc_plllc_cmn_vals,
> >> > > > +				[EXTERNAL_SSC] =
> >> > > &pcie_100_ext_ssc_plllc_cmn_vals,
> >> > > > +				[INTERNAL_SSC] =
> >> > > &pcie_100_int_ssc_plllc_cmn_vals,
> >> > > > +			},
> >> > > >  		},
> >> > > >  		[TYPE_USB] = {
> >> > > >  			[TYPE_NONE] = {
> >> > > >  				[EXTERNAL_SSC] =
> >> > > &usb_100_ext_ssc_cmn_vals,
> >> > > >  			},
> >> > > >  		},
> >> > > > +		[TYPE_QSGMII] = {
> >> > > > +			[TYPE_PCIE] = {
> >> > >
> >> > > now it is reverse! qsgmii -> pcie -> ... why?
> >> > >
> >> > > what is meant by pcie->qsgmii and qsgmii-> pcie?
> >> > >
> >> >
> >> > Multi-protocol configuration is done in 2 phases, each for one protocol.
> >> > e.g. for PCIe + QSGMII case,
> >> > [TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers
> >> > for PCIe and [TYPE_QSGMII][TYPE_PCIE] will configure common and lane
> >> registers for QSGMII.
> >>
> >> Then it should be always common + protocol or protocol + common, not
> >> both please! Pls make an order and stick to it everywhere... If that
> >> is not possible, I would like to understand why
> >>
> >
> >Could you please elaborate what do you mean by " common + protocol or
> >protocol + common, not both please!"?
> >The order is same everywhere which is common + lane configuration for
> >protocol 1 and then for protocol 2. For multiprotocol case, PHY configuration is
> >based on which protocols are operating simultaneously. So e.g.
> >[TYPE_QSGMII][TYPE_PCIE] -> QSGMII configuration when other protocol is
> >PCIe Which might be different than [TYPE_QSGMII][TYPE_*] -> QSGMII
> >configuration with other protocol.
> >
> >Thanks & regards,
> >Swapnil
> >
> >> --
> >> ~Vinod

-- 
~Vinod
