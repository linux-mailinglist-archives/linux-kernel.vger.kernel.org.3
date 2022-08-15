Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAFD592AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiHOICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbiHOIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:02:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E0AB1B791;
        Mon, 15 Aug 2022 01:02:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0BC7113E;
        Mon, 15 Aug 2022 01:02:25 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FD53F67D;
        Mon, 15 Aug 2022 01:02:23 -0700 (PDT)
Message-ID: <a15dd3b3-dd7c-4c7f-0eb9-ac1d6f2d608c@foss.arm.com>
Date:   Mon, 15 Aug 2022 09:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <YvahJcUNAZ0WC8fj@kernel.org> <YvahnOSyts95F8xm@kernel.org>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <YvahnOSyts95F8xm@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 19:53, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 12, 2022 at 03:51:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
>>> previous older versions of test scripts that are editor backup files
>>> as well as skipping perf.data files that may appear and so on.
> 
>>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
>> On the next series, please add to the cover letter a summary of what
>> changed on each repost.
> 
> I also saw that several of your patches got reviewed and given
> "Reviewed-by" tags, so if some of the patches in the previous versions
> didn't change and received Reviewed-by tags, please collect them on the
> current version.

I changed the Author. wrong email address (I missed it). So all of them 
changed.
