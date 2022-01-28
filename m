Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9949F84B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiA1L0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:26:31 -0500
Received: from foss.arm.com ([217.140.110.172]:37828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234386AbiA1L0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:26:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94601113E;
        Fri, 28 Jan 2022 03:26:29 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138D73F766;
        Fri, 28 Jan 2022 03:26:26 -0800 (PST)
Message-ID: <e84cf689-10a5-c63f-b574-9da682da034e@arm.com>
Date:   Fri, 28 Jan 2022 11:26:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 4/6] Documentation: coresight: Turn numbered
 subsections into real subsections
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220113091056.1297982-1-james.clark@arm.com>
 <20220113091056.1297982-5-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220113091056.1297982-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 09:10, James Clark wrote:
> This is to allow them to be referenced in a later commit. There was
> also a mistake where sysFS was introduced as section 2, but numbered
> as section 1. And vice versa for 'Using perf framework'. This can't
> happen with unnumbered sections.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Looks good to me

