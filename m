Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C81552D61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348422AbiFUIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFUIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:47:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B52610D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:47:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id k20so8205658ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zfcOaEapxaE9S9vGTGo2ekN6KOzKbUmzU3pXqQnWMdE=;
        b=LqDbSkS9NFzOkFGxfenpQv+DkPMsaj+d7E6D7gghLD52dzHu7LPrKJntN0xJuGtI5x
         Rc+SgNDXG8zJx+Y4mTYngrQl8PRNAV/DdDQlPxhODumpGxmQINJEVV6Lbg4s2iVP2xZb
         mZbW9rjb9c0cpNXlBKSxbO+6rlAUifh0y1RFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zfcOaEapxaE9S9vGTGo2ekN6KOzKbUmzU3pXqQnWMdE=;
        b=xkhuv/MgYoRRVlyPl9uB6GKOh4sF70ykI67bRdncHlfRxS2ApzVZn++Dou/fpuR6qt
         CSbDtppfyQQXLvUFzJBW80WPgP5G3NiqJNYP1i3qlPfkkpxX75wKnRNHvYgPyu0gMosp
         8NkUdvVvS6arwMUvtRGzTzapZhbbSvQ8zy2Kard+4Y3/F0XpUb1cGSlFjZSb+aC3Ebq1
         w0JcR+THorJYLSOdEXyZP4Dj5n54GAOfmw2BaEHAgG9pE50yyldrfyJa4ekzaQS396pp
         otO1wCRNze6rAYoExj89RCmC/X00sODHqEz9VdRVGaFsrVt3w8M719DGXRgBOnC9a5x2
         vJ0Q==
X-Gm-Message-State: AJIora8N/pI2ntWs3yqFbYyNi6tuwitWuv9s9q4G4LlVXIV3e5C+ZqeW
        h89gLNih7SZZnQWyaVU1kaEGFQ==
X-Google-Smtp-Source: AGRyM1tO+LjuM21Aq+uLF72weZdNrgOr4XfGu99LuzUOdAdShSSNsEmOlVEEI5kCXajkUOEiGxXbag==
X-Received: by 2002:a2e:3516:0:b0:25a:6505:4d12 with SMTP id z22-20020a2e3516000000b0025a65054d12mr7118972ljz.83.1655801245030;
        Tue, 21 Jun 2022 01:47:25 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e8511000000b0025a724f2935sm494272lji.137.2022.06.21.01.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 01:47:24 -0700 (PDT)
Message-ID: <bdedc4fd-e627-a23e-f00a-615dc087c670@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 10:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 05/34] vsprintf: %pf(%p)
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-6-kent.overstreet@gmail.com>
 <f9224687-ce0c-b41b-f158-1b679a70c2d5@rasmusvillemoes.dk>
 <20220621075159.m67qzftqulvphivw@moria.home.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220621075159.m67qzftqulvphivw@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 09.51, Kent Overstreet wrote:

>>>  struct printf_spec {
>>> @@ -2520,7 +2521,16 @@ int format_decode(const char *fmt, struct printf_spec *spec)
>>>  		return ++fmt - start;
>>>  
>>>  	case 'p':
>>> -		spec->type = FORMAT_TYPE_PTR;
>>> +		fmt++;
>>> +		if (fmt[0] == 'f' &&
>>> +		    fmt[1] == '(') {
>>> +			fmt += 2;
>>> +			spec->type = FORMAT_TYPE_FN;
>>> +		} else
>>> +			spec->type = FORMAT_TYPE_PTR;
>>> +		return fmt - start;
>>> +	case '(':
>>> +		spec->type = FORMAT_TYPE_FN;
>>>  		return ++fmt - start;
>>
>> NAK. Don't implement something that will never be tested nor used.
>> There's not a snowball's chance in hell that we'll ever build the kernel
>> without -Wformat.
> 
> We're not stopping here. Matthew is taking this to WG14 and I'll be working on
> adding this functionality to glibc next, and %() is the syntax we intend to take
> to the working group.
> 
> But the working group is naturally going to want to see that a working
> implementation of it exists.

OK. But implementation in glibc, musl and/or the kernel is much much
less interesting than support in gcc and clang for accepting %( in the
first place, and preferably also for not just treating %( as a synonym
for %p but actually checking that the argument is a function pointer and
 that its signature matches the arguments between (). Once _that_ has
landed in gcc 24 and the kernel requirements have been bumped to that
can we consider adding "%(" format strings (and the necessary support).

Yes, I appreciate the chicken-and-egg situation. No, I don't think the
mainline kernel is a suitable place for proof-of-concept and highly
experimental code.

Rasmus
