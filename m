Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29B5B0F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiIGVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIGVvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:51:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E2C122C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662587500; x=1694123500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUH9JVX82KYBUtZrhI4SrnRmAhQoUyXgBRPk10Mjuw0=;
  b=Ya1U7OHu/nF3Mo1EW5WRfHFIh3mBXoaZKErVRt5WM5LWZUZdNhCyy5db
   huFZJH/Wp2zaJQffqbQb/CyUx5kuPFgbrDFiYa5W3uy6mBFZY9GXtq//P
   kgZjnunJqpZUMwJe46r4Cdt4Hwg/J/NaFMgZl+Y7zWpyUKyf4ABnkNgSV
   x8pSwQngV6HfE/u2weT343ieAhCgRmoVhb3+7UgpAZvMutFEcvsD/bQqb
   XUh49ADjOKYFV2tucbBnVNXSnzJS6N8/037pV91rY/tdiO4h6i5UO65Ik
   RY5zHiL2XSLkPv05qpq/Qag3NfdERaCWrjjxABC5sQBWP7LVsRWcbalt3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295740263"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295740263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="790207835"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:35 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v9 02/16] mei: add kdoc for struct mei_aux_device
Date:   Thu,  8 Sep 2022 00:50:59 +0300
Message-Id: <20220907215113.1596567-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907215113.1596567-1-tomas.winkler@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mei_aux_device is an interface structure
requires proper documenation.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
V9: Rebase

 include/linux/mei_aux.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index 587f25128848..a0cb587006d5 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -7,6 +7,12 @@
 
 #include <linux/auxiliary_bus.h>
 
+/**
+ * struct mei_aux_device - mei auxiliary device
+ * @aux_dev: - auxiliary device object
+ * @irq: interrupt driving the mei auxiliary device
+ * @bar: mmio resource bar reserved to mei auxiliary device
+ */
 struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
-- 
2.37.2

