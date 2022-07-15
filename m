Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C75765E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiGORQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGORP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:15:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9743E4A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:15:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l68so3168553wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fpicviDv92d17eZ1c7+rexcLir2xBn7O3KmN0Kzxfro=;
        b=UsPBSJRfmKSsPNeL3N72N6j2SQUo01hlJU2ux3y9cLehp6fsxKs1PXgrJZ+cz7Gmgb
         JkNqaSxCMH9nf6fZP14uguh+M5eHFTqBe6JhJYpBo/J2GzbsZfW1UzY+B0CIiTW9Dqvy
         qLAjdjctG+wbU9nkMzarTluwuO8Sc9dBpW9PqkG73uNVF/ZiTZ29ttfNsGaX7p/yhIOs
         La2uu/vzBds0lAHxILy5ujM+HvwGG4V3b+LLpBTuBrUJZkYT1LJ42Gj8u1VtSvl13FaU
         ADF/qRTPaXxXALqTN+FH4PQCGGHoqAjCE39skMtpYo4L+AEocC65M356N/dyODgDhADt
         cKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fpicviDv92d17eZ1c7+rexcLir2xBn7O3KmN0Kzxfro=;
        b=FFxGQy4o0AzbjgJxy3HBuOU40OBS5g5G4CHlVZeXFd7AKbERVdxLPAyAiOcvl+nWMj
         3Rl90CaNs+KUhqV8qeIBaGnhRQLWej81Z5vm+cUcuVOnr44wTBw07vzeo0m53Muvc2MW
         mOv/ki91vEPF2Bsg4OgIMEV7vwvUEwAWdgWkD/W645F22nO7mIgcIqxhbfeT600Szj3g
         yTBZMlhFuTCmWRd57qBsho9qYEVmJtbl2Q1zUnumzv/btgDNS7dafSaLDh7AS1EoY2m8
         JZqe1ubLbeQLVGUzHoGfr+dmakM+dqo8snJTndBDuv+fe2qFL/6p1M4gntuiv13fH/9R
         V54w==
X-Gm-Message-State: AJIora/5v5/Sd7r6t2K7E6ZmOYlsnUqhLq4U06mPrWQpQzd1z8iA34+I
        ux8IG4yseeXSfHxOJlmcSTLRnw==
X-Google-Smtp-Source: AGRyM1srOvCAxL5rNPwCPwV3iadtGRLjhcptNZRRVwLonHjWJkzvBYZ4nYe7xGrUVTV1L4NwYd+qcg==
X-Received: by 2002:a1c:750e:0:b0:3a2:b42f:ec2c with SMTP id o14-20020a1c750e000000b003a2b42fec2cmr21460710wmc.153.1657905354184;
        Fri, 15 Jul 2022 10:15:54 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b003a300452f7fsm7847323wmq.32.2022.07.15.10.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:15:53 -0700 (PDT)
Message-ID: <21cec7bd-e4fb-73f7-a6a6-7f52c03ae7e9@isovalent.com>
Date:   Fri, 15 Jul 2022 18:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH bpf-next v2 0/3] Use lightweigt version of bpftool
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Pu Lehui <pulehui@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220714024612.944071-1-pulehui@huawei.com>
 <CAEf4BzZ_L+94O00mMDUh8ps8RTF=kcvX1zS5ocK8fPk4uw-_kg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzZ_L+94O00mMDUh8ps8RTF=kcvX1zS5ocK8fPk4uw-_kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2022 17:56, Andrii Nakryiko wrote:
> On Wed, Jul 13, 2022 at 7:16 PM Pu Lehui <pulehui@huawei.com> wrote:
>>
>> Currently, samples/bpf, tools/runqslower and bpf/iterators use bpftool
>> for vmlinux.h, skeleton, and static linking only. We can uselightweight
>> bootstrap version of bpftool to handle these, and it will be faster.
>>
>> v2:
>> - make libbpf and bootstrap bpftool independent. and make it simple.
>>
> 
> Quentin, does this patch set look good to you?

[Apologies, the mail server has been filtering Pu's emails as spam for
some reason and I had missed the discussion :s]

Looks OK to me:
Acked-by: Quentin Monnet <quentin@isovalent.com>

Although I'm a bit sorry to see the sharing of libbpf between bpftool
and libbpf go away. But OK. We can maybe reintroduce it through
bpftool's Makefile or a separate include Makefile in the future.

Quentin
