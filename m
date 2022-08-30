Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AC15A68C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiH3Qv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiH3QvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:51:06 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB62E9EE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:50:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k22so11992500ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LB0Usrjlkh7xslzohdKjOqDIh+FnkR8rdofoomTFePo=;
        b=V/TUBW29W2rTZvSqJpprSsVXCH2sHzwElfnaQ6Yrh446l4m7mD1WCPJhyMGGmW6A/W
         RqSFRqFBVuiPaCQf0/qTQCPh34InMJQgs4KdqMswdLrdOUcERJjjbaspE8Peg7IXIg2n
         PEgQe3ZWZHvg1vzID9MvWL6/xIoTWFXXYZ1e0mVN9lHWSoLQIR8RICThpRAFw6W16Jkf
         q4FzEaO1plKFIr9+btGjQuJQ30RC5Y5HTAszHP0AqBoribTg84wmd+3N0TJ1I64mQkPx
         0+7dEGNeP2P3yHzXxTgU73H+YIYf2AsyOjmjpdL93nEXtBxJArroBN1d425fbWABNVvi
         s2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LB0Usrjlkh7xslzohdKjOqDIh+FnkR8rdofoomTFePo=;
        b=AefiEen197IQmUqqypOEjxnERnrBxm5uSOyVNSgViUcOwZILQq98gx0QxkTmSYZ6Dm
         9cQDzEmBNuQQdKRGd5TQpQBvy2q0TYXHTFZqlk8rewmXY1XT1dkKBUcZ4sr+wstsH/ZW
         TB8jxwL0Cjr4Kmo8Y1EVtTuGe8pdaBQD0YJwfYknv/NVoOAY1+OOwtwp7rKqVkG5yg/t
         7AjSMcV6wxzEJsFncSR5ZHbyr/yd/EKO85PhlBEF6yeVKs+f/+U6vVbPu9CdqHvdpg8V
         MpED/QMTvo+kKGFW0U+xAIBnSwm4JQqODf0yxWy9HdXfqqEQpOCTuLC21LYxdEDXSoNd
         GeCA==
X-Gm-Message-State: ACgBeo3dllSFEdRjq6z/KHHEMw53YvByeX37rjwP38NR2PSQvIVCB/Ex
        bm45gSV4EXq5J8mIX63+sLPlyQ==
X-Google-Smtp-Source: AA6agR6EG3IyFUzxbWsyDhOmCP0vEkHv/lutNKfgPiYH8yyy2ff3ijld/cBf9iwIC9R5chRy65sWaQ==
X-Received: by 2002:a05:651c:10bc:b0:264:8e6c:f618 with SMTP id k28-20020a05651c10bc00b002648e6cf618mr3584131ljn.154.1661878227394;
        Tue, 30 Aug 2022 09:50:27 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t22-20020a056512209600b0048af4dc964asm1028074lfr.73.2022.08.30.09.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:50:26 -0700 (PDT)
Message-ID: <bc707091-3417-bc89-70bf-3a2496a11196@linaro.org>
Date:   Tue, 30 Aug 2022 19:50:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sc7280: Add device tree for
 herobrine evoker
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220830133300.1.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
 <184d4ff5-e80c-6a24-8071-0b0a69710685@linaro.org>
 <CAD=FV=VorVNKHgybGAH=dD5ob+1RYoguczycjOYu-5VPu=9Jkw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VorVNKHgybGAH=dD5ob+1RYoguczycjOYu-5VPu=9Jkw@mail.gmail.com>
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

On 30/08/2022 19:10, Doug Anderson wrote:
> Hi,
> 
> On Tue, Aug 30, 2022 at 2:33 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> +};
>>> +
>>> +/*
>>> + * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
>>
>> What does it mean and why it's SCREAMING?
>>> + *
>>> + * Sort order matches the order in the parent files (parents before children).
>>
>> Why? Sorting should be rather alphabetical.
> 
> We've had this discussion on the lists in the past. See, for instance:
> 
> https://lore.kernel.org/r/CAD=FV=U2C1W+JHWyGRfyRB=WiPKLYvtjO90UDoJ9p+Xwe09+ow@mail.gmail.com/

Good explanation, such sorting rule is quite nice. The part about
regulators is still a bit confusing, I guess it is about some other
pieces in some other place? But isn't this kind of obvious from
including other DTSI?

Best regards,
Krzysztof
