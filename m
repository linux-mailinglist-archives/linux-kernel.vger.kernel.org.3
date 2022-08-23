Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C359ECF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiHWUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiHWUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:00:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759111B781
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:13:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so18156606wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5HEozkN1eNSdRGMPEViSDPwooyUds18YjrCvv9Tq5PM=;
        b=JcEA4IBNP7ncyTN3CDgegKfm8PDRnp7A2SQsupOGwRFzoXrMkEjkRPXhsyEQUXtmc0
         uH80uPGU93JVu0ihwsF+XUqvG9Wv5BmDO6pfOyZOqBvaEUv8jl2eCzC828kLenl1lBza
         KqN6wEy/4S5mGi3tXtdUe6STKwVw5+cUeJQs2681POnzYwP5W74w3K5ZMBJPbJ7Qf/xY
         5L80FOve8JgO7nEiyy3MkQ6EqXx8fNgn+yUqvJbOTIo5Q3knkzN1z5RAHgnNnecHroSj
         3kNmjtRbztx8c+XzyT24BA7SDtzTMdNy9Qw8JlA8+wBrsqRs+ajUh5ufpZBJ6s5dpuL6
         aBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5HEozkN1eNSdRGMPEViSDPwooyUds18YjrCvv9Tq5PM=;
        b=gRvsMgf63HBYTiTO93W30l1BqUDzvapNCHkhvKlm/4X+aglUhxTDr4n1jcfD8Kqhb4
         tecjGrcINzfmJMVCK/qdLrn6juukbt7a7bA7poVAiH9PIBfOSpflm2EYZwLvMJGcRvMK
         9HhnMk4NZxgCTc65xAI2wyp+TAaf2WROpfOvAL1KJHLPghkjqGihHgkILU9yI0/R823l
         RylPSyLmTF7C4ZIfe/gJyXoM5cCyMVRafGHoZy4NvyGWA6WFheq05XrJAadMTqTPOmi8
         ZkC9S7z2dO4DnrO/tKzfQzzl2zq/0vNRgixwNQAsg3mqqYLGXPn0sKfEmoKvIN++tJZo
         ojTg==
X-Gm-Message-State: ACgBeo35+bfKp6sMB3DoH1IpPaKmmFtbfXlCXED09LHJ+yIbeMxSt0KZ
        eCPqbkh+z8xj0lF92dKODPV6jesHQMd+8Cw/
X-Google-Smtp-Source: AA6agR53ishkcncmQIKDj+9xe5xiVe6/2+ifQ+YB9Hqp1Fv0TSHoNuYxqGR/AucFKxKXXpbdTJMvQA==
X-Received: by 2002:a5d:660d:0:b0:225:59cc:9ad9 with SMTP id n13-20020a5d660d000000b0022559cc9ad9mr6140863wru.14.1661282002968;
        Tue, 23 Aug 2022 12:13:22 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002253d865715sm11781738wru.87.2022.08.23.12.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 12:13:22 -0700 (PDT)
Message-ID: <4e46e053-5240-aaa1-91c7-7aabdc7a2db3@arista.com>
Date:   Tue, 23 Aug 2022 20:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <20210611180242.711399-1-dima@arista.com>
 <8bba9ed8-ae1f-7c98-fde5-808927935447@csgroup.eu>
 <6b2513db-7c31-8da4-38ec-0b9898c6589c@arista.com>
 <ad912d91-c6e8-12ab-f309-d52b8cd9a92a@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ad912d91-c6e8-12ab-f309-d52b8cd9a92a@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 8/19/22 10:17, Christophe Leroy wrote:
> Hi Dmitry,
> 
> Le 10/03/2022 à 22:17, Dmitry Safonov a écrit :
>> Hi Christophe,
>>
>> On 3/9/22 15:41, Christophe Leroy wrote:
>>> Hi Dmitry,
>>>
>>> I'm wondering the status of this series.
>>
>> Yeah, I plan to work on v4 addressing the reviews.
>> WFH has quite affected my work on side-projects and I've laid aside for
>> a while this patch set that touches every architecture and is besides
>> a bit challenging to upstream.
> 
> Any progress ?

Yeah, I'm back to the office, so will spend some time on v4, thanks for
pinging.

Thank you,
          Dmitry
