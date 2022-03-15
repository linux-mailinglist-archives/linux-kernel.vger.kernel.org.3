Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE234DA2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351200AbiCOTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351187AbiCOTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:03:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CE551300
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h15so30433790wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rpWw5GZtUA3skuGiUIeSJI5HadVDx3g4iXvGFptmS4M=;
        b=SH2jLrHQwgbuOf2DYEmjO0csDoBUNE8FKLoh/ftcJWhhYcCrfmap7iu5VTTYcJP/kN
         k+sXm02Idlp7BzSU8aFj89xJPlXlB++6ZmT6rVV3wyLVjSit1bikx6zPgOfL+AN5ZbqU
         5uz6td4bZFNvzFXbxVNZxgAcI3AdkFIhzS1vwy+syIoL7XgAduTbaY246BMOmNQv3rwa
         U0iPqjSiXLIBEY/kxZIeell3K9qhMFlO4sK4UxgLfBt1cfWrOvlMjPQAX9BBp9zQ45cp
         RkJPvk74BoSkWWl88G/4gXmAqejGSE9iBS0Q3CbcjN1UYRBBn5iPjhsZOAtUR0VLHPGP
         72fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rpWw5GZtUA3skuGiUIeSJI5HadVDx3g4iXvGFptmS4M=;
        b=bgV8GtsBN4WNaSFLVVHt3/3KXMJln2n92l1dt5f+G8OZ/9zZzALnjTcGGNdyE7bCsP
         0UnAsQ8MaAUPuFeaDGjWFQL66qAbgdxJ+mPVzy5Z16vWoBnm75tHzEXaP438ts11ZVdi
         wO5CL/WDfowPUUtb0sflPFbVLfjdt1KLOO907TEqwlr2Bt24cUcEeASdXfdBlgGVR55U
         I4KaWQCHKCCoMPuM9QBhbw02KbtcoCxdDyzuQHqwpEez5CCJvfQi5brXAllF9N89fuvU
         YTAkaQa43k4KsQE1bf2PebkufuMHQlalX488LS6wLnfJeeDAj3R7E2cmGUWZI5G5S5vg
         Jh1g==
X-Gm-Message-State: AOAM532HaxNcmv70psKpCad1reiqa4UOEEbwVLCLKwe5Ps4PEnyRpx6K
        Fjjx08i5IQjsvxkMWV+ijf0XwQ==
X-Google-Smtp-Source: ABdhPJz/r8Jx2umpohv4OylgcEhcq9Sz6p6ok9F0LZtWaxNJR8Nr1StRrB55qMwmtLENo+6mFrItfg==
X-Received: by 2002:a05:6000:1b07:b0:1f0:248d:bc1d with SMTP id f7-20020a0560001b0700b001f0248dbc1dmr21076218wrz.534.1647370948816;
        Tue, 15 Mar 2022 12:02:28 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:f503:8f92:e04f:4dfc? ([2a01:e34:ed2f:f020:f503:8f92:e04f:4dfc])
        by smtp.googlemail.com with ESMTPSA id f2-20020a056000128200b001f1f39d05b0sm16298515wrx.100.2022.03.15.12.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 12:02:28 -0700 (PDT)
Message-ID: <04887e91-3116-c7fa-ac48-5d0ca8e42994@linaro.org>
Date:   Tue, 15 Mar 2022 20:02:26 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <09e8fdab-978b-fa9d-9e45-f8625ebc9c52@canonical.com>
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

On 15/03/2022 19:26, Krzysztof Kozlowski wrote:
> On 15/03/2022 15:01, Stanislav Jakubek wrote:
>> Hi all,
>>
>> anything holding this back? It's been sitting on the mailing lists
>> with 2 R-B's for ~2 weeks.
> 
> Maybe it's too late in the cycle for Daniel to take this?
> 
> Daniel,
> 
> If you are waiting for Rob's ack, mine should be sufficient.

Right usually, I'm waiting for Rob's ack before picking these changes.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
