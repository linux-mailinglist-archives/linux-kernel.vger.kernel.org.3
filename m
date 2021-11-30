Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F014641E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbhK3XBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345045AbhK3XBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:01:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306FC061574;
        Tue, 30 Nov 2021 14:57:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/V2ihpxA3WwS0vURZHQtur+oN9jzv/WY9q6y31GKWQ=;
        b=H/PJulp8NdWEg5GCLCZNyCcu7PnYq7sn0CrK1aunP9/Va3NAiT2tpFB+9cNLj44UjJgTZb
        EBidZKWS9bDsAPEW4Dz9m+FHuHmw1RNJV7kVzyh4X6YaE2A8+MJPoXZkfHON4ZzYA73xdW
        fISR28LMRyJUVKneoL8b5RixqutfQhP8Uk2FUH+tXp1oK3EBeauxPN9ceBnCDUpEQ9hbB+
        v05bBUHf5+5LfrqWShYKw4pHHl32cy4ui00eeQe+YEE24Uz/PcqtrzLmQFdYY8p5P9Glm0
        BfWJmQzn3ATb7hGDmkq5lWOw5DojQK1WP2Rpw1aeAhJqyi4gZkhA4dpubIu8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/V2ihpxA3WwS0vURZHQtur+oN9jzv/WY9q6y31GKWQ=;
        b=KgpDPuhXZS9DIP5qHaPhe9LJ6uWxazb+cN5ZuoMSHdZa4FSaN083kJFqyi246QrHYf7Ckf
        lC8ZOAaU4XJn9SAA==
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 2/5] perf: Add a counter for number of user access
 events in context
In-Reply-To: <20211027201641.2076427-3-robh@kernel.org>
References: <20211027201641.2076427-1-robh@kernel.org>
 <20211027201641.2076427-3-robh@kernel.org>
Date:   Tue, 30 Nov 2021 23:57:17 +0100
Message-ID: <87zgpl9rqq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27 2021 at 15:16, Rob Herring wrote:
> For controlling user space counter access, we need to know if any event
> in a context (currently scheduled or not) is using user space counters.

Who is 'we'?

Come on. How is someone without context supposed to figure out that 'we'
means ARM64 when staring at that changelog a year later?

Is it really that hard to write coherent changelogs which make sense on
their own and actually follow Documentation/process/ which exists for a
reason?

Thanks,

        tglx


