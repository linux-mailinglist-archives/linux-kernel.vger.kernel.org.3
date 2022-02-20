Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57E4BCFDC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiBTQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:30:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiBTQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:30:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE204A93B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:30:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p14so27014943ejf.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OWLpcBVa2M4tskUxAekykJf3XE4zqcHsbnkNsOcSIRk=;
        b=OExUL0nKv5AWNW77ihPgtZ0duZyFBCSH7B0XGHkXHeRORnzb5LfNn1CBEX3OMY08vb
         mtEdoxwa8GxbLD+QjdcavbJ24ggBqFpQnJVR081KF6hK8A3+cLe+ARKl2Mk2XX2azVeB
         Ite7Nt5XXgTANrkk+cmarOTwAGId4tsprSx0+yNqQXwoDxfAffi/tS1ojzzaImtUx+iG
         jgTAg2NylQ3+yEJj3hVXM9qfap6S+T5Yccfa+JLlsEhoBalqLJdn13jLxhitd3KzFEFA
         IpkwADNrtm37awybkEyKuRQp/yS6OyLWUoTAU4dH7rm0AC+6k9CH26tK3vlZhSWg5eKr
         9v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OWLpcBVa2M4tskUxAekykJf3XE4zqcHsbnkNsOcSIRk=;
        b=MWktqdGhWV4qbJgOlvl3/hNW2enjeeTMbn+kLl+Jbi9eyYHvGLmS1Clj0pqSu5qgtN
         +BGrgH9NTXdkzQHYTaE8wUrcEUMcV/T11PTGkyPKfG37zYlphuiteygqWGFUmLj/XpqK
         ce0u3QpZye/nB2ww8plV+Pxl1upLBxhJSNJm6uqpdlSJ5o/Y+rTOhJYIrAkqnpREQ1As
         ME6B4RA+E4UdbSZCDBd2IUIaSoGXYsfeeUtVpYXXY8jJwpkVyH3zp+kQ/5BMJ+jK8nfa
         fAot/1umIk7zeYjBxqZ/JthIHALrzr5L60IQlV3VYGUe6avk8dtGtpwL3GfJJjEj3Yae
         AMSw==
X-Gm-Message-State: AOAM531/kQfSrwX2bTKIzFXvhMik/RmwahQAQWshLwO/OhQOC/iYCkpE
        VSN4h0vAJM9TrJjTNIFhXPRF2oHdLfM=
X-Google-Smtp-Source: ABdhPJyd2RU/junM5/4SP6yca5whc9aoFfekgEyHnrTAndRTVOAuYulMS96VkhBSpJH9QAWYDA21sg==
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id u25-20020a1709064ad900b006cf093ff77emr13244335ejt.558.1645374609631;
        Sun, 20 Feb 2022 08:30:09 -0800 (PST)
Received: from [192.168.0.151] (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id l24sm7606251edv.88.2022.02.20.08.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 08:30:09 -0800 (PST)
Message-ID: <94160654-ec16-cad2-3cc2-46628caaa17e@gmail.com>
Date:   Sun, 20 Feb 2022 17:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-3-straube.linux@gmail.com>
 <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
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

On 2/20/22 17:20, Pavel Skripkin wrote:
> Hi Michael,
> 
> On 2/20/22 18:48, Michael Straube wrote:
>> -static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
>> -
>>   u32 rtw_ch2freq(u32 channel)
>>   {
>> -    u8    i;
>> -    u32    freq = 0;
>> -
>> -    for (i = 0; i < ch_freq_map_num; i++) {
>> -        if (channel == ch_freq_map[i].channel) {
>> -            freq = ch_freq_map[i].frequency;
>> -                break;
>> -        }
>> -    }
>> -    if (i == ch_freq_map_num)
>> -        freq = 2412;
>> -
>> -    return freq;
>> +    return ch_freq_map[channel - 1];
>>   }
> 
> What if channel has wrong value? The old code returned some default 
> value, but with new one we will hit OOB.
> 

Hi Pavel,

thanks for reviewing. Yeah, I thought about adding a check for channel
value between 1 and 14. But I did not add it because I think if this
function will ever be called with channel < 1 or channel > 14, then the
calling code must be wrong.

Would be nice to see what others think about this.

Thanks,
Michael
