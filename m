Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C618250ABE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442400AbiDUXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442211AbiDUXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:21:10 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA03CFE1;
        Thu, 21 Apr 2022 16:18:19 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id f13-20020a4aa68d000000b0033a2c53d0baso1115118oom.0;
        Thu, 21 Apr 2022 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=JFf9HGRfI7n3fI8XEiNo8PZc23LhVhvqXPq545IqGrk=;
        b=RaC8c5l2W0v6pOhCLkSP16q9FHjg+l0G3iYKDely13x1JVKHmucrVVnTpZruCzrJjH
         hYno2p3vlJZB/WhHursCUn2CkDySEOSbrbsiBbZ8L2pqDJmACqifeMDiQ38Y7smtTd+h
         Df8Gg7ZLSSac3T8Ps7+MM1EGz5920Zacnp1rXewEenu9knTvUeUhauIBNTZiUKiRGyeO
         VB5sxHQASILk3dTB9Ce0MRrNx9xZEXcMMuW8w9Hhn3n0BqG7BVj4mjjd1LrLagW80ZID
         /rURGVYiALfd2ihD5k/gdBGVEJAp+xn46xwEo5Eil35PoCBfA1HNZ2EizSFjbmaNUM2z
         MWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=JFf9HGRfI7n3fI8XEiNo8PZc23LhVhvqXPq545IqGrk=;
        b=h4md51jYpja4wY6BxC3SN/6q1N4f+Yilj7IFAatQcKYmK0qhKsXWSr98z1Lm2acUk7
         rJ4ga8MZQWMExZpYI78UhnhrzVDWyUuM1jBnECzkGF0RUhUF8rrPDDupyzX7+xtGepCF
         2xsmvdEMkL096j+T8NGm9YPKDlnvP1KkBe8HZyEcZteZ6H8fw/ykyc44CdHbmO8iXhyM
         XAuFx+gItPNBr0/2EAFJVw1L/P2z34Gwo6ukwdWy7RVJVeRl1rFfMZlcTl8j/z+kTyiG
         4RWic/kv4cLzNVv8HMdcPmVtOd9Z4XhZjNBIbixvqJNzbq9SsHyJbjxZUMFPAGFSUMMG
         tm9A==
X-Gm-Message-State: AOAM533jB1ZjyboMI15oMSPMIe/yhCV7s+uAROJHiBCrgqie0wKuiPvL
        xE4x7ujQ6u1q8BqCj9CLdoM=
X-Google-Smtp-Source: ABdhPJyc7CMa4UiuKdFaBzmxG/s0H7m7+CGfOZYs14tcZ9eyvfD1+Ot82CHaXWq6/Q14ARFgoH+trA==
X-Received: by 2002:a05:6820:151b:b0:33a:6aa4:2d6e with SMTP id ay27-20020a056820151b00b0033a6aa42d6emr689786oob.54.1650583097794;
        Thu, 21 Apr 2022 16:18:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d2903000000b005cda765f578sm139439otb.0.2022.04.21.16.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 16:18:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0d9aff44-d41b-dabd-4d49-dd80631a4361@roeck-us.net>
Date:   Thu, 21 Apr 2022 16:18:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-usb@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com
References: <CA+G9fYvdfYBq+Q=-XUJcKHSYXdubdoqhExRpjrqCgf_N3pPpHQ@mail.gmail.com>
 <15b38d01-702c-b39e-7053-54c3905a0794@roeck-us.net>
 <c86e540f-6611-4ef9-9439-8285fee61831@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not
 reduce to an integer constant
In-Reply-To: <c86e540f-6611-4ef9-9439-8285fee61831@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 15:27, Randy Dunlap wrote:
> Hi--
> 
> On 4/21/22 13:36, Guenter Roeck wrote:
>> On 4/21/22 12:03, Naresh Kamboju wrote:
>>> Linux mainline and linux next arm64 builds failed with gcc-7.3.x.
>>>
>>> drivers/usb/typec/tcpm/tcpm.c: In function 'run_state_machine':
>>> drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not
>>> reduce to an integer constant
>>>      case BDO_MODE_TESTDATA:
>>>      ^~~~
>>> make[4]: *** [scripts/Makefile.build:288: drivers/usb/typec/tcpm/tcpm.o] Error 1
>>>                                         ^
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> -- 
>>
>> That code is several years old, the define is a constant, and I don't see
>> a recent change in the code. What am I missing ?
> 
> See a recent patch for the same problem in a different area:
> 
> commit 1ef8715975de
> Author: Borislav Petkov <bp@suse.de>
> Date:   Tue Apr 5 17:15:08 2022 +0200
> 
>      ALSA: usb-audio: Fix undefined behavior due to shift overflowing the constant
> 
> so those constants probably need to be cast to unsigned int.
> (I guess)
> 

Turns out other versions of gcc are "affected" as well.

$ cc -Wall -std=c11 -pedantic -pedantic-errors testc.c
testc.c: In function ‘main’:
testc.c:16:2: error: case label is not an integer constant expression [-Wpedantic]
    16 |  case BDO_MODE_TESTDATA:
       |  ^~~~

... but _only_ with "-std=c11 -pedantic -pedantic-errors" or with "-fsanitize=shift".

It wants
	#define BDO_MODE_TESTDATA	(8u << 28)

Pedantic indeed ...

Guenter
