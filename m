Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7146951D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbhLFLmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:42:50 -0500
Received: from foss.arm.com ([217.140.110.172]:54890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241994AbhLFLms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:42:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C3541042;
        Mon,  6 Dec 2021 03:39:20 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.34.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 436A03F73D;
        Mon,  6 Dec 2021 03:39:18 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, leo.yan@linaro.com,
        Suzuki.Poulose@arm.com, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] perf/core: Wake up parent event if inherited event has no ring buffer
Date:   Mon,  6 Dec 2021 11:38:39 +0000
Message-Id: <20211206113840.130802-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one possible fix to the issue described in the commit message.

What I'm not sure about is whether these other two possibilities should
be done instead, which is what I'm looking for feedback on:

 * Assign the ring buffer of the parent event to the child in inherit_event()

 * Move the poll list from the RB to the event, although it was moved into
   the RB for a specific reason in 10c6db1

James Clark (1):
  perf/core: Wake up parent event if inherited event has no ring buffer

 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.28.0

