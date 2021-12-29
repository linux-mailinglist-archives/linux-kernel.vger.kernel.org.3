Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B902480F66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbhL2Dns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:43:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41416 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhL2Dnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:43:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9036132A;
        Wed, 29 Dec 2021 03:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2812C36AE7;
        Wed, 29 Dec 2021 03:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640749424;
        bh=pBleK/HLxkq2DSqnWGQeEvon68mcB1GiuzDLEaRVwJ0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OttH/xv7S2dUTiQWzeyhkY3LFrabD274E1InLPRlIYe6Jq8yXe2NllsWPrHkDqZ5y
         PvTEhYXG4OyHviTSfrzWzbYSL2ccshZ+978PRcFiglgG0NUhG9dF6ZHEUfhc2Nn5A4
         I7BZwmdKFcTueLd+BnyQstFHPUqzyc2JJNngRvwv8j1XTbotpF+wIPLAJHe3fThdt2
         kcbp4nuJiK0MANHSlie440HwRTKNAU6x1wJPacH8ORWIjlbKBOJCdUFNrzgfkeZpEy
         HY3/07rOOQvevMQYx5KTBbeStOvP4gycGR22pPhcnvnN0eMUePcqGufeBBl6QJrEt1
         o1mILfqZvQWNw==
Subject: Re: [PATCH] ARC: perf: Remove redundant initialization of variable
 idx
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211126222312.1125594-1-colin.i.king@gmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <6f199a8f-9e22-be7c-ba0b-ebb534720a8b@kernel.org>
Date:   Tue, 28 Dec 2021 19:43:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126222312.1125594-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/21 2:23 PM, Colin Ian King wrote:
> The variable idx is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Signed-off-by: Colin Ian King<colin.i.king@gmail.com>

Sorry for the delay in getting to this. Added to ARC tree now.

Thx,
-Vineet
