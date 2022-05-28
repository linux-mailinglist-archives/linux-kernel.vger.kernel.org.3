Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC1536B73
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiE1Hl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiE1Hlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:41:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1093260A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:41:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u30so9794945lfm.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5AdGIq1npdZwT45hdil7GXgBo5RZT0e5WlXJHtQnvA4=;
        b=VUkFP11V7NHqyP9pKVQuxrCrLAYh4CXAgqMwlTLdL5+So4X8aPlijKLs7J5FuKiVk9
         xdVtYnXC+aJSNmJIDSxepqp1LzNyVoJIIlm1bj/HzswB++51Q4LqKt5y5ORophQP5GQ6
         50UYjqMPmT8zvWZggY8zwysd+XQyL42+6wHGPgv37qnsxg+ZkKG+3ljXI6F+7Fh1Jha7
         j2pCGoEk+tgq/LfW3VIA1mIMIr98b90BqV8vkrfpv8NcSJqqnacMx9NvEsooQuvgWRw3
         LLpebgBDRzs9q9Sql0s02BCvsPjNW41eMXUs2/c35wWubRS7BowVdboDfauYBZb3hNQR
         9ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5AdGIq1npdZwT45hdil7GXgBo5RZT0e5WlXJHtQnvA4=;
        b=m00CbD66P5Cv1alvHtu4j+wyGFVldDF1e92/Q/jT8uvRhohwvEa0VfYa44geIyYfqJ
         9IDK3FA3NlpZ77yfDOqVkjIjrcM+O9ANId0u1L4d1d/jgIXX0x/pNeAcDoosqvMrUz9x
         NLRz16wm8cbqf1Sp/7dCQomluTGMWJ42gYW9lRuM4xDs7AT3oTsR2NAkU9Z4jAX4tITf
         23nU2AtrwSKei9nikBa8839LsRuksEsolnfrWXxiJINfBsm5Ye4b8TMCMWinMNqcjrK+
         LVIc0qlUKMtQzLYOhO3iMhjCnn/m/MlAWmyL6UVo2dIXQuGbZeSl5uQQBYpg+Fk36sIP
         ebnw==
X-Gm-Message-State: AOAM5307MGT83EBJmY2iKMxdKsDUYPzlVZaDUn7mqdxdrg+q4sPKgrde
        skG+K381YwvUd6KRkd+Z6G9LQYxDTHuglQ==
X-Google-Smtp-Source: ABdhPJx8aJAiRY08OkYNZSMia7+ZaPgZ8LWlQbSvjg4xvZctgrt+t9CYYFqgadl1iCEqdzUuAMXbOw==
X-Received: by 2002:ac2:59dd:0:b0:477:c4e0:1c59 with SMTP id x29-20020ac259dd000000b00477c4e01c59mr32687770lfn.248.1653723710167;
        Sat, 28 May 2022 00:41:50 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c107a00b00253bb2564cbsm326745ljm.134.2022.05.28.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:41:49 -0700 (PDT)
Message-ID: <17631d66-7b90-e60b-e3fb-76b25e5eceaa@kvaser.com>
Date:   Sat, 28 May 2022 09:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 00/12] can: kvaser_usb: Various fixes
Content-Language: en-US
From:   Jimmy Assarsson <extja@kvaser.com>
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <61060501-7edb-4277-acf6-117161e8593f@kvaser.com>
In-Reply-To: <61060501-7edb-4277-acf6-117161e8593f@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 10:41, Jimmy Assarsson wrote:
> On 2022-05-16 15:47, Anssi Hannula wrote:
>>
>> Hi all,
>>
>> Here's a set of fixes for issues I found while testing kvaser_usb as we
>> are preparing to start using it in production (with 0bfd:0124).
> 
> Hi Anssi,
> 
> Thanks for the patches!
> I will review and test your fixes before the weekend.
> 
> Best regards,
> jimmy

Sorry for the delay!

To summarize the status.

These patches look good:
[PATCH 01/12] can: kvaser_usb_leaf: Fix overread with an invalid command
[PATCH 02/12] can: kvaser_usb: Fix use of uninitialized completion
[PATCH 03/12] can: kvaser_usb: Fix possible completions during 
init_completion
[PATCH 05/12] can: kvaser_usb_leaf: Set Warning state even without bus 
errors
[PATCH 10/12] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
[PATCH 12/12] can: kvaser_usb_leaf: Fix bogus restart events

This looks good, but see comment regarding explicit queue flush:
[PATCH 06/12] can: kvaser_usb_leaf: Fix TX queue out of sync after restart

I still need some more time looking into:
PATCH 07/12] can: kvaser_usb_leaf: Fix CAN state after restart
PATCH 08/12] can: kvaser_usb_leaf: Fix improved state not being reported
PATCH 11/12] can: kvaser_usb_leaf: Ignore stale bus-off after start

I want to replace
[PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting error 
counters
with a new patch
"can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device"

I want to split the handling of CMD_ERROR_EVENT and the readback
functionality. I also want to add parameter readback for
kvaser_usb_hydra. I need more time to look over the can_bittiming_const
in kvaser_usb_leaf for the different supported firmware.
[PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus params setup


I would like to create a V2 series, including my patches, if you are
okay with it?


Best regards,
jimmy



>> The biggest caveat is that I only have two devices to test with [1] and I
>> don't have HW documentation, so there is a possibility that some of the
>> fixes might not work properly on all HW variants.
>> Hopefully Jimmy can confirm they look OK, or suggest alternatives.
>>
>> [1] Tested devices:
>> - 0bfd:0017 Kvaser Memorator Professional HS/HS FW 2.0.50
>> - 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778
