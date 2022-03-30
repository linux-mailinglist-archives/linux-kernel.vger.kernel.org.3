Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD34ECFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351728AbiC3Wuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbiC3Wud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:50:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD91A23BC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:48:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y10so16872825pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=QMdKMvLDRvSPwvzTu+YBaX4RHtka5vEAinUmoDMy378=;
        b=Q85UzJZq5gymYO463QLbf7WojuRAfFD16IQDE7Q+uJMgfbEaEtBIOFOwkTe3Fs+jq5
         DqadLPSI1bSY/0k7dFENy+KHLgmGj/PYWasB6I+Z7sgU/D5Z7iLnMlkTAIuLKIj0fP4o
         re4/h1TIpH34U4JxEQas3UvLeeO97ftDcu80cV5gw2dpgF6qsXjUfcw7kff7tAwnaqoq
         DimkJIUUcHTAEMIS9kzENP3Pr1HNE6mnKypopKVGld7nb8I6eVOKGvFlHlJhbSoIfCbB
         PQnbpn2FwYLbOcKCBpGn/pM3EQZ6T4uQfxXP1dQcfnpPqX2JGz16r4fcsmhNCrpb+Nit
         IxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=QMdKMvLDRvSPwvzTu+YBaX4RHtka5vEAinUmoDMy378=;
        b=RhC6gM3ghcFBGGXyGubUh9HtpLnulGZSXPY67BMqTYKJu2lct4kfm19Q3KYovz9RUs
         /OFNddxU6ALjzu7/gdvICcVEVyi6+KdY8JQLzxz7mcYuAh41xCFJ4vKSrMTGrnTPCGP3
         xkui8AugBMvG41IvMciOTvaHQzH/bc6sUKuPymDC+SW+dWsymHLHiZJxAP/5qPfDnhrf
         iP0Hx9EVUXvF3xAtqmETbFkARqM4rUPmg6nWIK44NoXX4By58wec2qoWmxL2nQevZlbS
         i4RT5CK4NrTi//EMnc2DuTuYqPxXnYiObra8t+EOTJhASlyYrmQQ9iDdrUM7zAGV6sxz
         T6OQ==
X-Gm-Message-State: AOAM530ospyRdAtUzwK3H9++NKvhjYBDYBnfG1U6gGqOPxQgMG38jJ0T
        S7y+qmrW/EXtqBW6TmDRsVhtH1RuXMbK5ARD
X-Google-Smtp-Source: ABdhPJwLkOuKIeLSUA0wm3vHPk8Ay9JFPnttpKJU7Hy6hPDPw7ilrmiFrIaQPS1i98m6HVutU3eNLw==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr1948547pfl.61.1648680526345;
        Wed, 30 Mar 2022 15:48:46 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ij17-20020a17090af81100b001c67c964d93sm8797906pjb.2.2022.03.30.15.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 15:48:45 -0700 (PDT)
Message-ID: <c8663435-c444-40bf-94e8-aa8b06d4404b@linaro.org>
Date:   Wed, 30 Mar 2022 15:48:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Gustavo Silva <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org
References: <20220329171252.57279-1-tadeusz.struk@linaro.org>
 <202203301448.31FEB0D2B@keescook>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] uapi/linux/stddef.h: add include guards
In-Reply-To: <202203301448.31FEB0D2B@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/30/22 14:49, Kees Cook wrote:
> On Tue, Mar 29, 2022 at 10:12:52AM -0700, Tadeusz Struk wrote:
>> Add iclude guarde to uapi/linux/stddef.h to prevent
>> redefining macros.
>>
>> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
> 
> Hi!
> 
> What was tripping over this? This isn't a new file, so has something
> changed with how it has been included?

Hi Kees,
Yes, it isn't new, but up until 5.15 it had only three lines:

#ifndef __always_inline
#define __always_inline inline
#endif

https://elixir.bootlin.com/linux/v5.15.32/source/include/uapi/linux/stddef.h

and one could include it as many time as one would liked.
Now that it has more #defines, and since it is an user api that people
can directly include in their projects, wouldn't it need to have
the include guards to avoid warnings about redefined symbols?
All the other headers in include/uapi/linux/ do have that.

-- 
Thanks,
Tadeusz
