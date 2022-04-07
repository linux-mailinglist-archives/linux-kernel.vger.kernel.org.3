Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8864F7F44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiDGMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiDGMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:42:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB71C108
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:40:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so8754711pjn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7D8Ly6E/D0GIQp5m461xt9+4DtgR3fN6dwKvGgUnNKA=;
        b=00qOgD0OD+TgEfEu65gLljAe/Iu1yrm/VJMQNC/IzQk+b5+F0eqO43hZL6Pes6ALrb
         SVwqvp1bYJSYrtdhqQHcuFo++IMfL/PQYVe3zContoSyi/3tSLh4HjuqcHcfyRzjbyaB
         jpSoeiOagcky1S5l5V3LBm546a1/Bq98FUDaQQpLqOF6nxfU0F8xmEh+1bgAPKMjhp0S
         kkSr09fb8KzbneTuKfHnK/ZnG+6+85+6LNVGiDQvrsDMi0MEfGkaZ210LlwxcwejCrdi
         NTdL6LN7fb1PDLpllGrpUjbB1ysduUl5QovKOF7fa6R1vB1lEkO2yGTjmGGMRIeqSzWe
         nkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7D8Ly6E/D0GIQp5m461xt9+4DtgR3fN6dwKvGgUnNKA=;
        b=eoZxEcEbP46/ROQ1RBjzMIFzbilc9G6FVH3yu0EIfmG0lFm0H0MnPKbkskpVxTB/jY
         y95LOuUU/pzFvLM8U6FMHV2fhDrEjeoTyiVSAnVrc8Qw/SzlkIgDZxF2WsTyW+KmftCG
         J64+TAsQ/9JV0Uoksw9ow5LihhcIWsgs3Xu8ncKg6psydRUBmmkNz94BTx4hLKMXEB8e
         v967/vE0N1oVmiU0BWmaezVZq+i5zAdLbdqDTDpTxPz8oCu1YXWoSWOqpe2m029pslvN
         Iyxs6U0U2Z3Un0usYaSteUZ0+yvooPtxtviWR76VcRiczwLyYMJ4mRaWjRjRCorAtaAy
         UFrg==
X-Gm-Message-State: AOAM5305X9VrRSsWNx9i39piZkO6xfgiXMrBe1e7Y+LmqOE8FV2wDLJP
        QBT+2G4p6LtzWAV+1P9D3SlIBQ==
X-Google-Smtp-Source: ABdhPJy3Cb6npz6MEcQ+JjJHojbQTebgfXDeYnnR6FF0CxSMKMVQNaX6eURMR79cB9ugNzwQoUBRJQ==
X-Received: by 2002:a17:90a:fac:b0:1ca:5eb8:f3b2 with SMTP id 41-20020a17090a0fac00b001ca5eb8f3b2mr15878473pjz.37.1649335203985;
        Thu, 07 Apr 2022 05:40:03 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6c:f010:8831:9916:fb54:54f1? ([2409:8a28:e6c:f010:8831:9916:fb54:54f1])
        by smtp.gmail.com with ESMTPSA id o4-20020a625a04000000b004fdf5419e41sm15280638pfb.36.2022.04.07.05.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:40:03 -0700 (PDT)
Message-ID: <7db864d6-16a8-8393-269e-f8904900f4fa@bytedance.com>
Date:   Thu, 7 Apr 2022 20:39:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v3 3/3] arm64/ftrace: Make function graph
 use ftrace directly
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     mark.rutland@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, tglx@linutronix.de, catalin.marinas@arm.com,
        will@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
 <20220224093251.49971-3-zhouchengming@bytedance.com>
 <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
 <20220322094100.73dc3ad0@gandalf.local.home>
 <7807fc23-c6c9-b6a9-62ef-e34e8beefdea@bytedance.com>
 <20220322104956.42203163@gandalf.local.home>
 <69edba11-6d15-b80a-5840-86834101f76d@bytedance.com>
 <Yk6nw1kWC28c9W2k@sirena.org.uk>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yk6nw1kWC28c9W2k@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/7 16:58, Mark Brown wrote:
> On Thu, Apr 07, 2022 at 10:26:53AM +0800, Chengming Zhou wrote:
>> On 2022/3/22 22:49, Steven Rostedt wrote:
> 
>>> I don't have an issue with this patch, but it needs to go through the arm64
>>> tree.
> 
>> Hi Mark, would you mind picking this up for arm64 tree?
> 
> [Different Mark here...]
> It's Catalin and Will who pick things up for the arm64 tree, AFAICT this
> was sent before -rc1 so you'll probably need to resend it to make sure
> it gets picked up.

Ok, I will resend it. Thanks for reminding.
