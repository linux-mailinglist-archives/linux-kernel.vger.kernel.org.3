Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E059E9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiHWRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHWRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:36:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93FC80B64;
        Tue, 23 Aug 2022 08:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 685F4B81E07;
        Tue, 23 Aug 2022 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C2FC433B5;
        Tue, 23 Aug 2022 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661268038;
        bh=OCV4SD7jf1gl8FJIP/MP717c/wV/sjJ2VFg21xqMHf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVPWX5/bnlhjHSOiLI5Z0zKIy2IUYmuXKLGztHQ/Tw8cKRfvq6NyBRK9E4roe3LNz
         bsFdBePCGoj5PI1TMme33d1MnHNF9B26lfMraMm6kPIdujzoLRf3T6oAOXQ22eN5Vy
         OmQ+E6BqHkkISV1QwrSMiKo1mzNGHvGt2bX/XYeWfhmajGf5x+3IXte5wupLrFz2FO
         SG5ecZBo2rVDgG9DYTby+V4ErK3I5PIH1qImziJwLEAZJz2YUcfEcuIKz+ikxS499w
         hybrAsi2AOJx68vBmZTgP4Wyl+rS/YF5QVc9YShNE1zynAx9szX/cFyNG8OP7CdcfP
         U8r9lcRN9RGvA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] rv/monitors: Make monitor's automata definition static
Date:   Tue, 23 Aug 2022 17:20:29 +0200
Message-Id: <a50e27c3738d6ef809f4201857229fed64799234.1661266564.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
References: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
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

Monitor's automata definition is only used locally, so make
them static for all existing monitors.

Link: https://lore.kernel.org/all/202208210332.gtHXje45-lkp@intel.com
Link: https://lore.kernel.org/all/202208210358.6HH3OrVs-lkp@intel.com

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
Fixes: 8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/rv/monitors/wip/wip.h   | 2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index c1c47e2305ef..dacc37b62a2c 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -27,7 +27,7 @@ struct automaton_wip {
 	bool final_states[state_max_wip];
 };
 
-struct automaton_wip automaton_wip = {
+static struct automaton_wip automaton_wip = {
 	.state_names = {
 		"preemptive",
 		"non_preemptive"
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index d1afe55cdd4c..118e576b91b4 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -27,7 +27,7 @@ struct automaton_wwnr {
 	bool final_states[state_max_wwnr];
 };
 
-struct automaton_wwnr automaton_wwnr = {
+static struct automaton_wwnr automaton_wwnr = {
 	.state_names = {
 		"not_running",
 		"running"
-- 
2.35.1

