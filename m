Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5955AC60
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiFYUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiFYUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:07:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99310140EE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:07:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ge10so11231214ejb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X+Lr3CyLHg8l+WoesZRIR4QxL5Y/Rc1xXhYNDNvStyI=;
        b=IBoAZmceQvdZPXV/2l6M1n8oicyx4EqEU2jxFqPzYHocRD2KVno+pbt6uizvvb+2bJ
         72Xz6eMz/tCB7CFgF9niLi3bSrXZ1Sp4FuT8ykA8Xd+fJml2AjZlS7lZ8Mv1A2E4idji
         f+AJnHZI3YDuCUGlLAnkmxxG+h0i6aAp9rFQFdpXGg5BIG4d/2bPMTlzGW3fEkI3fQAZ
         +bP6sw7KwEz6WImvC3TqD5fdAgcL1pcFqEsE3ET6huztcZH44kgWo57tki9xgXPfyyVW
         kOrZuLf3Jwk0/0TKdUz84J16zWox7bpuyUsgSiMhgDPy1fdfytZwSkTdgQziILSw2/Mm
         QdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X+Lr3CyLHg8l+WoesZRIR4QxL5Y/Rc1xXhYNDNvStyI=;
        b=S8kKg+fJKMX7yCQotjV7vP8HwUmkC144CK0NOJ+b0TmHBSXl3leXSYoXeGs46EclWg
         qIE8iGHuSvq/uCQg6KteNg5mT7kKreUM8tfI3XfDDEhsVXcDMfNamRig+3md6/d62jv5
         mxSMfwUdN9Ws9UlaMK7zPsbTKXZVTlxnngZxsdeEPUS1XZtDaBcM1+g82vChkxlXIqsh
         r38VAvOEuBFBpKxjhjJGk+evlCY9Sywo0ZKzFds5DzN9i6aGRAK3KX2OTF3uuH8UdyEc
         cWetXaD25iYtPpNIlT2iNwfKSnmoFytLT6XZf5FE0j8ZTEfob61vrRjnc8nXpdLv3hd5
         gyFg==
X-Gm-Message-State: AJIora+nfU1CfospklN8a/lvqHW/RGTyHBEk/Ak+y+DF795o8yLnCbYJ
        5zayX7yDo0k2xFHGHBSv8jcMIQ==
X-Google-Smtp-Source: AGRyM1uFK1aCJI0IKu+IECshTEhUPm544i46IeQzI6rca2B7aLaB2Qq1VQJblNRj3bbgkXG+E+r3mQ==
X-Received: by 2002:a17:907:9816:b0:726:2b90:4bab with SMTP id ji22-20020a170907981600b007262b904babmr5331885ejc.544.1656187669249;
        Sat, 25 Jun 2022 13:07:49 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v10-20020a50f08a000000b004357f88fcdcsm4642069edl.11.2022.06.25.13.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:07:48 -0700 (PDT)
Message-ID: <f542defa-3c87-a138-8bf1-4986c6bde832@linaro.org>
Date:   Sat, 25 Jun 2022 22:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220623182542.1116677-1-robimarko@gmail.com>
 <20220624010103.GA23758@quicinc.com>
 <CAOX2RU7yKuV4i_9YRs9fx2DTTvAndWFFw3cYtQ3qFk9m1zZJVg@mail.gmail.com>
 <20220625015714.GA6675@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220625015714.GA6675@quicinc.com>
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

On 25/06/2022 03:57, Guru Das Srinagesh wrote:
> On Jun 24 2022 10:50, Robert Marko wrote:
>> On Fri, 24 Jun 2022 at 03:01, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
>>>
>>> On Thu, Jun 23, 2022 at 08:25:42PM +0200, Robert Marko wrote:
>>>
>>>> +
>>>> +description: |
>>> ...
>>>> +
>>>> +  '#reset-cells':
>>>> +    const: 1
>>>
>>> This isn't part of the original file - could you please explain why this is
>>> being added?
>>
>> Yes, its not part of the original file, however I noticed that a lot of SCM
>> nodes were adding #reset-cells, and upon looking at the SCM code its
>> clear that it is being registered as a reset controller so #reset-cells are
>> appropriate.
>>
>> However, since its not really being used via phandles #reset-cells did
>> not really matter, hence why I did not add them to be required,
>> this is something that DT guys can probably clarify.
> 
> Makes sense, ACK.

Please mention deviations from conversion in the commit msg.


Best regards,
Krzysztof
