Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7287535630
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiEZWyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346064AbiEZWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:54:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C8E8B91
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DF7AB82225
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C4C385B8;
        Thu, 26 May 2022 22:54:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nuMN5-002Tdo-T6;
        Thu, 26 May 2022 18:54:23 -0400
Message-ID: <20220526225345.068997320@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 18:53:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing/rtla: Updates for 5.19
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next-rtla

Head SHA1: dada03db9bb1984826e61cfcf1418ac73848324d


Daniel Bristot de Oliveira (3):
      rtla/Makefile: Properly handle dependencies
      rtla: Fix __set_sched_attr error message
      rtla: Remove procps-ng dependency

John Kacur (2):
      rtla: Don't overwrite existing directory mode
      rtla: Minor grammar fix for rtla README

Wan Jiabing (1):
      rtla: Avoid record NULL pointer dereference

----
 Documentation/tools/rtla/Makefile      |  14 ++++-
 tools/tracing/rtla/Makefile            |  40 +++++++++++-
 tools/tracing/rtla/README.txt          |  13 ++--
 tools/tracing/rtla/src/osnoise_hist.c  |   5 +-
 tools/tracing/rtla/src/osnoise_top.c   |   9 +--
 tools/tracing/rtla/src/timerlat_hist.c |  11 ++--
 tools/tracing/rtla/src/timerlat_top.c  |  11 ++--
 tools/tracing/rtla/src/utils.c         | 108 ++++++++++++++++++++++++++-------
 tools/tracing/rtla/src/utils.h         |   3 +-
 9 files changed, 164 insertions(+), 50 deletions(-)
