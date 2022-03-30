Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4024EC6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347145AbiC3OtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiC3OtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:49:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9E37A25
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651652; x=1680187652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C8bm2gOvcstjeaYZeQG+YiUBR0sB/DxJtgPFvM0gZ0Y=;
  b=WVT6vy6+2VvqCxswqx6oZHcP0P0uCS8gsI8FHPhXeKTuAuekOrb9YSjT
   nzF2+TCze3nJ3fMi7vKa8BOJGgUdp1qfcyt2BDWi/uCbs/mWqDBInc4l5
   YlA4ecB+AwToAbJ5NPSElQW0rDs2mEUA78KGimkIkxRkRhYo8FSakryTg
   CLIz4z2Srw1FXEcKKP9zebui6QfSoycGc2jr7ejcb6OlaJ2xeCeOTKmJH
   XK9HppaSDswRMDDgdwynWiIJt6klRWhd+YX5r+767FMsiYETbpOdz/IyY
   sisPhLddhiEt4CCoyfyDxgYttht7aDfQ5/lA/R/BhRGuq9QljzOmH7TIt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322739955"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="322739955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:47:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="695122692"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:47:30 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Mar 2022 17:47:27 +0300
Date:   Wed, 30 Mar 2022 17:47:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkRtf2HiXBOWGjna@lahna>
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 30, 2022 at 10:24:35PM +0800, Brad Campbell wrote:
> Nope, that did the same thing. I wonder though. I'm testing it on the laptop and that reports :
> [    0.442832] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
> 
> Changing "if (in->sw->generation == 1)" to "if (in->sw->generation == 2)" on the laptop solves that.

Heh, indeed I forgot that this is Falcon Ridge.

> I can't test hotplug properly on the iMac due to the radeon training issue.
> 
> The laptop still has the issue of a cold boot working in one socket
> and not the other, but hot plug is working correctly.

Let's try this one next:

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index a473cc7d9a8d..7150b5bc5403 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -865,6 +865,8 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 	struct tb_tunnel *tunnel;
 	struct tb_path **paths;
 	struct tb_path *path;
+	struct tb_port *port;
+	int link_nr;
 
 	if (WARN_ON(!in->cap_adap || !out->cap_adap))
 		return NULL;
@@ -883,22 +885,34 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 
 	paths = tunnel->paths;
 
+	/*
+	 * Hard code the lane for both DP IN adapters when first
+	 * generation hardware is present in the topology.
+	 */
+	link_nr = 1;
+	tb_for_each_port_on_path(in, out, port) {
+		if (tb_port_is_null(port) && port->sw->generation == 1) {
+			link_nr = in->port == 11 ? 1 : 0;
+			break;
+		}
+	}
+
 	path = tb_path_alloc(tb, in, TB_DP_VIDEO_HOPID, out, TB_DP_VIDEO_HOPID,
-			     1, "Video");
+			     link_nr, "Video");
 	if (!path)
 		goto err_free;
 	tb_dp_init_video_path(path);
 	paths[TB_DP_VIDEO_PATH_OUT] = path;
 
 	path = tb_path_alloc(tb, in, TB_DP_AUX_TX_HOPID, out,
-			     TB_DP_AUX_TX_HOPID, 1, "AUX TX");
+			     TB_DP_AUX_TX_HOPID, link_nr, "AUX TX");
 	if (!path)
 		goto err_free;
 	tb_dp_init_aux_path(path);
 	paths[TB_DP_AUX_PATH_OUT] = path;
 
 	path = tb_path_alloc(tb, out, TB_DP_AUX_RX_HOPID, in,
-			     TB_DP_AUX_RX_HOPID, 1, "AUX RX");
+			     TB_DP_AUX_RX_HOPID, link_nr, "AUX RX");
 	if (!path)
 		goto err_free;
 	tb_dp_init_aux_path(path);
