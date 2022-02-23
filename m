Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD74C15A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiBWOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBWOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DC3E5E8;
        Wed, 23 Feb 2022 06:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 054F1B81FEA;
        Wed, 23 Feb 2022 14:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868AEC340E7;
        Wed, 23 Feb 2022 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645627614;
        bh=vpgwV1R5ym8F2CoToh9UIP31zXnshBp9Dq+OGFK5Z/8=;
        h=From:To:Cc:Subject:Date:From;
        b=gVyUDvCICsCNnrnMNypi1UPFXpITuN6dKZLPYItiHFpSIYVAZvQgT35cM8c7++MDY
         Tqxh+st74Bskw7JxPGjXIgyH4k/R8vT4DXEiBnszZsJP+6/A/C0c1wA5iGfjma9Avv
         AGS6tuwRMd5P/dLtpMfOxT1SWmwueOPS56sL8vyEaLVFtmKOwhaiRajSLG1Ias7HAG
         7aMpcokII15HeIXgTdftXUKnDZUfiHJo+77l0F3v7JMHIbH0usc+pv4tDvSLsUk+Ic
         cnFH/gEzrsPXSeKACOClrH5Ztx6roDEZI+W6CLYbYzKN15Wz3nOCKOkpkUQIi5NYMD
         KcuXxTvucLfvg==
From:   broonie@kernel.org
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the drm-intel-fixes tree
Date:   Wed, 23 Feb 2022 14:46:49 +0000
Message-Id: <20220223144649.254884-1-broonie@kernel.org>
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

  drivers/gpu/drm/i915/display/intel_bw.c

between commit:

  ec663bca9128f ("drm/i915: Fix bw atomic check when switching between SAGV vs. no SAGV")

from the drm-intel-fixes tree and commit:

  6d8ebef53c2cc ("drm/i915: Extract intel_bw_check_data_rate()")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

(took the drm-intel version)
