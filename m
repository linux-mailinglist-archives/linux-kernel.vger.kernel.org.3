Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84F53CA32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbiFCMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiFCMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:49:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE939B8B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:49:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 187so7114305pfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=exsCTb3RhNEwxvlMOwcnt/00mt1Hbb8S9b9s0CrxOYc=;
        b=NEayjROeNRhzaRdT2aEtWiUezegpHOWOrpd2GvE7Z/aivpPYe42GVQkk4iFNohBkLW
         +l2/kY2/lTcbQbCXLPX5axWZE280lzO5TNdrAHqjMaUfeCDwLZYQGQ6+CAuYKGNN/Gb7
         ikXuHoJ3WuDNjzgbxblnokllN8WgtNeXPLFK6MEqNC6U9z1Ezd9aTObkOjlMlzT3NOWO
         2o+HwI1J9zcBSSgd7lDleGUW4hMYLN8y8bqzdrpPtJvXQHWLQdk/1KXf4JmA7rqcpx80
         GhQmkPMXCAV0vDgzqegTVrouCAnllXh4Q04Dt096GZQveNibtWj+ThOrNaMaEdvra7w7
         chQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=exsCTb3RhNEwxvlMOwcnt/00mt1Hbb8S9b9s0CrxOYc=;
        b=XZEcsL3/crQorbrY7AsT1Zd6tjwItury/Pqxz6jGXkTgbaBUdZiUf5DyzfsGI+sr3b
         vIZULJ+OL9Zag75LpO+tooq/xee43fV8c+pp+k9In39qhH5ljnHKdYWg0ts3lJRJD8cH
         INMvawuQ80L7XTwsGYYVhIPSh8FHeNOm10ADdEiuPsogSdD+BRrJMXko3R9ZtTIbYaWw
         P1P4aG13HcWdDojLGvIv/YSbXcXr6r97QU16ahekvwsssLi2ev7nHPj3DOJeJNdmzTJD
         NWoQodWm/43BSa0tbdWQ+ZiLXvPBfxDRfz6tq/oGc26Cju4iol8xS2162WYopE7jJYRV
         WHkA==
X-Gm-Message-State: AOAM5328yY9vlcg/zAEPm9mBJsr14z3D45PNuJS9CiCxtg8vDPXthyuF
        vXGJcSKG7AO9/H373wG8Ksk=
X-Google-Smtp-Source: ABdhPJxv5+I2g+mWtYFMgs6frgtLMqaaIInMvTVmCBavcqiatsfOJA+R0qNn2t9bXYW0WVs1Y1lKow==
X-Received: by 2002:a63:6ac8:0:b0:3fb:cd6e:8d8f with SMTP id f191-20020a636ac8000000b003fbcd6e8d8fmr9098485pgc.542.1654260567774;
        Fri, 03 Jun 2022 05:49:27 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.243.30])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a0c8900b001e0899052f1sm7684900pja.3.2022.06.03.05.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 05:49:27 -0700 (PDT)
Message-ID: <a2a85252-685f-d0d7-100d-96be014879a2@gmail.com>
Date:   Fri, 3 Jun 2022 18:19:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] char: lp: ensure that index has not exceeded LP_NO
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, Shreenidhi Shedi <sshedi@vmware.com>,
        linux-kernel@vger.kernel.org
References: <20220515075455.306082-1-sshedi@vmware.com>
 <64570db1-e9f2-4f23-1d14-3d4b35776bca@gmail.com>
 <991f7966-0734-36ea-b206-a428620efe41@gmail.com> <YpoCIS1HVft8MbmB@kroah.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <YpoCIS1HVft8MbmB@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/22 6:14 pm, Greg KH wrote:
> On Fri, Jun 03, 2022 at 05:32:25PM +0530, Shreenidhi Shedi wrote:
>> On 03/06/22 5:27 pm, Shreenidhi Shedi wrote:
>>> On 15/05/22 1:24 pm, Shreenidhi Shedi wrote:
>>>> After finishing the loop, index value can be equal to LP_NO and lp_table
>>>> array is of size LP_NO, so this can end up in accessing an out of bound
>>>> address in lp_register function.
>>>>
>>>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>>>> ---
>>>>  drivers/char/lp.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
>>>> index bd95aba1f..e61060f3c 100644
>>>> --- a/drivers/char/lp.c
>>>> +++ b/drivers/char/lp.c
>>>> @@ -971,7 +971,7 @@ static void lp_attach(struct parport *port)
>>>>  			if (port_num[i] == -1)
>>>>  				break;
>>>>  
>>>> -		if (!lp_register(i, port))
>>>> +		if (i < LP_NO && !lp_register(i, port))
>>>>  			lp_count++;
>>>>  		break;
>>>>  
>>>
>>> Hi Greg and Arnd Bergmann,
>>>
>>> Please review the above changes. Ignore second patch.
>>>
>>> --
>>> Shedi
>>
>> Sorry, not the second patch. Ignore the 3rd patch which fixes checkspec.pl warnings.
> 
> I have no way to do that, please fix up and resend the correct series,
> our tools can not pick and choose from a series easily.
> 
> Also remember this is the middle of the merge window and we can not do
> anything at the moment.
> 
> greg k-h

No problem, I will send a new patch series with only intended fixes.
It's okay, take the patch when the time is right. Thanks for your prompt response and your time.
 
--
Shedi
