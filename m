Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE97468EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhLFCJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhLFCJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:09:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66178C061751;
        Sun,  5 Dec 2021 18:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB23860FE2;
        Mon,  6 Dec 2021 02:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7336C00446;
        Mon,  6 Dec 2021 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638756349;
        bh=jYNEke2yNaj7kP0D636Xh+m70cSQm3OE66MK3rE+1uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUqfVqThFiStueV6SxKWGbfwem+jjQpxZ8n5rUnVprHizRFO1l43cQqPBnepzW5gk
         8kUrg7FcAViXh4tjUGuzL+0IwLWzwjVeHvewmFAWZKLZN5voGL5Y67Uds+vBjasBq4
         rM7+Z+iQBljk8rEh90/LO/deWBXaS5NkHMeg/WSoBaGBpys4nqGKT3XFyYYQj8yTc/
         HB+RwI037vC9+Pd/a0s/AmCPN6+pzmjRS3G1IY2Ntnrin5lvk5Y5k0UnddVIPD9OTS
         Ne8f6PMIv5LX7YCUs0wBFjzdX92nJkSE17HXCG/HIA7zabqCJJKXiOamLLsuBNije/
         JbKtSXeUBPzPw==
Date:   Mon, 6 Dec 2021 10:05:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Message-ID: <20211206020542.GS4216@dragon>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
 <20211123080506.21424-5-qiangqing.zhang@nxp.com>
 <20211206011531.GM4216@dragon>
 <DB8PR04MB6795F657BDD2962D032F567BE66D9@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB8PR04MB6795F657BDD2962D032F567BE66D9@DB8PR04MB6795.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 01:59:18AM +0000, Joakim Zhang wrote:
> 
> Hi Shawn,
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: 2021年12月6日 9:16
> > To: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Cc: robh+dt@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO
> > voltage
> > 
> > On Tue, Nov 23, 2021 at 04:05:03PM +0800, Joakim Zhang wrote:
> > > As commit 2f664823a470 ("net: phy: at803x: add device tree binding")
> > > described, configure FEC PHY VDDIO voltage according to board design.
> > >
> > > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 6 ++++++
> > > arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 6 ++++++
> > > arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 4 ++++
> > >  3 files changed, 16 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > index 50b3bbb662d5..3bac87b7e142 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > @@ -117,6 +117,12 @@
> > >  			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> > >  			reset-assert-us = <10000>;
> > >  			qca,disable-smarteee;
> > > +			vddio-supply = <&vddio>;
> > > +
> > > +			vddio: vddio-regulator {
> > > +				regulator-min-microvolt = <1800000>;
> > > +				regulator-max-microvolt = <1800000>;
> > > +			};
> > >  		};
> > >  	};
> > >  };
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > > index 342f57e8cf61..c3f15192b76c 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > > @@ -100,6 +100,12 @@
> > >  			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> > >  			reset-assert-us = <10000>;
> > >  			qca,disable-smarteee;
> > > +			vddio-supply = <&vddio>;
> > > +
> > > +			vddio: vddio-regulator {
> > > +				regulator-min-microvolt = <1800000>;
> > > +				regulator-max-microvolt = <1800000>;
> > > +			};
> > >  		};
> > >  	};
> > >  };
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > index a9e33548a2f3..c96d23fe3010 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > @@ -170,6 +170,10 @@
> > >  			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> > >  			reset-assert-us = <10000>;
> > >  			qca,disable-smarteee;
> > > +			vddio-supply = <&vddh>;
> > > +
> > > +			vddh: vddh-regulator {
> > > +			};
> > 
> > Why does this need to be different from the one on imx8mm-evk and
> > imx8mn-evk?
> 
> It's depend on RGMII_IO voltage out from SoC and PHY reference design.
> 
> For 8MM/MN:
> 	SoC RGMII_IO is 1.8V, and board design use "Reference Design, 1.5/1.8 V RGMII I/O", PHY default work on 1.5V, so we need configure PHY to work on 1.8V.
> For 8MQ:
> 	SoC RGMII_IO is 2.5V, and board design use "Reference Design, 2.5 V/ 3.3 V RGMII I/O", PHY default work on 2.5V.

Hmm, why do you not specify 2.5V with regulator-min[max]-microvolt then?
Also, why is the regulator named vddh instead of vddio?

Shawn

> 
> Best Regards,
> Joakim Zhang
> > Shawn
> > 
> > >  		};
> > >  	};
> > >  };
> > > --
> > > 2.17.1
> > >
