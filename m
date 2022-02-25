Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B924D4C4A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiBYQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242705AbiBYQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:15:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455191A8CB7;
        Fri, 25 Feb 2022 08:14:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBDE3B83278;
        Fri, 25 Feb 2022 16:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A29CC340E7;
        Fri, 25 Feb 2022 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645805670;
        bh=xkC4nSLHICZXNHLPzus0cNfYAdOEoTaFaMgu+1Pf2Vc=;
        h=From:To:Cc:Subject:Date:From;
        b=KWzljE6iP0Y97AxNUAcL/+fpHDJq+enejnltiHRu5mlxaBfZ3P2f5S6vvhYvFMRlZ
         5lx4hDKWtwpPHnv/RCFL47/gTQjHP9l5p9lm97amNS8k1YorS/bndcY1pO8qSbZD27
         UFiumJwdp/SnxZLlsDA3SRUYI+h2rEe27MmIPedORKgyuwW9x4N6PEg9fhNea4ROx3
         HvAAIWTzr+vwekPDlVXPJQpPnFepl/t4ET8jAuvjwj8ePtqN0BG2zVDZf1LMsikXwF
         tN9CjGuTx6eAMomX5NQLgIQ9rOnPti0UqMPV8104E87n5ornDX3kD+RhhdTwuETlth
         QfwWHvwjwubog==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes tree
Date:   Fri, 25 Feb 2022 16:14:25 +0000
Message-Id: <20220225161425.456356-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_snps_phy.c

between commit:

  28adef861233c ("drm/i915/dg2: Print PHY name properly on calibration error")

from the drm-intel-fixes tree and commits:

  c5274e86da5fe ("drm/i915/snps: convert to drm device based logging")
  84073e568eec7 ("drm/i915/dg2: Print PHY name properly on calibration error")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

[Used drm version]
