Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7D57291D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiGLWPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGLWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:15:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CFB0F92;
        Tue, 12 Jul 2022 15:15:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so545976pjl.5;
        Tue, 12 Jul 2022 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VNSOvMf1wiS65CVMi1hnE71txPGZzIrKVk/LaP0yIA0=;
        b=P8IIfyb/MMaIGhr3xcwikcGvUINrer798RJJFZbDHsBd1B+vvlbJ7QP3GLwUp/3g4+
         f8gYimNdJUamewuiN7h6Yc6NaU6TFiSpWLGiU4jt5DWooj0J7DBMYOR6Rhy8qmlvqhjE
         6K2t9ba7X1BWCgH40iLSutIuekOS1z3CrjiN5OO+YGafRztQzHP6VbrX769srKNHOn80
         r2ixaOL6CPQuRNgzyL1/xvHukMwIkWTxZSei6nMSj7uCOJU/hQvrkVwVH3G/Ni2ySMOc
         G4E99EQ4r4ZfonZmu1T+jirF2HKF5mqT0VWTvjLex2T4YB9fhNDb79y28JIMd4hTYpoP
         +hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VNSOvMf1wiS65CVMi1hnE71txPGZzIrKVk/LaP0yIA0=;
        b=wtzADRKmOpofxNrLWT7HclfFrf+r3p4fFoXTAWvjVw9Bavp7S5m5/AQBMZ/OYpqW/V
         5+IPdhi0A+wSN4+5HNuvhX8FqGFiOICtMn1C8GioK6WBYQIm8y/YNhaFlhxJcKGMBdaE
         PZ6+xTAGmZyo8uIWALMn0kcIOfF5JZuoEPJ0/OIEeEvSaPESUgeHk+NNQwZMjIVee1cT
         zU4MAoDwSkbu33kUO/3cYttIoLLLjPJGRgLEh1Sl1/cJbsiQLEImBcPGkdRE6uBHTBpn
         XzMvLriL5BsRO38kn3CaUwc5GsSUwR8BiK4Ten4nzCrj4b0L7UkNpVyMCCjLJFDb7yMP
         cfYw==
X-Gm-Message-State: AJIora/ie2/xAyKfRVHcmVA06GewaKsOeffDOoaX4RWaQAOAEq2IYWUG
        IrXho3ZlRMCOhvFXx4njE1rRVkHFWw0=
X-Google-Smtp-Source: AGRyM1uer6hihTFeglZMipJB6cNWERL/KN0RAAkXs4nl+RhH248E9OeUoUsgLJAOpdzlDHHY0vukrA==
X-Received: by 2002:a17:90b:1811:b0:1ef:d453:9539 with SMTP id lw17-20020a17090b181100b001efd4539539mr6676405pjb.170.1657664143538;
        Tue, 12 Jul 2022 15:15:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bn19-20020a17090b0a9300b001e29ddf9f4fsm97287pjb.3.2022.07.12.15.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 15:15:42 -0700 (PDT)
Message-ID: <036b6113-d6a1-ca82-5033-98bc9caa7255@gmail.com>
Date:   Tue, 12 Jul 2022 15:15:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: Change mentions of mpm to olivia
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, olivia@selenic.com,
        paul.gortmaker@windriver.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20220712185419.45487-1-f.fainelli@gmail.com>
 <20220712200010.kbx24o2nxobrhmey@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220712200010.kbx24o2nxobrhmey@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 13:00, Uwe Kleine-König wrote:
> On Tue, Jul 12, 2022 at 11:54:19AM -0700, Florian Fainelli wrote:
>> Following this mercurial changeset:
>> https://www.mercurial-scm.org/repo/hg-stable/rev/d4ba4d51f85f
>>
>> update the MAINTAINERS entry to replace the now obsolete identity.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> This was first submitted by Uwe:
>>
>> https://lore.kernel.org/lkml/20210920080635.253826-1-u.kleine-koenig@pengutronix.de/
> 
> My variant was to drop Matt/Olivia. Given that we didn't get any
> feedback from them, that's still what I would favour.
> 
> Without any feedback (and committment?) from Olivia, I tend to nack this
> patch.

I do not care either way, by explicitly CC'ing Olivia we give a fighting 
chance of seeing one's identify continue to be listed under MAINTAINERS. 
Now without any recent commits in the past 12 years, one could argue 
that removal is long due.

Either way is fine as long as we stop getting SMTP server bounces which 
is just extremely annoying...
-- 
Florian
