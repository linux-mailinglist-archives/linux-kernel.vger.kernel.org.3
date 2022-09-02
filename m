Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBD5AA8B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiIBH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiIBH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:27:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D21B5147
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:27:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so1210726pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sJtVpmkFY08WY7LXA/ozxMi1qLKASR3s0joHG/nWqyY=;
        b=Cn1aZEFgcAfeXe0eVBIHqzLKHgWUsMHq6nx0vzHR8F3TaJkEihPwPwQ3sAQtZdXmLQ
         MgCy3YCMuJfKVPIzqRXYz106uC64CWASHYrS5IkU+ittZEKT+Hj9nNbzSKBNPAyD67eN
         agCvitqFxfihPiF/410NGS3gUMokz4LLF0bnA7U/qclW5PucF7GqfwvUINhaubUh5i0q
         HuFeRuIX7sdJJdraU3UNWqNFUeeGOXETTLxXyUqaNGO0SP8mm0cHlO1yBzB/bzpKKjpL
         hWd5AORg1by06MqOz1YM7yKILorOT/bnWjZSFudeyuLrvnj17X125r4MMraBpi46rVJK
         TWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sJtVpmkFY08WY7LXA/ozxMi1qLKASR3s0joHG/nWqyY=;
        b=0kyNQ5VK0mB6flsJGs+MUG8mFCeyK4QzqdyE/0OmVORAV6YNg50nb+jG1ncD8b1uCL
         ZnN8+f55L6mTSCF+rZ8DyRE0rkonuJIJDGJOrvpnngm7SuKPtcjWKnepMtsYSvEbdQ8b
         +ZYy3UU6Q58JhqoXjfBtQd+K+WKyHjvN3UyiR6D0kwDSOF2AVaAm6haV4Vuns5FKaEKj
         iburo+gbLXW0ht+kdr8UptCqsGxg9gZaMDR2v9GLBDe2dLiTrSUyGjgawWDhKdjwuFcO
         WJhLPe4OoML2hnckwf1fbAQAk6djleLgnOyzjr25LnsIY6xivQKjto3/xNy8vJjBWSsI
         iLgA==
X-Gm-Message-State: ACgBeo3S6fpgCUW+dyY0/e5HlwVLv4FLR8YpvkJdLt5CP8n6XtmTDGG1
        Is9+c6pCEjIUrG5p21KcrZ4zKA==
X-Google-Smtp-Source: AA6agR4i+k/17lXj0/dmHbg3/O1oZcl/uiGB7o+NaxYFkKXKUdrUZBvJZIxwZffacljaHKcq0zzulw==
X-Received: by 2002:a05:6a00:9a5:b0:538:73c:bf8f with SMTP id u37-20020a056a0009a500b00538073cbf8fmr27684156pfg.9.1662103628087;
        Fri, 02 Sep 2022 00:27:08 -0700 (PDT)
Received: from [192.168.1.21] ([223.178.213.132])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7961d000000b0053617cbe2d2sm899604pfg.168.2022.09.02.00.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 00:27:07 -0700 (PDT)
Message-ID: <db00f6a9-263d-9c47-486e-7080ffc5b3c9@linaro.org>
Date:   Fri, 2 Sep 2022 12:56:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org>
 <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
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

Hi Maximilian,

On 02/08/22 18:52, Maximilian Luz wrote:
>
>
> On 8/2/22 13:51, Srinivas Kandagatla wrote:
>> Hi Maximilian,
>>
>> On 23/07/2022 23:49, Maximilian Luz wrote:
>>> On modern Qualcomm platforms, access to EFI variables is restricted to
>>> the secure world / TrustZone, i.e. the Trusted Execution Environment
>>> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
>>> therefore need to talk to the UEFI Secure Application (uefisecapp),
>>> residing in the TrEE.
>>>
>>> This series adds support for accessing EFI variables on those 
>>> platforms.
>>>
>>> To do this, we first need to add some SCM call functions used to manage
>>> and talk to Secure Applications. A very small subset of this interface
>>> is added in the second patch (whereas the first one exports the 
>>> required
>>> functions for that). Interface specifications are extracted from [1].
>>> While this does not (yet) support re-entrant SCM calls (including
>>> callbacks and listeners), this is enough to talk to the aforementioned
>>> uefisecapp on a couple of platforms (I've tested this on a Surface 
>>> Pro X
>>> and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
>>> Yoga C630 devices).
>>>
>>> The third patch adds a client driver for uefisecapp, installing the
>>> respective efivar operations. The application interface has been 
>>> reverse
>>> engineered from the Windows QcTrEE8180.sys driver.
>>>
>>> Apart from uefisecapp, there are more Secure Applications running that
>>> we might want to support in the future. For example, on the Surface Pro
>>> X (sc8180x-based), the TPM is also managed via one.
>>>
>>> I'm not sure whether this should go to drivers/firmware or to
>>> drivers/soc/qcom. I've put this into firmware as all of this is
>>> essentially an interface to the secure firmware running in the 
>>> TrustZone
>>> (and SCM stuff is handled here already), but please let me know if I
>>> should move this.
>>
>>  From what I see so far is that this is adapted from downstream 
>> qseecom driver, this approach could work for a limited usecases but 
>> not scalable, as we cannot add drivers for each Qualcomm specific TA 
>> in kernel.
>> This has to be handled in much generic way using Linux TEE framework, 
>> and let the userspace side deal with TA specific bits.
>
> I generally agree with the sentiment, however UEFI variables should 
> IMHO be
> handled by the kernel. Moving handling of those to userspace breaks 
> things like
> EFI-based pstore and efivarfs. The latter will in turn break some 
> user-space
> tools (most notably efibootmgr used by e.g. GRUB and I think fwupdmgr 
> which
> needs to set some capsule variables). Ideally, we would find a way to 
> not break
> these, i.e. have them work out-of-the-box.
>
> A similar argumentation might apply to the TPM app.

See below, there is already an existing TPM app driver [2] in kernel 
although the app is based on OP-TEE.

>
>> AFAIU, Qualcomm is moving away from qseecom interface to new 
>> smc-invoke interface, most of Qualcomm SoCs starting from SDM660 
>> already have support to this.
>>
>> This interface provides a better abstracted IPC mechanism to talk to 
>> TA. Most of these TA specific interfaces are packed in closed 
>> userspace source.
>> Having said that QTEE smcinvoke driver can be modeled as a proper TEE 
>> driver with Userspace driving the TA specific bits using existing tee 
>> uapis.
>> This also brings in other features like loading, Listeners aka 
>> callbacks, secure memory allocations..etc.
>>
>> In the past, I have tried to do a prototype of this smcinvoke driver 
>> as a proper tee driver, incase you are interested patches are at 
>> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-qcomtee
>> Plan is to discuss with Qualcomm and send it for upstream review.
>
> Thanks for this information! So as far as I understand it, this is 
> currently an
> interface to user-space only, i.e. does not allow in-kernel drivers 
> for apps?

The Linux TEE framework already provides an in-kernel interface to TEE 
as well via TEE bus [1]. There are already multiple kernel drivers [2] 
[3] [4] [5] [6] [7] using it. So an EFI driver can be an addition to that.

Now coming on to TEE implementations, the drivers I mentioned are based 
on OP-TEE where devices are queried/enumerated during OP-TEE probe here 
[8]. So in similar manner QTEE smcinvoke driver should be able to 
register devices on the TEE bus.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/staging/tee.rst#n56

[2] drivers/char/tpm/tpm_ftpm_tee.c

[3] drivers/char/hw_random/optee-rng.c

[4] drivers/firmware/arm_scmi/optee.c

[5] security/keys/trusted-keys/trusted_tee.c

[6] drivers/firmware/broadcom/tee_bnxt_fw.c

[7] drivers/rtc/rtc-optee.c

[8] drivers/tee/optee/device.c

-Sumit

PS. TBH, I haven't looked into detail workings for the QTEE smcinvoke 
driver.

> It would be great if this could then be extended to handle (the bare 
> minimum
> of) in-kernel drivers (i.e. only things that the kernel itself needs, 
> like EFI
> variables). Alternatively, I'm happy to hear suggestions on how we not 
> break
> the aforementioned things while moving handling off to userspace.
>
>> I think its worth exploring if uefisecapp can talk smcinvoke.
>> I can ping Qualcomm engineers to see if that is doable.
>
> I think that would be great! Thanks!
>
> Regards,
> Max
>
