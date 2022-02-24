Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A4C3404
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiBXRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBXRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:52:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175265748A;
        Thu, 24 Feb 2022 09:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A4361CAA;
        Thu, 24 Feb 2022 17:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0BBC340E9;
        Thu, 24 Feb 2022 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645725113;
        bh=okvli80VUxIOQbN6MsWGNd2XsmG92pwx21C/8Pm4/Y4=;
        h=From:To:Cc:Subject:Date:From;
        b=Uk/Ss2CSiLRq9yizvMPg10mROQXswArnNro4vr0utE0RxaFpZ6sdEFevmk2GaeCVs
         +5QQeeTq8FHZ/Fj6uxIQi0USANb3cECCBdWr4okr1y9I5YiICuNclJf2BPsidpMp5h
         L8V4estdNA27lBXssSFTva8Mn8tqMxzX4FrO0BYgjS/LfQqRt26ltGXYWmccoxBmGW
         WMCOCvq5Oc59lM26EG48O5UiNjbQdFwjV263//DpeFgI8HarZa0fbfVMkyQZzClsUO
         R0V2iP18+YDjas5hEg+1CboZA6+0Cq8e8RNUIZoQRVaOhI0HBBOvJ2JBSLFWho8P0O
         y8e7LR5anI37g==
From:   broonie@kernel.org
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     John Harrison <John.C.Harrison@Intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the drm-intel-gt tree
Date:   Thu, 24 Feb 2022 17:51:47 +0000
Message-Id: <20220224175147.2694056-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c

between commit:

  721fd84ea1fe9 ("drm/i915/pmu: Use PM timestamp instead of RING TIMESTAMP for reference")

from the drm-intel-gt tree and commit:

  b3f74938d6566 ("drm/i915/pmu: Use PM timestamp instead of RING TIMESTAMP for reference")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 04b8321fc7587,b3a429a92c0da..0000000000000
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c

[Used drm-next version]
