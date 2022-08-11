Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8C58FA44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiHKJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiHKJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:50:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC1BBD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660211413; x=1691747413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ofy+K1zpY8NXY6GiPW67q6uAvp+9L1Ki/icb2bX70DY=;
  b=O9Q0UD+PDSFNNpfataj4jwoEd9n++JF7GQ43nXbAIje3Psr6CKaPaHYm
   0xjIbMkZqqSfKVkyP4//2L1rzgeKHR8FdM8idInP5uL+APpXVpsGJq0Kk
   0qKZ9OmcOHebxQf/P1daCNf8lJf2KypH1xVtPabhixCSTPwU6moIqh8jL
   tSGYy9Ln5WKBWdEcyySPfKEm4kJa/RU7JOs3l8M8ySYkpWH6u0+XFuprf
   mN/W9O97faQO6RDjmsPH7GSib5ZGbXAAUqU/AAV19CW01XLj164f3b0u+
   GnyXQtE+/iCA2hONwQ0ExL0YLOdu8/s5jRdFLVYIrUiXvfpktwm/+/a5f
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="278253074"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="278253074"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 02:50:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="608871369"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 02:50:10 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Aug 2022 12:50:08 +0300
Date:   Thu, 11 Aug 2022 12:50:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvTQ0N2Py4rc4k3Z@lahna>
References: <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
 <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
 <YvKCRPtoN6m2rMr2@lahna>
 <2c4420ac-d988-9dd8-c223-4243b9a6881e@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4420ac-d988-9dd8-c223-4243b9a6881e@fnarfbargle.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 10, 2022 at 03:40:08PM +0800, Brad Campbell wrote:
> G'day Mika,
> 
> On 9/8/22 23:50, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Aug 09, 2022 at 11:16:27PM +0800, Brad Campbell wrote:
> > > If I then reboot and load the driver it fails.
> > > 
> > > The only thing I could think of doing was an lspci -vvv after the boot and module load
> > > and an lspci -vvv after a warm reboot and diff them, because there are changes around the
> > > thunderbolt bridge devices. I've done a diff -u50 to try and keep as much context as possible.
> > > 
> > > On the first boot I can unload/reload the thunderbolt module repeatedly and there's no issue
> > > but loading it after a reboot locks up. There are no lspci changes on the first boot after the
> > > initial module load unless I rescan the PCI bus, but they're minor and it doesn't cause an issue
> > > with loading the thunderbolt module.
> > > 
> > > The firmware *must* be doing something on reboot I suppose or the PCIe configs wouldn't change.
> > 
> > Okay, let's try a bigger hammer and reset all the ports upon load. That
> > should hopefully clear out the "bad state" too. This is completely
> > untested but it should trigger reset and then re-initialize the TBT
> > links.
> > 
> > diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
> > index 633970fbe9b0..c419c2568de4 100644
> > --- a/drivers/thunderbolt/lc.c
> > +++ b/drivers/thunderbolt/lc.c
> > @@ -6,6 +6,8 @@
> >    * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> >    */
> > +#include <linux/delay.h>
> > +
> >   #include "tb.h"
> >   /**
> > @@ -327,6 +329,34 @@ void tb_lc_xhci_disconnect(struct tb_port *port)
> >   	tb_port_dbg(port, "xHCI disconnected\n");
> >   }
> > +int tb_lc_reset_port(struct tb_port *port)
> > +{
> > +	struct tb_switch *sw = port->sw;
> > +	int cap, ret;
> > +	u32 val;
> > +
> > +	if (sw->generation != 3)
> > +		return -EINVAL;
> > +
> > +	cap = find_port_lc_cap(port);
> > +	if (cap < 0)
> > +		return cap;
> > +
> > +	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val |= TB_LC_PORT_MODE_DPR;
> > +	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msleep(20);
> > +
> > +	val &= ~TB_LC_PORT_MODE_DPR;
> > +	return tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> > +}
> > +
> >   static int tb_lc_set_wake_one(struct tb_switch *sw, unsigned int offset,
> >   			      unsigned int flags)
> >   {
> > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > index 0ae8a7ec7c9c..21ac3ccf1cf9 100644
> > --- a/drivers/thunderbolt/switch.c
> > +++ b/drivers/thunderbolt/switch.c
> > @@ -740,6 +740,11 @@ int tb_port_disable(struct tb_port *port)
> >   	return __tb_port_enable(port, false);
> >   }
> > +int tb_port_reset(struct tb_port *port)
> > +{
> > +	return tb_lc_reset_port(port);
> > +}
> > +
> >   /*
> >    * tb_init_port() - initialize a port
> >    *
> > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > index 8030fc544c5e..48a7396994ef 100644
> > --- a/drivers/thunderbolt/tb.c
> > +++ b/drivers/thunderbolt/tb.c
> > @@ -1875,6 +1875,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
> >   static int tb_start(struct tb *tb)
> >   {
> >   	struct tb_cm *tcm = tb_priv(tb);
> > +	struct tb_port *p;
> >   	int ret;
> >   	tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
> > @@ -1911,6 +1912,12 @@ static int tb_start(struct tb *tb)
> >   				false);
> >   	/* Enable TMU if it is off */
> >   	tb_switch_tmu_enable(tb->root_switch);
> > +
> > +	tb_switch_for_each_port(tb->root_switch, p) {
> > +		if (tb_port_is_null(p))
> > +			tb_port_reset(p);
> > +	}
> > +
> >   	/* Full scan to discover devices added before the driver was loaded. */
> >   	tb_scan_switch(tb->root_switch);
> >   	/* Find out tunnels created by the boot firmware */
> > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > index 28bb80d967d6..fe5edefec712 100644
> > --- a/drivers/thunderbolt/tb.h
> > +++ b/drivers/thunderbolt/tb.h
> > @@ -1028,6 +1028,7 @@ int tb_port_clear_counter(struct tb_port *port, int counter);
> >   int tb_port_unlock(struct tb_port *port);
> >   int tb_port_enable(struct tb_port *port);
> >   int tb_port_disable(struct tb_port *port);
> > +int tb_port_reset(struct tb_port *port);
> >   int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
> >   void tb_port_release_in_hopid(struct tb_port *port, int hopid);
> >   int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
> > @@ -1121,6 +1122,7 @@ bool tb_lc_is_usb_plugged(struct tb_port *port);
> >   bool tb_lc_is_xhci_connected(struct tb_port *port);
> >   int tb_lc_xhci_connect(struct tb_port *port);
> >   void tb_lc_xhci_disconnect(struct tb_port *port);
> > +int tb_lc_reset_port(struct tb_port *port);
> >   int tb_lc_set_wake(struct tb_switch *sw, unsigned int flags);
> >   int tb_lc_set_sleep(struct tb_switch *sw);
> >   bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
> > diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> > index f8c1ca3464d9..8fd12bc2d500 100644
> > --- a/drivers/thunderbolt/tb_regs.h
> > +++ b/drivers/thunderbolt/tb_regs.h
> > @@ -555,6 +555,9 @@ struct tb_regs_hop {
> >   #define TB_LC_POWER				0x740
> >   /* Link controller registers */
> > +#define TB_LC_PORT_MODE				0x26
> > +#define TB_LC_PORT_MODE_DPR			BIT(6)
> > +
> >   #define TB_LC_CS_42				0x2a
> >   #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
> > 
> 
> Yep, that certainly solves the lockup/reboot issues and all PCIe devices are
> discovered and appear to work. I can reboot repeatedly and that seems to be ok.
> 
> It causes some peculiarity in the DP tunnel however where one or both will fail to come up
> leaving this in dmesg (in this instance both failed) :
> 
> [   10.550439] [drm] Adding stream 00000000a5b9bb95 to context failed with err 28!
> [   10.551032] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22
> [   11.180398] [drm] Adding stream 00000000a5b9bb95 to context failed with err 28!
> [   11.180830] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22
> 
> Oddly enough X thinks the displays are there and is pretending to display on them, but they
> remain black. This can be one, the other or both depending on the boot.
> 
> I have probably cold/warm booted 50 times now with varying combinations of activation to attempt
> to pin some form of determinism on this behaviour, but I've got nothing at this point.

Okay, do you see in the dmesg whether the DP tunnels are actually
created when you see the issue?
