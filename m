Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3F4E9313
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiC1LPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiC1LPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5385522A;
        Mon, 28 Mar 2022 04:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06F561124;
        Mon, 28 Mar 2022 11:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA6EC340EC;
        Mon, 28 Mar 2022 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466006;
        bh=DfqUxVX+5WP9pagJlTm4FcFkhSqHyaRpzyiaeYkTWC0=;
        h=From:To:Cc:Subject:Date:From;
        b=LqEVRs6wOZQtSIcp0MA2Zg17F8n1hEGjSsqIOhKQJfc00eEMrJmmRZJzXu8omvhu3
         bD/6KpaeVKL5d/xvIW5dfYJSFXGQ4O0aSnmuQpUXYswJ9Km6fGANBsWLaMBcwgthYG
         xM6DAGkVGsaUrLX4ew81wMAWgcyrc6RkbE6lBlGQK6IWhU26smNSIDPpFHvqqVti0s
         +loe4Bh6WJiAr/F6OByMlFm2kcExKi3LiMiLyxXzb9UoZ8T9gLX9O+KQt0WZ/7N0VQ
         l5zh2sANbSZ/Cj8jvz2CMquwveS9W+UnYgPqYCr+NiIocoB1ZKkDs75laTevEPE7Dx
         jZM3kDekmWDJA==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] memory: omap-gpmc: Allow module build
Date:   Mon, 28 Mar 2022 14:13:17 +0300
Message-Id: <20220328111319.1236-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Allow OMAP_GPMC config to be visible in menuconfig and buildable
as a module.

Changelog:
v2:
- Allow building as a module

cheers,
-roger

Roger Quadros (2):
  memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
  memory: omap-gpmc: Allow building as a module

 drivers/memory/Kconfig     |  4 ++--
 drivers/memory/omap-gpmc.c | 44 +++++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.17.1

