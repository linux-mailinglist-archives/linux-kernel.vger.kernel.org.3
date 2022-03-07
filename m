Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F34CFB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbiCGKki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbiCGKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:19:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079256E7B0;
        Mon,  7 Mar 2022 01:58:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so30523579ejc.9;
        Mon, 07 Mar 2022 01:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lvfy01UpSWqibXjrsA2NRMYfaNAFGMpNCLUP4kDHK1M=;
        b=Dvo67ngNJed3vFqSiNZTs7gwur/8pFWrk00H3gLeR1Uhi0J1S0Dvf0RTm7WpyOfJm7
         p2dmZjAm+eZUq3qHLtRrov5Cp4vWTGbmS90DhZrzBHww0wJLC/90F/xXqPl2h0xZHSws
         F1xvPlf9GnWHWGDm6NzZSZQoEIPvniOg2aKgfAjypMuT05DU62L/bPlOoR6xeOGo0lhp
         +OEkWjbL5mso9U5XkiCD2t+miHm0pJ8Ine7ta9zdt16GZjIK2Ql8AeP6FQshD2af4bLM
         2rxN3+ZpU4BJz7eKkFppsu/F+M38SvhDX6Pp6gwUbqLXhivxQQ8HxRGo85ycrzF6uOcc
         KS6A==
X-Gm-Message-State: AOAM533AVaIYuhCsF7iqIwzFcAso+OdVpG90Pr/l3wevFrK9dYPPtGDb
        gHs8+gbnLiaSaI+QbG22r6k=
X-Google-Smtp-Source: ABdhPJy2a+ssp3PCDGv244Sv0qzercOAnpnvXaSdoUvgiWg0gDS3kSVC0mbVL/j4WU0X0LRBGqEbXw==
X-Received: by 2002:a17:907:1c16:b0:6d7:622b:efea with SMTP id nc22-20020a1709071c1600b006d7622befeamr8448209ejc.110.1646647017681;
        Mon, 07 Mar 2022 01:56:57 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm4575502ejj.142.2022.03.07.01.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 01:56:57 -0800 (PST)
Message-ID: <a65a0c0c-22bf-f24a-6f16-2f3358ccf681@kernel.org>
Date:   Mon, 7 Mar 2022 10:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/4] support USB offload feature
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <CGME20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc@epcas2p1.samsung.com>
 <1027007693.21646375403236.JavaMail.epsvc@epcpadp3>
 <YiHCTgg5Ibv9YQvi@kroah.com>
 <851f1804-4156-0b37-0bbd-598bdbb2abfa@infradead.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <851f1804-4156-0b37-0bbd-598bdbb2abfa@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 16:27, Randy Dunlap wrote:
> 
> 
> On 3/3/22 23:39, Greg Kroah-Hartman wrote:
>> On Fri, Mar 04, 2022 at 03:23:54PM +0900, Daehwan Jung wrote:
>>> This patchset is for USB offload feature, which makes Co-processor to use
>>> some memories of xhci. Especially it's useful for USB Audio scenario.
>>> Audio stream would get shortcut because Co-processor directly write/read
>>> data in xhci memories. It could get speed-up using faster memory like SRAM.
>>> That's why this also gives vendors flexibilty of memory management.
>>> Below pathches have been merged in AOSP kernel(android12-5.10) and I put
>>> together and split into 3 patches. Plus let me add user(xhci-exynos) module 
>>> to see how user could use it. 
>>>
>>> To sum up, it's for providing xhci memories to Co-Processor.
>>> It would cover DCBAA, Device Context, Tranfer Ring, Event Ring, ERST.
>>> It needs xhci hooks and to export some xhci symbols.
>>>
>>> ANDROID: usb: host: fix slab-out-of-bounds in xhci_vendor_get_ops
>>> ANDROID: usb: export built-in tracepoint functions
>>> ANDROID: usb: host: Use old init scheme when hook unavailable
>>> ANDROID: usb: host: free the offload TR by vendor hook
>>> ANDROID: usb: host: xhci: provide function prototype for xhci_address_device
>>> ANDROID: usb: host: add bus_suspend/bus_resume to xhci overrides
>>> ANDROID: usb: host: add address_device to xhci overrides
>>> ANDROID: usb: host: add max packet parameter on alloc_transfer_ring hook
>>> ANDROID: usb: host: add xhci hooks for vendor specific container context
>>> ANDROID: usb: host: export xhci symbols for ring management
>>> ANDROID: usb: host: export additional xhci symbols for ring management
>>> FROMLIST: usb: xhci-plat: add xhci_plat_priv_overwrite
>>> FROMLIST: usb: host: export symbols for xhci hooks usage
>>> FROMLIST: usb: host: add xhci hooks for USB offload
>>
>> What does that list of text mean?  You are only submitting 4 patches
>> here, not that many.
>>
>>>
>>> Below are owners of patches.
>>>
>>> Howard Yen <howardyen@google.com>
>>> Jack Pham <jackp@codeaurora.org>
>>> Puma Hsu <pumahsu@google.com>
>>> J. Avila <elavila@google.com>
>>> chihhao.chen <chihhao.chen@mediatek.com>
>>
>> What do you mean by this?  Did you loose authorship of the code you just
>> submitted?  That's not ok.  You always have to properly credit the
>> creators of the changes you submit to us for obvious legal reasons.
>>
>> Please fix up and resend this series properly.
> 
> Also: Greg might have received the full patch series, but I didn't, so I
> checked lore.kernel.org/linux-usb/, and it did not either, so it appears
> that there is a problem with sending the full series.

Yeah, lore did not get anything more than cover letter. What's more
interesting, the cover letter mention exynos:
  drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
so get_maintainers.pl should point you to additional people and lists,
which are not present here.

What is even more interesting, such file
"drivers/usb/host/xhci-exynos.c" does not exist... which could explain
missing CC above, but raises question what is this cover letter from? Is
it still Linux kernel or some other project?

Best regards,
Krzysztof
