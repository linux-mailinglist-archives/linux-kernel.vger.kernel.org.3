Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89452AD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353045AbiEQU4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353138AbiEQU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:56:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636B55BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:56:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id fu47so291537qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IlwUjNSLf76IqlK4dytNhwOeLSPnXacyr795IjKBjN0=;
        b=OhMMKe4D/Xy4ZfBgi4xNp/2vinjcK1iw9/dAHtcgVHLrurwYDrxu+nvOuw6/1QxysI
         6QaUP0Xphjt8+WFHFz9mMPJCGlJ8cxXARBeTpcubZhogfi32h9bDuDPIM/ehqlanH+FG
         zQC/R8uYxpXzjBokrAVv5F8CsznHIAKSvPdVLo2hXgt1ygUGIIN/PBS1VvfNQAUbj58r
         iNqUWGaaQm4bqgvRit1H7duT8ehgKFPB94Dx3olM0Z3T2PlaC4kTe2Pci1ypIZU2kVLp
         3LZqfU/RjwK3UIQjoEHTLemGexjTRhgHH6cF99pf93CP6bGgM/fe6fPUO/W8yVtiocm7
         +Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IlwUjNSLf76IqlK4dytNhwOeLSPnXacyr795IjKBjN0=;
        b=MJfdj32LxGTcUXDRfTFHNBO9D1yLab5//rX7uXOHp1HiD9HnfC07pr8eAYoLQfPgKJ
         8lngkZChTvAWxfx1UWNg+mmEA3/+zqYpddskUEJaz69YhuFdIJLoEuY50g6uTcsUEH0i
         JLCtSqCw6tNCxEgnCbDq9Q1EZbTV1MXoSrBWxGA7byfgT43v/A0zEbnqvK2MGT1dphDo
         USbsdsARztaEHs8z0xrjiOyJ+cG6R6bvo9I6c7H00zeMp4VUJxKXiDAWM9GLxkGJOpEn
         UpdYMSQTZFh278hjaGeiZQpHRAXqudHYYS2YvHy0tkV3nzS5TP/ziK1bKVYJ9aOywnlo
         yhpA==
X-Gm-Message-State: AOAM532TEBtLR2imKIfJeTo9wicDv0EOk9cPUwQSPavJPyQmm5MwcSI+
        qiURvJmMNXlnFesK3yuuN/xAqWpyU/g52A==
X-Google-Smtp-Source: ABdhPJzI8jTA6RPSQ/jSxS3vrh06ZHXlk0E56JG7bV/rr2t7IxudeVW3ddgVrP3RbcBI/Af2Qwrl9w==
X-Received: by 2002:a05:622a:1a24:b0:2f3:bc7c:dade with SMTP id f36-20020a05622a1a2400b002f3bc7cdademr21557051qtb.647.1652820968738;
        Tue, 17 May 2022 13:56:08 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 78-20020a370a51000000b0069ffe63228fsm112755qkk.121.2022.05.17.13.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 13:56:07 -0700 (PDT)
Message-ID: <1cbd12ad-4147-5d97-ef7f-4104b630244b@linaro.org>
Date:   Tue, 17 May 2022 15:56:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on
 trogdor
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20220517193307.3034602-1-swboyd@chromium.org>
 <ceb32b66-1341-d54f-a60a-5c342119c784@linaro.org>
 <CAE-0n50rUW7Lqk4CwfSUgKYEJzwjXuVohAnbj9uKA=kEkXikyw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <CAE-0n50rUW7Lqk4CwfSUgKYEJzwjXuVohAnbj9uKA=kEkXikyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 3:06 PM, Stephen Boyd wrote:
> Quoting Alex Elder (2022-05-17 12:51:34)
>> On 5/17/22 2:33 PM, Stephen Boyd wrote:
>>> We don't use this carveout on trogdor boards, and having it defined in
>>> the sc7180 SoC file causes an overlap message to be printed at boot.
>>>
>>>    OF: reserved mem: OVERLAP DETECTED!
>>>    memory@86000000 (0x0000000086000000--0x000000008ec00000) overlaps with memory@8b700000 (0x000000008b700000--0x000000008b710000)
>>>
>>> Delete the node in the trogdor dtsi file to fix the overlap problem and
>>> remove the error message.'
>>
>> Is the mpss_mem node (which defines 0x86000000-0x8ec00000) correct?
> 
> I think it is. Modem is working for me.
> 
>>
>> You're right, we don't use that memory on Chrome OS, but I just
>> wondered whether the other node might also have a problem.
> 
> What sort of problem are you thinking about?

At some point in the past I think some of these carved out
areas got updated (perhaps on sdm845?).  I.e. they were
wrong, and got corrected later.  Some things worked despite
that.  So the problem, for example, might be that the
mpss region is bigger than it needs to be.

I don't *assume* there's a problem, I was just asking,
and maybe Bjorn or someone else can verify what's right.

I'm done for the day right now; otherwise I'd spend a
little more time trying to track the information down
myself...

					-Alex


>>
>> I don't actually know...  Bjorn, do you?
>>

