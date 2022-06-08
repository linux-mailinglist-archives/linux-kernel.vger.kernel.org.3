Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EF543025
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiFHMV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiFHMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:21:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AAB7C9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:21:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n28so26829790edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xjj1tLFDgk1IP/xpbiEVDtCshJsxAgTV6gwqm2wyO5s=;
        b=I3+7/tR9MfmP3QzIkLLK4neR+JKEKyUz0cZbOYUIx60SQYnTUvbbNwiWC7QssDKtBX
         YPyTJyz3DdWQ2p7Pu8mJEErij5pJJkyimocnDb6qem+eQgQPcIZ/oflXf4FPmipvl7mi
         cYWhrz7bkL/MHtLPggH3BY/pJdmqFBYjLmb/xOaMA0fJirGfGCIpw+2hM+DmQdQdTQJ6
         +SnXfxq6BpVANa/Lru8XgHwjwjMbQ9rOUAach/nC2UrKMRugdRXgDqNDu2g3Rkpw6PDq
         yhMGhJuA1bUfz/EGXNOE2XqRdppj83i+xsq/nKAwn8GIsBwIKG6Z2ire3rMiLyRBT4jL
         68xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xjj1tLFDgk1IP/xpbiEVDtCshJsxAgTV6gwqm2wyO5s=;
        b=yUDDXgKevTOCiVaSkZZ/d5Ii6L0K1pXUog7GLzokf5cqgh0i/dlulzcOt/4KdNPxqu
         yTBwhkIBQ6SL1/o+cO6tkEkqtLCqTmft0PGeonyTrIi/roNasr4jj1qZodpDoi4Vgf8I
         kZ5HmDq1LZfFRwrHjhzC1RYFVCCRjym2qDs17mHwu6mY5DI4nLxtoCs75kSMwQVMuuoV
         1s6J3p+yw8oZ5IA04Wbx2eOqewzRpIyTcpMDI1o8ON00jycsQV2uw0vrOSOs9trPx13J
         MZspE667S6PfP97UKZeFIFTUOpWr40JSLAxDlGxQU0JRu1XIhZh1OyZ+HqAQ5je+lB3z
         WTIQ==
X-Gm-Message-State: AOAM533uE2QVW5gwHrLgTlzz4Nx/qV0pNLOJNiDSPyyc4yMYT6J+NVhv
        24N77TBQ4A/CbI7y36oNBhQ=
X-Google-Smtp-Source: ABdhPJy+JqdifjdZSTQcoX42t13NAgohoprOiyoAOzoTPgBhO3lKMUQLa6SEOI/mUhs1y1P2USGlFA==
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id f1-20020a056402194100b004132b5f9074mr39306489edz.414.1654690883253;
        Wed, 08 Jun 2022 05:21:23 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb79.dynamic.kabel-deutschland.de. [95.90.187.121])
        by smtp.gmail.com with ESMTPSA id gg1-20020a170906e28100b006f3ef214da9sm9293193ejb.15.2022.06.08.05.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 05:21:22 -0700 (PDT)
Message-ID: <66c634ae-2b72-8c7c-e312-104e59cda269@gmail.com>
Date:   Wed, 8 Jun 2022 14:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [BUG] staging: r8188eu: driver stopped working with commit
 ("staging: r8188eu: add check for kzalloc")
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Martin Kaiser <lists@kaiser.cx>, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220606064055.12565-1-straube.linux@gmail.com>
 <ded4b3f5-a9bc-4612-33cc-68bd85cb92fe@gmail.com>
 <20220608092731.hz26q37fhmrhipmj@viti.kaiser.cx>
 <01d6737a-9e2d-c009-4e24-c2c54b39b80c@gmail.com> <YqB9siuACKQMKXhv@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YqB9siuACKQMKXhv@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:45, Greg KH wrote:
> On Wed, Jun 08, 2022 at 12:34:45PM +0300, Pavel Skripkin wrote:
>> Hi Martin,
>>
>> On 6/8/22 12:27, Martin Kaiser wrote:
>>> Hi Michael & Phil,
>>>
>>> Thus wrote Michael Straube (straube.linux@gmail.com):
>>>
>>>> The driver does not work anymore on my system. In dmesg there is:
>>>
>>>> "r8188eu 1-4:1.0: _rtw_init_xmit_priv failed"
>>>
>>>> I bisected it to commit f94b47c6bde ("staging: r8188eu: add check for
>>>> kzalloc").
>>>
>>>> ~/kernels/staging> git bisect bad
>>>> f94b47c6bde624d6c07f43054087607c52054a95 is the first bad commit
>>>
>>>> At the moment I have no time to look further into it.
>>>
>>> See also
>>>
>>> https://lore.kernel.org/linux-staging/YoyU4zXf45UpF1Tq@kroah.com/T/#mb5e56a285b8eb1ebb0e798462fc388cb02b4a7cc
>>>
>>> Phil said in
>>>
>>> https://lore.kernel.org/linux-staging/YoyU4zXf45UpF1Tq@kroah.com/T/#m7a21d460b2569f6b59965ecc3298a6337fa3458a
>>>
>>
>> There is the posted patch [1]. I also have to apply it every time I want to
>> test smth.
>>
>> [1] https://lore.kernel.org/all/20220521204741.921-1-phil@philpotter.co.uk/
> 
> That patch is in linux-next and will be sent to Linus later this week.
> 

I obviously missed that patch. Thank you all.

Michael
