Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C266A4869A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiAFSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:18:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53938 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbiAFSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:18:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2502B822E3;
        Thu,  6 Jan 2022 18:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489DFC36AED;
        Thu,  6 Jan 2022 18:18:26 +0000 (UTC)
Date:   Thu, 6 Jan 2022 13:18:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCHv6 4/5] tracing: Add register read/write tracing support
Message-ID: <20220106131824.073fbe5c@gandalf.local.home>
In-Reply-To: <76983c26d889df7252a17017a48754163fb6b0d5.1638858747.git.quic_saipraka@quicinc.com>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
        <76983c26d889df7252a17017a48754163fb6b0d5.1638858747.git.quic_saipraka@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 12:24:48 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:

> diff --git a/kernel/trace/trace_readwrite.c b/kernel/trace/trace_readwrite.c

This should not be in the kernel/trace directory. It should be in the
directory of something that calls it.

-- Steve


> new file mode 100644
> index 000000000000..10ebe3c9687a
> --- /dev/null
> +++ b/kernel/trace/trace_readwrite.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Register read and write tracepoints
> + *
> + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
