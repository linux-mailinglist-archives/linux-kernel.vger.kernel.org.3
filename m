Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED858D0AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiHHXy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbiHHXyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F17391C93D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660002870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZBOqHQ+0wLuoWsigkrWi4WtzQUueoCKnZQINx3aEaTo=;
        b=KfvyP72MnvBbpx6LoVvehV5kOzeQWvjISjg+52ju5eqiQkQODRSgdr2IhlG7BHBu2iuWMn
        E8h91Mozx9SvO3XLg8i/rdk30ySk611uhK+Q4Xeia97psPenDT0TFM9Vm7X7TjecGRrJQa
        4pYhpbEZaENpfdKjUitL9is9hL5jD8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-uGTCsmAXPx-nPqTFc-21Jg-1; Mon, 08 Aug 2022 19:54:23 -0400
X-MC-Unique: uGTCsmAXPx-nPqTFc-21Jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23C3C1019C96;
        Mon,  8 Aug 2022 23:54:23 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.17.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 776F5C15BA1;
        Mon,  8 Aug 2022 23:54:22 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Wayne Lin <Wayne.Lin@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 06/18] drm/display/dp_mst: Add some missing kdocs for atomic MST structs
Date:   Mon,  8 Aug 2022 19:51:51 -0400
Message-Id: <20220808235203.123892-7-lyude@redhat.com>
In-Reply-To: <20220808235203.123892-1-lyude@redhat.com>
References: <20220808235203.123892-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're about to start adding some stuff here, we may as well fill in
any missing documentation that we forgot to write.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 include/drm/display/drm_dp_mst_helper.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 9cdd2def56a1..3b155ad3eee4 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -542,7 +542,14 @@ struct drm_dp_payload {
 
 #define to_dp_mst_topology_state(x) container_of(x, struct drm_dp_mst_topology_state, base)
 
+/**
+ * struct drm_dp_mst_atomic_payload - Atomic state struct for an MST payload
+ *
+ * The primary atomic state structure for a given MST payload. Stores information like current
+ * bandwidth allocation, intended action for this payload, etc.
+ */
 struct drm_dp_mst_atomic_payload {
+	/** @port: The MST port assigned to this payload */
 	struct drm_dp_mst_port *port;
 
 	/**
@@ -551,16 +558,32 @@ struct drm_dp_mst_atomic_payload {
 	 * the immediate downstream DP Rx
 	 */
 	int time_slots;
+	/** @pbn: The payload bandwidth for this payload */
 	int pbn;
+	/** @dsc_enabled: Whether or not this payload has DSC enabled */
 	bool dsc_enabled;
+
+	/** @next: The list node for this payload */
 	struct list_head next;
 };
 
+/**
+ * struct drm_dp_mst_topology_state - DisplayPort MST topology atomic state
+ *
+ * This struct represents the atomic state of the toplevel DisplayPort MST manager
+ */
 struct drm_dp_mst_topology_state {
+	/** @base: Base private state for atomic */
 	struct drm_private_state base;
+
+	/** @payloads: The list of payloads being created/destroyed in this state */
 	struct list_head payloads;
+	/** @mgr: The topology manager */
 	struct drm_dp_mst_topology_mgr *mgr;
+
+	/** @total_avail_slots: The total number of slots this topology can handle (63 or 64) */
 	u8 total_avail_slots;
+	/** @start_slot: The first usable time slot in this topology (1 or 0) */
 	u8 start_slot;
 };
 
-- 
2.37.1

