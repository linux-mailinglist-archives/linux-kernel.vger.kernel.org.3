Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955B04B410E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiBNFBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:01:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiBNFBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:01:38 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53851E6B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:01:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 320E3320024A;
        Mon, 14 Feb 2022 00:01:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 00:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=dU8UWEWsFE7FhtMSk7XoqjsqtGAURy
        8zRWRk2DFxHlw=; b=s4myWKLYLGpYHNE24mjhPbhjeKUwYPYq1/cUDKRuHOViUR
        s89tnwBW92utXEgdpOq/9s2Cf/yY0u+j+H+VLrUYV8lJPieWaTSbxn7ot0ywc7Ng
        d/r1feAPTbtH1Za55Em5e3kNSKE7x2tpUgQnfm5wqZqnfhnUZBIqPJ7if0Um/fTd
        e2gnqsk/OIRVivCeNWrn6MVSVZni9OGe08aUG2GxGF1Rbx0Bwk9d5CqhJdWHkNlO
        uFCvwwd6NzpC1LaOjea377srhx0QCpg+YD4xUvTlD/gJE41fCHLqTg8m6OxzT0bW
        TjqBzCtv53hZHaNIalFv4n9k0E7yw5pDOlFXNP+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dU8UWE
        WsFE7FhtMSk7XoqjsqtGAURy8zRWRk2DFxHlw=; b=ZNqziKM/AuUvmLCnip6La5
        WgfEscaPTIGiW2zlw3FASQvH340qTeoGMlFMG11fAf5pphzQzWP4F6TBnoK85qh7
        lXiCOwe+o3MLMLTsZaK4ZYM/iyCCzYG9oVFy/0DuJwLcmg/KecR2xg8teVOGx/Vq
        255zakkKxiG1zkxcB8BolQS7mX0O1PbdCYqd0JQ2GtC54vS5J9AtKk5Y4a1SdkVv
        TDsH35jSvZ1DCPHPJisTt8PzfCBf6+nWVY/lf1SbugzXco/z9IBQ4j8o8rYEPEbB
        UzBkzgv/xbvXbZGebNLq23n8l2nLXgSDL/KrHszXOu7CfQg4E4Bi7ukzt1LE1dxA
        ==
X-ME-Sender: <xms:J-IJYjU3MU95ANDvSPC9PvKIBIVbROAiZCcV4hH43RqRpWhTWAhjQw>
    <xme:J-IJYrk7YBL8NXcPbzpwNGmKOGH_fQvXEcpI4p3nOVRlzNyP2sxTuliVSvGy2U51b
    Ds7epSHFE4iIgQd6A>
X-ME-Received: <xmr:J-IJYvb7jbyWCtK-7hJ7JrUDjmFyHvSE9g09XlKAPO_GvpFMnSaXGT1kwjk_6BqXSu-reY-OEwV4KxUCwh3ZGq1la0fjjZUaZeKO1WMpH_P3Gl8rky1jgGDoQ-O3FVMudu1ZZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:J-IJYuW3friZNHtZenOR5_8hLEIGUhUPYR0XU8MQmpssqjn3UrKqkQ>
    <xmx:J-IJYtnOi8AZbKJZp8cxC-lHQ3mCBn48xEButla1F30ZI4hzurnVJA>
    <xmx:J-IJYrekUPYEEbNjgzWyR0IjSwWTrS1oR2gZrsLJ9aDugM4MewfdFQ>
    <xmx:J-IJYmCJtzmVpTFwAUr_aLPquQLUBlr_A4sQf74rtoST40QogEq3RA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 00:01:27 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/4] usb: typec: Factor out non-PD fwnode properties
Date:   Sun, 13 Feb 2022 23:01:16 -0600
Message-Id: <20220214050118.61015-4-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220214050118.61015-1-samuel@sholland.org>
References: <20220214050118.61015-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v3:
 - Leave the call to fw_devlink_purge_absent_suppliers in its original
   place in the TCPM code. It is not needed by the new driver.
 - Remove unused variable from TCPM function.

Changes in v2:
 - Always put the return values from typec_find_* in a signed variable
   for error checking.

 drivers/usb/typec/class.c     | 43 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c | 24 +------------------
 include/linux/usb/typec.h     |  3 +++
 3 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb..ee0e520707dd 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1894,6 +1894,49 @@ void *typec_get_drvdata(struct typec_port *port)
 }
 EXPORT_SYMBOL_GPL(typec_get_drvdata);
 
+int typec_get_fw_cap(struct typec_capability *cap,
+		     struct fwnode_handle *fwnode)
+{
+	const char *cap_str;
+	int ret;
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
index 5fce795b69c7..3bc2f4ebd1fe 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5928,7 +5928,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 			    struct fwnode_handle *fwnode)
 {
 	const char *opmode_str;
-	const char *cap_str;
 	int ret;
 	u32 mw, frs_current;
 
@@ -5944,23 +5943,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	 */
 	fw_devlink_purge_absent_suppliers(fwnode);
 
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
 
@@ -5997,14 +5983,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
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

