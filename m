Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022055664CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGEICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGEICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:02:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7185C54
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:02:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z1so4558966plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n0R6nbAYcFlIlocqvmmsPrIIpCpktqVZQJ8z9/fyVK4=;
        b=Z98svj9VDXHOVooOTVV01w+BAvRGgzkgrFH1ejhIzr5DYJYG6YuFewJBYrNbn0h0LG
         s8O1JgdMhQEiPsiKqI/+uj2g1I4cwvtyP1ptlTPReMTQ90irMiUxvxYHABDE5gI9TjWC
         6Xu0oSrZVi+hwhxgmaatmt89nD1iHChiwxja5hyhKGZ2/ExkmOZxCcJ2tLRj3OjLtWYh
         CdACAONvvfs6Tv9vbdjPRadhd7pcREdtew0dKS7X5Hejjl9pgERnJnljhOJUYHFllb8F
         6MuN9BvtA9j5Oogv8IZqrw0An1xaUuMZDuMtwi9mCU81BcFoQn4A1GYsSuQxL/XacAea
         b/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n0R6nbAYcFlIlocqvmmsPrIIpCpktqVZQJ8z9/fyVK4=;
        b=aTyh7bcikdWtl96eS1PeMXL6kEOtIkktGI00uxQLFo0nBjrnGLivJZIUfmEwPfu3Kp
         ox4gFrQ1xPf1rKCzRHw9te5fCo4RYAVgYt8tFhQkagVtxrULaGJoYhlKu/5frnaGZvTP
         t02e//30uxTk5Ty0KcAWaVV8DyAqWaxe+VMIhL3erGxm9369O4LCyI1zJge6tFycx9Da
         99lQLetI1a7NOb2U6slWBiibRxAfsRBuRvn0omOmTa1u3+9Z9EaMaQJ9lXzXgKHeA4TH
         OEszKK5Z8Kos/R3uuI5VzuZVy411ZGzsCUnTGa6ITxNOUVbmPAIAYTXYag5O2m/jTczq
         v3Jw==
X-Gm-Message-State: AJIora8mKdnbePO37tPp6G+arBRy5n5aU/rWW8goAEwGmn9u4UPukk5W
        RxKSd7quz4uryOMJriV8OY3JNg==
X-Google-Smtp-Source: AGRyM1vcY7StP2D8I4GYxNQ8t14MTiB9EtldjbEWH+eZ5Gl4s2dEXeGTbgeH0Vow/htgL57Esu2b/g==
X-Received: by 2002:a17:903:3247:b0:16b:e386:dcc9 with SMTP id ji7-20020a170903324700b0016be386dcc9mr9752055plb.54.1657008148367;
        Tue, 05 Jul 2022 01:02:28 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b0016bf0b1e771sm1085389pls.19.2022.07.05.01.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 01:02:27 -0700 (PDT)
Message-ID: <5d1909e6-54bf-5511-74e0-e9c62fcf66c3@bytedance.com>
Date:   Tue, 5 Jul 2022 16:02:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [External] Re: [PATCH] sched/fair: move nohz definition to where
 it's used
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220623130325.49813-1-zhouchengming@bytedance.com>
 <xhsmhwncsf15y.mognet@vschneid.remote.csb>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xhsmhwncsf15y.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 15:50, Valentin Schneider wrote:
> On 23/06/22 21:03, Chengming Zhou wrote:
>> The nohz definition is too far from where it's used, just move it
>> to the right place. No functional change.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Standalone cosmetic changes are very unlikely to get anywhere, I'd suggest
> bundling this with some other non-cosmetic patches hitting the area.
> 

Right, make sense, just minor grumble when review the code, sorry for noise.

Thanks.
