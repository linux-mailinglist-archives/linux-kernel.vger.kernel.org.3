Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66EB586189
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 23:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiGaVJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiGaVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 17:09:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B1DF86
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B11E5B80DCF
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BFEC433D6;
        Sun, 31 Jul 2022 21:09:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIGBv-007Ghh-0b;
        Sun, 31 Jul 2022 17:09:39 -0400
Message-ID: <20220731210918.097591536@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 17:09:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 0/4] rtla: Updates for 5.20
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas Schwab (2):
      rtla: Fix double free
      rtla: Define syscall numbers for riscv

Daniel Bristot de Oliveira (1):
      rtla: Fix Makefile when called from -C tools/

jianchunfu (1):
      rtla/utils: Use calloc and check the potential memory allocation failure

----
 tools/tracing/rtla/Makefile    | 2 +-
 tools/tracing/rtla/src/trace.c | 9 +++++++--
 tools/tracing/rtla/src/utils.c | 7 ++++---
 3 files changed, 12 insertions(+), 6 deletions(-)
