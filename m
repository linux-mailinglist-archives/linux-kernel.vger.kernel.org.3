Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425014BFDED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiBVQAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiBVP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:59:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E79D76E2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:59:33 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d27so34249445wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U9Ou92nqYvdx+GxKcNtcQAp/eYvlk1EdyKPY3vKJyh4=;
        b=OcgPCyS6DmUgHOQ6AClPXfqsnc+31xJBv9/PMuz8zNDY8bld+xDcMIhC9+VNa5lmw4
         R+nmTxWsE0AKWYnPLWgk2ee6HUVytph6yydArbXgL6XkYIfrDoCosi9vn/h+pMFvIyRZ
         dkHiKYz2qyzKFbYGdFF8KPFfSu8/vx85NQTlBUJgopaBzJc/Ba8pLxh/tFH7mUcg25Lt
         gZUtAv0H9GFHL/VqM44/A0xtG4UCb8Z448RM+HIBHxasmkTCs5fjFl1t6rjqOD/PXoRL
         6srx3jAhtEVEe1xOBTfTHmeMigFMfvwK8eMTcVNtCepYIBhzTovCoVNqGWp2nlbLiR6Q
         ui2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U9Ou92nqYvdx+GxKcNtcQAp/eYvlk1EdyKPY3vKJyh4=;
        b=ylbxPtH10Q7IijgEWW8Fjg6NPt5md0oEw9NNHa2f/Z4y7c/jN/Gg16WcBGzUp0amBr
         5qSf+fYkKJ5tEJ734BuKLu+mu6WqYtMASfTR7xkj2SUQ2G98bdIIIiNsyLQacNojZoNc
         blX6cuDRXoyuR76v7hOzxWj3rcw9tR4QanStUEGMcdnfQLek3psk2Np0FguzV95BuLEP
         j58smdca3IX9y1/Ab//pXph8Ab6rnOBMI4JyH5AmcEGeBIF6izIshcI6E7efyNt7VZWN
         w5sqrhzNKqB0QivUpg9Utx0ty/0nprqup9TicQzIpylHaflLQfcdTWueM8UgSLSdazBO
         CO7g==
X-Gm-Message-State: AOAM532sj1lhMgRUqpeOUbAoB1oJmvho38fFQSyL/KLeWKUuwFYyLNUN
        cad4D8Df/4IkItg5oCmQRxZzuQ==
X-Google-Smtp-Source: ABdhPJzgqGgohypuPzxtBqAj8srdmeqRgWf44uVAx2+2yUD0xAICR4RYD74O4lt9Ktey6Mh/Ky5Bog==
X-Received: by 2002:a05:6000:1843:b0:1ea:3bdd:dae with SMTP id c3-20020a056000184300b001ea3bdd0daemr8685097wri.235.1645545572015;
        Tue, 22 Feb 2022 07:59:32 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a? ([2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a])
        by smtp.googlemail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm3592866wmq.6.2022.02.22.07.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 07:59:31 -0800 (PST)
Message-ID: <2d78266d-0b49-593e-79d8-00215c14fde5@linaro.org>
Date:   Tue, 22 Feb 2022 16:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org>
 <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
 <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org>
 <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
 <cfbaefa5-fc7b-bd0f-e4ed-8f046de2a7cf@linaro.org>
 <CAPDyKFoWq+i09Ts_+SAz9ctC2a7-cqC71buDmvb-LZFTVSH+DQ@mail.gmail.com>
 <41214f23-ddb1-f60c-5e2a-96ba161cf727@linaro.org>
 <CAPDyKFqo1vhhW994NsnWonTWW34qcSMU5xaBZyV76Njtr0ST4w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPDyKFqo1vhhW994NsnWonTWW34qcSMU5xaBZyV76Njtr0ST4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 16:55, Ulf Hansson wrote:
> On Fri, 18 Feb 2022 at 14:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 17/02/2022 16:45, Ulf Hansson wrote:
>>
>> [ ... ]
>>
>>> Does ops->release() also resets the "dtpm" pointer to NULL? If not,
>>> it's good practice that it should, right?
>>>
>>> In that case, we would be calling "kfree(NULL);" the second time,
>>> which is perfectly fine.
>>
>> So you suggest to replace:
>>
>> if (ops->release)
>>          ops->release(dtpm);
>> else
>>          kfree(dtpm);
>>
>> By:
>>
>> if (ops->release) {
>>          ops->release(dtpm);
>>          dtpm = NULL;
>> }
>>
> 
> I don't have a strong opinion how to code this.
> 
> What I was trying to point out was that if ->ops->release() frees the
> memory it could/should also reset the pointer to NULL

No it can't because it is not a pointer, it is contained by the backend 
specific structure.

eg.

struct dtpm_cpu {
	struct dtpm dtpm;
};

the release frees a dtpm_cpu structure.



> And if that is already done, the kfree below is harmless and there
> would be nothing to "fix".
> 
>> kfree(dtpm);
>>
>> ?
> 
> Kind regards
> Uffe


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
