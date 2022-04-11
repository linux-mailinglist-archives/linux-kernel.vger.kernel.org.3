Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8F4FB8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbiDKJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbiDKJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88301263F;
        Mon, 11 Apr 2022 02:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DB3612A0;
        Mon, 11 Apr 2022 09:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B09C385A4;
        Mon, 11 Apr 2022 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670922;
        bh=+RklqxRhzlfdfvUIrHk5oEeLX7rsicASkcyAD7DL274=;
        h=From:To:Cc:Subject:Date:From;
        b=ZmrH4u2zGqXgrrS8YbjgR8pyrc26ioLlxlVFAwGOnEoDxn19O2AP2KQtFKWbArXAN
         unLc+mJGerT+uXwvHXlAO7sGuQZ6HPVVcdS6J5REiDu1Y3QCuV3QdGDgXtdliBKJLj
         JWt/fKhpFDpoDUdIp1fh2Up+yyi0NLlYkNMKHCZ+Rq4FR5yyVLDheKB+FVktMtTJCG
         vDcJzv7UsUe0v93JT2gFGgBG5dwTau6ilzfiIWBwK586/CDT/iX7a5c+Up52DA+WFQ
         8YtH+yZ1WV2ehBuVcfdYfbdvIzYuPbN+ERizUA/WMdRAEnc9JwgsYPGgu1Cs7v9D4j
         gZ3Xh5HoZ2X8w==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Date:   Mon, 11 Apr 2022 12:55:14 +0300
Message-Id: <20220411095516.24754-1-rogerq@kernel.org>
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

These patches allow OMAP_GPMC config to be visible in menuconfig
and buildable as a module.

Changelog:
v3:
- Remove not required MODULE_ALIAS
- Mention in commit message why we need to remove of_match_node() call

v2:
- Allow building as a module

Roger Quadros (2):
  memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
  memory: omap-gpmc: Allow building as a module

 drivers/memory/Kconfig     |  4 ++--
 drivers/memory/omap-gpmc.c | 43 ++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 22 deletions(-)

-- 
2.17.1

