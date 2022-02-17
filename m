Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543814BA2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiBQOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:21:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiBQOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:21:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159221F6BA9;
        Thu, 17 Feb 2022 06:21:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso9617850pjg.0;
        Thu, 17 Feb 2022 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zkjfkwq/YomfxBvSBbQLb7tDBf/0siF/BKq3uCb8pFM=;
        b=jMK94xUwVfJts3RC2Izy1WmyoCtbGVSEPm8Kx8sPtZPjc3NqZtRixRlr0ysz136PiF
         eb7KAaREvGNeyXgd4cFAZtUbKRsrmllKOD3MFYtEbG1EP/m9SOW4W2PoXC9HzuQS8eyr
         /i0hv8zPKOWolVL8Yar5CBfI6WlrOxoJZ/Xa6tIGL2R8BzvQazryk2HReWW4j9bYAR+o
         2Sy5r9BQQYsK9HTlCWcfI9A9C6whs/Di8TFh/lTZ1UJbR8wEWGf3OxQCZYgt/NLjTVk3
         WVlFInKRTjzB8qyzxDPqXK4HiicNUICrGwan6u/VQcARwzlkn2e0gkQzAkKrcd5fDEcQ
         vGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zkjfkwq/YomfxBvSBbQLb7tDBf/0siF/BKq3uCb8pFM=;
        b=ADCLZpUx38mEjI1eiL32d7xCxtLRQlTZBYB5gzC5FdgkoxEAkanf7q+HbR0IiLmCs9
         eIYLg1CDpvgDIB7N7TYw5RikzLe5Ea4KXXA1yPP2KhS+QtWSYJH3tbqkDhFFH0YVF9I3
         4P3Vo2ufMhqJVTwYt3AHEzvBhpwBdbv2EB9knh8CQU4n/ecMU8HDvtIAOdAAH5kqalnw
         1P+eAgJGNZ7ePxGLWorCifEAcMemKn31Hzz+JA9xzl7vo7qALoKsx8s4QxtO+3SRtl+D
         i/3S4wyJe6e7BG/HoEDBBoopKb1l+S1xn/RVo6nat3U5J2dQwU22u344FsJi/IwkSfOI
         SzzA==
X-Gm-Message-State: AOAM531srkN4xJmqQPKcKMRp14n0wPpBYsVbrnZvQmQg01J0cO1yPfNM
        7IYv4asknHWScRZBAOo43HU=
X-Google-Smtp-Source: ABdhPJztQKiBOsjV2AzbPif9n2PyHL/tB203hJrI3taKE8NrxtwxPGH3UVmvE5Mw0sMj+ftWt3WqdQ==
X-Received: by 2002:a17:902:8497:b0:14f:919:9fdd with SMTP id c23-20020a170902849700b0014f09199fddmr3123094plo.52.1645107699583;
        Thu, 17 Feb 2022 06:21:39 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b21sm2077067pji.22.2022.02.17.06.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:21:39 -0800 (PST)
Message-ID: <cd8b2f4e-6ec4-af27-4f9b-b1dc754ab322@gmail.com>
Date:   Thu, 17 Feb 2022 23:21:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] docs: pdfdocs: Improve LaTeX preamble (TOC, CJK
 fonts)
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
 <87zgmr66cn.fsf@meer.lwn.net>
 <d0ce2c79-4e4d-9373-3ab6-e1e355224559@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <d0ce2c79-4e4d-9373-3ab6-e1e355224559@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 22:00:04 +0900,
Akira Yokosawa wrote:
> On Tue, 15 Feb 2022 16:46:32 -0700,
> Jonathan Corbet wrote:
> 
>> I've applied the set, thanks.
>>
>> I do notice that Documentation/conf.py is getting large and
>> unapproachable.
> 
> Yes, I was having the same impression.
> 
>>                  At some future point, it might be nice to pull all of
>> the latex stuff out into a separate file where it won't scare people who
>> stumble into it by accident.
> 
> I have an idea to accomplish this.
> 
> Will prepare a follow-up patch once you push the docs-next branch with this
> set applied.

Jon,

The head of docs-next I see is commit 4fbe7b19a948 ("docs: Fix wording in
optional zram feature docs").
I think you have applied my patch set on top of it.
I'd like you to push up-to-date docs-next so that I can start preparing
a follow-up patch.

        Thanks, Akira

