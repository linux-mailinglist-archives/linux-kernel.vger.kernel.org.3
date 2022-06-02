Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDF53B1F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiFBDHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFBDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:07:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2829DC3B;
        Wed,  1 Jun 2022 20:07:17 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h18so2617494ilj.7;
        Wed, 01 Jun 2022 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UHKfOpo21i5MoDcQk+7qlf8n2C1uh2g5W/XKZOO7xm4=;
        b=XqzZbjV/Hai6OuvPT51RZ5MBwaa4GjrqL4asM6ShURsMufo/2R1ExscNVQqvu5DBtw
         9Y+i20d8C5dFfgnd1jzRReVbkwhp4RbWZS1l9JXgLofMR8G9V5AAS6gFWtLXtQtsPhGx
         1OQBjTpmQ//8AyQzrwP3+JCGnVnNnIi/l06Baooqun/kLub8dkoTG8yNFBG6nUOqMDY+
         trMWnOWVLdIC3jUyb1KMLhLwhyg+N5P3IAcHoHkf1i8mtgh40icijw2HLmWXO5Ugyg4A
         OvQX6IgsCsoGI8YblKc99qRYEVpFsfpolaftzk9HqOjOt9PrxrpYJK59h1oGYo96Cve1
         jYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UHKfOpo21i5MoDcQk+7qlf8n2C1uh2g5W/XKZOO7xm4=;
        b=OJ8Ai4zyKx9sfeMfqsS99ENkngADmTgVbLfYAf9vs2yOCwtEux43ylQxBUCY49oZ7+
         Hr4vl3G1DA5ALf4OAk3Aj3YEOdcUDbaEv+NCw+VXGLZ8iuR8vqJbkY8R3dXd5FEg92Hc
         vP2P2m3dewBHZFSKVUO5VFI174CmNVUQz3sQleWkkHeBmj87w30lWuZlKlwfA7NX0M5d
         0/MLUUuMkZ20tjUBkZ23dYNyirFXBIonfOtqIRh8URNoV/D5O8T256Tu765blGsSneY6
         TK8Pl7hz4ib0S/qIg4+aXi+OsTSVxIUlu1XxEbuLsXXgaWsu0qwKJrIXta9nPnXdF22n
         qFww==
X-Gm-Message-State: AOAM530mvDnD/9CS+nGaknllcwEKQQ+BWWpqHD0SG/LLIk1sPuRsrkaT
        Hj2Lqajrckw0FBa6coGdeyQ=
X-Google-Smtp-Source: ABdhPJx+fqog1Uk+ibtsTSfCYj8/q1T78oJkFBEJpVW0wb27VYQ2ApRYJ31SJjEzEP9rUa3YWg/UOw==
X-Received: by 2002:a05:6e02:170f:b0:2d3:dc72:7172 with SMTP id u15-20020a056e02170f00b002d3dc727172mr2083947ill.218.1654139236758;
        Wed, 01 Jun 2022 20:07:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:edec:ab49:ad93:c595? ([2600:1700:2442:6db0:edec:ab49:ad93:c595])
        by smtp.gmail.com with ESMTPSA id d35-20020a026063000000b0032b3a78175fsm902283jaf.35.2022.06.01.20.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 20:07:16 -0700 (PDT)
Message-ID: <e0055a5c-cca9-db63-80bd-a39ff1585389@gmail.com>
Date:   Wed, 1 Jun 2022 22:07:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] scripts: dtc: fix a false alarm for
 node_name_chars_strict
Content-Language: en-US
To:     "qun-wei.lin" <qun-wei.lin@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, casper.li@mediatek.com,
        chinwen.chang@mediatek.com, kuan-ying.lee@mediatek.com
References: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
 <8d4b8cc3-8433-24f9-1fc5-12d71e640952@gmail.com>
 <20220531214914.GA2388344-robh@kernel.org>
 <7c6f0015-cf50-4c8b-060d-f6641d0aeb16@gmail.com>
 <b054866a5c043d3b6d5553057b5f5bf7b06681f0.camel@mediatek.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <b054866a5c043d3b6d5553057b5f5bf7b06681f0.camel@mediatek.com>
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

On 6/1/22 09:59, qun-wei.lin wrote:
> On Tue, 2022-05-31 at 20:45 -0500, Frank Rowand wrote:
>> On 5/31/22 17:49, Rob Herring wrote:
>>> On Tue, May 31, 2022 at 04:43:18PM -0400, Frank Rowand wrote:
>>>> On 5/31/22 01:33, Qun-Wei Lin wrote:
>>>>> The function check_node_name_chars_strict issues a false alarm
>>>>> when
>>>>> compiling an overlay dts.
>>>>>
>>>>> /fragment@0/__overlay__: Character '_' not recommended in node
>>>>> name
>>>>>
>>>>> This workaround will fix it by skip checking for node named
>>>>> __overlay__.
>>>>
>>>> This is not a false alarm.
>>>>
>>>> Do not special case node name "__overlay__".  This node name
>>>> should never
>>>> occur in a modern overlay source file.
>>>
>>> A dtbo -> dts pass will give warnings, so handling these nodes is 
>>> worthwhile. Though thinking a bit more about it, I think this one
>>> is off 
>>> by default, but W=2 turns it on.
>>
> 
> When DTC detects an overlay target, it will generate a node name
> "__overlay__" in function add_orphan_node [1]
> 
> Use the example on page 34 of the slide [2]. When the parser reads this
> line in overlay source file:
> 
> &{/soc/base_fpga_region} {
> 
> It will build two nodes, one with no name and the other one is a
> subnode __overlay__ [2].
> 
> So if we set W=2, the following warning will be issued:
> 
> Warning (node_name_chars_strict): /fragment@0/__overlay__: Character
> '_' not recommended in node name

Thanks for digging into the internals of dtc to determine how a properly
formatted overlay source file is processed in a way that the check for
a leading "_" in a node name is after dtc creating the __overlay__ node
name.

I have looked at dtc several times and have never educated myself enough
to be anything other than dangerous.  It seems that you might be more
educated about how it works.  If so, is there a reasonable way to tell
check_node_name_chars_strict() when the node name is one of the special
ones that dtc creates for overlays instead of a node name that appears
in a source file?

-Frank

> 
> I think this is a false alarm because this __overlay__ is automatically
> generated by DTC.
> 
>> Yes, at least as of 5.18-rc1 the warning is only if
>> '-W node_name_chars_strict', so a dtbo -> dts pass will not give the
>> warning for node __overlay__ by default.
>>
>> -Frank
>>
>>>
>>> Rob
>>
>>
> 
> We want to enable all warnings in DTC to ensure that all of our DTS are
> compliant with the conventions.
> 
> [1] 
> https://git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/dtc-parser.y#n169
> [2] https://elinux.org/images/0/03/Elce_2018_dt_bof.pdf
> [3] 
> https://git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/livetree.c#n228
> 
> 
> 
> 

