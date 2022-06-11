Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCB5475C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiFKOso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiFKOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:48:41 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051F22B14;
        Sat, 11 Jun 2022 07:48:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AE55E20003;
        Sat, 11 Jun 2022 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654958918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8VR4ymqkJ5K3C4CihtuWX5UmLAF7ogIHNe6DBY0KA0=;
        b=BL/jeWKrSHxkcIKpUp2Vg+dVcMhHN5ckuWf415X7yA3gTo/5vUJpz3kQuA8qk7YbJz0mjF
        QMBdcBNrtM9lNgf6aE6nMXNxk0XlKyyxBAYQcd0UNeQMQSrDRbWlm7JTByoaUs++wTtNdj
        s1BG16xDGduS2MzfHCABnguNOmYkMtKrruCP/woalx5hjKL6WhC6a3qdN5OwRRRl+5Rh7y
        wMR6egEXS2RQGhAr+3AkKwxaJNSCVgVt+zjFjJ8R7D3UNfTZMCclVIvphFwLJYTgnOsHGX
        KRUwRFWIiFgG6muyNySalKcWhYzJTYlmHBkZNpJT0Ribgai2PP3I8FIZA07UHQ==
Date:   Sat, 11 Jun 2022 16:48:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        "shubhraj@xilinx.com" <shubhraj@xilinx.com>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: Re: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
Message-ID: <YqShO5B+pMbIB7CH@mail.local>
References: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
 <20220610113709.2646118-3-srinivas.neeli@xilinx.com>
 <YqMzK50DbPAm1+dl@mail.local>
 <BY5PR12MB4033DC535FF8B1230D5E860493A69@BY5PR12MB4033.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4033DC535FF8B1230D5E860493A69@BY5PR12MB4033.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 15:04:31+0000, Neeli, Srinivas wrote:
> [AMD Official Use Only - General]
> 
> Hi,
> 
> > -----Original Message-----
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Sent: Friday, June 10, 2022 5:34 PM
> > To: Srinivas Neeli <srinivas.neeli@xilinx.com>
> > Cc: a.zummo@towertech.it; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com;
> > sgoud@xilinx.com; shubhraj@xilinx.com; Neeli, Srinivas
> > <srinivas.neeli@amd.com>; neelisrinivas18@gmail.com;
> > devicetree@vger.kernel.org; linux-rtc@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git@xilinx.com
> > Subject: Re: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
> >
> > On 10/06/2022 17:07:09+0530, Srinivas Neeli wrote:
> > > As per RTC spec default calibration value is 0x7FFF.
> > >
> >
> > Having that as a second patch breaks the calculation in your previous patch,
> > really, this should just be a single patch.
> 
> Can I swap 3/3 and 2/3, Will that be fine ?.

That would be better, yes

> 
> >
> > > Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> > > ---
> > > Changes in V7:
> > > -New patch
> > > -TRM not updated yet, Internal design document contains 0x7FFF as
> > > default value. TRM Will update in next release.
> > > ---
> > >  drivers/rtc/rtc-zynqmp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c index
> > > 39b23f88ee26..1dd389b891fe 100644
> > > --- a/drivers/rtc/rtc-zynqmp.c
> > > +++ b/drivers/rtc/rtc-zynqmp.c
> > > @@ -37,7 +37,7 @@
> > >  #define RTC_OSC_EN         BIT(24)
> > >  #define RTC_BATT_EN                BIT(31)
> > >
> > > -#define RTC_CALIB_DEF              0x198233
> > > +#define RTC_CALIB_DEF              0x7FFF
> > >  #define RTC_CALIB_MASK             0x1FFFFF
> > >  #define RTC_ALRM_MASK          BIT(1)
> > >  #define RTC_MSEC               1000
> > > --
> > > 2.25.1
> > >
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
