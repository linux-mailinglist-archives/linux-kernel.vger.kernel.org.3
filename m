Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50FE47340E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbhLMScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:32:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234465AbhLMScB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:32:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613C66D;
        Mon, 13 Dec 2021 10:32:00 -0800 (PST)
Received: from [10.1.34.138] (e127744.cambridge.arm.com [10.1.34.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494113F793;
        Mon, 13 Dec 2021 10:31:57 -0800 (PST)
Subject: Re: [PATCH v1 2/4] perf script: Add "struct machine" parameter to
 process_event callback
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-3-german.gomez@arm.com>
 <D6A3A8F3-9946-44FE-A70F-42977C6F38A1@linux.vnet.ibm.com>
 <38fd4992-63ae-4871-ddfd-27d40b5c48d2@arm.com> <YbePfOMaiJjoDb3b@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <73ecfe08-f38b-1308-40b5-a1a778323bf5@arm.com>
Date:   Mon, 13 Dec 2021 18:31:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbePfOMaiJjoDb3b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/12/2021 18:22, Arnaldo Carvalho de Melo wrote:
> [...]
>
>> Thanks for the suggestion. It looks like we can skip this patch if we
>> can get the arch value that way.
> So the first one is already upstream, will you post a v2?
>
> - Arnaldo

Hi Arnaldo,

I sent a v2 where this patch was removed. The upstreamed patch (1/4
here) remained the same.

https://lore.kernel.org/all/20211207180653.1147374-1-german.gomez@arm.com/
