Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38449F2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiA1FCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:02:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:49689 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbiA1FB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643346117; x=1674882117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RO9ZZxmjqCuKF+rRhN0z+oMjHUed1ETrae8AqmGHMHw=;
  b=PAVIy1jMcMcFhg09riFVb8TRQFLrZqAqmA/mCJt7iX12zhQhO6ewpvUH
   P2B+b3qild+yBjqigOlSLY/wb6GgT/2VPv2aof8KLWZNUOx24laCZf9E1
   WGZg7mg9rYFyw9fEd0uhd4QgAUCFz6MtyHgEZ90UCoT8cMlqARQs1RSu0
   29YG8X5AgO01YmN/wkOMiC5a5oWyxKpcQahbvMt6hktcLFjsfMNjebwFs
   uXQEBzPJ9N+Q+UBSKUnhfEbQckJiOOnkfDng+LFsbWtQo5LoBs28nuTCA
   7ilx6RDeLrZI7zMhqGOQQYLWMzi4QE4NW3/Uj9mPvNF8TJfIjUcT25uGo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="307761569"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="307761569"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 21:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="628984302"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2022 21:01:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDJOU-000NUt-82; Fri, 28 Jan 2022 05:01:54 +0000
Date:   Fri, 28 Jan 2022 13:01:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>, hch@lst.de, jgg@nvidia.com,
        jani.nikula@linux.intel.com
Cc:     kbuild-all@lists.01.org, Zhi Wang <zhi.wang.linux@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Terrence Xu <terrence.xu@intel.com>,
        intel-gvt-dev@lists.freedesktop.org
Subject: [RFC PATCH] i915/gvt: intel_gvt_match_device() can be static
Message-ID: <20220128050111.GA69282@e2c1dfe2c692>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127120508.11330-1-zhi.a.wang@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/i915/gvt/handlers.c:45:6: warning: symbol 'intel_gvt_match_device' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 handlers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index dad31ad074a03..459f0d902f64f 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -42,7 +42,7 @@
 #include "display/intel_display_types.h"
 #include "display/intel_fbc.h"
 
-bool intel_gvt_match_device(struct intel_gvt *gvt,
+static bool intel_gvt_match_device(struct intel_gvt *gvt,
 		unsigned long device)
 {
 	return intel_gvt_get_device_type(gvt->gt->i915) & device;
