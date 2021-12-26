Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5423147F4F5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 03:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhLZCwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 21:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLZCwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 21:52:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580BC061401;
        Sat, 25 Dec 2021 18:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gX5evYVinjGbsiStWzjEEIK31bgPDuqwX+4DvdyTdbM=; b=kiN31DSAJePpsd7sVUHXvsgB0U
        CLk6HeeLqg7JLhHzYydmOeagUcBbnkP0zvFcafhMty1X6/GrqbS9HqL70esy/kZANc2P5DWOuxuNk
        gsfUFZn3vZUESiVFPnScoMEtyUOgDPGfEaSLziN4J38HoIY3n1+jukxC/qZfks3tu4RQjdYFI2Jau
        AvOOLJ3DegYzYq6VZWqzo06M9BwDLBRWa36bO+738yEqaMZNF+Zq11/nEjAbgZ0nQopkyjGoWT0bp
        JVbyg5hDDFKiX4+CbtxxhvFeKIbcag+gboI/LvfM/izdUMO8ekWhXD50x/hqlJQeg8EtSuxh3BNbu
        UVIOGy4w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1Jdw-00FErp-JS; Sun, 26 Dec 2021 02:52:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: fix typos of "its" and "reponse"
Date:   Sat, 25 Dec 2021 18:52:15 -0800
Message-Id: <20211226025215.22866-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the possessive "its" instead of the contraction of "it is" ("it's")
where needed in user-viewable messages.

Correct typos of "reponse" to "response" (reported by checkpatch).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/broadwell/uncore.json          |    6 +++---
 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json |    4 ++--
 tools/perf/pmu-events/arch/x86/haswell/uncore.json            |    6 +++---
 tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json     |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

--- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
+++ linux-next-20211224/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
@@ -184,8 +184,8 @@
     "EventCode": "0x80",
     "UMask": "0x01",
     "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
-    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
+    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
+    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
     "Counter": "0,",
     "CounterMask": "0",
     "Invert": "0",
@@ -275,4 +275,4 @@
     "Invert": "0",
     "EdgeDetect": "0"
   }
-]
\ No newline at end of file
+]
--- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ linux-next-20211224/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -514,7 +514,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to it's home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to it's home socket to be written back to memory.",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to its home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to its home socket to be written back to memory.",
         "UMask": "0x20",
         "Unit": "CHA"
     },
@@ -524,7 +524,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to its home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
     },
--- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/haswell/uncore.json
+++ linux-next-20211224/tools/perf/pmu-events/arch/x86/haswell/uncore.json
@@ -304,8 +304,8 @@
     "EventCode": "0x80",
     "UMask": "0x01",
     "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
-    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
+    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
+    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
     "Counter": "0",
     "CounterMask": "0",
     "Invert": "0",
@@ -371,4 +371,4 @@
     "Invert": "0",
     "EdgeDetect": "0"
   }
-]
\ No newline at end of file
+]
--- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ linux-next-20211224/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -514,7 +514,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to it's home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to it's home socket to be written back to memory.",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to its home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to its home socket to be written back to memory.",
         "UMask": "0x20",
         "Unit": "CHA"
     },
@@ -524,7 +524,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to its home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
     },
