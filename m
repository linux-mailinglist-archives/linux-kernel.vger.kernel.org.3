Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EB5802B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiGYQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiGYQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:29:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495131C93D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:29:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l15so12694202wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LoYYiG/WIlrwIoSGoXt46XAdgVPx2zUgg6hvl9E+37Q=;
        b=pYNlGnom+uaENCgIt/1JCDAumOiTIgIiAZ2521LncXOkfjzv0/3uGCwwKdzWYV3TLu
         KOJ/H6iLH/mBNkEMzYyY3gD0vqMFdGb4jeoY4Lu2hs0XzQsTKCXjv5yXJIon4JXfFgyQ
         JuNy6iZ4JjvtRR+eD1gg4OF2UQr9p4sUidvf1wdrPMeDTSllq0pEQqb/N+ErXFvk7TqD
         n+WkqVl3oGthoPUIKbRByMT6IDvxqUJvd3xA+QE+t7NPEtYz4ivz6qXQQaHdqdK78aDg
         0EhD6J5NKsnNqFZuwZ5JoqbIsqSb+DCEDEhEUVecLHg2XZ1tsXySaYCzuU9IX4/dvW5P
         FZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LoYYiG/WIlrwIoSGoXt46XAdgVPx2zUgg6hvl9E+37Q=;
        b=mNLnJpExzhj8dLVReXAMjdOZ5/B+Cv0jubsacTJhh2vITE4QFRSWgR6mUmDbtSGfmL
         duHxIokkUhp0XQ1+5kJEKM1jgxwfyWs1BBevEjDFalkdni7sJShzSgKeQ/Nib7yAbr2L
         0ubeatVt/tW4woOJWKm0UjyPKptCsdZ0Dx5h2NuGlMiwDEn9BUp1hhA1AHYW9M7w1Jk2
         O8HRKonigke9dAeliT7s5hOUKikWJYA7q9kG6buFmcpB7OjfiyWQpSwlZIMMZxqD33w0
         nTYL8SWqQVdnBHpNSATEBtKiX/wvn90H3CmLR8gsxPs6qio5uExTkECkAE/INz7TOfN/
         Tdfg==
X-Gm-Message-State: AJIora8uHSw5/ht16RjrTucQGKWe7JUPOALwQu0D7PAwRdqBsNwjnNIw
        AvxgMHi+3gKltMhbc+tong5TsA==
X-Google-Smtp-Source: AGRyM1vOY2CRNxGtumn+m6EYQqGzDTCujramxYvHnb4Nhthb97l52FH4gSoKUHh2wSE2Kk7XAsMyrA==
X-Received: by 2002:adf:ef87:0:b0:21e:8cb4:86ac with SMTP id d7-20020adfef87000000b0021e8cb486acmr3178134wro.674.1658766581495;
        Mon, 25 Jul 2022 09:29:41 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.googlemail.com with ESMTPSA id t10-20020a5d534a000000b0021e5e5cd3a8sm10169283wrv.87.2022.07.25.09.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:29:41 -0700 (PDT)
Message-ID: <1ec4d34d-6700-0f99-81e3-1c7129a80246@linaro.org>
Date:   Mon, 25 Jul 2022 18:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-3-daniel.lezcano@linaro.org>
 <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
 <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org>
 <CAJZ5v0gjfeyiS8rUoPpa3sMrofw1ZyQe=+P6pvPbeirs07F+Qw@mail.gmail.com>
 <8926eed7-436f-5f1a-7036-0e1520bd3a0b@linaro.org>
 <CAJZ5v0icAE1t4+VsEq71FiUjQXr1LJeokBiuGTxvsHByedfmhw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0icAE1t4+VsEq71FiUjQXr1LJeokBiuGTxvsHByedfmhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 22/07/2022 19:40, Rafael J. Wysocki wrote:

[ ... ]

> They can be made in the opposite direction, starting at the core
> level.  Then, it would be clear where you were going.
> 
>> I would like to
>> keep the indexes trip array approach to fix the trip cross events which
>> is broken right now and then go forward with the struct thermal_trip
>> changes and the thermal-of cleanups I've sent last week.
>>
>> Does it sound reasonable ?
> 
> I'm not convinced about the need to make the code more complicated if
> the overall direction is to simplify it.
> 
> I understand that you want to avoid regressing things, but you want to
> make these changes eventually anyway, so why to you think that the
> risk of regressing things would be smaller in the future, after making
> the code more complicated than it is now?  Sounds counter-intuitive to
> me.

Ok, I'll rework the core code for that.

Having the series [1] and the new version of [2] will have the trip 
point partly reworked.

Thanks
   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
