Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F324522AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiEKEZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiEKEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:25:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE383CA44;
        Tue, 10 May 2022 21:25:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 814831F44A6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652243109;
        bh=k4CAo9Y95waZZqgDc5richqC5rLeJJTWfy44Q601/Q0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=niWJrFanqGGREze6rfJDFHgENDAnnMzMPF1kW1PppuLMKTJrCqRH5Manut/a+mBZi
         qfP5A2JO/4AMj55JBTKCwMaOOFmcM6hoWeaQkyAuWSnmN5h0BpzX/+4r3DlUGq0V8Y
         LofZuROKTHNgs6pUHlJhdSIjqDzNtoy0ppPHE1sj7Roqwqw1AADwNS1IMfkPgMASJb
         9tgcrydqEl4JdMpTAomltpPNZib56Y29L7FNr29pTB0iqZrqiVefgbYjbxEmWAsmwr
         YsUxUW4/t1xacp3+wVJ2CBqyqw/XtAH+cUPfmfAYFOIrLXLHAj3CTroxJ7HX9R0mw8
         FXYT9MeAeEEnA==
Subject: Re: [Freedreno] [RFC v2] drm/msm: Add initial ci/ subdirectory
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com>
 <e4e03cd8-3ebc-e5e1-e7d0-6bdc038049b5@quicinc.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <33ab308f-f0a1-b5b9-1bcb-b4387f5a4152@collabora.com>
Date:   Wed, 11 May 2022 06:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e4e03cd8-3ebc-e5e1-e7d0-6bdc038049b5@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 9:39 PM, Jessica Zhang wrote:
> 
> 
> On 5/10/2022 7:13 AM, Tomeu Vizoso wrote:
>> +igt@kms_atomic_interruptible@legacy-setmode@pipe-a-edp-1
>> +igt@kms_atomic_interruptible@atomic-setmode@pipe-a-edp-1
>> +igt@kms_atomic_interruptible@legacy-dpms@pipe-a-edp-1
>> +igt@kms_atomic_interruptible@legacy-pageflip@pipe-a-edp-1
>> +igt@kms_atomic_interruptible@legacy-cursor@pipe-a-edp-1
>> +igt@kms_atomic_interruptible@universal-setplane-primary@pipe-a-edp-1
>> +igt@kms_atomic_interruptible@universal-setplane-cursor@pipe-a-edp-1
> 
> I see that there are some KMS subtests/tests are missing such as 
> kms_atomic_transition -- are they unstable across all boards?
> 
>  From what I've seen, kms_atomic_transition is unstable only on Trogdor, 
> but has stable results on other boards.

I don't know of a good reason for not having the tests in this list. 
Developers can follow the instructions at "How to expand coverage" to 
add tests if the driver can consistently pass (or fail) them.

There is ongoing work to have a test runner that will better handle 
flaky tests, which will make it possible to expand the list without 
having to resort to per-soc test lists.

>> +igt@kms_addfb_basic@size-max,pass
>> +igt@kms_addfb_basic@too-wide,pass
>> +igt@kms_addfb_basic@too-high,dmesg-warn
> 
> For test results on Trogdor, is is possible to have them be 
> success/fail/skip only?
> 
> Results such as dmesg-warn/dmesg-fail are igt_runner specific and 
> because there isn't support for igt_runner on ChromeOS, they will be 
> difficult to replicate and debug.

As Rob said later, it's probably better to drop that distinction. Maybe 
at some future point we will want to track expected kmsg output but I 
think there are lots of work to do before that makes sense.

Will do that in a v3.

>> +igt@kms_universal_plane@universal-plane-pipe-a-functional,skip
>> +igt@kms_universal_plane@disable-primary-vs-flip-pipe-a,pass
>> +igt@kms_universal_plane@disable-primary-vs-flip-pipe-b,fail
> 
> We could probably skip checking the results for kms_universal_plane on 
> Trogdor for now, since this is a test affected by the hack regression. 
> There is an IGT patch in the works for fixing the 
> disable-primary-vs-flip-pipe-b failure, so it should be updated pretty 
> soon too.

So, how this should work is for the patch that fixes that bug to update 
also the expectation files (see "How to update test expectations" in the 
docs). In this case though, the fix is likely to land before this patch, 
so I will just update the expectations once I rebase and the fix is 
brought into my branch.

Thanks for the feedback!

Tomeu
