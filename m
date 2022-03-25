Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896CA4E725B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349385AbiCYLiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356931AbiCYLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:37:58 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E96BD7DA;
        Fri, 25 Mar 2022 04:36:23 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id w21so5923656wra.2;
        Fri, 25 Mar 2022 04:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5/xCx5Y2e0Klyd/HbXihrZqcDQDT2V+46V0GBs4k8mk=;
        b=rDQf89hUvx34pCOLWGZCNqei98dKC/P/8jK/LzBHGAaTQCvQxDa5DYlBDA8c9UwBor
         K2HRPVMKPcbQZuY8tkPp8l/tCrRoAwD63D6eFW/cp60wr7Z8NcuEzLQMAE6mNxKNgxyx
         7FhncPHm6rxzVVrIViIX60t6Yc/v0OQAxe43ZzMyuTASK8ym+kSXQnCBRBGviQfkhKzw
         WWtU2MaeHnS/jATfhtdrVtX8noVCfCpRArgUVoKPgyphgpUAeTR1p0gB/SaCksL5nZWS
         oraJdsp9jU8my/VCQUoaylZWzSfpOyfExoGnVKGibEeuDUWmaY8MjM+C/TEWH5BrU0ih
         jyig==
X-Gm-Message-State: AOAM530VIQxPY2F6xiWrghMPfFp6B2vC8rR+f0EkC5GXEMNvcooT5eJi
        bIekemMyGbDbJmpnsJqwFcc=
X-Google-Smtp-Source: ABdhPJxJjF28B2+aRUQOSmKVj4QHce1eDHa+AlOHnwTrZyL7xExfzeVoAfSxs7+n8uRRi+3rbh3eiw==
X-Received: by 2002:adf:d1c2:0:b0:205:7f2f:5043 with SMTP id b2-20020adfd1c2000000b002057f2f5043mr8882517wrd.238.1648208181638;
        Fri, 25 Mar 2022 04:36:21 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm5565941wmh.41.2022.03.25.04.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 04:36:21 -0700 (PDT)
Message-ID: <382c4fae-95c5-af26-5d54-fa7ae7422b37@kernel.org>
Date:   Fri, 25 Mar 2022 12:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
 <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
 <1295226194.41648172284403.JavaMail.epsvc@epcpadp4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1295226194.41648172284403.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 02:28, Jung Daehwan wrote:
> On Wed, Mar 23, 2022 at 10:41:23AM +0100, Krzysztof Kozlowski wrote:
>> On 23/03/2022 03:58, Jung Daehwan wrote:
>>> On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
>>>> On 04/03/2022 07:23, Daehwan Jung wrote:
>>>>> Export symbols for xhci hooks usage:
>>>>> 	xhci_ring_free
>>>>> 	- Allow xhci hook to free xhci_ring.
>>>>
>>>> Instead of copying-pasting the name of function, please explain why do
>>>> you need these symbols exported.
>>>>
>>>> The "Why" is actually one of most important questions, because "what is
>>>> this patch doing" we can easily see...
>>>>
>>>>>
>>>>> 	xhci_get_slot_ctx
>>>>> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
>>>>> 	  for getting the slot_ctx information to know which slot is
>>>>> 	  offloading and compare the context in remote subsystem memory
>>>>> 	  if needed.
>>>>>
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi Krzysztof
>>>
>>> xhci_ring_free has been removed from v3..
>>> The reason why I want to export is for managing vendor specific ring.
>>> I want to alloc and free vendor specific ring on specific address.
>>> It's done with xhci hooks.
>>
>> It's better, but still does not explain why these have to be exported.
>> Please mention where are these hooks going to be. Where are they
>> implemented. I actually expect all of these exports to be used in your
>> patchset.
>>
>> Best regards,
>> Krzysztof
>>
> 
> OK. How about adding call stack like below?
> 
> xhci_free_endpoint_ring -> xhci_vendor_free_transfer_ring(xhck hooks
> ops) -> xhci_ring_free

What I would like to see is high level explanation, why do you need
these functions exported. Such call trace does not answer this, because
you do not need to export functions just to call the. You need to export
them for modules, so this means that some modules (which - need names)
will be using these functions. Three or four sentences are usually
enough to explain it.


Best regards,
Krzysztof
