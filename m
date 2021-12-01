Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93A464A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348209AbhLAJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbhLAJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:29:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61EFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:26:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so50763489wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h6vtMpd8C2OVSmV4kXIfdV5q7UU768pshmu8uo8Dncs=;
        b=H9e7UsKFATLHgRApvxytRa6rR1qLReWi0Fxf21UaTOSFEH1zFudVH7ZXF4mDT9GTQ3
         kA2tbpbUKRx9aDnwoHav7ZAvxnB8UjiNAiUnvh52wFA66O93qfcSZQOy9E/yeiSoTGvT
         v1NALbM618jSQYef9DuNrDXoqFut0cugRzcdRTc3N+8ZqjmUAAQS76GKieX5V1x4dt5R
         i3iHBe/P6STvHiwW8WYm24G0wHptnZb2gjdlBso+WZAHcuC2OQPHWl7tUoZLYFFDYNWB
         91b3RX7VC16Jp0A+EkqANANqk1aKaokeO9i9YzMFyaEdTjcQOIZjO7dxx9v4ywBMnh79
         FjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h6vtMpd8C2OVSmV4kXIfdV5q7UU768pshmu8uo8Dncs=;
        b=2CfpC6cnsXbkxckYnr1Q4bOrfaYsM2po/7wUXX4SMaU2G08jsl3+fuZ7z31YmSFyEo
         ysRqfMFTyjBDSvPQis5wKnbkEd27P0U+jehUFXPnf3+ls7Wpyeklwv9kVAxYDxsLAFtT
         Rqe3tMY+xEo/UMgXSla4daRE3KfAVM/a1mWlFsjiR6RZuqWGji2/sHLYUEfWaDKN6nq2
         Rq3b0QV4VqLIO0h+wZRQ+CQh+dWj0f2zgiqpkmXdlcPtR7n2yM7Gyq8Jg77FZu5MG54w
         OL0gh69SbJip/vE8srn83w492wT/m3doM9oYvCLC28I3DLHHlzbsZfLIU1dqTfHKJijV
         YTHg==
X-Gm-Message-State: AOAM530S742YLrkIjufqTuGqHksxqwNPmw/jjugNLZ3G9+qvObSd7w19
        wjQLsAxTyKZKQjxju77aVGnt7JyoCcqgekGk
X-Google-Smtp-Source: ABdhPJz5oJJMEyrhU9Df4sLOzl5l4NSa49qltp90IxNBFfQLiyMm6db7Ld4xZWuVzcGZO1xu+mhi+w==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr5440858wrn.521.1638350778216;
        Wed, 01 Dec 2021 01:26:18 -0800 (PST)
Received: from [10.1.3.24] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b13sm15555246wrh.32.2021.12.01.01.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 01:26:17 -0800 (PST)
Subject: Re: [PATCH] arm64: meson: fix dts for JetHub D1
To:     Vyacheslav <adeep@lexina.in>, Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20211125130246.1086627-1-adeep@lexina.in>
 <163826896367.1309037.1000352899984422910.b4-ty@baylibre.com>
 <2ee1dea9-df39-ee76-4079-0ded15ed43c7@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <cb425c20-f699-7b24-2ef3-d798f417d09c@baylibre.com>
Date:   Wed, 1 Dec 2021 10:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2ee1dea9-df39-ee76-4079-0ded15ed43c7@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 19:48, Vyacheslav wrote:
> 
> 
> 30.11.2021 13:43, Neil Armstrong пишет:
>> Hi,
>>
>> On Thu, 25 Nov 2021 16:02:47 +0300, Vyacheslav Bocharov wrote:
>>> Fix misplace of cpu_cooling_maps for JetHub D1, move it to right place.
>>>
>>>
>>
>> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/dt64)
> Thanks. Could the patch get into 5.16?
> 
>>
>> [1/1] arm64: meson: fix dts for JetHub D1
>>        https://git.kernel.org/amlogic/c/03caf87822220b4e22c349d170881d122df0b349
>>

Moved to v5.16/fixes with fixes tag:
Fixes: 8e279fb29039 ("arm64: dts: meson-axg: add support for JetHub D1")

Neil
