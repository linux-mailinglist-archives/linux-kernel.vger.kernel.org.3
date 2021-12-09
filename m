Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706DC46E7CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhLIL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:57:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52520 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhLIL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:57:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED12FCE245E;
        Thu,  9 Dec 2021 11:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34854C004DD;
        Thu,  9 Dec 2021 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639050843;
        bh=LuduuUVtRzUzUrU1F4AC42Ur8LrJtnTcV5XvLjCCZgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5e2dNB8nKRDEbTaMlPbcP115LXIR9iFP6KpUPvXQnbXR5igdH0hk9V2Yzc1a772L
         P2SfAjKd/6HYdrQe6THTcim1QXVkqF/yuKry13bUXVhK+jmuo5qRZwoXBfy8i32xbB
         WV+blwXbxcNFhCOPagIg1KfvBUjXS/LWSOMlAgPVxz+oBCQDyYZvDL2kWvGLTdquuf
         LtEi96p5aBXEKKVOC7IGXjol6hn53KqjriUMYpMFdtKVT2dSjH93an7FIjKqLokKyE
         7TcefqtLtgZWJ6V5Dtna+nAoV1aRctmaMBOZDi8JX2Id8+vHJpzog1CLV+a08hn9M5
         /UDTXIjflPatQ==
Date:   Thu, 9 Dec 2021 17:23:59 +0530
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
Message-ID: <YbHuV/LpcZqOTuLV@matsya>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com>
 <YZxyja2xEkpWvStR@matsya>
 <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YZ8aygJQoxie+Ddn@matsya>
 <DM6PR07MB61549C25EBF70ED2639FBCF6C5699@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB61549C25EBF70ED2639FBCF6C5699@DM6PR07MB6154.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 14:12, Swapnil Kashinath Jakhade wrote:
> Hi Vinod,
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Thursday, November 25, 2021 10:41 AM
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
> > On 24-11-21, 07:33, Swapnil Kashinath Jakhade wrote:
> > 
> > > > so this is pcie->qsgmii ->ssc/external/internal ... ok
> > > >
> > > > > +				[NO_SSC] =
> > > > &pcie_100_no_ssc_plllc_cmn_vals,
> > > > > +				[EXTERNAL_SSC] =
> > > > &pcie_100_ext_ssc_plllc_cmn_vals,
> > > > > +				[INTERNAL_SSC] =
> > > > &pcie_100_int_ssc_plllc_cmn_vals,
> > > > > +			},
> > > > >  		},
> > > > >  		[TYPE_USB] = {
> > > > >  			[TYPE_NONE] = {
> > > > >  				[EXTERNAL_SSC] =
> > > > &usb_100_ext_ssc_cmn_vals,
> > > > >  			},
> > > > >  		},
> > > > > +		[TYPE_QSGMII] = {
> > > > > +			[TYPE_PCIE] = {
> > > >
> > > > now it is reverse! qsgmii -> pcie -> ... why?
> > > >
> > > > what is meant by pcie->qsgmii and qsgmii-> pcie?
> > > >
> > >
> > > Multi-protocol configuration is done in 2 phases, each for one protocol.
> > > e.g. for PCIe + QSGMII case,
> > > [TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers for
> > > PCIe and [TYPE_QSGMII][TYPE_PCIE] will configure common and lane
> > registers for QSGMII.
> > 
> > Then it should be always common + protocol or protocol + common, not
> > both please! Pls make an order and stick to it everywhere... If that is not
> > possible, I would like to understand why
> 
> Could you please elaborate what do you mean by
> " common + protocol or protocol + common, not both please!"?
> The order is same everywhere which is common + lane configuration for protocol 1
> and then for protocol 2. For multiprotocol case, PHY configuration is based on which
> protocols are operating simultaneously. So e.g.
> [TYPE_QSGMII][TYPE_PCIE] -> QSGMII configuration when other protocol is PCIe
> Which might be different than
> [TYPE_QSGMII][TYPE_*] -> QSGMII configuration with other protocol.

As I said I would like to understand what is the difference b/w
[TYPE_QSGMII][TYPE_PCIE] & [TYPE_PCIE][TYPE_QSGMII] and why?

-- 
~Vinod
