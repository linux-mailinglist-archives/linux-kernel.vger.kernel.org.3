Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDD58C363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiHHGic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:38:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581311C10
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:38:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by6so395750ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tJaOlNJnvpuuVPsZGu5FsCCSJWxw4AyuPGJcjlxUqJM=;
        b=QcM0epFzISH7qYgagFl0U3HjKMvbLzNfLfjKL9vsGamNlRrxJnxeiCkKE7G0AVHva3
         lg7tcddwWBDimD4g9gJ7DUGy87M35PjrIcjRjEF0ocfo9sgBVlx8W/nEylfuWuzzU5oZ
         E+6fXw+osXINDcT+SxphuPk1pYQAxUJ7VcTMren9hIFlzVkdy+cKDhMKKhNaE9ebDM3o
         UQCxDOkuIcHkuJMyV53YpqUDVHERRM9Z7T0sJLYTzsctFCJf1XyzExmT65Z8F73zCukM
         LxPNjXrGrrPxN/kvmQ+Fbvtc2TDtlBB5+/eyqMVCf6LdrRV3APvi4P542hcijXQKoDtv
         1rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tJaOlNJnvpuuVPsZGu5FsCCSJWxw4AyuPGJcjlxUqJM=;
        b=upoE3hCHCsySEo8CWMin+nXUhkEh89vvoLrhtyOABXLwSI26u2ICD0RrWX38F1FPmw
         wldwoQYNcBrGS/67emtjCw4xpcgsMkWZapmLvXxDbmGXd4E9+O4hx8cXcmw4He3OKaFr
         mAgHdVRysa79VzbS7wcHijlXmrm8wShML+cOfGVFiMYcBOfdLJZVNntijBc9Kj7Tq8zM
         2R0uSssME2PDrQqL/0MS6sdrnEfS+ax8S6kKCHlcNVCIG4/1iRxfaooxaAV7uyjbjbat
         tHHhDmybbBbR7eMCiS3JFXpC9ixFp4qFAvsSQo+A+d+usj85jpGeNuLN6sBa9sI72zdd
         lvRA==
X-Gm-Message-State: ACgBeo3qa3NVuJAuJsoz9M/Eddt/wyhC0qgLKwEi+zWR+yoBFpt34kCG
        +03mryq7T9CbUFpJkEny3VoPGw==
X-Google-Smtp-Source: AA6agR5AIWN6XBF5CyoMX8w9eG5KkshT9AMUozo8DvOohVm3dA7uhHirEgBpJOn+eohjxc5srQCecw==
X-Received: by 2002:a2e:81d8:0:b0:25e:4ede:6d61 with SMTP id s24-20020a2e81d8000000b0025e4ede6d61mr4960452ljg.410.1659940703752;
        Sun, 07 Aug 2022 23:38:23 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b0048b27215fb3sm1321898lfg.41.2022.08.07.23.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:38:23 -0700 (PDT)
Message-ID: <cf320916-c88b-0c4a-7515-24318f1b85b2@linaro.org>
Date:   Mon, 8 Aug 2022 09:38:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Caleb Connolly <kc@postmarketos.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
 <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2022 04:37, Tom Fitzhenry wrote:
> On 6/8/22 12:10, Caleb Connolly wrote:
>> I was surprised to see this series, and this patch especially.
>> An almost ready to submit version of this patch with considerably more 
>> functionality has been sat around for a while but unfortunately never 
>> sent [1].
> 
> Firstly, thank you for your review!
> 
> I'm not sure why that other patch series has never been submitted. It 
> was prepared 3 months ago (unbeknownst to me, at the time of v1), but 
> since then has not been submitted.
> 
> I would feel uncomfortable submitting that patch series, since I am not 
> familiar with parts of the full DT. In time I intend to be, but for now 
> I think we'd benefit from having a base DT mainlined, on top of which we 
> can iterate and parallelise.
> 
>> According to the link below (and my own knowledge of PPP development) 
>> Kamil is the original author of this patch, both Kamil and Martijn 
>> created the initial version of the devicetree. Given that you're using 
>> their work as a base, Kamil's authorship should be respected in the 
>> patch you submit.
> 
> I agree authorship is important, and thus Kamil, Martijn and Megi are 
> listed as Co-developed-by in this patch.

But you miss their SoB... Without them you should not send it. It does
not pass checkpatch, does it?

> 
>> Their original patch [2] contained SoBs from them and Martijn, those are 
>> both missing below. Both of their signed-off-by tags should be added 
>> before this patch hits the mailing list, and the same for Ondrej. The 
>> order also seems wrong (Ondrej should be last before you).
> 
> Yes, this patch's acceptance is blocked until all Co-developed-by 
> authors (Kamil, Martjin, Megi) provide their Signed-off-by to this patch.

You add SoB based on original work. When you send a patch, it is
expected to be ready (so having correct DCO chain), not incomplete from
our process point of view.

Best regards,
Krzysztof
