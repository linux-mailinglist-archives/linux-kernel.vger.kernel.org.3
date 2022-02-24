Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B224C3185
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiBXQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiBXQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:34:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F11BA939;
        Thu, 24 Feb 2022 08:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE12DB8270B;
        Thu, 24 Feb 2022 16:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB975C340EC;
        Thu, 24 Feb 2022 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645720432;
        bh=Jx798Ph8I20XDqm7nN7xiXbSKh34Ido96y5BYrAeLHI=;
        h=From:To:Cc:Subject:Date:From;
        b=NSMN9NNieFOK4ayCzXWROSzX5iLWj1SLOrkaoxNkcEaChvcHP3sybgHfl4yzSa7oR
         CsvGfO7Zgs/3UwY2VCEOOYCRW2dn1GOkrnkwz2zrsNBRbia+zmih+qVDZSI/j5GJUx
         pEmOdeSECTORe3n1sHoEmN1pjG9lSI+mQma+yrUwF7ZeEse84h0l0dUlyX1163iixS
         kFFZ2nEGLnZTpRmddl4U4rEA0F4JCV2mJ1kXiWxOVfDlih/Ao4H6OjKD/BTs1oHVIU
         5v8KTJKW7GbHorm6XHMjQ4RQy1siXduEr/AsfKhD15IFSl4mqXPF4ezp2wTVYzo/T4
         vsO/jPhJjZY0w==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Date:   Thu, 24 Feb 2022 16:33:48 +0000
Message-Id: <20220224163348.3751461-1-broonie@kernel.org>
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

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/core/dc_resource.c

between commit:

  3743e7f6fcb93 ("drm/amd/display: Fix stream->link_enc unassigned during stream removal")

from the drm-fixes tree and commits:

  6d33f0e820bfb ("drm/amd/display: Fix stream->link_enc unassigned during stream removal")
  d9eb8fea6862e ("drm/amd/display: Drop DCN for DP2.x logic")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 18757c1585232,19b56f9acf84e..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c

[Used drm version]
