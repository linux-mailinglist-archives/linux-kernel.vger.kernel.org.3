Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052453EAD4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiFFPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbiFFPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:33:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5471F27B1C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:33:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so23866624lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YcwGpjo58UXNBMEnswMeb//FPBvxd6I0WbIZe/2XdyM=;
        b=dfwcDxiP3tZ2AU6j2Akd8JwNhhm7Av2t7LErsEwmFMrzbzdoSErffgfZcss/wD693j
         eMY7HaQWW78zuROkKEk69OZn8hxZhVr2gWMcPrt7rHTx84FZtK5QVVL7NCUkRTToAKgc
         IkJMYc2lhePiW80os7pTGZXGbHcaFIMHu34WLWIVz2o0Dxxp4xL9ErfwLy3eiC/ynwIb
         OQXqhTEPaZVKFPaMLSr1vtEQ1LKTlAMLbdBy4wFureLfrbLu9/qLLOCG3+9yd2AFLfOc
         cxmRzvKjvxUhrNlFvteKji32EHTRCMy3z4WAEU8Ehaj3aZpj0m7FKFVkWL8GNFVw996y
         IZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YcwGpjo58UXNBMEnswMeb//FPBvxd6I0WbIZe/2XdyM=;
        b=w4Q4f1xVOuY37TuOfNHykhkGGus1ljvTlAMMDP/76LmupAECiDGjiUXLjJ3nUtZWGA
         Y+UEeYEYrei8EtGoy/mHSec/exVVqhwMe49KI581TNAIzSnKQnu9qhMZxzK2Ty9fnFbn
         7Kg5B/GKoLF3oMY10xrxVNT+DRzrS2mpqNgFQ23Kjt2tUMU9+CLqEu0h1yXdqL5rmnVL
         sLtQoSYNEatHOLZ/uvOVVlIPJ8Gl6lviKJOjgSL643yPQm3l7uk+mwEH9pmM5xzHeeGL
         lJj6+4adRB6PM1XFsAeXdvwWUfsQQQOWjfnKQbYuwIuGD1WOVk1gYihA0iAZ+UtbYpPc
         D/oA==
X-Gm-Message-State: AOAM53022sIgDtuwSE3n/Du79VqdfFK3WkGlzmEIR/pB4esKZ9k8q/K0
        WoiW6zcvCAOIRFLnfK+hPE2O7K9p06m/jA==
X-Google-Smtp-Source: ABdhPJwUPMCGoQRCjPx3AH/QV9HgvnP0J75vM1Bxs0mNku0haACOc5sir73qVYeZwVmRfnitti5DRQ==
X-Received: by 2002:a19:640f:0:b0:478:6d61:ae68 with SMTP id y15-20020a19640f000000b004786d61ae68mr15989243lfb.640.1654529594099;
        Mon, 06 Jun 2022 08:33:14 -0700 (PDT)
Received: from [192.168.16.142] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id w30-20020a05651204de00b0047255d21165sm2901970lfq.148.2022.06.06.08.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:33:13 -0700 (PDT)
Message-ID: <9816143d-198a-a238-9fa6-772724ee37c8@kvaser.com>
Date:   Mon, 6 Jun 2022 17:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 00/12] can: kvaser_usb: Various fixes
Content-Language: en-US
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <61060501-7edb-4277-acf6-117161e8593f@kvaser.com>
 <17631d66-7b90-e60b-e3fb-76b25e5eceaa@kvaser.com>
 <af065054-50cb-08d7-4eb4-e42530710eb2@bitwise.fi>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <af065054-50cb-08d7-4eb4-e42530710eb2@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 12:56, Anssi Hannula wrote:
> On 28.5.2022 10.42, Jimmy Assarsson wrote:
>> On 5/17/22 10:41, Jimmy Assarsson wrote:
>>> On 2022-05-16 15:47, Anssi Hannula wrote:
>>>> Hi all,
>>>>
>>>> Here's a set of fixes for issues I found while testing kvaser_usb as we
>>>> are preparing to start using it in production (with 0bfd:0124).
>>> Hi Anssi,
>>>
>>> Thanks for the patches!
>>> I will review and test your fixes before the weekend.
>>>
>>> Best regards,
>>> jimmy
>> Sorry for the delay!
> 
> No problem!
> 
>> To summarize the status.
>>
>> These patches look good:
>> [PATCH 01/12] can: kvaser_usb_leaf: Fix overread with an invalid command
>> [PATCH 02/12] can: kvaser_usb: Fix use of uninitialized completion
>> [PATCH 03/12] can: kvaser_usb: Fix possible completions during
>> init_completion
>> [PATCH 05/12] can: kvaser_usb_leaf: Set Warning state even without bus
>> errors
>> [PATCH 10/12] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
>> [PATCH 12/12] can: kvaser_usb_leaf: Fix bogus restart events
>>
>> This looks good, but see comment regarding explicit queue flush:
>> [PATCH 06/12] can: kvaser_usb_leaf: Fix TX queue out of sync after restart
> 
> Feel free to drop the flush, or let me know if you want me to resend it
> without it.
> 
>> I still need some more time looking into:
>> PATCH 07/12] can: kvaser_usb_leaf: Fix CAN state after restart
>> PATCH 08/12] can: kvaser_usb_leaf: Fix improved state not being reported
>> PATCH 11/12] can: kvaser_usb_leaf: Ignore stale bus-off after start
>>
>> I want to replace
>> [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting error
>> counters
>> with a new patch
>> "can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device"
>>
>> I want to split the handling of CMD_ERROR_EVENT and the readback
>> functionality. I also want to add parameter readback for
>> kvaser_usb_hydra. I need more time to look over the can_bittiming_const
>> in kvaser_usb_leaf for the different supported firmware.
>> [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus params setup
>>
>>
>> I would like to create a V2 series, including my patches, if you are
>> okay with it?
> 
> 
> Yes, that's fine. I can test your series on my setup as well.

I'll rebase and send V2 of this series, once "can: kvaser_usb: CAN clock 
frequency regression" [2], is sorted out.
That would be great :)


[2] 
https://lore.kernel.org/linux-can/20220603083820.800246-1-extja@kvaser.com

Best regards,
jimmy
