Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCA47F6C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhLZMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhLZMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:42:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C933C06173E;
        Sun, 26 Dec 2021 04:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93FBDB808CF;
        Sun, 26 Dec 2021 12:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0632C36AE8;
        Sun, 26 Dec 2021 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522560;
        bh=a6k2AGhGfbVVrPwPB2n2dcWKqqDT8I+55NN7Xa+aK88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkAvsSc+Jc0Qch0IXU63LfzlVZoRWgzrrykSbgUbv165OT1OirKMcrvlvu22daF7t
         XHSev0RZsQTOdn8i59zipyVFl0+YjP9aNzOqRtbVg95qqg3bjb+nihIADTmM1ZyLLf
         RF2CXhWenPoS4sN/4TpUgmPCJ/2v18LEdT847ghRwaTrNosewtl9vhhWldnZI1bO8/
         qVxYeckvdx0O56GIL4ZixggRbSJWUGlnxj5HcsVPk5dDZ9JSJlAyzEf3jJ+mhfixOq
         TXivM1rerdfmv3gBI5KgVtc8J59gSw+SJsfQoOlivD/ohPO8RnZgJqhENireML/EvL
         CrN+qtHA6lo+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FC1640B92; Sun, 26 Dec 2021 09:42:37 -0300 (-03)
Date:   Sun, 26 Dec 2021 09:42:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: JSON typos Re: [PATCH] perf: fix typos of "its" and "reponse"
Message-ID: <YchjPcUlOH4tUB5M@kernel.org>
References: <20211226025215.22866-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226025215.22866-1-rdunlap@infradead.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 25, 2021 at 06:52:15PM -0800, Randy Dunlap escreveu:
> Use the possessive "its" instead of the contraction of "it is" ("it's")
> where needed in user-viewable messages.
> 
> Correct typos of "reponse" to "response" (reported by checkpatch).

These files are made from other files, Andi?

- Arnaldo
 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> ---
>  tools/perf/pmu-events/arch/x86/broadwell/uncore.json          |    6 +++---
>  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json |    4 ++--
>  tools/perf/pmu-events/arch/x86/haswell/uncore.json            |    6 +++---
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json     |    4 ++--
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> --- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> +++ linux-next-20211224/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> @@ -184,8 +184,8 @@
>      "EventCode": "0x80",
>      "UMask": "0x01",
>      "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
> -    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> -    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
>      "Counter": "0,",
>      "CounterMask": "0",
>      "Invert": "0",
> @@ -275,4 +275,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> --- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> +++ linux-next-20211224/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> @@ -514,7 +514,7 @@
>          "EventCode": "0x5C",
>          "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to it's home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to it's home socket to be written back to memory.",
> +        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to its home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to its home socket to be written back to memory.",
>          "UMask": "0x20",
>          "Unit": "CHA"
>      },
> @@ -524,7 +524,7 @@
>          "EventCode": "0x5C",
>          "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
> +        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to its home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
>          "UMask": "0x10",
>          "Unit": "CHA"
>      },
> --- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> +++ linux-next-20211224/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> @@ -304,8 +304,8 @@
>      "EventCode": "0x80",
>      "UMask": "0x01",
>      "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
> -    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> -    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
>      "Counter": "0",
>      "CounterMask": "0",
>      "Invert": "0",
> @@ -371,4 +371,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> --- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> +++ linux-next-20211224/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> @@ -514,7 +514,7 @@
>          "EventCode": "0x5C",
>          "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to it's home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to it's home socket to be written back to memory.",
> +        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to its home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to its home socket to be written back to memory.",
>          "UMask": "0x20",
>          "Unit": "CHA"
>      },
> @@ -524,7 +524,7 @@
>          "EventCode": "0x5C",
>          "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
> +        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to its home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
>          "UMask": "0x10",
>          "Unit": "CHA"
>      },

-- 

- Arnaldo
