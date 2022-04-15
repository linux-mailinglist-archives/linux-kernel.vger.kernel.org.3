Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8650267D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351309AbiDOIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiDOIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:06:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590DDA2046
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:04:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lc2so14135294ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wRw/pC6iJAbq8IgOgAwHeaA7kFsJWyDEzT/CDMq/3c0=;
        b=DyPzs60VOqjaquhFCmTIU1huFGvTpFS2Q3D8ea17oC6cXKiIq9dnCvyq5soefWSwGO
         SMq1Yf6sIYKoQEPi59fEdu5nQsTR16XNV4vcLAu9WVg4Am9H7w9dSYyEDFw2tA1q/wok
         BzdDb7/zJhi3Goum3Zkv7ZYoFQA4Z7L/IiaQ/VOryKHwS7Z9VxoHfoZ1Ob1dmztlo01o
         8I+vIeqTz6emCxQ8Cgf73kRNtvqaD1DcEe+Hni03k/DlHD3S1MBlHqqsKUcJA2yrQsf6
         1adGXAnL5VAtweeyBVtw5Oo+mTmVCovnG/bJ99kYQhc1OR0Lgl13jLEH5bs9beH02HTD
         bSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wRw/pC6iJAbq8IgOgAwHeaA7kFsJWyDEzT/CDMq/3c0=;
        b=cfrGtocqh+Vam02HaUpPHjev8+c9QGjDxfUcBiaiZbNkL1RX5NGDZp4sZvzIU1cMMi
         VqdCON+kvjcTyehhQYK8Bym9HD4UvdasR04u9sYBeYPmiWKTWT+QrZ2ZcdV7wUO+DNAw
         NpQjtn6+rhWDxsajx45LGWSgHN6aQ+A2lKsdOdeHfrlHepxhTn8vVCiXEWPFF0+G7baT
         dWQ+vgO+kolTZ12UVy1UFfmSETI02HpVsy/ihVLr+t/eP8s3PWTfrSagz7B4Sd0nsve2
         kg+a8Uu60gEPcQRGMzPAHIbNOwL6eY0wvwO41feiaJzJYdd5p6We5pp8eOQkPF/ItcKp
         cBcw==
X-Gm-Message-State: AOAM530VrXyDa0ydTSMN9325v5gYW5wtNLfEdXh5gAvrjvzYw9muOQ+2
        mJZlI7kjLBXdo1QMJcBSNT7vud+uBaE=
X-Google-Smtp-Source: ABdhPJwNIcoC4r4J7MSintYlBjxhytSXAjiatuIfoyyRuCFmh+rjzGV+vqz1XLARpUQAcbUS5Me7jQ==
X-Received: by 2002:a17:907:7204:b0:6e8:c19e:93da with SMTP id dr4-20020a170907720400b006e8c19e93damr5276877ejc.695.1650009847891;
        Fri, 15 Apr 2022 01:04:07 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:1dce:acd2:1722:e6e8? ([2a02:908:1252:fb60:1dce:acd2:1722:e6e8])
        by smtp.gmail.com with ESMTPSA id y13-20020a50eb8d000000b0041f112a63c4sm2313487edr.52.2022.04.15.01.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 01:04:07 -0700 (PDT)
Message-ID: <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
Date:   Fri, 15 Apr 2022 10:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        thomas.hellstrom@linux.intel.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>, Ken.Xue@amd.com
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
 <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.04.22 um 07:38 schrieb Mikhail Gavrilov:
> On Sat, Apr 9, 2022 at 7:27 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> That's unfortunately not the end of the story.
>>
>> This is fixing your problem, but reintroducing the original problem that
>> we call the syncobj with a lock held which can crash badly as well.
>>
>> Going to take a closer look on Monday. I hope you can test a few more
>> patches to help narrow down what's actually going wrong here.
>>
>> Thanks,
>> Christian.
>>
> Hi Christian.
> I'm sorry to trouble you.
> Have you forgotten about this issue?
>

No, I just couldn't find time during all that bug fixing :)

Sorry for the delay, going to take a look after the eastern holiday here.

Christian.
