Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBB493B41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354819AbiASNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiASNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:42:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F311C061574;
        Wed, 19 Jan 2022 05:42:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y15so1223409lfa.9;
        Wed, 19 Jan 2022 05:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fiWGg7IWiML/7N4nCQF8+O3tLFRGpS4pRUibWz6/nYk=;
        b=Uc9Mox9mQA6sTTgRLvA65XdynaaJhp0ppd8bHEO+uuitrAEUWYKq57HRqXBzPjUjFT
         fi0W7fI3/2eM5rnD5Wfw25mD1KJXCPTc1Y8ikFxKELFXmTOf8Byf+ArSVIUF6qG8BgKR
         YJ6nbdv7r5pbff8Wma2zoWeQMs3Pd4c2NTaPsA4ohKrIoTOLRBD3Xa3sLHutVk/1favH
         FgFZWu5qqcTkgGsFULeTkJb+q0Nu2p7+np6XNZEzUIWhioTMkX2LqwIqgQAsQUwt0ly/
         E9DhOuITgAc/VXq/p9XcNk7P6FSJNQ811lKsJw27tbbyrbN2BXcf5/wCF62zBNSx6RNu
         IiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fiWGg7IWiML/7N4nCQF8+O3tLFRGpS4pRUibWz6/nYk=;
        b=B90YksRi02uuXLVKIP5bR55qRlc3PZ4uS5C4y54keCD670ZXfat4C+CKFLvf/k9Qu6
         00ylJDUmjx5LkP0xYQdeWupY7ieyJkrqDfVl6I8rZyrGa8opDMDEa31sdXH9Od/tp9Bm
         q/joSRLtufjk5yZ4OfIwuqiAMCJ5NXuO7K+PHVq7jw/Rn4TY/7U6Co8NrPsiaYRLb6Gm
         /APZe7an0ScA0wLt3qryR38Ny2j+OkLJx6qbSZzoOL9OYoFpn7/JJW0UVnzjyIshvvX2
         w41i8tWJ+A+SiFx+LbbTl6KBTgcEAeajSl72hqZ2n9dT5Vxo6q0J4DL44u6978FehXco
         Ltaw==
X-Gm-Message-State: AOAM5339gVfQEeekBQO37Ix/JgX5Yi4RRPfclzWCJsBmhrVu/49eMbvq
        4Z98RvG4IuFNergE5so6UYI=
X-Google-Smtp-Source: ABdhPJzegh2uP7oEHWLAvDhA+rUmRRUda13i+MeZaADKS7j8zT4hyVLHhsxp5bSySbz0wRnpdcq+Mg==
X-Received: by 2002:ac2:520e:: with SMTP id a14mr27429588lfl.680.1642599728450;
        Wed, 19 Jan 2022 05:42:08 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id q2sm1230638lfr.305.2022.01.19.05.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 05:42:08 -0800 (PST)
Message-ID: <fb6a6827-06bf-992e-ed87-cb20eff3c19b@gmail.com>
Date:   Wed, 19 Jan 2022 16:42:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 1/4] memory: tegra: Add support for mc interrupts
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
 <1c2dacc4-566a-929c-2100-37b6f9bece98@gmail.com>
 <fb2fa56a-f1eb-bb19-36ab-a2d460dd3a9b@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <fb2fa56a-f1eb-bb19-36ab-a2d460dd3a9b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.01.2022 11:47, Ashish Mhetre пишет:
> 
> 
> On 1/12/2022 1:43 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 11.01.2022 21:45, Ashish Mhetre пишет:
>>>
>>> @@ -765,16 +768,21 @@ static int tegra_mc_probe(struct
>>> platform_device *pdev)
>>>                        return err;
>>>        }
>>>
>>> -     if (mc->soc->ops && mc->soc->ops->handle_irq) {
>>> +     if (mc->soc->interrupt_ops &&
>>> mc->soc->interrupt_ops->handle_irq) {
>>>                mc->irq = platform_get_irq(pdev, 0);
>>>                if (mc->irq < 0)
>>>                        return mc->irq;
>>>
>>>                WARN(!mc->soc->client_id_mask, "missing client ID mask
>>> for this SoC\n");
>>>
>>> +             /* clear any mc-errs that occurred before. */
>>
>> s/mc-errs/Memory Controller errors/
>>
> Sure, I'll update these in next version.
>>> +             if (mc->soc->interrupt_ops->clear_interrupt)
>>> +                     mc->soc->interrupt_ops->clear_interrupt(mc);
>>
>> There is no explanation of this change neither in the code, nor in the
>> commit message. Please always provide detailed descriptions for a
>> non-trivial changes.
>>
>> Interrupts aren't cleared intentionally by the driver, otherwise you'll
>> never know about early-boot memory faults which happened before the
>> probe. Hence this change is incorrect.
> That's true, we should be logging early-boot memory faults as well.
> Ideally there shouldn't be any early-boot faults as all clients will
> be up after MC, right? But I agree that we should be checking and
> logging if any interrupt is present.

Normally there won't be any errors during early boot, otherwise they
need to be fixed.
