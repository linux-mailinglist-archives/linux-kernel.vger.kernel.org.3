Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40A4A5599
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiBADYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:24:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37513 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233010AbiBADYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:24:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D35065C0130;
        Mon, 31 Jan 2022 22:24:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 31 Jan 2022 22:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=fGPVCA0gXY8m3VZ3g5/TKTWe7QXMkJ
        WQJ5IgFoCKMZw=; b=TyReY45E93Wi6xPFaCZGVcpE7bIzfe6VFLxeZSHYEJ+t+Y
        DYv1Iv3EIk3jkDs9pjEpND8QCTe+4RRCE2jHR21fcSQfu+j+sZvEYKqlMyzUJG3J
        8Cgzew4OVc1eVBKLlSiQu49NoYzPSd3K0d1Kqth3f//QHwHEUbvuwzxwJsocySwc
        dsBPFCuHBPUT2wnZm2+1M13cN4Q8G8GEGjKZW84a58TLpekMZi4mADOY/tP9+Yx1
        7/nzs412sHMpQYzFAyxh+N7I0yCE3X+iE7Q6g224NQUFDRLBJhaW7uhmzCyxXbci
        SUNExr9m2ZFP+uZcM5X99uAT7QgKI+D4RPbyOU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fGPVCA
        0gXY8m3VZ3g5/TKTWe7QXMkJWQJ5IgFoCKMZw=; b=PWmuCLk4pWaR2d6dPxYydc
        AdrJ35AMOzFazTiGxnb5rylJI2d2b9dODXksvBcjBAvgXISfBs0x9isrdf2E97Fa
        9UgaGIVlJKOskvrXBMR4FFgEHBcrezJ8LRffYpadLE53LcyWq/l2nnNICnqi6EiM
        F9nRpybQOGueZoLFCefIj0FuMYlNDtYvk+wmG+m970imMXi+SRWlg6KH3DBcKO2R
        1oykNRc2tk+aQJIcEMEFRipp7sIgSK0hTXPS7P6G1lVR4FlSvZr2Xu6yO8GGQESl
        VijSroL2LvPk6b845+s2DFwL9lWiODj4WTXmL9pg3fTzoxKnRykgF5sRGcSPP9Aw
        ==
X-ME-Sender: <xms:_af4YZqw7XW3tokXC7jiJ7luRl_qiTq_d_SGse8rqz4OoW3Sf48-xA>
    <xme:_af4YbqpzGSDFwHKSxEbmVP9OI2WKFzAO1JA0hQKWFaDbT2Hj0qePxPtIeZzFVI2t
    vjctp-0-mTak8n3hg>
X-ME-Received: <xmr:_af4YWO4eYYvuehuxWWJnhKLl2Z5W5OmwgQMFKRy4IknwHjU9nCyGt03xbZNAo-F6zYxjTTBgv49__hRAWnsONda0LY1oGdB7unFI30c-jWlM8QO9ADkmjK1SQwOWUsAD6txJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgedvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_af4YU7go7f6R3c92gYgzKhZ-sgSEqqV2NWnmL5Jz5vIdZNUP_uzhA>
    <xmx:_af4YY5ZeBTdWFU7v95NCI8d6wvZEJIQP4xqwvO7rsgBLutC1AfbxA>
    <xmx:_af4YchRggt3s5U6B1LmiLAOWcy7uow6_Z7iOfD8J1-EBvWR0nvugA>
    <xmx:_af4YVtw8D0_y-pcDJWu7ccK-TFVEU3XdZUlDshqos1YAbD2BHC32A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jan 2022 22:24:45 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/4] usb: typec: Factor out non-PD fwnode properties
Date:   Mon, 31 Jan 2022 21:24:39 -0600
Message-Id: <20220201032440.5196-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201032440.5196-1-samuel@sholland.org>
References: <20220201032440.5196-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic programmable non-PD Type-C port controllers do not need the full
TCPM library, but they share the same devicetree binding and the same
typec_capability structure. Factor out a helper for parsing those
properties which map to fields in struct typec_capability, so the code
can be shared between TCPM and basic non-TCPM drivers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/usb/typec/class.c     | 49 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c | 32 +----------------------
 include/linux/usb/typec.h     |  3 +++
 3 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb..8863d2e93d50 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1894,6 +1894,55 @@ void *typec_get_drvdata(struct typec_port *port)
 }
 EXPORT_SYMBOL_GPL(typec_get_drvdata);
 
+int typec_get_fw_cap(struct typec_capability *cap,
+		     struct fwnode_handle *fwnode)
+{
+	const char *cap_str;
+	int ret;
+
+	/*
+	 * This fwnode has a "compatible" property, but is never populated as a
+	 * struct device. Instead we simply parse it to read the properties.
+	 * This it breaks fw_devlink=on. To maintain backward compatibility
+	 * with existing DT files, we work around this by deleting any
+	 * fwnode_links to/from this fwnode.
+	 */
+	fw_devlink_purge_absent_suppliers(fwnode);
+
+	cap->fwnode = fwnode;
+
+	ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
+	if (ret < 0)
+		return ret;
+
+	cap->type = typec_find_port_power_role(cap_str);
+	if (cap->type < 0)
+		return cap->type;
+
+	/* USB data support is optional */
+	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
+	if (ret == 0) {
+		cap->data = typec_find_port_data_role(cap_str);
+		if (cap->data < 0)
+			return cap->data;
+	}
+
+	/* Get the preferred power role for a DRP */
+	if (cap->type == TYPEC_PORT_DRP) {
+		cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+		ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
+		if (ret == 0) {
+			cap->prefer_role = typec_find_power_role(cap_str);
+			if (cap->prefer_role < 0)
+				return cap->prefer_role;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_get_fw_cap);
+
 /**
  * typec_port_register_altmode - Register USB Type-C Port Alternate Mode
  * @port: USB Type-C Port that supports the alternate mode
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5fce795b69c7..8b58aa6e3509 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5935,32 +5935,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	if (!fwnode)
 		return -EINVAL;
 
-	/*
-	 * This fwnode has a "compatible" property, but is never populated as a
-	 * struct device. Instead we simply parse it to read the properties.
-	 * This it breaks fw_devlink=on. To maintain backward compatibility
-	 * with existing DT files, we work around this by deleting any
-	 * fwnode_links to/from this fwnode.
-	 */
-	fw_devlink_purge_absent_suppliers(fwnode);
-
-	/* USB data support is optional */
-	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
-	if (ret == 0) {
-		ret = typec_find_port_data_role(cap_str);
-		if (ret < 0)
-			return ret;
-		port->typec_caps.data = ret;
-	}
-
-	ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
+	ret = typec_get_fw_cap(&port->typec_caps, fwnode);
 	if (ret < 0)
 		return ret;
 
-	ret = typec_find_port_power_role(cap_str);
-	if (ret < 0)
-		return ret;
-	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
 	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-disable");
 
@@ -5997,14 +5975,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	if (port->port_type == TYPEC_PORT_SRC)
 		return 0;
 
-	/* Get the preferred power role for DRP */
-	ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
-	if (ret < 0)
-		return ret;
-
-	port->typec_caps.prefer_role = typec_find_power_role(cap_str);
-	if (port->typec_caps.prefer_role < 0)
-		return -EINVAL;
 sink:
 	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
 
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 7ba45a97eeae..fdf737d48b3b 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -295,6 +295,9 @@ int typec_set_mode(struct typec_port *port, int mode);
 
 void *typec_get_drvdata(struct typec_port *port);
 
+int typec_get_fw_cap(struct typec_capability *cap,
+		     struct fwnode_handle *fwnode);
+
 int typec_find_pwr_opmode(const char *name);
 int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
-- 
2.33.1

