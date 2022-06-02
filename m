Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36553BF8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbiFBUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiFBUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42AABF2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654201102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6zy4gylOAiT2S0vmAiXock9a3C8kfyAtNE7kTj9V6A=;
        b=Cc7PkMx6QdtBEn9UbkumZpU72racPAS828pvkYbL8I/NFsEPluvZf6mhD854kNeVkX5USb
        W7yQflZyU/iHmPgCJiz26So7TW2smwBg3hO9/8FXA03hqUe36SVBBlrXrcgQ1LajEjgDWZ
        wgDranuVNncjpSBJArPdg/LBpAGMFfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-7Tf9A5f1Pxe92-hXKqPAPg-1; Thu, 02 Jun 2022 16:18:21 -0400
X-MC-Unique: 7Tf9A5f1Pxe92-hXKqPAPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 943D985A5BC;
        Thu,  2 Jun 2022 20:18:20 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.34.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39F99414A7E7;
        Thu,  2 Jun 2022 20:18:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Rajkumar Subbiah <rsubbia@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/dp_mst: Get rid of old comment in drm_atomic_get_mst_topology_state docs
Date:   Thu,  2 Jun 2022 16:17:57 -0400
Message-Id: <20220602201757.30431-4-lyude@redhat.com>
In-Reply-To: <20220602201757.30431-1-lyude@redhat.com>
References: <20220602201757.30431-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't actually care about connection_mutex here anymore, so let's get
rid of the comment mentioning it in this function's kdocs.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index d6e595b95f07..9f96132a5d74 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5458,8 +5458,7 @@ EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
  *
  * This function wraps drm_atomic_get_priv_obj_state() passing in the MST atomic
  * state vtable so that the private object state returned is that of a MST
- * topology object. Also, drm_atomic_get_private_obj_state() expects the caller
- * to care of the locking, so warn if don't hold the connection_mutex.
+ * topology object.
  *
  * RETURNS:
  *
-- 
2.35.3

