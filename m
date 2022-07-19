Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20CC5796DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiGSJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiGSJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:57:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E9E03B;
        Tue, 19 Jul 2022 02:57:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so8838116wmb.5;
        Tue, 19 Jul 2022 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AG0iUsFsG7Mu365cDyJiadCV9JDZc0YicjKM3ZE3PJA=;
        b=qJT10KNlK1zs+BUKY+mRp0/aj7gHX+xDZMbmvRHyyOGe+T95hfOngkHEqxn+/yBqID
         kRDYSsUve7v4ly9N7zx2sQqQ/DafczSkEU5sbYkUhGRzNzg0bjfNwS5huE4IcjpJFAfu
         G9TyJtwaeTMMUSuxJUTIZd9/vPnQlB3VebdlKb3ezgKjiu3NiwISTYeCSXqE0CEIDr9+
         jigUE0YI9zbI+DYflvvB69ZKb/bJlPUobB21ew1ANFRk0PENz5tRPfNcO8W9fAWxPK6Q
         mawoAe4FRTnRWuIZv4H2x2YuwIIEuntxJAQjssmwviTabD8K0v4Ee40G+GlXM4b2otT9
         DtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AG0iUsFsG7Mu365cDyJiadCV9JDZc0YicjKM3ZE3PJA=;
        b=IStdQ1k5ssHc9X8YJk0VJci9+sy5fWVghVrYKCcWdaJ5bF4ztcO1HqNW/JWKFsfFGK
         5qvVkn/XuthWCyodcTVzKoZHIRNTIA526aphr+qzkHPc21lzKP2+aSz1X+kvZSThrkm7
         Cs7R3ICp5QbWpbponP/54aX9SIv/x8hOjI1R4CTn9H6CFvd0XOAOI9+m3NKAC+y3IU4K
         goQf/bQHddhEU9BSjHNcH1PmK5Q8I+5EhjT40opqr/KMpy27aSIOGnYAtL6F4Ez97V1I
         ZkVJnfsrFzcy+McmnlctiT8yffNeTKuVv1AfyMmole1OtvyT15vsvqtLnTDuVbJgQXUP
         2ARw==
X-Gm-Message-State: AJIora8w3hjZqbVds0I9xRerucAu/UiDVLTCEmEOhW4i+NMojaIBwkNA
        IGoPv3GjpmesQFsicuFCOGs=
X-Google-Smtp-Source: AGRyM1uT7q6vr3EOvqwsCnDSjATUAiRH02JhXJgp0KKdyxXCd8xF7UTuYcHoJzxb2BTr2Dda2KYxDA==
X-Received: by 2002:a1c:4c02:0:b0:3a3:160f:f1ec with SMTP id z2-20020a1c4c02000000b003a3160ff1ecmr12214782wmf.159.1658224631291;
        Tue, 19 Jul 2022 02:57:11 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d5310000000b0021d7b41255esm13244112wrv.98.2022.07.19.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:57:10 -0700 (PDT)
Message-ID: <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
Date:   Tue, 19 Jul 2022 12:57:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20220718172953.6817-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi José,

First of all, thanks a lot for all the work you're doing with the tablets!

Yes, this situation is unfortunate, but there's really not much we could do.
The tablet database at http://digimend.github.io/tablets/ hasn't been updated 
in ages, and it has never been exhaustive to start with.

There are tons of tablet modifications, including of the same (marketed) 
model, and those can differ not only in the reported name, but probably even 
the VID:PID, as could've happened when Huion switched from v1 to v2 protocol.

So, I think a "whitelist" would be a maintenance nightmare.

Moreover, I think it's better to disable the tablet completely in case we 
failed initialization (e.g. got an invalid response to configuration, or 
failed to find some interfaces and such), after producing a comprehensive 
error message. Configuring a tablet partially, and then handing it over to the 
generic driver could mess things up more.

It's less confusing for the user, and stops them from trying to fix the 
problem up the stack with various settings, often getting into a worse 
situation. It's also much easier for the maintainer, since they don't need to 
investigate all the higher layers.

A "blacklist" would work better here, if you can find the tablets to include.

Nick

On 7/18/22 20:29, José Expósito wrote:
> Hi!
> 
> No code yet, just a kind request for comments and hopefully some wisdom
> and experience from Nikolai dealing with HUION devices.
> 
> HUION keeps reusing the same vendor and product IDs for their devices.
> This makes it really difficult to differentiate between devices and
> handle them in the kernel and also in user space.
> 
> Reusing IDs could introduce a problem:
> 
> If HUION, or other vendor following the same practices, releases a new
> tablet with a duplicated product ID, the UCLogic driver would handle it.
> The device might work with the existing code or it might fail because of
> a new feature or a whole different firmware.
> 
> As far as I know, at the moment there is not a mechanism in place to
> avoid this situation.
> I think that it'd be better to ignore those devices in UCLogic and let
> the HID generic driver handle them because using HID generic would
> provide a basic user experience while using UCLogic might fail to probe
> the tablet.
> 
> DIGImend's web already provides a nice list of supported devices:
> http://digimend.github.io/tablets/
> 
> So, I wonder:
> 
>   - Do you think it makes sense to ignore untested devices?
>   - If the answer is yes, do we have a better option than checking the
>     device name against an allow-list? It'd be great to hear other
>     people's ideas.
> 
> Best wishes,
> José Expósito
> 

