Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7E595A93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHPLtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiHPLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:48:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E2DCE2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 178A1B8169E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3BAC433C1;
        Tue, 16 Aug 2022 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660648981;
        bh=QmM0D3HPMpAQ57+p24HiqKUMow8mOiT3SsENxf3kG4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=fl+jrBHNTZpABG57Xda3Et8S4Es/maPIN8EjGKK+IK5kzKzZPujcnVJpAI29lf2km
         JUk6QRD4Q9ADal95SMXUJl985bUGuftNCkU1W0LHAV9yb1/3oTBMvhYo73W8hdGH4P
         RRyzFoW5B14yn+oiRekqkwGt8irzIuBL+aH8IZB+aMXlig1ca6+90mtzpXmlwxN0tT
         B0fhf4dAdiIQ/oYaKvx13+bcQvDWoVbHt+qWfsR7PdtmIwsMCCnlj9Bpm2gKGVGyQD
         BucczyUY5HkqZguFG97czhApFJIDiNVmVKLD57Py6iHlAE5S5/04xoEsmYbmC8DkLl
         HNN9CP/QXNk3Q==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.0-rc1
Date:   Tue, 16 Aug 2022 12:22:43 +0100
Message-Id: <20220816112301.7C3BAC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit efc93392960cb9c3534e7aed15481ca7bcfdf15c:

  regulator: Consumer load management improvements (2022-07-28 00:01:30 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.0-rc1

for you to fetch changes up to d511e8a7e850db567cd7f633288aa96a19508e5b:

  regulator: core: Fix missing error return from regulator_bulk_get() (2022-08-10 14:52:07 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.0

A couple of small fixes that came in since my pull request, nothing
major here.

----------------------------------------------------------------
Douglas Anderson (1):
      regulator: core: Fix missing error return from regulator_bulk_get()

Frieder Schrempf (1):
      regulator: pca9450: Remove restrictions for regulator-name

 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml  | 11 -----------
 drivers/regulator/core.c                                      |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)
