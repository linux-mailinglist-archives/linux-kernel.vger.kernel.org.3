Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273574A7AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbiBBWUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:20:00 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43751 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347867AbiBBWTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:19:54 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 10B595C01A6;
        Wed,  2 Feb 2022 17:19:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 17:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=Xs1zDsbUVkBNQ8Xqh/xz1yx3FBHqCo
        kCJ3va+NN7ckQ=; b=JwLzvK5cZudUshAmPboWiDnMv8zVTqxOiKI4uu6vJnHHLJ
        N+tHjg5Kp1RFzJRyFukkm38nSi0FjqBpjyCwraaOfExHDHlCG8ZuIcUQC4wE86DZ
        DMIZeXzoU3ZhMQQgEBZ43mC8GYO3m2Pf75BMu5Binybc7PH7Z1GpfmhM2MA8rYfo
        4CRn+ZUJwk1ewTdbbJJbqhcdPz+bbyk1dtuM8II2/qAx4l8Da3CEc/hpg4JsIMea
        iH/h2Q2wYWrNKIJMqqqSVu9ihQPztLYwf/Ckq1L5xiUZEt59V5BD3ONu98knRJRK
        mslqmMzK1IWx1Rs9RbOpC9mqUc7cqsFFVl/s8qyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Xs1zDs
        bUVkBNQ8Xqh/xz1yx3FBHqCokCJ3va+NN7ckQ=; b=Zy/8/TFcqiKfzftZjgo+Fk
        XZXMU5OogJYjy683rmMfbOLcNdQbstBVoQmX0NnL0ihgqTsy+08eNll6GHxEbA/V
        UBwvy6LoXfvc7LXXz15qwO7RcUouRKeRZ5yuwyFfRsfbbfLew0TonSFmAS/J1yz1
        rPdd4M4DSoukLivcWwajmIZ+8tXx0VfFUXYzQn9WCbVscPJRV5BVAebOLHC5dFvM
        SU3c6hm1tDMatzllzZyE/K9UAdvGjFAkJNFG1Wi/h0AuFg1TeikVpxMS97m4ngQK
        pNQn1LIoy6S6sfuiC5Q9N8C1su7Mghv4cWDalUmn60IryJv18fXc9n3RTyUP/I2Q
        ==
X-ME-Sender: <xms:iQP7YUleOav39_57f6eQ-OIS40Exf4jUStBzrLEHFMVo_lrl5eIJDQ>
    <xme:iQP7YT3XZPOjbYEVtT-BOn1PAJPewMkUaTZ-is6Zukt_1MVI8nHgTpSJ81-W0Tp1b
    tb_7kh0tz9Cm-PDEA>
X-ME-Received: <xmr:iQP7YSrL7ISxSG1cxIu99a9qfQ3CGgvWZM2S5MMz_GQeqAhtOdaseL_ZxycE4P4w7hXDZ0DuPo49r5toghRAgvujh69Jvca32dDoFC0ryN5duwUlDruNmDrvHhtS4gKTCJvXiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:igP7YQmp9VIGSH_uPpNfyW9rIQ9ilp5UdoP5Fp5usXxD_5FRnX5xVw>
    <xmx:igP7YS3TBudgthGDUfYkt2XMQ8ZU2N2gx19gEc8CSCHpyLEj9TOgAQ>
    <xmx:igP7YXv0BLROivFfp-LotY_QR9Z8Ev5ZZ64V03OM4UVgqCmwsP2SMA>
    <xmx:igP7YcrnzrD7V6VpAsfBq9LJIzyNLthEdwQ3ZKDu26d04pkSaWlDYQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 17:19:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/4] usb: typec: Factor out non-PD fwnode properties
Date:   Wed,  2 Feb 2022 16:19:46 -0600
Message-Id: <20220202221948.5690-4-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220202221948.5690-1-samuel@sholland.org>
References: <20220202221948.5690-1-samuel@sholland.org>
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

Changes in v2:
 - Always put the return values from typec_find_* in a signed variable
   for error checking.

 drivers/usb/typec/class.c     | 52 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c | 32 +--------------------
 include/linux/usb/typec.h     |  3 ++
 3 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb..b67ba9478c82 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1894,6 +1894,58 @@ void *typec_get_drvdata(struct typec_port *port)
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
+	ret = typec_find_port_power_role(cap_str);
+	if (ret < 0)
+		return ret;
+	cap->type = ret;
+
+	/* USB data support is optional */
+	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
+	if (ret == 0) {
+		ret = typec_find_port_data_role(cap_str);
+		if (ret < 0)
+			return ret;
+		cap->data = ret;
+	}
+
+	/* Get the preferred power role for a DRP */
+	if (cap->type == TYPEC_PORT_DRP) {
+		cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+		ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
+		if (ret == 0) {
+			ret = typec_find_power_role(cap_str);
+			if (ret < 0)
+				return ret;
+			cap->prefer_role = ret;
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

