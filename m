Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3BF48E78D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiANJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:32:08 -0500
Received: from foss.arm.com ([217.140.110.172]:58832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbiANJcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:32:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5A7101E;
        Fri, 14 Jan 2022 01:32:06 -0800 (PST)
Received: from [10.57.34.164] (unknown [10.57.34.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155F83F766;
        Fri, 14 Jan 2022 01:32:05 -0800 (PST)
Subject: Re: [PATCH 0/2] perf: arm_spe: make the PMSCR CX bit[3] consistent
 across the session
To:     linux-eng@arm.com
Cc:     james.clark@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220113175417.5523-1-german.gomez@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <4f28367f-f6a2-fcca-dd33-c98daeb6bc11@arm.com>
Date:   Fri, 14 Jan 2022 09:31:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113175417.5523-1-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies everyone, this was a missend.

On 13/01/2022 17:54, German Gomez wrote:
> The value of the CX bit of the PMSCR register is not consistent across
> a perf session. There is an example in [1/2] to reproduce the issue.
>
> This cset applies a small correction to fix the consistency issue.
>
> - [PATCH 1/2] Makes the CX bit consistent by caching the value during
>   the initialization of the SPE PMU event.
> - [PATCH 2/2] Allows CONTEXT packets when profiling in CPU mode.
>
> German Gomez (2):
>   perf: arm_spe: make the PMSCR CX bit[3] consistent across the session
>   perf: arm_spe: Enable CONTEXT packets if profiling in CPU mode
>
>  drivers/perf/arm_spe_pmu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
