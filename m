Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4896048CCB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357355AbiALUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:01:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33258 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357188AbiALUAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F8360B01
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 20:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5993C36AE9;
        Wed, 12 Jan 2022 20:00:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7jnN-003EMS-9g;
        Wed, 12 Jan 2022 15:00:33 -0500
Message-ID: <20220112195843.098894945@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jan 2022 14:58:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 00/14] tracing: Rebase for update of v9 of RTLA tool
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I pulled in version 8 of the rtla tool instead of the most recent
v9 (which was the one I last reviewed, but somehow pulled in the older
version), I'm rebasing to v9. This is not an issue as none of the
patches actually touch kernel code. Only tools and Documentation.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: fa7e5a516e8ca0740ad1563b33d24b430dc31f77


Daniel Bristot de Oliveira (14):
      rtla: Real-Time Linux Analysis tool
      rtla: Helper functions for rtla
      rtla: Add osnoise tool
      rtla/osnoise: Add osnoise top mode
      rtla/osnoise: Add the hist mode
      rtla: Add timerlat tool and timelart top mode
      rtla/timerlat: Add timerlat hist mode
      rtla: Add Documentation
      rtla: Add rtla osnoise man page
      rtla: Add rtla osnoise top documentation
      rtla: Add rtla osnoise hist documentation
      rtla: Add rtla timerlat documentation
      rtla: Add rtla timerlat top documentation
      rtla: Add rtla timerlat hist documentation

----
 Documentation/tools/rtla/Makefile                  |  41 +
 Documentation/tools/rtla/common_appendix.rst       |  12 +
 Documentation/tools/rtla/common_hist_options.rst   |  23 +
 Documentation/tools/rtla/common_options.rst        |  28 +
 .../tools/rtla/common_osnoise_description.rst      |   8 +
 .../tools/rtla/common_osnoise_options.rst          |  17 +
 .../tools/rtla/common_timerlat_description.rst     |  10 +
 .../tools/rtla/common_timerlat_options.rst         |  16 +
 Documentation/tools/rtla/common_top_options.rst    |   3 +
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |  66 ++
 Documentation/tools/rtla/rtla-osnoise-top.rst      |  61 ++
 Documentation/tools/rtla/rtla-osnoise.rst          |  59 ++
 Documentation/tools/rtla/rtla-timerlat-hist.rst    | 106 +++
 Documentation/tools/rtla/rtla-timerlat-top.rst     | 145 ++++
 Documentation/tools/rtla/rtla-timerlat.rst         |  57 ++
 Documentation/tools/rtla/rtla.rst                  |  48 ++
 tools/tracing/rtla/Makefile                        | 102 +++
 tools/tracing/rtla/README.txt                      |  36 +
 tools/tracing/rtla/src/osnoise.c                   | 875 +++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h                   |  91 +++
 tools/tracing/rtla/src/osnoise_hist.c              | 801 +++++++++++++++++++
 tools/tracing/rtla/src/osnoise_top.c               | 579 ++++++++++++++
 tools/tracing/rtla/src/rtla.c                      |  87 ++
 tools/tracing/rtla/src/timerlat.c                  |  72 ++
 tools/tracing/rtla/src/timerlat.h                  |   4 +
 tools/tracing/rtla/src/timerlat_hist.c             | 822 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_top.c              | 618 +++++++++++++++
 tools/tracing/rtla/src/trace.c                     | 192 +++++
 tools/tracing/rtla/src/trace.h                     |  27 +
 tools/tracing/rtla/src/utils.c                     | 433 ++++++++++
 tools/tracing/rtla/src/utils.h                     |  56 ++
 31 files changed, 5495 insertions(+)
 create mode 100644 Documentation/tools/rtla/Makefile
 create mode 100644 Documentation/tools/rtla/common_appendix.rst
 create mode 100644 Documentation/tools/rtla/common_hist_options.rst
 create mode 100644 Documentation/tools/rtla/common_options.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_description.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_options.rst
 create mode 100644 Documentation/tools/rtla/common_timerlat_description.rst
 create mode 100644 Documentation/tools/rtla/common_timerlat_options.rst
 create mode 100644 Documentation/tools/rtla/common_top_options.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-hist.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-top.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-hist.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-top.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat.rst
 create mode 100644 Documentation/tools/rtla/rtla.rst
 create mode 100644 tools/tracing/rtla/Makefile
 create mode 100644 tools/tracing/rtla/README.txt
 create mode 100644 tools/tracing/rtla/src/osnoise.c
 create mode 100644 tools/tracing/rtla/src/osnoise.h
 create mode 100644 tools/tracing/rtla/src/osnoise_hist.c
 create mode 100644 tools/tracing/rtla/src/osnoise_top.c
 create mode 100644 tools/tracing/rtla/src/rtla.c
 create mode 100644 tools/tracing/rtla/src/timerlat.c
 create mode 100644 tools/tracing/rtla/src/timerlat.h
 create mode 100644 tools/tracing/rtla/src/timerlat_hist.c
 create mode 100644 tools/tracing/rtla/src/timerlat_top.c
 create mode 100644 tools/tracing/rtla/src/trace.c
 create mode 100644 tools/tracing/rtla/src/trace.h
 create mode 100644 tools/tracing/rtla/src/utils.c
 create mode 100644 tools/tracing/rtla/src/utils.h
