Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E017F4A594A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiBAJdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiBAJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:33:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 01:33:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so30750991wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 01:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jR0cK8D/cxqE0XH4x3hRJS7ga+v+EADCVtjxDl6n2ec=;
        b=e3XfiA5vXUh72nUHoqnkjA+JNWHiMQM9t7dBcPXPHgF6sDSGez1IqxNzJpi+GjFBOV
         KUD48C81FhtNoxA0lbzVxeyRRhvpRlx+cE0VRNTkadtW8VaTsaf+Df+BRX/o6WXx3KeJ
         ggfrpaYwN5ipBuJYBt6C96M4z3HvTR/E+3kCkKZTbsh2NsUI+fG9SCrLO+h+/XA87aOr
         d2FJ4JQpI44+yS86eGUFGZUt2O97zc/ek9olDN0omyd9T2PSXc5OjaVHoT+CTDB2WufY
         gL4SDiz7omcLywGsPoK771Bp0vY6kAwTETgNkV8fXkWv8vOmtUkFqqpehVTj0IkxDF39
         7D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jR0cK8D/cxqE0XH4x3hRJS7ga+v+EADCVtjxDl6n2ec=;
        b=YiOTeDGi10ISUbXZgghK5UWqbZMoRM6GQzHk3YJ1CZ5UUl0nIXAGFwlNS50qx9eyFM
         kapWgu9wVjvQn05Hg4RRORRdQ+vaRKMKC6HcQTE9E+9chkP6McybOs0U+hy3QAiCY/Z8
         mNGjQytYPC54BAO5bRf/Cdi7gWlm1pq7QP9/wRZsyPJtbQB/s7fTCshkeleoDsVnlx6i
         qWxVBO2NW6Zhoqdt2FJt2YGOa/ku75GkkiYqLo2ZfuFiqLlY7Dc7UCzVIfz15Z/vSqpF
         FHxVNowMGGrc0S33H3InJCa2Lngj7ytYPDUelmK/b/G3qROHniRE7vYfScK+mh012Ts+
         UsYA==
X-Gm-Message-State: AOAM5318oNA/Hvuy+XJqlpkkAhsZgO6jlvZkzm3SvDfaV0XRhQYa5xMJ
        kAN1VJW6zAVoobPNMBrvwfmC7w==
X-Google-Smtp-Source: ABdhPJz7q6Dc9gGjf2b6E0Z5D79bjl78fxuAGHPjeuYmXnRsPs8fH+DkNHCl7jLbwlUXMVseit1hTg==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr21065076wrx.252.1643708017192;
        Tue, 01 Feb 2022 01:33:37 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:accd:30fa:dc2c:eeeb? ([2a01:e34:ed2f:f020:accd:30fa:dc2c:eeeb])
        by smtp.googlemail.com with ESMTPSA id k10sm1520260wmi.1.2022.02.01.01.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 01:33:36 -0800 (PST)
Message-ID: <ec3c5869-a7e0-9963-2da1-5e695e4f6e95@linaro.org>
Date:   Tue, 1 Feb 2022 10:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v3 3/3] dt-bindings: thermal: Add sm8150 compatible string
 for LMh
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220106173138.411097-1-thara.gopinath@linaro.org>
 <20220106173138.411097-4-thara.gopinath@linaro.org> <Ydd8IhMesT4QBiWZ@ripper>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Ydd8IhMesT4QBiWZ@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 00:32, Bjorn Andersson wrote:
> On Thu 06 Jan 09:31 PST 2022, Thara Gopinath wrote:
> 
>> Extend the LMh dt binding document to include compatible string
>> supporting sm8150 SoC.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
