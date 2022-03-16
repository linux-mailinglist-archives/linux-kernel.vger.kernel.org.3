Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC824DAC77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbiCPIbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345036AbiCPIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:31:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCC51E50
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:30:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so1793331wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n4jT1RjeJJWHOEdN70qWuAEROGM9ltzRtlg+VHWsxEQ=;
        b=NLexxdFUOR7amVsGtzjMppUS9aSAXjUPyKgLqix1jKarrLQmiTjZHcUOk4YLE5dEpn
         2vmstUncqBvlVBKuI4IizdbNFbxkBnpaPhjWtljYv5Yugsap6H1WzcJ3aWEHX2gLBtvh
         6DVkkzBVRyGsfrc6ROhbxhcRuGE6AJhogrZ2HhIL0PGAy6/H5sqRhQg5/20inF+TCeHl
         GLUELF81qxNF1muJUCFJ9Ea6qTz7kyXQw2WVYrUzn8ClH/E185Xp8tyLzZXjOF8OCYZj
         60IRtMs9Qas6DiYqBiiCRqVNQZwmqDRBt62YQrG997eBTFkSQOW8LfeUAYpWWWAShVpm
         qpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4jT1RjeJJWHOEdN70qWuAEROGM9ltzRtlg+VHWsxEQ=;
        b=TTCl3Nlne+zQ1e+gUeIiRbn7zJU5goBs1WHh10M8pkX8LVh0CscnYUrNxZOQ9VcRjp
         Y0Dhy0PEt8qB0xEOLUDJpRq22MEaQfEGLOhyBKpQpAtKfzVxLiFrl/R6hiAl/XVkGi5P
         jVrw3vOk8mmBYR3dtNTvjz/BVvrxv4tA5bWMzZfG+tLXw8nFbOkUT7yp+u1t76fWeTSm
         8ijub+zHc+VMFgvg+Gkc4529v5yamRjD3IvS5Y7eA1fuuIvYeCEXdlR18r0D8qixpe9W
         +iQcupCLFPmENImEtWC1UaHTnyYhAquf+EEon/R3Ex5Lje/7m3gFbjCx15BIfSCe435c
         oSuQ==
X-Gm-Message-State: AOAM531VLxqe4vlfKg8p/lUugv2MYc22iZ10BfnzcAv9MPdNAwqG283v
        LWsO33oxXd2ugFzqOwin8mEMAg==
X-Google-Smtp-Source: ABdhPJziPWZgig37bq1fGs6Jc1n/vr71i2BL52Sydfux32Le8WdoAOTEHy2i2yK6hhwnuYJocNX3FQ==
X-Received: by 2002:a5d:42ce:0:b0:203:d8fe:7046 with SMTP id t14-20020a5d42ce000000b00203d8fe7046mr4101252wrr.295.1647419438552;
        Wed, 16 Mar 2022 01:30:38 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:f503:8f92:e04f:4dfc? ([2a01:e34:ed2f:f020:f503:8f92:e04f:4dfc])
        by smtp.googlemail.com with ESMTPSA id j34-20020a05600c1c2200b0038995cb915fsm7205350wms.9.2022.03.16.01.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 01:30:38 -0700 (PDT)
Message-ID: <a0fac2e5-77b7-c6f8-42e6-a6a93986bc40@linaro.org>
Date:   Wed, 16 Mar 2022 09:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220225173734.GA7573@standask-GA-A55M-S2HP>
 <20220315140140.GA2558@standask-GA-A55M-S2HP>
 <09e8fdab-978b-fa9d-9e45-f8625ebc9c52@canonical.com>
 <04887e91-3116-c7fa-ac48-5d0ca8e42994@linaro.org>
 <18cf03b5-631a-e97f-dbb8-0fa93c8784cf@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <18cf03b5-631a-e97f-dbb8-0fa93c8784cf@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 09:25, Krzysztof Kozlowski wrote:
> On 15/03/2022 20:02, Daniel Lezcano wrote:
>> On 15/03/2022 19:26, Krzysztof Kozlowski wrote:
>>> On 15/03/2022 15:01, Stanislav Jakubek wrote:
>>>> Hi all,
>>>>
>>>> anything holding this back? It's been sitting on the mailing lists
>>>> with 2 R-B's for ~2 weeks.
>>>
>>> Maybe it's too late in the cycle for Daniel to take this?
>>>
>>> Daniel,
>>>
>>> If you are waiting for Rob's ack, mine should be sufficient.
>>
>> Right usually, I'm waiting for Rob's ack before picking these changes.
> 
> Which is fine :) but for the record (since information spreads slowly):
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=d029175f1420931e8d855868d264c4685687f3fd

Ah, ok excellent

Thanks for pointing this out, I'll pick the series


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
