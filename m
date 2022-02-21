Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE374BEABB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiBUTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:20:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBUTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:20:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD15F88
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:20:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk11so35793953ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ambcHh4g4nuzaHL8tbFi1rXA5xQNyGp2dIP09whVRJw=;
        b=BQiL3mkhBFlLDxQtoIqAcV0ab3fcefJxlG9lEU/rFkdNKxHll2gNnfU6QQ/0CvYXhQ
         oelqyNJ88r0YdQ6lyqQVm6JdWfzVMuWL3A5cByfb2CXg3qCYvRw+wVfAipds3b0pzX5E
         Lx1aPU3g8MVUxUBRuYwpE2Al7S5hTJ2enK1VT1nHr83WNzNuSjS/tzBx0B0y6CZrXwUK
         WQZWagQKbhkmbMvQgKld/Ga55nSnSIWPUAh6GhFiFri8GfIacFZs1u7dK1gzJpCwNGGO
         cVulXnFWWod6FxqKXgEvqLUwkkFtUS6Kj9+K8rt+5OSLXJpaalWhhTI92QIGc0IUtEli
         0+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ambcHh4g4nuzaHL8tbFi1rXA5xQNyGp2dIP09whVRJw=;
        b=IDYvbiORflKOfvShVXhfLYOyMn/wQjr/du+Dkh88y0mxhRr1CuQ/xJTdGkOXGNmdts
         hD1cVvWbx/m618BFLZ3DPiguRikFELSoliEW0nOmhmmiYeMqDrU6kIkMmfCOWvCyqWQ0
         XTfpBiJgbTpdkDtMo9Sh2nNcyZt4l79UNZo7nij7HIVVLxGBbVytrKBoon9oHAhA7cQJ
         JrrNGGlG0NKvPlQA4JbxZhHtLHQem6MAdXUE75ufO3w94T2UDFnQpyGyWUPuCepaSakZ
         TiXAsXlfOfK+L3l663+KYeWjNVLsb+umePBgLoBdFUHh0JK22a3SqqsWQ21XlQNP8PFS
         3IQw==
X-Gm-Message-State: AOAM532cUn8BTSx55OQQ9JE9bdvSpul7DAXXE9NJVVdaSIAoqnTZLYXF
        afPCYk1eCIO5ErMQdNi/Roo=
X-Google-Smtp-Source: ABdhPJz7/WK2HknMFO/miUSmniYf+SBuMVCKGeq3/nF9oTSQSB2PZSHKErD9buGGSiCDI6qiSnwl8g==
X-Received: by 2002:a17:907:1dc4:b0:6ce:a705:9d95 with SMTP id og4-20020a1709071dc400b006cea7059d95mr16735531ejc.597.1645471215416;
        Mon, 21 Feb 2022 11:20:15 -0800 (PST)
Received: from [192.168.0.253] (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id m11sm9262546edc.110.2022.02.21.11.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 11:20:15 -0800 (PST)
Message-ID: <32a2b74b-f541-ddf6-d8c9-6bd6ca0ad07b@gmail.com>
Date:   Mon, 21 Feb 2022 20:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-3-straube.linux@gmail.com>
 <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
 <94160654-ec16-cad2-3cc2-46628caaa17e@gmail.com>
 <20220221122250.GE3965@kadam>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220221122250.GE3965@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 13:22, Dan Carpenter wrote:
> On Sun, Feb 20, 2022 at 05:30:08PM +0100, Michael Straube wrote:
>> On 2/20/22 17:20, Pavel Skripkin wrote:
>>> Hi Michael,
>>>
>>> On 2/20/22 18:48, Michael Straube wrote:
>>>> -static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
>>>> -
>>>>    u32 rtw_ch2freq(u32 channel)
>>>>    {
>>>> -    u8    i;
>>>> -    u32    freq = 0;
>>>> -
>>>> -    for (i = 0; i < ch_freq_map_num; i++) {
>>>> -        if (channel == ch_freq_map[i].channel) {
>>>> -            freq = ch_freq_map[i].frequency;
>>>> -                break;
>>>> -        }
>>>> -    }
>>>> -    if (i == ch_freq_map_num)
>>>> -        freq = 2412;
>>>> -
>>>> -    return freq;
>>>> +    return ch_freq_map[channel - 1];
>>>>    }
>>>
>>> What if channel has wrong value? The old code returned some default
>>> value, but with new one we will hit OOB.
>>>
>>
>> Hi Pavel,
>>
>> thanks for reviewing. Yeah, I thought about adding a check for channel
>> value between 1 and 14. But I did not add it because I think if this
>> function will ever be called with channel < 1 or channel > 14, then the
>> calling code must be wrong.
>>
>> Would be nice to see what others think about this.
> 
> I'm glad that Pavel noticed this change.  This is a risky thing and
> should have been noted in the commit message.
> 
> Just from a review stand point it would be best to leave the original
> behavior.
>

Do you mean to leave the whole original code including the 5 GHz 
frequencies? Or returning a default value if we have a channel value < 1
or > 14?

I'm a bit confused now, because Greg asked how we know that the driver
is only for 2.4 GHz chips.

> I have audited this change and I do not think it is safe.  It seems to
> me that one way this can be controlled is via
> module_param(rtw_channel, int, 0644); in
> drivers/staging/r8188eu/os_dep/os_intfs.c.  I don't see any checking on
> that.
> 

Thank you Dan!

I missed that and blindly assumed the function will never be called
with channel values OOB. That was not good, sorry.

regards,

Michael
