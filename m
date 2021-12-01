Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18544646B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbhLAFfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:35:34 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36704 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhLAFfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:35:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UywZWaF_1638336727;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UywZWaF_1638336727)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Dec 2021 13:32:08 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] ftrace sorting optimization changelog 
Date:   Wed,  1 Dec 2021 13:32:05 +0800
Message-Id: <20211201053207.32339-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,steven

Patch1 added the configuration judgment in build time and boot time.
Patch2 fix code style issue in sorrtable.h.

Best regards!
-- Yinan Liu
 
Yinan Liu (2):
  scripts: ftrace - move the sort-processing in ftrace_init to compile
    time
  script/sorttable: code style improvements

 kernel/trace/ftrace.c   |  11 +++-
 scripts/Makefile        |   2 +-
 scripts/link-vmlinux.sh |   6 +-
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 124 ++++++++++++++++++++++++++++++++++++++--
 5 files changed, 135 insertions(+), 10 deletions(-)

-- 
2.19.1.6.gb485710b

