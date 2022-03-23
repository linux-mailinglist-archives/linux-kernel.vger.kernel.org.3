Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF98F4E4F99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiCWJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiCWJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:42:55 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78D7659F;
        Wed, 23 Mar 2022 02:41:26 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id bg10so1658133ejb.4;
        Wed, 23 Mar 2022 02:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=xySPtePfuIUSWooZkIPbEuzptBUM5W/rtX4UbEINCw4=;
        b=4umIlZpoIR7iREOpSCp+AUSPosQELa7f6X9+hCTRzbQYhzCvWKBZJ/DG1C+RffIYmy
         BPuJG1vBn8NmLYPGTCcKr80lQ1/TTSLKfip1ejguHeWN0oYk4N/w7pC5hQIq2ljGXKnQ
         VsCmVgDJRGefi6s68v9Y5RJwW05EzVs5FSO1S3QvpKvpORFXnWc/Z9xZap0zn2pnG2w0
         FRucTShFmhHkqRNS2aqINAL+Mzk2qRcXSIdrBFJLQEpbCNHka7WY02Fu2vIL1T3dkttT
         6vOEu1kZPpFKwJZLmwiVYpZXjquqp+b4/YZdKE9zl0q4+8GTjbQ6F/QZ6NqDwv3u+QjP
         U6uA==
X-Gm-Message-State: AOAM532cos1axf0sJGfNZ10g/eydrNJM+gatXfLUiizynO61Ade3AnC4
        qJKvON01ZkowyIwqx9Af7ZY=
X-Google-Smtp-Source: ABdhPJzzqnM3mtuaJvptWQ6OfJRGL6YFu3G7jy/CFB2Qo4BVD5vlrovTkKH1yJklEub/bWNm5vRFkQ==
X-Received: by 2002:a17:907:3f17:b0:6da:68b6:7876 with SMTP id hq23-20020a1709073f1700b006da68b67876mr30117951ejc.740.1648028485079;
        Wed, 23 Mar 2022 02:41:25 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id hu8-20020a170907a08800b006dfd2056ab2sm5736908ejc.97.2022.03.23.02.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:41:24 -0700 (PDT)
Message-ID: <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
Date:   Wed, 23 Mar 2022 10:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
 <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
 <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
 <1983025922.01648006681661.JavaMail.epsvc@epcpadp4>
In-Reply-To: <1983025922.01648006681661.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 03:58, Jung Daehwan wrote:
> On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
>> On 04/03/2022 07:23, Daehwan Jung wrote:
>>> Export symbols for xhci hooks usage:
>>> 	xhci_ring_free
>>> 	- Allow xhci hook to free xhci_ring.
>>
>> Instead of copying-pasting the name of function, please explain why do
>> you need these symbols exported.
>>
>> The "Why" is actually one of most important questions, because "what is
>> this patch doing" we can easily see...
>>
>>>
>>> 	xhci_get_slot_ctx
>>> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
>>> 	  for getting the slot_ctx information to know which slot is
>>> 	  offloading and compare the context in remote subsystem memory
>>> 	  if needed.
>>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof
> 
> xhci_ring_free has been removed from v3..
> The reason why I want to export is for managing vendor specific ring.
> I want to alloc and free vendor specific ring on specific address.
> It's done with xhci hooks.

It's better, but still does not explain why these have to be exported.
Please mention where are these hooks going to be. Where are they
implemented. I actually expect all of these exports to be used in your
patchset.

Best regards,
Krzysztof
