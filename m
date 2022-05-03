Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D590251892F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiECP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiECP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:58:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21121E3A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:55:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so20337995edw.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BsC042lq+ASiI+KFVDMGvdvhCioXLu8YzSoGzXQsmrY=;
        b=pYggHZGRfnSGxHO3zqFddU6dCPxSZQdfkap6iw5ccn5lYkccQ6x02JX3sZ6dA6GMtR
         H1jZHQco1peMLbjoCRKdvWCX6jqTeG/7vN3C0JetQFcJo2LvvJRpgFgXy8akYpZzcdfK
         rJRJ/10OtXEFVdtpp7KCF+q0nVbSiFgxb6Mft/WRKq1vIYIwAz/iZ82bNzMWr77LmGk6
         VeKfWl2zDyrWA58ZWll6lnq40pkoozr3XMqSGVF4F81bjVWEyQMtY7+r+0pDsdNJYxg3
         x4cafyO6aRbgR26p7+CmXzHG+DAWZowK3qb1b6viX2ruYE61w9OOZwd39gx7mCtYiymL
         bumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BsC042lq+ASiI+KFVDMGvdvhCioXLu8YzSoGzXQsmrY=;
        b=DQsS6IhCodUMX28dleVwfEzcfRwHIvfEG93sNFnMWtKSP8ejkXwOb5CkJyuT2SIEOK
         58h8Nx8Yd8BM/u4Zg3OZDychYclRwlD48cVE8pl+oBSZknowZWVR4Q6tK/60G+KgcFOE
         ft/qJ+FEXI5RpNc8QjuvorMWu0ZW1U62L9+TqqgIVznpEYtxDmA3960Gxipg6+1ms2Ww
         U2Da+SHkMfELvueBQ9oqV5N8s9LOBSFI63sMRBmCV+QF+DfCtXKWPJDWsf/8dlk6A09z
         FHz0WQEpkCCD4jIUDRqLQ7zTEQzuIoSzocgEHyuAXNiXhxzuour7JuXLElrNq6nVxgwp
         qVaQ==
X-Gm-Message-State: AOAM531xFHwkUKxQPASX4vGI245eHMDimLz1Jcu9oq2kit/21BfwD64j
        QZheSFVpdlHZ/5ycQLapjD37IA==
X-Google-Smtp-Source: ABdhPJwEIWnG+vCQLxXejn5znkqT8nvWu/vgYffG3VNTTp+aGCOoi4adOvVNNTah+A+rfBkYqvrPYw==
X-Received: by 2002:aa7:c619:0:b0:425:b14f:1183 with SMTP id h25-20020aa7c619000000b00425b14f1183mr18187742edq.254.1651593319833;
        Tue, 03 May 2022 08:55:19 -0700 (PDT)
Received: from [192.168.0.206] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cf4-20020a0564020b8400b00426488dce1dsm5370443edb.25.2022.05.03.08.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:55:19 -0700 (PDT)
Message-ID: <e321d8c2-950c-a194-04a3-1fe2659749e9@linaro.org>
Date:   Tue, 3 May 2022 17:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Joseph S. Barrera III" <joebar@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.3.Ic20d0c002ac5406b880cbdf9824739f38740926c@changeid>
 <dbcb45d6-d495-1e5d-b7ad-963096e5fe9d@linaro.org>
 <CAD=FV=WhAqQnxwNaW4kfq9Wuwsz6YYzBgSn=KX9Se_5o2mkcsA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WhAqQnxwNaW4kfq9Wuwsz6YYzBgSn=KX9Se_5o2mkcsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 17:34, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 3, 2022 at 8:31 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/04/2022 10:15, Joseph S. Barrera III wrote:
>>> Quackingstick is a trogdor-based board. These dts files are copies from
>>> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
>>>
>>> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
>>
>> (...)
>>
>>> +/*
>>> + * Google Quackingstick board device tree source
>>> + *
>>> + * Copyright 2021 Google LLC.
>>> + *
>>> + * SKU: 0x601 => 1537
>>> + *  - bits 11..8: Panel ID: 0x6 (AUO)
>>> + */
>>> +
>>> +#include "sc7180-trogdor-quackingstick.dtsi"
>>> +
>>> +/ {
>>> +     model = "Google Quackingstick (rev0+)";
>>> +     compatible = "google,quackingstick-sku1537", "qcom,sc7180";
>>
>> Here and in other patches you keep adding undocumented board compatibles.
> 
> Sure, but perhaps we could continue the conversation at:
> 
> https://lore.kernel.org/r/CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com/
> 
> ...to avoid forking it and losing all the context.

It's not that close to that discussion because none of compatibles here
are documented and we discussed about documenting specific revisions.


Best regards,
Krzysztof
