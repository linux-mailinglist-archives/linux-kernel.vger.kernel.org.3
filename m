Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101C4719D0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhLLLeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:34:13 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8357 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhLLLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:34:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V-JK-la_1639308839;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0V-JK-la_1639308839)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Dec 2021 19:34:00 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/1] change log
Date:   Sun, 12 Dec 2021 19:33:57 +0800
Message-Id: <20211212113358.34208-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, steven

The config check of mcount_sort_enabled have been change 
from CONFIG_FUNCTION_TRACER to CONFIG_DYNAMIC_FTRACE.
The patch now can applies to situation that the function 
tracer be statically enabled. 


Best regards!
-- Yinan Liu 

Yinan Liu (1):
  scripts: ftrace - move the sort-processing in ftrace_init

 kernel/trace/ftrace.c   |  11 +++-
 scripts/Makefile        |   6 +-
 scripts/link-vmlinux.sh |   6 +-
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 120 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 137 insertions(+), 8 deletions(-)

-- 
2.27.0

