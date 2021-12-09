Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07046ED1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhLIQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:37:01 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43862 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235038AbhLIQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:37:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V-4XSLS_1639067604;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V-4XSLS_1639067604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 00:33:25 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 0/2]  mm/damon: Do little changes
Date:   Fri, 10 Dec 2021 00:33:15 +0800
Message-Id: <cover.1639066954.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are mainly used for fine adjustments.

Xin Hao (2):
  mm/damon/dbgfs: Avoid target_ids display wrong pid value
  mm/damon: Modify the display form of damon tracepoint

 include/trace/events/damon.h | 6 +++---
 mm/damon/dbgfs.c             | 8 +++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

--
2.31.0
