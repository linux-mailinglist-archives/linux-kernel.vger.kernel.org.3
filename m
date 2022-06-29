Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A978255FD06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiF2KV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiF2KVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:21:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028B2CDEA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:21:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m184so9049960wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LUI568KKXBWt/UbA1wIV56CczfgTe2ipRJvz8jOekL4=;
        b=Dg+/K7lGSuLotSEUfjS3gnurmv3Ls9wWXf6+SkWUT8cGyAwt/fvEJr+1Ttq4qiye9Y
         hdXUYGJ0HMbnWxRaZs6PA2J9hJ1QmKztIGxEVZBrNp0IAJO9fpBuhsBWdANK2Tpo4QvD
         qcnWerCjZqxRV/tFdNll1My2DNgYExo3D1raK2FrREl9oEp9VBo1JlfI/xtFTpgjb9+Z
         XX2iTKSC+tjZKqAll7tRdmBEb08QNDXYF2+8mF21DIUneW0qNkD/q1WemgocXxI8SShR
         kz8hLD9uhFTE4E/MfabHQsewdcdUPmic23x2KnI7UsNFlKzbQs7bjwjTpR36z5tz4GaY
         P9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LUI568KKXBWt/UbA1wIV56CczfgTe2ipRJvz8jOekL4=;
        b=L8n2PHhkYkvo5mISG1mwD9BJ6WcY8GvVeteKtfdNUvGK75aUkHJ8LPpWvjx0Su/7Vu
         31UOvTr5PUCGN/zVHCEHytxtRa/bLkbsslhbtTNQX0qGSIm9d1m+aE6HNiZoF/WkDrwC
         UKhoEoI624pzZSh2UrdYRl2JuiO7JIjqBgOgNFFgBTD/4SZmItHCnrVk5OtYDUVigZOh
         ZP63XUC37OdaZeMPIlhW/jRQSk3zD3vlFDPr1QjQPm5isjrDPFO1GAAkTsu+tt1GszGI
         MHd6OTj9bgKSQScC28PPzK76sNYOLuhQJBR4+H6+0czlH56YsolTt2CGLt4/tHzavilm
         eKnw==
X-Gm-Message-State: AJIora+Xf2hihBEnoFwoSR77Gwk+vC8b1GCP8x3CrSifhyAKNNwdfYwO
        KkCu1Wy+RLjVFhqz4SV9gZ/hsQ==
X-Google-Smtp-Source: AGRyM1t66misOvkWP/wDFaZ3DmxBe9/TdCWM/N12/+KveC7B17Rp6dA33RQzHq6OCHRATnzN0JeudQ==
X-Received: by 2002:a7b:c196:0:b0:3a0:3d46:4620 with SMTP id y22-20020a7bc196000000b003a03d464620mr4808384wmi.26.1656498082205;
        Wed, 29 Jun 2022 03:21:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm2562035wmi.29.2022.06.29.03.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:21:21 -0700 (PDT)
Message-ID: <7d3fdfb5-ed03-671b-59d8-918cc0d60612@linaro.org>
Date:   Wed, 29 Jun 2022 12:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
 <20220629095302.bi3xx6yicsnjeff7@vireshk-i7>
 <1072cb84-4097-0cbd-f980-a864ea851b0c@arm.com>
 <20220629100148.67kevfelqq7d23n5@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220629100148.67kevfelqq7d23n5@vireshk-i7>
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


Hi Lukasz,

On 29/06/2022 12:01, Viresh Kumar wrote:
> On 29-06-22, 11:00, Lukasz Luba wrote:
>> Thanks for fast response. It would be great.
>>
>> I have 2 ACKs from Sudeep for the SCMI part,
>> but I don't know the status e.g. of DTPM
>> current work which is using the EM milli-Watts
>> and does conversion to uW internally.
>> I hope, I won't make issues to Daniel's work with this
>> change.
> 
> Daniel, do you have any objections to this ?

Sorry I had no time to review the series yet, give me a couple of days, 
may be a bit more if possible


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
