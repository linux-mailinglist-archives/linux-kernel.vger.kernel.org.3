Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54BE572835
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGLVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGLVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:03:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03CA1172
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:03:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so277569pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oXKjVT7u/Vdw6OQapcARzJ8tfeoIWiT56vDmOkl6F3I=;
        b=OjqqmVzsv0YolRrIIZLjhjdZCq1rmYEBkn8DRiK6Wk0S2y5Ir4mr4pL/27LxVLDmQe
         aWl1whRFV+vPO/nyLDG9vb6DyCXlGyMboZjjSOMxHQxu6SSTOxqJxPuiMUF5fcOIqBRP
         4TdCdMZIwKJ6EV9qhTaoX79MbML24W6P0A1MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oXKjVT7u/Vdw6OQapcARzJ8tfeoIWiT56vDmOkl6F3I=;
        b=tlt9+7p9mbnGs4aWJVdEx8Qm9/qKqRcafTHGDFULx/ugsP9EZdWWEE4JaXkRIiADw4
         Jzq6gt2b0ZTITehhUaQ0W6cH8ydvFe0br4O3R34z9LwPnr1opFSza/5c19Kl1ala/UAG
         jyib5eJF1npUm3fCWig4/jmTgTQsbctgtfpFxdhQPETCGVPDR9AlSCFJ50DCNfPWd7dV
         Ah0Fz5XJCXxoQvpRiLMuO0Ni3wnUuYRA018rBa1JvaV14XqJnsNC0VWJD476dH3V3Kfq
         wDJXTyzAHJ5VcCu0x0XDDniIIGRKLHQ9d8fpGSVNsaJFoSBsl7488cKtMWBoEoEE92GM
         MTDQ==
X-Gm-Message-State: AJIora+a2uCkGrnkxFoIg30CPbtD9t+5Q2CT6wkAdrsst1PpUogrX0ls
        7gusKEmV0hvWlAMz1QSDR0lrpWouHVGLwg==
X-Google-Smtp-Source: AGRyM1t3A2NeYZ46IZn1+5Gsngitu30LooC617kS/EU05ggoSiWAACIwHprl6NLuRAJwQgmOn5AP2A==
X-Received: by 2002:a17:90a:eacd:b0:1ef:84c2:418d with SMTP id ev13-20020a17090aeacd00b001ef84c2418dmr6323006pjb.101.1657659808270;
        Tue, 12 Jul 2022 14:03:28 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b0016bf8048bd2sm7284130plh.175.2022.07.12.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:03:27 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_typec: Rename port altmode array
Date:   Tue, 12 Jul 2022 21:03:17 +0000
Message-Id: <20220712210318.2671292-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename "p_altmode" to "port_altmode" which is a less ambiguous name for
the port_altmode struct array.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d6088ba447af..b9848e80f372 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -60,8 +60,7 @@ struct cros_typec_port {
 	uint8_t mux_flags;
 	uint8_t role;
 
-	/* Port alt modes. */
-	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
+	struct typec_altmode port_altmode[CROS_EC_ALTMODE_MAX];
 
 	/* Flag indicating that PD partner discovery data parsing is completed. */
 	bool sop_disc_done;
@@ -282,16 +281,16 @@ static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	struct cros_typec_port *port = typec->ports[port_num];
 
 	/* All PD capable CrOS devices are assumed to support DP altmode. */
-	port->p_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
-	port->p_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
+	port->port_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
+	port->port_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
 
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
 	 * if it doesn't support it, so it's safe to register it unconditionally
 	 * here for now.
 	 */
-	port->p_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
-	port->p_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
+	port->port_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
+	port->port_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
@@ -431,7 +430,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
 
 	if (!port->state.alt) {
-		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_TBT];
+		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_TBT];
 		ret = cros_typec_usb_safe_state(port);
 		if (ret)
 			return ret;
@@ -473,7 +472,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	/* Configuration VDO. */
 	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(pd_ctrl->dp_mode);
 	if (!port->state.alt) {
-		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_DP];
+		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_DP];
 		ret = cros_typec_usb_safe_state(port);
 		if (ret)
 			return ret;
-- 
2.37.0.144.g8ac04bfd2-goog

