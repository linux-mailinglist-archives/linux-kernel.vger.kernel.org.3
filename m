Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398C52001B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiEIOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiEIOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:46:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34E174933
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:42:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so10927720wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QqShHkKgDFizDmpmSSdmDrX/sfeJAiBTI970sTvj+Bk=;
        b=vUy+W4dIB/CP4YqBPfl7YXr3TPoHkkXMM47VvBAqP/P1bbeTv4auv5JpEO6P39GtZm
         bsQxBjNyr4BTyuFajqyQj/5iiJXQHSSq1vLW78v2crhgsZw7Aa6oXTgSYFzYJlfQtayt
         WWoI7y3gP2Oe9lNHwYCzvDmVAx4DJ/J6rXmdLnAkugqYE5ogUCPFXFf10SHfx2Luq0J4
         JZHqC7UkLdH4Qvcr4DtfA9ICf47joRUk8ZEG0n0derS73v0seQdqQ8pPvN+4jtbxxT3i
         rBlHR+Joh2mFZEWpealWjPEjyD7SeQOJhzZ1gf80hJQyTybFOVr0abLFbYecgfkogYVG
         h69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QqShHkKgDFizDmpmSSdmDrX/sfeJAiBTI970sTvj+Bk=;
        b=KbJ0sLP7tMXhDKPy08684g8Jgdn0xc59Bx9cS7cfAQhINou1x1m1QosuLdKZkxoRwu
         ZwxUqMkEUgJhKqY+P/TMziIc+1rah6+FUdreQ2/TJWnJzB2yy03idsSTiBxT0Dse06Sl
         aNz1RLh/uXemZ2ggT3lgYCfWPw1aC47KESfo5V1Yh6UOccS2iQFZ1VOWLOQJHXqXEDmm
         iS86pxr2Vrep4z/vBBl0w4lxvdcywt8wM+0N+dJBVH925O4AjZFzRjbGy8j2I2CBG3uw
         W3/TzhUliXbJ6qKd8XuXdyjURar3sz4Gjk08lIYfRgstx3C7b4v0WJHezF9RTuMChiel
         nhFw==
X-Gm-Message-State: AOAM533Np+4UmNHmgY4Kbpxl6m/bkM9WP+3tPzAmrLzP/pKnf+CMleiU
        uA9yozB/opNn8DOQpn0aWaR02w==
X-Google-Smtp-Source: ABdhPJxsUsgm5c1MnmnJGYS6LLodO6fR2/kEd6o3eu0aWtFgK9hd1itoxZfX0/O+ZDNhqZshbeCK2g==
X-Received: by 2002:a05:600c:3b99:b0:394:70a0:12e3 with SMTP id n25-20020a05600c3b9900b0039470a012e3mr16461461wms.120.1652107355673;
        Mon, 09 May 2022 07:42:35 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id 7-20020a05600c230700b003942a244edbsm14842645wmo.32.2022.05.09.07.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:42:35 -0700 (PDT)
Message-ID: <b127f25f-51ea-f5d1-baef-9a0f026a2e05@linaro.org>
Date:   Mon, 9 May 2022 15:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
 <725af523-d144-e373-e09b-fb48b3afb9ed@linux.intel.com>
 <8643d266-7108-2440-43e1-c51b829ba481@linaro.org>
 <d9646029-29b1-d71b-d1f5-b33267888e3c@linux.intel.com>
 <fd355232-c5e3-ba1b-801d-526ee6f04946@linaro.org>
 <97cd6566-e686-e1f2-fe91-4b4ba9d95f12@linux.intel.com>
 <d17db27d-ad1b-f52c-50e9-4aab78ae0ff0@linaro.org>
 <0d645ee0-a54f-d9b4-9392-06ea1c37b29a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <0d645ee0-a54f-d9b4-9392-06ea1c37b29a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2022 15:36, Pierre-Louis Bossart wrote:
> 
>>>> Even if enumeration timeout, we will not access the registers because
>>>> the ASoC codec is not registered yet from WCD938x component master.
>>>
>>> What happens when the codec is registered then? the autoenumeration
>> Codec is only registered after reset and when both TX and RX components
>> are probed.
>>
>>> still didn't complete, so what prevents the read/writes from failing
>>> then?
>> If codec is reset and registered and for some reason autoenum took more
>> than 100ms which will be hw bug then :-).
>> In this case register read/writes will fail.
> 
> Does this reset result in the 'bus reset' in the SoundWire sence and
> restart hence the autoenumeration?
The reset am referring here is codec reset gpio line. on reset device 
will show up on the bus which should trigger an autoenumeration.

> 
> It looks like you have a race between different components and starting
> the bus before it's needed, no?WCD938x is bit of a odd hw configuration, that is why we are using 
Component framework for this codec. This does ensure most part of it.

--srini
