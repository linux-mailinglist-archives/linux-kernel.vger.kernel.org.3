Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2457AADD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGTARw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGTARt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:17:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8664F686
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:17:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g24so9618045qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=in1U7QOoHlBT9spKzaUde6TVoZcpMDEN9PmUJ+MkwlE=;
        b=J5FE9SMckzYGleW+eLaTtjqk8aZngKiBjyR0di4cob19UE4XFM1CU9wX0WOjFp7A4O
         +LCU/JozugF1/EYLsGyuYVFwC6NMAPxpw7R4mtj59ovg+m/nlsACKEoKNCGFhP80VNpg
         18AdPXbRUIk70EhukXKjgEdvResKflt0mteXWCna3c4nqjKUNFYlU9B1ZLKa6lOX6WfJ
         AAvD9Nsr+6jRC+lj0DJWbLxod3qyNl05mG2+up6gFiRTIZ3bjXXedYUBAuJywaTi253M
         Uw3bw40CW8s8S/pq43/DZ6375K2u2w2SInqSNAhz69hP7gU/t+d1Ls1aSIYnc23W4MGr
         ERNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=in1U7QOoHlBT9spKzaUde6TVoZcpMDEN9PmUJ+MkwlE=;
        b=IHkfG78qMdsG7EN396AAnKq27K59BWDtx8e0ksF48eVks8euhqy2nbtNhFAck0Yq6Z
         QJJXT1pSUbIhq8j9wJaVsgeeK9d/JwIA3sSU+GgErMXP/HY1pp7Ky7EsTeJKYCurb8ja
         4KXLpyrQHHOXgm3jqAatqzXMmCY0le72uUaKEm4IhvqLkNXeFr+6JNBrGXp+JiaqOVjK
         PFriABfkN/oQeE3JupRLojhkiEU2DvSRFSWkFEiDDzUPLUVhbOqzOBoHWhk1l0GXxGwM
         uuMh4QC3LAj4smc6hO8FSxariHRLCYRx+CAjX9/bTmqJliXCI7dFvq2YHIzVP0ollVGR
         OCvg==
X-Gm-Message-State: AJIora/tCpAtfBokRMLEw9gylXzAK275ycxYsr3anm51iHeT14kwbKa4
        05h/yr0UsYBz/WVXPK1iYw==
X-Google-Smtp-Source: AGRyM1uKcUQ+y4eU6fW/0QyzZ4ryd5dL3sm2pXqBFOki8Aq7ocPKB5pgyPAjxGfHSzV4i0VhSRnlkg==
X-Received: by 2002:ac8:7f91:0:b0:31e:fec2:eb18 with SMTP id z17-20020ac87f91000000b0031efec2eb18mr4398808qtj.485.1658276267541;
        Tue, 19 Jul 2022 17:17:47 -0700 (PDT)
Received: from [192.168.1.161] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 67-20020aed30c9000000b0031ea2328edcsm11517534qtf.82.2022.07.19.17.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 17:17:46 -0700 (PDT)
Message-ID: <a674920f-68b0-0b72-5375-da7c062543cc@gmail.com>
Date:   Tue, 19 Jul 2022 20:17:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220719191522.4002a5fb@gandalf.local.home>
 <7462e934-f746-eef7-ff92-0eeb8cc08b82@gmail.com>
 <20220719200507.361b06ee@rorschach.local.home>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220719200507.361b06ee@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 20:05, Steven Rostedt wrote:
> On Tue, 19 Jul 2022 19:43:46 -0400
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
>> On 7/19/22 19:15, Steven Rostedt wrote:
>>> On Sun, 19 Jun 2022 20:41:59 -0400
>>> Kent Overstreet <kent.overstreet@gmail.com> wrote:
>>>    
>>>> Core idea: Wouldn't it be nice if we had a common data structure and calling
>>>> convention for outputting strings?
>>>
>>> Because seq_buf gives us this already, the cover letter really just needs
>>> to state exactly what the benefit is to replace seq_buf with printbuf (and
>>> why seq_buf can not be simply extended to do some extra features).
>>
>>    - seq_buf has the wrong semantics on overflow for what vsnprintf needs.
> 
> More specific please.

Steve, look at the man page for snprintf if you don't see what I mean. 
This discussion has become entirely too tedious, and your _only_ 
contribution to the discussion on pretty-printers has been "why isn't 
this using this thing I made?".

You haven't been contributing to the discussion, you haven't been 
helping figure out what the APIs, helpers, data structures should look 
like, IOW _actually_ building something that could serve as a low level 
string formatting library.

I get that you're busy - but look, we all are, and this patch series has 
already been set back what, a month and a half while I was waiting on you.

I've got the tests now, I'll CC you when v5 is posted.
