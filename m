Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A970C52EB11
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbiETLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348659AbiETLnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:43:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23BF15A75F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:43:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a19so7519583pgw.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YOapDlN8jb/oTIK7p2pjJfrsska7tlBqsu0+8NfTwEY=;
        b=bQTvIXXjUdwosurQPkJH/SVzTHlXmYVkmSU8KGI239VF2VrKMKGdXwQPe/FX5FjDcV
         OjWqYUJh4T/DBhv3epcNl/8e6OohOtqNMwdz0tKYSureU2boaoAYS24WP8tibBhV0Y/H
         U/GKHNZ1wvSOl4NFvVySuQRABROUYTP+210DUQnDlaagGeloNqCNmW0nwHUg25Hwa8oO
         x898GnG9E6iAwK05PAjra8RII82DYqePuGXqxWkO845G7SkFYsxG0ES4OJqVc2RCT2c0
         GmL8qjfxYGBoTKM5ZdBgmmIR9fWB23mQMD7Nb0RiB17voph8qnC7nWWKPuVe221HxBD3
         YvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YOapDlN8jb/oTIK7p2pjJfrsska7tlBqsu0+8NfTwEY=;
        b=aiPx0que0kokiVh73X2vLS0Pvcbs/iZoBFxqMezkiAOEuAn5WqCzhq7Xqknen0+6rI
         1stOzoevp35AVOuboJYsJxIrFzFk44HOFYP/xLTo1sYDr2Dy23u9JsGq+5IIf24xNdgq
         omWarmpEqnihwjxTvi2dISQDH+kW2JuHryCRrrFq5lrFklCYSNnF4XTCucboClIyVq85
         TZtu+/8l4zoJ557YTnO8ayMBTROqv/yVz9QBETxI1+tBnond2qFCRJ0zAQLmXRPgCj1j
         OZCOKsAclFh/khVyR6KdS03mQScB7Gar76WE/vWInxuu7XgIFhuWkicZmIGEN2EFYyfw
         mWDw==
X-Gm-Message-State: AOAM533R4ZuRFrBWRuAiTFw5YTczKDCHF4N5zom/okhUyBwRJoypB4LO
        YveEpChiRNjvUs0j4n7RrQqzeD30v7MZxYzw0jvV/g==
X-Google-Smtp-Source: ABdhPJxcLpa0lnyGIu1w0+2MVsg7exXsrDcE1PoSHWbjPDZanK7+BZn3kMFWMNyk80Lm/Gp/GWnHZA==
X-Received: by 2002:a62:3881:0:b0:4b0:b1c:6fd9 with SMTP id f123-20020a623881000000b004b00b1c6fd9mr9824353pfa.27.1653046983390;
        Fri, 20 May 2022 04:43:03 -0700 (PDT)
Received: from [192.168.0.103] ([106.51.243.174])
        by smtp.gmail.com with ESMTPSA id z18-20020aa785d2000000b005183c6a21c8sm1542950pfn.165.2022.05.20.04.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 04:43:02 -0700 (PDT)
Message-ID: <53809b87-9b39-0aa9-dbc9-d5b40b3b46a6@gmail.com>
Date:   Fri, 20 May 2022 17:12:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/vmware: use unsigned integer for shifting
Content-Language: en-US
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Borislav Petkov <bp@alien8.de>
Cc:     amakhalov@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
References: <20220520072857.592746-1-sshedi@vmware.com>
 <Yode3m6iia9ZBHsl@zn.tnic>
 <c3219731-5f7e-80ea-b193-f8c93d7c1bdc@csail.mit.edu>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <c3219731-5f7e-80ea-b193-f8c93d7c1bdc@csail.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/22 4:59 pm, Srivatsa S. Bhat wrote:
> Hi Shreenidhi,
> 
> Thank you for the patch!
> 
> On 5/20/22 2:26 AM, Borislav Petkov wrote:
>> On Fri, May 20, 2022 at 12:58:57PM +0530, Shreenidhi Shedi wrote:
>>> Shifting signed 32-bit value by 31 bits is implementation-defined
>>> behaviour. Using unsigned is better option for this.
>>>
> 
> Can you also add a "Fixes:" tag with the commit that introduced the
> issue? I believe it is 4cca6ea04d31 ("x86/apic: Allow x2apic without
> IR on VMware platform").
> 
>>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>>> ---
>>>  arch/x86/kernel/cpu/vmware.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>>> index c04b933f48d3..b28f789d3c56 100644
>>> --- a/arch/x86/kernel/cpu/vmware.c
>>> +++ b/arch/x86/kernel/cpu/vmware.c
>>> @@ -476,7 +476,7 @@ static bool __init vmware_legacy_x2apic_available(void)
>>>  {
>>>  	uint32_t eax, ebx, ecx, edx;
>>>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
>>> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>>> +	return (eax & (1U << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>>>  	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
>>
>> Or you can use the BIT() macro and simplify this expression even more:
>>
>>        return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
>>                (eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
>>
>>
> 
> That's better indeed.
> 
> Regards,
> Srivatsa


Thanks for the quick reviews Boris and Srivatsa. I will make the changes and push the another patch soon.

--
Shedi
