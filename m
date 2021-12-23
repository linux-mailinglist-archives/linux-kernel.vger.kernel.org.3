Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775E647E297
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbhLWLuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:50:07 -0500
Received: from foss.arm.com ([217.140.110.172]:40338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhLWLuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:50:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7DA1FB;
        Thu, 23 Dec 2021 03:50:06 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 390853F5A1;
        Thu, 23 Dec 2021 03:50:04 -0800 (PST)
Date:   Thu, 23 Dec 2021 11:49:58 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
Message-ID: <20211223114958.GA30243@lpieralisi>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-9-git-send-email-hongxing.zhu@nxp.com>
 <Ybtuo0CzfUhoJwsT@rocinante>
 <AS8PR04MB8676F7F8BBE79E36D3EAFB6B8C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676F7F8BBE79E36D3EAFB6B8C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:54:21AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Krzysztof Wilczyński <kw@linux.com>
> > Sent: Friday, December 17, 2021 12:52 AM
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com; Marcel Ziswiler
> > <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> > kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> > galak@kernel.crashing.org; shawnguo@kernel.org;
> > linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
> > 
> > Hi Richard,
> > 
> > Apologies for a very late review!  Especially since Lorenzo already took
> > patches as per:
> > 
> > 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
> > e.kernel.org%2Flinux-pci%2F163965080404.20006.52416095516435017
> > 49.b4-ty%40arm.com%2F&amp;data=04%7C01%7Chongxing.zhu%40nxp
> > .com%7C8afb673348214261883608d9c0b45b1d%7C686ea1d3bc2b4c6fa
> > 92cd99c5c301635%7C0%7C0%7C637752703124166805%7CUnknown%7
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=rfmN1Xojubap2vi3J4Jol3ozy
> > N1Q2q7YiBM5bqMm22s%3D&amp;reserved=0
> > 
> > However, perhaps it's not too late.
> [Richard Zhu] Hi Krzysztof: 
> Thanks for your review.
> But I don't know how to handle this situation.
> How about that I add this refine patch into the following bug fix and
>  refine patch-set later?
> PCI: imx6: refine codes and add compliance tests mode support
> " https://patchwork.kernel.org/project/linux-arm-kernel/cover/1635747478-25562-1-git-send-email-hongxing.zhu@nxp.com/"
> 
> > 
> > [...]
> > > @@ -446,6 +452,13 @@ static int imx6_pcie_enable_ref_clk(struct
> > imx6_pcie *imx6_pcie)
> > >  		break;
> > >  	case IMX7D:
> > >  		break;
> > > +	case IMX8MM:
> > > +		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > > +		if (ret) {
> > > +			dev_err(dev, "unable to enable pcie_aux clock\n");
> > > +			break;
> > > +		}
> > > +		break;
> > 
> > You can drop the inner break, it wouldn't do much here, unless this was
> > intended to be a return?
> [Richard Zhu] Yes, it is. The inner break can be dropped. The error return
> would be handled in the end.
> 
> > 
> > > @@ -538,6 +559,10 @@ static void
> > imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> > >  	case IMX8MQ:
> > >  		reset_control_deassert(imx6_pcie->pciephy_reset);
> > >  		break;
> > > +	case IMX8MM:
> > > +		if (phy_init(imx6_pcie->phy) != 0)
> > > +			dev_err(dev, "Waiting for PHY ready timeout!\n");
> > > +		break;
> > 
> > If the above, you can keep the same style as used throughout the file
> > already, so it would just simply be:
> > 
> >   if (phy_init(imx6_pcie->phy))
> > 
> > Also, a nitpick: to be consistent with other such messages here, the error
> > message would be all lower-case letters.
> [Richard Zhu] Yes, it is.
> > 
> > [...]
> > > @@ -614,6 +639,8 @@ static void imx6_pcie_configure_type(struct
> > > imx6_pcie *imx6_pcie)  static void imx6_pcie_init_phy(struct
> > imx6_pcie
> > > *imx6_pcie)  {
> > >  	switch (imx6_pcie->drvdata->variant) {
> > > +	case IMX8MM:
> > > +		break;
> > >  	case IMX8MQ:
> > 
> > Would it warrant a comment that adds a note there to this single bare
> > break?  Perhaps this version is not support, lack this particular
> > functionality, etc.
> [Richard Zhu] Yes, it's easier to understand after add one comment.
> > 
> > [...]
> > > @@ -1089,10 +1122,39 @@ static int imx6_pcie_probe(struct
> > platform_device *pdev)
> > >  			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> > >  			return PTR_ERR(imx6_pcie->apps_reset);
> > >  		}
> > > +		break;
> > > +	case IMX8MM:
> > > +		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > > +		if (IS_ERR(imx6_pcie->pcie_aux))
> > > +			return dev_err_probe(dev,
> > PTR_ERR(imx6_pcie->pcie_aux),
> > > +					     "pcie_aux clock source missing or
> > invalid\n");
> > > +		imx6_pcie->apps_reset =
> > devm_reset_control_get_exclusive(dev,
> > > +									 "apps");
> > > +		if (IS_ERR(imx6_pcie->apps_reset)) {
> > > +			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> > > +			return PTR_ERR(imx6_pcie->apps_reset);
> > > +		}
> > > +
> > > +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > > +		if (IS_ERR(imx6_pcie->phy)) {
> > > +			if (PTR_ERR(imx6_pcie->phy) == -EPROBE_DEFER)
> > > +				return -EPROBE_DEFER;
> > > +			dev_err(dev, "Failed to get PCIE PHY\n");
> > > +			return PTR_ERR(imx6_pcie->phy);
> > > +		}
> > 
> > A question about handling of the -EPROBE_DEFER above: why not to use
> > the
> > dev_err_probe() helper similarly to the code above and below?  Would
> > there be something different preventing the use of dev_err_probe() here
> > too?
> [Richard Zhu] To be aligned, the above one can be replaced totally.
> I didn't want to dump the error message when -EPROBE_DEFFER occurs.
> Anyway, I can make them aligned later.

Can you send me an update for this patch only so that I can update
the corresponding commit according to this review please ?

Thanks,
Lorenzo

> Best Regards
> Richard
> 
> > 
> > >  		break;
> > >  	default:
> > >  		break;
> > >  	}
> > > +	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> > > +	if (imx6_pcie->phy == NULL) {
> > > +		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> > > +		if (IS_ERR(imx6_pcie->pcie_phy))
> > > +			return dev_err_probe(dev,
> > PTR_ERR(imx6_pcie->pcie_phy),
> > > +					     "pcie_phy clock source missing or
> > invalid\n");
> > > +	}
> > 
> > Thank you for another amazing patch!
> > 
> > 	Krzysztof
