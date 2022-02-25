Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057B94C4BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiBYRIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBYRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:08:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5117B8A3;
        Fri, 25 Feb 2022 09:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70383B82E51;
        Fri, 25 Feb 2022 17:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03800C340E7;
        Fri, 25 Feb 2022 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645808897;
        bh=hz+lH5qNUjVnCbRoevPcMCs+vilBSIywQyZBMPYFZE4=;
        h=From:To:Cc:Subject:Date:From;
        b=J6iG1CiTd1gJ8dTRKFQs5BuMv+965CCZ5QT10FvqfnorcsRa+c8PyzUudIZfn8QJn
         bBeDyPP3mXgBnf4JPBeOv9XNs8qsTP7veQYZXGnXKv9Oek7Cv/CGfWO3AIxqLPpgzS
         v8Bpt6npCDD/MOd8qb2SkfqtMJb0rFmfvVxjr/yrCWwE6ZyOCDTN2+Hk5Pj6mlwIxi
         twKPO0qogNY5eJFX5cJWvjpIMSkaDl6NTLrbMz0BYLZHs8vTisOEDy+EU22+7EXW3B
         iUzc5yZdjH5hs+mIPnCrtlAQ0chWXYcGr0fhQGVlxhiII618BBgpeuIbl5JMvyAtES
         C/7M0HdvYUuHA==
From:   broonie@kernel.org
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the drm-intel-fixes tree
Date:   Fri, 25 Feb 2022 17:08:12 +0000
Message-Id: <20220225170812.1523966-1-broonie@kernel.org>
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

  drivers/gpu/drm/i915/display/intel_snps_phy.c

between commit:

  28adef861233c ("drm/i915/dg2: Print PHY name properly on calibration error")

from the drm-intel-fixes tree and commits:

  84073e568eec7 ("drm/i915/dg2: Print PHY name properly on calibration error")
  b4eb76d82a0ea ("drm/i915/dg2: Skip output init on PHY calibration failure")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

[Used drm-intel version]
