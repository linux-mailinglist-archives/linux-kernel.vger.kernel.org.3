Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259CC4A60BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiBAPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:52:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50892 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiBAPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:52:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5CBBB82EB6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D79AC340EB;
        Tue,  1 Feb 2022 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643730730;
        bh=5/saOX6toIHgF6kPJ+ZsWbSdAIkUIRl0ofe1oFPsY5g=;
        h=From:To:Cc:Subject:Date:From;
        b=DxR0t77q8AbhwvcGWWqLBZwsLzAVz/veNv6O17Sj+bknvO+FD0c+kG/ucqtuDs85r
         +2X3ux4IvKLrc113VeVBRFqT5Uk66S4KLii/e1jJwx677a8PlwVBidClYh0MxOs1sS
         3K3H7WUPz20OV5i0Mu+kUZaeKSFkBRmthYPO6v3zRvok46AvVoK6InQCPYQ5OMkO7E
         6lx9HKIToC5VDStNf8ZiH/AncJpSACWSKJB/3hZZ+mVqrhTHX9G2w5G3LURC8ztbcP
         3vhb4mIpyQxhsju14EThx7q7Y5QyVpPZm/tlnfFWQk3PBahkoVO4FT46497higyG4V
         qPbeHdSNRT1Wg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.17-rc2
Date:   Tue, 01 Feb 2022 15:51:57 +0000
Message-Id: <20220201155210.2D79AC340EB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfff546aae50ae68ed395bf0e0848188d27b0ba3:

  regulator: Add MAX20086-MAX20089 driver (2022-01-07 13:36:35 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc2

for you to fetch changes up to b4c18c18ebf7cf1e602af88c12ef9cb0d6e5ce51:

  regulator: MAX20086: add gpio/consumer.h (2022-01-19 16:47:39 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.17

A couple of very minor fixes for the regulator framework, nothing at all
urgent here.

----------------------------------------------------------------
Dan Carpenter (1):
      regulator: max20086: fix error code in max20086_parse_regulators_dt()

Randy Dunlap (1):
      regulator: MAX20086: add gpio/consumer.h

 drivers/regulator/max20086-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
