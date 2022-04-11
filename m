Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6777B4FBED1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiDKOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiDKOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD1AE080
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2CKZnVDwRbmavT6IByuUkxzVO/hIRHVsBfHKJD/UCD4=; b=Qa6yGQ9PChKdxgeyF3wQjKEoPW
        MJCjS8bN7MrzmtpZrO1CE0wZoQAP/iqhKu/bLAM+mdWTrxMThW9HsZ7cEeKQcLECKnkq4ED0yS+wB
        Q1ovDGwFdtXSITpaLgGxwqitn+DtHqxeT+EQOnEB2kwmmm1F/0WD13lFrq8ncZ5KVXeNABuAWyKZf
        OU4TDj+bRdmAzd8MYpoDZ60de1jnXkctm1tM9mpcerSvO8IGM+smkgpArNND+iFIRcVWhMFR+CdN7
        imh2cH7NXTyVf9Hfjkx/dcwWNO3EIYD2wAedO3HhOM/xB2exds6xSa70yD492L5sDNV92rp4pMQsp
        FZJLSXAA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduo5-009KK6-MC; Mon, 11 Apr 2022 14:14:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/34] drm/i915/gvt: rename intel_vgpu_ops to intel_vgpu_mdev_ops
Date:   Mon, 11 Apr 2022 16:13:32 +0200
Message-Id: <20220411141403.86980-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the intel_vgpu_ops symbol name for something that fits better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 5231ce8084b36..e3f0c555ed5f6 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1765,7 +1765,7 @@ static const struct attribute_group *intel_vgpu_groups[] = {
 	NULL,
 };
 
-static struct mdev_parent_ops intel_vgpu_ops = {
+static struct mdev_parent_ops intel_vgpu_mdev_ops = {
 	.mdev_attr_groups       = intel_vgpu_groups,
 	.create			= intel_vgpu_create,
 	.remove			= intel_vgpu_remove,
@@ -1788,9 +1788,9 @@ static int kvmgt_host_init(struct device *dev, void *gvt, const void *ops)
 		return ret;
 
 	intel_gvt_ops = ops;
-	intel_vgpu_ops.supported_type_groups = gvt_vgpu_type_groups;
+	intel_vgpu_mdev_ops.supported_type_groups = gvt_vgpu_type_groups;
 
-	ret = mdev_register_device(dev, &intel_vgpu_ops);
+	ret = mdev_register_device(dev, &intel_vgpu_mdev_ops);
 	if (ret)
 		intel_gvt_cleanup_vgpu_type_groups((struct intel_gvt *)gvt);
 
-- 
2.30.2

