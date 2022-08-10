Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD158F012
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiHJQGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiHJQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD22E7E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 878AA6115A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015ACC433C1;
        Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oLoDF-000Uxs-09;
        Wed, 10 Aug 2022 12:05:41 -0400
Message-ID: <20220810160455.872730397@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Aug 2022 12:04:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 0/4] rtla: Last minute fixes and a couple I forgot to add
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Vicenzi (1):
      rtla: Fix tracer name

Ben Hutchings (2):
      tools/rtla: Fix command symlinks
      tools/rtla: Build with EXTRA_{C,LD}FLAGS

Steven Rostedt (Google) (1):
      rtla: Consolidate and show all necessary libraries that failed for building

----
 Documentation/tools/rtla/rtla-timerlat-hist.rst |  2 +-
 tools/tracing/rtla/Makefile                     | 70 ++++++++++++++-----------
 tools/tracing/rtla/src/timerlat_hist.c          |  2 +-
 tools/tracing/rtla/src/timerlat_top.c           |  2 +-
 4 files changed, 43 insertions(+), 33 deletions(-)
