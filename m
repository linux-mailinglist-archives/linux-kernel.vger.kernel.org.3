Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF19D5730AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiGMIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiGMIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC54E95FF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6AFCCE1F1A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2860BC341D5;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=dqEgYcPkp6CoT1+pkogxK7Zv+2U/IkJfflbdiVF7QUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twY5Ac3JMaUHbaMmwE3PjdU5dKLPD/CLckhOTJaIxfv+d8n/PT54BgAGL00bTWCk/
         zaJV0pp3+pYaMBoO2RjZb4GI8xA/2lBpjTCmT5y9gEh/oXpyGRgcl3ulep+eTyD/A5
         jgn66y1/WYXVs8deqG/FNdovunko316SlAuVH4IFrEt5W4q9IhPY+RbshfPNfbt/Aw
         qwrWtG8iv++IMU66Z2isl8HbgWawR9T2oHqEXPht4cJBLkwGaSTGwYmurpEAfGAhfv
         QrVShACgLEkUWb9fUbTYBMqr2zl+v6n/A/TdRy/BGLOFcC7QhHRQ9S7mC3WloW22vT
         3ylsSb18TfPSQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zsk-D3;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fernando Ramos <greenfoo@u92.eu>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Patnana Venkata Sai <venkata.sai.patnana@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/39] drm/i915: display: fix kernel-doc markup warnings
Date:   Wed, 13 Jul 2022 09:11:53 +0100
Message-Id: <e860a7d8e5f9c41c462ef354b9ca6f36ae142e1b.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of issues at i915 display kernel-doc markups:

	drivers/gpu/drm/i915/display/intel_display_debugfs.c:2238: warning: Function parameter or member 'intel_connector' not described in 'intel_connector_debugfs_add'
	drivers/gpu/drm/i915/display/intel_display_debugfs.c:2238: warning: Excess function parameter 'connector' description in 'intel_connector_debugfs_add'
	drivers/gpu/drm/i915/display/intel_display_power.c:700: warning: expecting prototype for intel_display_power_put_async(). Prototype was for __intel_display_power_put_async() instead
	drivers/gpu/drm/i915/display/intel_tc.c:807: warning: Function parameter or member 'work' not described in 'intel_tc_port_disconnect_phy_work'
	drivers/gpu/drm/i915/display/intel_tc.c:807: warning: Excess function parameter 'dig_port' description in 'intel_tc_port_disconnect_phy_work'

Those are due to wrong parameter of function name. Address them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 2 +-
 drivers/gpu/drm/i915/display/intel_display_power.c   | 2 +-
 drivers/gpu/drm/i915/display/intel_tc.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 6c3954479047..1e35eb01742b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -2229,7 +2229,7 @@ DEFINE_SHOW_ATTRIBUTE(i915_current_bpc);
 
 /**
  * intel_connector_debugfs_add - add i915 specific connector debugfs files
- * @connector: pointer to a registered drm_connector
+ * @intel_connector: pointer to a registered drm_connector
  *
  * Cleanup will be done by drm_connector_unregister() through a call to
  * drm_debugfs_connector_remove().
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 589af257edeb..fd6b71160a06 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -685,7 +685,7 @@ intel_display_power_put_async_work(struct work_struct *work)
 }
 
 /**
- * intel_display_power_put_async - release a power domain reference asynchronously
+ * __intel_display_power_put_async - release a power domain reference asynchronously
  * @i915: i915 device instance
  * @domain: power domain to reference
  * @wakeref: wakeref acquired for the reference that is being released
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 6773840f6cc7..7ce0cbe0de05 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -797,7 +797,7 @@ void intel_tc_port_lock(struct intel_digital_port *dig_port)
 
 /**
  * intel_tc_port_disconnect_phy_work: disconnect TypeC PHY from display port
- * @dig_port: digital port
+ * @work: workqueue struct
  *
  * Disconnect the given digital port from its TypeC PHY (handing back the
  * control of the PHY to the TypeC subsystem). This will happen in a delayed
-- 
2.36.1

