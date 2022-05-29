Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71F5371DF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiE2RJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2RJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:09:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCBA8AE4D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8916B80B33
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 17:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C8CC385A9;
        Sun, 29 May 2022 17:09:22 +0000 (UTC)
Date:   Sun, 29 May 2022 13:09:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: [GIT PULL] tracing tools: Updates for 5.19
Message-ID: <20220529130917.06df783b@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[ You did tell me that you prefer the tools to be a separate pull
  request than the kernel changes.]

Updates to Real Time Linux Analysis tool for 5.19:

Various clean ups and fixes.


Please pull the latest trace-tools-v5.19 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-tools-v5.19

Tag SHA1: 70796e161d97186eb56dd830a504d3ab154b283d
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
---------------------------
