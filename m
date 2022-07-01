Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD846563AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiGAT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiGAT7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:59:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C0396B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:59:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r9so3788513ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VKjYZjtyWMGAgtOQRu2VL2Cr62DJTgW2LkTbwG92hCg=;
        b=C+MTQq4+apcBMl7BgiWqLAHOh7NSZDD0CFIVPxfddtAW14mMHGs0Ioc+hv7hKF3n8E
         eDAvrZJHs9qrMQ5ZmhbFu3ei9BEf82NF51RPm5SUOwdbzDax7HVEygm9OM8JD6GQ0nOJ
         9n7tYpSC45VPI8wrTph7neA0dKddbENGyic3w119+axKiwFEw429WHKgRZeypMsenhPq
         kbSSKHvywE2fVk9KdcN4e6P0W6w3AcDbEyYXmnA2WlJxRCUoZwJfqPADp/RapVF9XPwR
         +rLFJllHOCuAoiOkG2/z9rmAiaZYOgd3+nhaqks1ItsTdveYBSTVpd+QTX0TamDSl4vO
         Ms+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VKjYZjtyWMGAgtOQRu2VL2Cr62DJTgW2LkTbwG92hCg=;
        b=t3lkiRPEFG2/KCaydZ3ZdbzGbqozX/tLXcN5RTWeQC/DL9ru+d63KwyrdD1sCulIj6
         ID14QhsCoHVrMiMDaqnlgyW3DsVERQdaFv+kXHSF39V+1QfjhYcRBFxRI2b9cR2mmajJ
         rfjhV5ukCpdH+x1j3GaBnsh156ILlXHvp10OhbjNfb/cWUhPrt2KCqi7+kaJ1jn4GuQg
         rGYOqoiFt0s4l7dBdX7tRmHHNDCDjx2H1riR5A2kul6POvDMgSJ7pzhKkV3rvEneOG0T
         3A632Uktz2d+ijiuVqn4wHXaDUxQS7ENg8yQP5RGZxsF6//PauStz2dTRp5xuTtFzTpF
         sxiA==
X-Gm-Message-State: AJIora8Nr3vyCq8Czi3ZTrDT7DYDp/oVfgdktsRUXpaXbvLvDMi9/Fn+
        InmZCg43v48iIy6Vl+5GpAKs+2mqcYQ=
X-Google-Smtp-Source: AGRyM1tFXGQtubcqz/kTqQxPAh+cUZXJFrL2Y6sn1DklEs5NkS1oXEDSXZhJBDobwrXJBo/yQxynBA==
X-Received: by 2002:a2e:9f12:0:b0:25b:ad89:80e8 with SMTP id u18-20020a2e9f12000000b0025bad8980e8mr8600710ljk.145.1656705540635;
        Fri, 01 Jul 2022 12:59:00 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.63])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e88d8000000b0025c05ce1bdasm376669ljk.49.2022.07.01.12.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 12:59:00 -0700 (PDT)
Message-ID: <7d763251-c761-1260-b03a-cecf8f6f9738@gmail.com>
Date:   Fri, 1 Jul 2022 22:58:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] staging: r8188eu: remove unneeded semicolon
Content-Language: en-US
To:     Martin Kaiser <lists@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220630090937.4983-1-yang.lee@linux.alibaba.com>
 <20220630115848.hkzavd67cwjubjq4@viti.kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220630115848.hkzavd67cwjubjq4@viti.kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kaiser <lists@kaiser.cx> says:
> Thus wrote Yang Li (yang.lee@linux.alibaba.com):
> 
>> Eliminate the following coccicheck warning:
>> ./drivers/staging/r8188eu/hal/HalPwrSeqCmd.c:70:2-3: Unneeded semicolon
> 
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>> diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
>> index b5f6d41464db..5b0f66573d94 100644
>> --- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
>> +++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
>> @@ -67,7 +67,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
>>  		break;
>>  	default:
>>  		return false;
>> -	};
>> +	}
> 
>>  	do {
>>  		pwrcfgcmd = pwrseqcmd[aryidx];
>> -- 
>> 2.20.1.7.g153144c
> 
> Thanks for spotting this.
> 
> Fixes: df8d0a55047b ("staging: r8188eu: make power sequences static")

^^^^^^^^^^^^^^^^^^^^^^^^^^

No need to backport code-style warning, so Fixes: is not needed here.




Thanks,
--Pavel Skripkin
