Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829805465EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbiFJLoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346959AbiFJLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:43:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB973564
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:43:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x17so36170951wrg.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/5YJpP3pdMDmTKMTFCWXXpZqW0H2SA7UK43ZKjPSKgc=;
        b=yob+Rw2WWG/AgEEPq6tT3/t3XqlSfSQ3jvHLFr/TIpmuPbFwxlVia+GRePZuFJQrJX
         VSVY3sx0GIuiw0VQKSguBpC5ELizScKoMI6TLuUBBTkjSsU45pbZvHSYN3QQIWwgEg/M
         Sdp90ArObWOLFb85Y4xamML12ImzqmdetXCwF1L/JmeLXQO6fDpCUwN86tocl4I+84Ld
         D/uy3tGwWG3Sc3Rh1gch3KlR/1km1l68hmLjwRDDHTBdodJNabY9Da/rGnjqmxQa9CVY
         +1lCdOb+Dur+ByiRyWxTzbYIp2MeU5W48PpAStjmAqwydWyT1/5nto8G63yNBnC5dPyM
         p2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/5YJpP3pdMDmTKMTFCWXXpZqW0H2SA7UK43ZKjPSKgc=;
        b=rXLSNBfa9AT3Z3ET2/0S6JHjNod4p+RlTutYIfERlvJxoqVGVoCszXhrIU4OvFgNu2
         zNQOnHaj2GKCa5CJfHEi+EstlfNpkD8gMiszWpQBdEKj0+gfMbPlQllpL/HeMEHlOufY
         ZAadZm4PIsySgvtSJb+qNxbKhs8vNFHn4SnINrO1GumzwYzlKXBYyxQVdtHzgyUnTAox
         fk1E51SzRUMOxQ4cEe4id3Qf8JeGW6NuQZRKouMpz2g9zTzIwfxQULHoIj332FjoFEx3
         Qaj90UkIqqgdgkZC6a8hP83vxqqKvs1tF8ktryor8uCDq0HmMBiwuQu67/JIAsvXpZpX
         wstQ==
X-Gm-Message-State: AOAM531NMC1zWNangy2iib+RNiCISFl81Jcgbsc8Cztyjs9cYm+aHrgB
        olhquEPrKIE/x8+z9j4RK6EhLA==
X-Google-Smtp-Source: ABdhPJwseanLf0i2ChgalXTWzdaG20s3fQfwYCNZ/3tWzUs4mQ/RBHTRdI5POW1Eg22PbtGPF+QDtQ==
X-Received: by 2002:a5d:6141:0:b0:20f:c66b:209d with SMTP id y1-20020a5d6141000000b0020fc66b209dmr42129589wrt.27.1654861404895;
        Fri, 10 Jun 2022 04:43:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:936e:a821:ac60:872f? ([2a05:6e02:1041:c10:936e:a821:ac60:872f])
        by smtp.googlemail.com with ESMTPSA id c15-20020a7bc00f000000b0039c4e2ff7cfsm2609787wmb.43.2022.06.10.04.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 04:43:23 -0700 (PDT)
Message-ID: <86edf34a-256d-9c30-9069-123aa1192c7e@linaro.org>
Date:   Fri, 10 Jun 2022 13:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [CFP] Power Management and Thermal Control MC at LPC 2022
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <CAJZ5v0hjp2-yLN_UyQvMwhoPreTkA3xU0g3boYtxgLi6TWqabA@mail.gmail.com>
 <CAJZ5v0iLoGsauHTh+H7EemsjGApXpant0RQFEDZRQMiGoHzpCg@mail.gmail.com>
 <CAJZ5v0hEodhL2P50=MwN-jW7EF_k21CnQOnwiqTAGHyDo=2u3Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hEodhL2P50=MwN-jW7EF_k21CnQOnwiqTAGHyDo=2u3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

done.

Thanks for the reminder

   -- Daniel

ps: I noticed the dead line is not June 15th but June 13th


On 09/06/2022 12:20, Rafael J. Wysocki wrote:
> [I see I sent this from my personal e-mail address, sorry for the confusion.]
> 
> On Tue, Jun 7, 2022 at 5:30 PM Rafał Wysocki <rjwysocki@gmail.com> wrote:
>>
>> Hi All,
>>
>> On Wed, May 25, 2022 at 7:48 PM Rafał Wysocki <rjwysocki@gmail.com> wrote:
>>>
>>> Hi All,
>>>
>>> The Power Management and Thermal Control micro-conference:
>>>
>>> https://lpc.events/event/16/contributions/1158/
>>>
>>> has been accepted for the LPC 2022, so if you have a topic for
>>> discussion in that session, please submit it through the LPC web page:
>>>
>>> https://lpc.events/event/16/abstracts/
>>>
>>> (please choose Power Management and Thermal Control MC as the track).
>>> Please also submit topics already listed in the MC description.
>>>
>>> Please note that the LPC is mostly about discussing work in progress
>>> and development proposals, so make sure that your topic falls into
>>> this category.  In particular, please avoid submitting topics
>>> regarding work that has already been done.
>>>
>>> The LPC will be held in Dublin this year, but it should be possible to
>>> participate in the sessions remotely, so it should be fine to submit a
>>> topic even if you cannot go to Dublin in person.
>>>
>>> Looking forward to seeing you all at the LPC!
>>
>> The deadline for topic submissions is approaching (it appears to be June 15).
> 
> There are 5 topics submitted ATM, 4 from Intel and 1 from AMD.  ARM is
> obviously underrepresented.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
