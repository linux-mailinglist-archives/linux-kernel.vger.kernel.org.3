Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF7465128
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350475AbhLAPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbhLAPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:14:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159CC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 747D8B81F6E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE70C53FCC;
        Wed,  1 Dec 2021 15:11:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1msRGh-000d23-8v;
        Wed, 01 Dec 2021 10:11:35 -0500
Message-ID: <20211201150959.545092970@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Dec 2021 10:09:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Two minor fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two tracing fixes:

- Allow compares of strings when using signed and unsigned characters

- Fix kmemleak false positive for histogram entries.

Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Steven Rostedt (VMware) (1):
      tracing/histograms: String compares should not care about signed values

----
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/trace/tracing_map.c       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
