Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81648C1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiALJyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiALJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:54:16 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F9C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:54:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u25so7716508edf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RKo91di2sOasHWwOkOS7vEgFOhyymD7QyATPRQc4HnE=;
        b=dhdxs48L7s30gK/LWnk7/LY/XQt+a1JqMVuYyaEUY8Av/6F6qVezkPvduJsHUMqKpq
         EZmjEqF9tQeEUU+g8abw7ZOyLQdox9S0D02A36aqV78bOhnjASi0xoAT6R1H0/2n4xZ1
         0aDvTw2V4rcJzbx0xf1xdPtC2eprfy8SSFZKHp7VZZyRY+4olN8ccqUcDnL1n6AsuLwL
         1efuyHToMl11EjOdWI4bdckpnlZ6DNrvz5KcQ9AScNaEPd+6NjVEEmaZAvyPoD38xmlK
         qRQ0EU0PHAlIXLoPdF/lHb5dizmxeCwAfP9h8GnR4NSqbzWix8cUrSnlKbwXO92Pg21E
         DQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKo91di2sOasHWwOkOS7vEgFOhyymD7QyATPRQc4HnE=;
        b=z3yAQOvhnUPU9rpWLylyQt9s57PrHnct334CFIDO46nQ7k97xApE5SujDdhQb0vUFi
         wKSqTuKGPZPfQioxILtdWTfP9RznO0odftYHCk7b7EvqmLIlJ0mZrjrCRX29WrqDJL5E
         1gBUdyYk6e1Bbeu++U+AgCEGLPZQVElDLjrbocxZDMRI6huuwYTV6OFSTVj5j1Rael+T
         r0gvkrwjtzfxk86E9MVz1/kBjCN6vlOXxhSIMtMYdvbE61XUJ8t7NM0Zw6ppJZpzpwSU
         YzKcz2vefB18cVMMBS7z/SCSXOhEEDaBk+JQ3yg+OFux+3uRDrhRdEc6Giph4nHPPAwd
         0Nig==
X-Gm-Message-State: AOAM530xR0e6tlIL+eRgUBuyRieHKAI9vTwtIKXV2omIQ67V80cLZrwa
        rzKJAiIt7lWpk7+hW0g7xcq1wA==
X-Google-Smtp-Source: ABdhPJwYI5jsn5NntCskA59252Yue4qHC6eXASgCoNeTw9BHxn+PYKQqQjDTiE+E0BmKshC/+z5WwQ==
X-Received: by 2002:a05:6402:490:: with SMTP id k16mr8348720edv.99.1641981253877;
        Wed, 12 Jan 2022 01:54:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.239])
        by smtp.gmail.com with ESMTPSA id z18sm6056989edc.76.2022.01.12.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 01:54:13 -0800 (PST)
Date:   Wed, 12 Jan 2022 17:54:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 07/12] perf test: Add simple bubblesort test for
 coresight aux data
Message-ID: <20220112095408.GB3322255@leoy-ThinkPad-X240s>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-7-carsten.haitzler@foss.arm.com>
 <20220103080037.GB2660949@leoy-ThinkPad-X240s>
 <5b46181f-2162-e07d-c142-e257583daee8@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b46181f-2162-e07d-c142-e257583daee8@foss.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On Tue, Jan 04, 2022 at 03:13:08PM +0000, Carsten Haitzler wrote:
> On 1/3/22 08:00, Leo Yan wrote:

[...]

> > Furthermore, I expect the bubble sort is to be used for testing the
> > CoreSight configuration, e.g. it can be used to test for the strobing
> > mode (and for validation AutoFDO).
> > 
> > How about you think for this?
> 
> I actually didn't include any autofdo testing as this was mostly a matter of
> tooling after you have collected a trace. Run through the trace data and
> then build up a good image of the execution of the target and that would
> probably belong in tooling outside of the kernel. The idea here was to see
> if we do collect sufficient amounts of data and that the data looks "sane".

Yeah, this is consistent with what Suzuki told me that the main target
of this patch set is to verify the CoreSight trace data quality.

> This is all about looking to see if we only get a single block or only 2 or
> 3 blocks then it stops or no blocks and then with various stresses on kernel
> (memory heavy, cpu heavy) to see if anything will greatly affect this.
> 
> The bubble sort does allow a basis to build some fdo tests on, but having a
> baseline of "does it collect data at all" to start with is a good call. I
> had not tested the strobing yet as that was probably another phase in this.
> Most of this was about getting the core infrastructure in to be able to add
> lots of little test tools we can run and the harnesses to run them and
> collect statistical data over time.
> 
> Just a side note - the asm loop is arm64 specific and thus it's good for
> testing an exact result from, but bubble sort is portable. It would allow us
> to use this for an Arm  64 platform like the Morello board. I've been
> keeping in mind "be somewhat portable" for this reason.
> 
> The only downside of keeping this test I think is that the whole test suite
> takes a bit longer to run. Is this sufficient a concern to remove this test
> from the patchset given the above?

So my essential purpose is to condense test cases as possible :)

For example, although the Arm64 asm loop case and the bubble sort case
have different execution flows, both of them actually are to verify
verify a complete process with CoreSight trace data recording and
reporting (so covers CoreSight driver, perf tool and OpenCSD lib).
Since we can pass different loop number to a test program, e.g. we
already have one case to test very small trace data with Arm64 asm
loop, why we still need the test case of bubble soring with small
array?  Seems to me that more cases are not bad thing, but if both
case work on the same integration flow, I personally think these two
cases cannot give us significant benefit rather than single case.


Throughout the whole patch set, my another concern is some test cases
are platform dependent.  E.g. if mainline kernel contains these test
cases and later a developer reports a test case failure, it's difficult
for us to figure out whether the failure is caused by the platform
factors (e.g. memory usage, timeout, etc), or it's a good exposing for
any issue in software components.

So for a test case requiring very small resources, we can set a strict
criteria, for a test case with big chunk trace data, we can report a
percentage value as the profiling quality metrics (e.g. we expect 1000
branch samples, but the result only contains 100 branch samples, so we
can output the quality metrics as 100 / 1000 = 10%).  This can allow us
to easily conclude that the underlying mechanism works well, but the
profiling quality is bad caused by losing tracing data.  In other
word, we can convert the quality result from binary format to a
range value [0% .. 100%].

Thanks,
Leo
