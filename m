Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33449F565
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347512AbiA1Igp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:52651 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347437AbiA1IgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358983; x=1674894983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DxsEBKwfgW0rOPFfBesx2Q3+XXutgIiZyZTOdCGgx8=;
  b=O1WV8fcZ7C3NYWaSQ7ZIxmOxGWPPsNcaxRgili1xHGx4C/pK6r/C2cTF
   aTjz5qvwwvY9r+nfESEFRnfhmse4rUNzbloSvQfbeYGU7YYXQHJK1tlgG
   KgK/v087x+8SHgshdb7JP2IJo02JFPjgeD9iW7RRVX5HGXGHP+nsZmo2O
   6dG6QGt6kiyVvGEPXbLfSNSUZXk1AFtvIKHMlNhRgkRMc666vDI5NNWDw
   NHuz8dCSUn3oAb4cr1JMA0ZzEf7a+2mASCEv4146Pn+2qwuRVlncGZYV8
   xejDPLUHPEf2JW0S6aYkE7lxllQte9Lvl1qlRWyJAM7An9sZyN62HXb5/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749383"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788769"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:17 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 13/14] Documentation: Refer to iosys-map instead of dma-buf-map
Date:   Fri, 28 Jan 2022 00:36:25 -0800
Message-Id: <20220128083626.3012259-14-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma-buf-map is being phased out in favor of the equivalent and renamed
interface: iosys-map. Use the new header in documentation.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 Documentation/driver-api/dma-buf.rst |  4 ++--
 Documentation/gpu/todo.rst           | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 2cd7db82d9fe..ea1e81894d7c 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -131,10 +131,10 @@ Kernel Functions and Structures Reference
 Buffer Mapping Helpers
 ~~~~~~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: include/linux/dma-buf-map.h
+.. kernel-doc:: include/linux/iosys-map.h
    :doc: overview
 
-.. kernel-doc:: include/linux/dma-buf-map.h
+.. kernel-doc:: include/linux/iosys-map.h
    :internal:
 
 Reservation Objects
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 1b2372ef4131..ee842606e883 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -222,7 +222,7 @@ Convert drivers to use drm_fbdev_generic_setup()
 Most drivers can use drm_fbdev_generic_setup(). Driver have to implement
 atomic modesetting and GEM vmap support. Historically, generic fbdev emulation
 expected the framebuffer in system memory or system-like memory. By employing
-struct dma_buf_map, drivers with frambuffers in I/O memory can be supported
+struct iosys_map, drivers with frambuffers in I/O memory can be supported
 as well.
 
 Contact: Maintainer of the driver you plan to convert
@@ -234,7 +234,7 @@ Reimplement functions in drm_fbdev_fb_ops without fbdev
 
 A number of callback functions in drm_fbdev_fb_ops could benefit from
 being rewritten without dependencies on the fbdev module. Some of the
-helpers could further benefit from using struct dma_buf_map instead of
+helpers could further benefit from using struct iosys_map instead of
 raw pointers.
 
 Contact: Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter
@@ -434,19 +434,19 @@ Contact: Emil Velikov, respective driver maintainers
 
 Level: Intermediate
 
-Use struct dma_buf_map throughout codebase
-------------------------------------------
+Use struct iosys_map throughout codebase
+----------------------------------------
 
-Pointers to shared device memory are stored in struct dma_buf_map. Each
+Pointers to shared device memory are stored in struct iosys_map. Each
 instance knows whether it refers to system or I/O memory. Most of the DRM-wide
-interface have been converted to use struct dma_buf_map, but implementations
+interface have been converted to use struct iosys_map, but implementations
 often still use raw pointers.
 
-The task is to use struct dma_buf_map where it makes sense.
+The task is to use struct iosys_map where it makes sense.
 
-* Memory managers should use struct dma_buf_map for dma-buf-imported buffers.
-* TTM might benefit from using struct dma_buf_map internally.
-* Framebuffer copying and blitting helpers should operate on struct dma_buf_map.
+* Memory managers should use struct iosys_map for dma-buf-imported buffers.
+* TTM might benefit from using struct iosys_map internally.
+* Framebuffer copying and blitting helpers should operate on struct iosys_map.
 
 Contact: Thomas Zimmermann <tzimmermann@suse.de>, Christian König, Daniel Vetter
 
-- 
2.35.0

