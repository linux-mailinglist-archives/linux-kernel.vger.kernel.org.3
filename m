Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5357BD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiGTSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiGTSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:13:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B30165D7D;
        Wed, 20 Jul 2022 11:13:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so14408761wrc.8;
        Wed, 20 Jul 2022 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5LukrXp7Co7uGUlwQKh4k3CtbJ6qok1w1ecgOSE/NhA=;
        b=EJ0NNqR7uzooGBM/Nz5kGkkws9Ha/pvhYQjO/XhRL5N8BCDAQCH9XpzYlxJT7GIUGz
         Vo71h/yMCvnmqLK2ZknAunJn90vauRUI5pccmeQ5l1+Mo3skiYGretzGgbrfM/eMVJ40
         jB6oOYG0Ni82faiKxaMS40ZogP+TLi6Tli47Ik5CCQd9qq2gVKDqjaUuVLvpoC+G5iUa
         lfJ1O2lFaBFmEurG4BYi2dD+uzkI77hZxMBCvd7WDyy+9Gen94gzKMGAJprDJZXuwgLf
         NIBkvSEH2Jyo2eFO0KevCmvv62IFyJfoy09moCDv7v0FXdgIytEY/97mvfISZH/ewy8W
         ng5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5LukrXp7Co7uGUlwQKh4k3CtbJ6qok1w1ecgOSE/NhA=;
        b=MorNKj52BqRXggZR3nTBOjok1TIbDXiaNLbIUMoVk79+3gh+jenJRxUQAktYEfjVwn
         1zKB0vQ9l7mqPhtxI60TAtoppvHILjzwOs/F0VimTMozy5HC3PRbnhJfFsZXFzmwL8x2
         RS7E3dHpcebz88HzO71dxWmeEs1mwpEnp7MqVmW5VJ1j5dn8HBZwr4MWxsq9NMbRPI0J
         cyRQwvKkCAEizn/KCz7Q7OcxbbgZCH+FiYh8NblnSAVRnw1ujSsw2FCfnV7gR5+LbH0e
         se6fXnEpn9Iofuqe4KTPgCX7nvDQqnaKkVsEOBj/EhG3VsKKtx35P0gJoRqbXRk77iLn
         DJ+g==
X-Gm-Message-State: AJIora9XCDcjSWGBgcYuawwiW48JlfLcmHEgabPsWPJ3zx4n36VI+RLp
        8OgXhdmjYuJcqd4TlKD9DcA=
X-Google-Smtp-Source: AGRyM1sYf0GyVKs6sPI8vNn2iaV/h41VtqCv5qZu5Hg/3oDz+aIbNR9y5NIkml2ugL1Ie/rTYtiU8Q==
X-Received: by 2002:a5d:6149:0:b0:21d:6ba7:6095 with SMTP id y9-20020a5d6149000000b0021d6ba76095mr31477059wrt.680.1658340820757;
        Wed, 20 Jul 2022 11:13:40 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c2c4900b003a02cbf862esm3208832wmg.13.2022.07.20.11.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:13:40 -0700 (PDT)
Message-ID: <3cdbcfe5-bb7e-2677-730f-f250e2d33f0c@gmail.com>
Date:   Wed, 20 Jul 2022 21:13:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
 <20220720173656.GA3725@elementary>
 <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
 <20220720175444.GA10744@elementary>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20220720175444.GA10744@elementary>
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

On 7/20/22 20:54, José Expósito wrote:
> Hi!
> 
> On Wed, Jul 20, 2022 at 08:45:55PM +0300, Nikolai Kondrashov wrote:
>> On 7/20/22 20:36, José Expósito wrote:
>>> I don't know about any broken device handled by the driver, so there is
>>> no need to add new code yet :)
>>> I'll try to keep an eye on DIGImend's issue tracker now that the code
>>> present in the upstream kernel is being released by many distros.
>>
>> If you have the time, backporting your changes to digimend-kernel-drivers
>> would get you feedback much faster :)
>>
>> I can do a release once we get the code in.
> 
> I already opened a PR a few months ago:
> https://github.com/DIGImend/digimend-kernel-drivers/pull/598
> 
> But more code has been merged since then. I'll try to backport the
> latest changes this weekend and ping you on GitHub once it is
> ready for review again.

Ah, sorry, I rarely look at DIGImend notifications 🙈

Could you send me an email once you got something ready for review?

Thank you!
Nick
