Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38D519C41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiEDJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347567AbiEDJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:51:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5751EC4D;
        Wed,  4 May 2022 02:47:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so1057977edw.11;
        Wed, 04 May 2022 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UMi5L4NU7YtuCRrDszdWe8xOLn3j2yayIhCAekkyhRM=;
        b=WDmxoCNXwFJk/LykyGgZ5h6mI4rzQG3Rg9y9I7kpI/c8+Urxqy6b7qcRzX1N/kSF/f
         WK2ENuP5ABc3//g8suPgi+V176dSQkgsEcDWAM8k2z4JO5A/3yiJ0+rh8JX0v1i/EVBL
         gNLqXJw2qYFH4+u5xTfiGD8p9kQtN98eA5n8/bQ37xMZSVLRB3nvP9VODCE0bpiybwN/
         zhxyhW4+//JA8Xk8bHrKKHfX6A9+raZ4IWiKlpNye0P5lY/DD9OnSD8f4D8Vew8iur8D
         8Cx80hnvraEIbG2EEZRgLKd7dhg5rzkVgJBcJBhG4fgtO7yKdXK+vG3R3vZhuDBoHkLc
         M10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UMi5L4NU7YtuCRrDszdWe8xOLn3j2yayIhCAekkyhRM=;
        b=OEztZPBFVGDg9WetNTixFKExhYxPNVbTeg+/6InVh9kWMW9n9g7yo/khbQlXpWuWoD
         z3b6RWuvzodkgvlBP58DKVO4z7U6u6qsOEj8eynZGvOHc1G/QNhnQvXfUAd7BgTdoxyu
         h2411M4Oh6DsFRLh7lFj/5L0KIYPzl2IoHddvKwQh7f9TGnANoonjmNTpntW36SzVNz/
         HZwtyys56y67CA2PXcZes4RDnZDPeL7H6rD32y0MwqPbj1sfN6b/D8UFCJYCy4x+pH6h
         vRYqmjXCFIXe/mQ/xjyQZ8bejux01ViqUtr5Qa3W8UrRPqwTSl+btBy6OiNK5etyYV3w
         jWNQ==
X-Gm-Message-State: AOAM531FTmlH5iyX8UxIwaRExDnxYU6aIo1tbAW3drhjd1Hb4SDGKS81
        mjjeLlnNrGZfVwuho6H+hE4=
X-Google-Smtp-Source: ABdhPJya6lHf7igGAb2eIfhtj49OpcX70BuRC8nDoJHvWavZcEixqKxkVIAJZ6KPK65JpqjcGV6fqQ==
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id q2-20020aa7cc02000000b00411487e36femr22183786edt.338.1651657674535;
        Wed, 04 May 2022 02:47:54 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402019700b0042617ba637bsm8951540edv.5.2022.05.04.02.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 02:47:54 -0700 (PDT)
Message-ID: <24c9a856-be10-e9b3-b26d-e6ced9e13c63@gmail.com>
Date:   Wed, 4 May 2022 11:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jason@zx2c4.com
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
 <alpine.LRH.2.02.2205040453050.22937@file01.intranet.prod.int.rdu2.redhat.com>
 <YnJFViBFIgYOl7/2@smile.fi.intel.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <YnJFViBFIgYOl7/2@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 11:20, Andy Shevchenko wrote:
> On Wed, May 04, 2022 at 04:57:35AM -0400, Mikulas Patocka wrote:
>> On Wed, 4 May 2022, Stafford Horne wrote:
>>> On Mon, Apr 25, 2022 at 08:07:48AM -0400, Mikulas Patocka wrote:
> 
> ...
> 
>>> Just a heads up it seems this patch is causing some instability with crypto self
>>> tests on OpenRISC when using a PREEMPT kernel (no SMP).
>>>
>>> This was reported by Jason A. Donenfeld as it came up in wireguard testing.
>>>
>>> I am trying to figure out if this is an OpenRISC PREEMPT issue or something
>>> else.
> 
>> That patch is so simple that I can't imagine how could it break the
>> curve25519 test. Are you sure that you bisected it correctly?
> 
> Can you provide a test cases for hex_to_bin()?

BTW we use exactly the same code from Mikulas in cryptsetup now (actually the report
was initiated from here :) and I added some tests for this code,
you can probably adapt it (we just use generic wrapper around it):

https://gitlab.com/cryptsetup/cryptsetup/-/commit/2d8cdb2e356d187658efa6efc7bfa146be5d3f60#d9c94cde02e4509f6d12c3edd40f8a9138696807_0_176

(it calls this: https://gitlab.com/cryptsetup/cryptsetup/-/commit/ff14c17de794fe85299d90e34e12a677e6148b71 )

I do not have OpenRISC available, but it would be interesting to run cryptsetup/tests/vectors-test there...

Milan
