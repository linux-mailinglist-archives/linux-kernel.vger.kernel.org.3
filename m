Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE63449D0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiAZRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiAZRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:35:34 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B04EC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:35:34 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 9so466732iou.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZIc0fSllSEZH1gk3JGk22AP5NW4tb6II2GdmBEkjev0=;
        b=LnfjBxx8+MlxwefUxtOVRjjQeNugF5BLhAaiOjLOUI05XgLF/0FvOpyr9lunVuSSM/
         GWLE3mpgl31ce08kr2pVl/LjYH7sLAuCh9YurtESr4S0oR7i+wttHvXJnqYFmpETT3Lq
         /WYOeCzK1O7PAZZ8K2ES1Ck4JpmB4RtuQkLIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIc0fSllSEZH1gk3JGk22AP5NW4tb6II2GdmBEkjev0=;
        b=pXga1M4wGBlBgtBAQDoRlVOeY01Aj2w+wB407b3YQyGzifDFosmUajEcRaw+Qebu8r
         1fflhUv16Pt6C5dgbZ2QP+3OBr8bK0Ouf8BHtADnNKmO6NhbAxUMzgm+pWrdH3uYFLeA
         ocBg1Rk+fiZrxVyf1T44qop10FxJGCqyjUYDt8wdZ3JA9tBGnB4mGuaULi5OVTRiR/AA
         ix7SKGUNRaNY1fDydnoLKWKKy95newbaJhJHOHuGvH5uAVOpHazjLLAEvau5IBS/te3j
         FQ9ccFQodAjFTQrsbJWt1twzKHxcsp2pq2b0EqomK7Dh+zOuUuKIQYkFEq/hl3rPxMvW
         N1lQ==
X-Gm-Message-State: AOAM530dQN73RlJwpvO+D2RgJt4FxipNlTQDYLskB7XtOiFlUk1E2pn7
        MMIRJ0A50iTIdWYuyiJOMERniw==
X-Google-Smtp-Source: ABdhPJwBBSYp7lhFZ6a63yjqa1UiVsse+h9o1ohr4kLC1ezejkIkL5BQXXZZ5oix6wchCHW+SEfYOg==
X-Received: by 2002:a05:6638:2ba:: with SMTP id d26mr428556jaq.250.1643218533820;
        Wed, 26 Jan 2022 09:35:33 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:f2e:a7f7:d853:1e3? ([2601:282:8200:4c:f2e:a7f7:d853:1e3])
        by smtp.gmail.com with ESMTPSA id x6sm11128452ill.78.2022.01.26.09.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:35:33 -0800 (PST)
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
To:     Petr Vorel <pvorel@suse.cz>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "aleksei.kodanev@bell-sw.com" <aleksei.kodanev@bell-sw.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
 <61F0D9F7.1080200@fujitsu.com> <YfD0hiUSf40jX82d@pevik>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
Date:   Wed, 26 Jan 2022 10:35:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YfD0hiUSf40jX82d@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 12:13 AM, Petr Vorel wrote:
> Hi all,
> 
>> on 2022/1/26 4:33, Shuah Khan wrote :
>>> On 12/15/21 2:56 AM, Yang Xu wrote:
>>>> Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams
>>>> internals"), zram has
>>>> switched to per-cpu streams. Even kernel still keep this interface for
>>>> some reasons, but
>>>> writing to max_comp_stream doesn't take any effect. So remove it.
> 
>>> I get that max_comp_stream doesn't do anything since this referenced
>>> commit. Don't we need this test on older kernels since older kernels
>>> still support max_comp_stream?
> 
>> I read the following info from kernel selftest documentation
>> https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> 
>> "The kernel contains a set of “self tests” under the
>> tools/testing/selftests/ directory. These are intended to be small tests
>> to exercise individual code paths in the kernel. Tests are intended to
>> be run after building, installing and booting a kernel."
> 
>> So, we can build older kernel(use older kernel source) if we want to
>> test older kernel.
> 
>> IMO, kernel selftest is different from other testsuit(ie ltp, this
>> shuould think about api changes because ltp may test on different kernel).
> Yes, that's how I understand the difference with approach of in kselftest - the
> kernel tree testsuite and LTP - the out-of-tree testsuite.
> 

Removing max_comp_stream test appears to be motivated by the fact it isn't
needed on newer kernels.

Kselftest from mainline can be run on older stable kernels. This is a use-case
for a lot test rings. The idea is that when a new test gets added for older
code to regression test a bug, we should be able to run that test on an older
kernel. This is the reason why we don't remove code that can still test an older
kernel and make sure it skips gracefully.

Hence, I won't be taking this patch.

thanks,
-- Shuah
