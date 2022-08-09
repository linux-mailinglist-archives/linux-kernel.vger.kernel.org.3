Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A458DB61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbiHIPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiHIPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:52:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0F175A2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660060350; x=1691596350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqkjv7X49zyKahKBsy/Af1XfeH6iBppELh4Mlt5gIXo=;
  b=PkyVmkOB1AuOagU7NPOXmIWB4O2vjISwjR2QQRyEiHMUUEQsXr+sgDdc
   5n3qa0T5l0FzMHZkfA7PIfIIquOd8ldULDDq6ETIMWS7FXFbEqOw5OKvZ
   wgPaPmDY7OdcUu6Efo6zp1J+8Ds69i2enUmFzKtyU41P35j/9tkJW0zP8
   3/zxtAmC3mgZq3Bd6As5UDyqlrhGLIJGEjQ9uk1J4cAQ4Jj9PuPW6qc1i
   bIfV7/6Jj6KmfLsSNXVOWn7NkvztU+7XV2S+zw1yFxfp2AW66grVYQ5xT
   jxuhYiZyv6b1BbSH+qlUGkRD4qswDPqY8vBtKaZxW2HGms+PIzAjEaJwE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="277804944"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="277804944"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 08:50:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="664484569"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 08:50:31 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Aug 2022 18:50:28 +0300
Date:   Tue, 9 Aug 2022 18:50:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvKCRPtoN6m2rMr2@lahna>
References: <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
 <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
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

On Tue, Aug 09, 2022 at 11:16:27PM +0800, Brad Campbell wrote:
> If I then reboot and load the driver it fails.
> 
> The only thing I could think of doing was an lspci -vvv after the boot and module load
> and an lspci -vvv after a warm reboot and diff them, because there are changes around the
> thunderbolt bridge devices. I've done a diff -u50 to try and keep as much context as possible.
> 
> On the first boot I can unload/reload the thunderbolt module repeatedly and there's no issue
> but loading it after a reboot locks up. There are no lspci changes on the first boot after the
> initial module load unless I rescan the PCI bus, but they're minor and it doesn't cause an issue
> with loading the thunderbolt module.
> 
> The firmware *must* be doing something on reboot I suppose or the PCIe configs wouldn't change.

Okay, let's try a bigger hammer and reset all the ports upon load. That
should hopefully clear out the "bad state" too. This is completely
untested but it should trigger reset and then re-initialize the TBT
links.

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index 633970fbe9b0..c419c2568de4 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -6,6 +6,8 @@
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/delay.h>
+
 #include "tb.h"
 
 /**
@@ -327,6 +329,34 @@ void tb_lc_xhci_disconnect(struct tb_port *port)
 	tb_port_dbg(port, "xHCI disconnected\n");
 }
 
+int tb_lc_reset_port(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+	int cap, ret;
+	u32 val;
+
+	if (sw->generation != 3)
+		return -EINVAL;
+
+	cap = find_port_lc_cap(port);
+	if (cap < 0)
+		return cap;
+
+	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	val |= TB_LC_PORT_MODE_DPR;
+	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	msleep(20);
+
+	val &= ~TB_LC_PORT_MODE_DPR;
+	return tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+}
+
 static int tb_lc_set_wake_one(struct tb_switch *sw, unsigned int offset,
 			      unsigned int flags)
 {
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 0ae8a7ec7c9c..21ac3ccf1cf9 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -740,6 +740,11 @@ int tb_port_disable(struct tb_port *port)
 	return __tb_port_enable(port, false);
 }
 
+int tb_port_reset(struct tb_port *port)
+{
+	return tb_lc_reset_port(port);
+}
+
 /*
  * tb_init_port() - initialize a port
  *
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 8030fc544c5e..48a7396994ef 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1875,6 +1875,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
 static int tb_start(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_port *p;
 	int ret;
 
 	tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
@@ -1911,6 +1912,12 @@ static int tb_start(struct tb *tb)
 				false);
 	/* Enable TMU if it is off */
 	tb_switch_tmu_enable(tb->root_switch);
+
+	tb_switch_for_each_port(tb->root_switch, p) {
+		if (tb_port_is_null(p))
+			tb_port_reset(p);
+	}
+
 	/* Full scan to discover devices added before the driver was loaded. */
 	tb_scan_switch(tb->root_switch);
 	/* Find out tunnels created by the boot firmware */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 28bb80d967d6..fe5edefec712 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1028,6 +1028,7 @@ int tb_port_clear_counter(struct tb_port *port, int counter);
 int tb_port_unlock(struct tb_port *port);
 int tb_port_enable(struct tb_port *port);
 int tb_port_disable(struct tb_port *port);
+int tb_port_reset(struct tb_port *port);
 int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_in_hopid(struct tb_port *port, int hopid);
 int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
@@ -1121,6 +1122,7 @@ bool tb_lc_is_usb_plugged(struct tb_port *port);
 bool tb_lc_is_xhci_connected(struct tb_port *port);
 int tb_lc_xhci_connect(struct tb_port *port);
 void tb_lc_xhci_disconnect(struct tb_port *port);
+int tb_lc_reset_port(struct tb_port *port);
 int tb_lc_set_wake(struct tb_switch *sw, unsigned int flags);
 int tb_lc_set_sleep(struct tb_switch *sw);
 bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index f8c1ca3464d9..8fd12bc2d500 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -555,6 +555,9 @@ struct tb_regs_hop {
 #define TB_LC_POWER				0x740
 
 /* Link controller registers */
+#define TB_LC_PORT_MODE				0x26
+#define TB_LC_PORT_MODE_DPR			BIT(6)
+
 #define TB_LC_CS_42				0x2a
 #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
 
