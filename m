Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B749C7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbiAZKic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:38:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37924 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbiAZKia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:38:30 -0500
Received: from [127.0.0.1] (dynamic-002-247-255-194.2.247.pool.telefonica.de [2.247.255.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 539241EC032C;
        Wed, 26 Jan 2022 11:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643193505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUF5MXDkS5s86gTz8iswnR0nRof+hvmKQAqLsKqNNVw=;
        b=QBseN54oMY9gNAZbAQG0Aw0RHrt1FBcLEaXB8e7ErvZNfJUbiEf4XEQVRqpOy2YkHNXfOF
        jsaUdRI9do/XYSe7QifwComFo8PSwA5YZpBJfEQv05vo5d8foElSR+c68jEreup8lzunOA
        Mbu8yrZbQ4p1SlwywCh1bnwtizojyAE=
Date:   Wed, 26 Jan 2022 10:38:22 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        H Peter Anvin <hpa@zytor.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_perf/x86/intel/pt=3A_Add_a_c?= =?US-ASCII?Q?apability_and_config_bit_for_event_tracing?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220124080651.2699107-2-adrian.hunter@intel.com>
References: <20220124080651.2699107-1-adrian.hunter@intel.com> <20220124080651.2699107-2-adrian.hunter@intel.com>
Message-ID: <579106E0-687D-4731-8B70-1997DE9A76D9@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 24, 2022 8:06:50 AM UTC, Adrian Hunter <adrian=2Ehunter@intel=2E=
com> wrote:
>From: Alexander Shishkin <alexander=2Eshishkin@linux=2Eintel=2Ecom>
>
>As of Intel SDM (https://www=2Eintel=2Ecom/sdm) version 076, there is a n=
ew
>Intel PT feature called Event Trace which is enabled config bit 31=2E
>
>Event Trace exposes details about asynchronous events such as interrupts
>and VM-Entry/Exit=2E
>
>Add a capability and config bit for Event Trace=2E
>
>Signed-off-by: Alexander Shishkin <alexander=2Eshishkin@linux=2Eintel=2Ec=
om>
>Reviewed-by: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>

These patches need your SOB to represent that you have handled them on the=
ir way upstream=2E=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
