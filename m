Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560BF57AD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiGTBky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbiGTBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:40:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4D79EF5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:31:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o1so12673841qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AtMEgJwqgzRjiyHQFY73y+e82U1rR+yNa9cRQVtZqJg=;
        b=JDL7Vm+f723/K5qgHietHufAHe6xEygeLdDSHughUfYIG3tORNp42yxMfr4LQqXjlW
         FB3q6QZcg7HiF9sICAi3urc5asGX0vWwn67ZwsHDEjGSgyC7Y8Wy94VDnSBh+bPh1KCO
         uWJ/xOU6p5kSsC4B4WRJXdh0j+CCA8lIO56LweBgBSIZTC83OKJr6qYlRBWErxDAwb1H
         4k/u8lmE0/eZtEyXBw/swwhUQ6JW/lM97is0k98FK3jBy9i0u+2SsYBj0m2I3k9O7CqN
         JNZZwdIQOeJpeDosW9vj1tkG4f+KBxa63/W+fTV6dqSFwY2D9NOf2uNuqIaDeRSZpGEg
         lmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AtMEgJwqgzRjiyHQFY73y+e82U1rR+yNa9cRQVtZqJg=;
        b=Uv3UXSDp14EPPcL93+uj5xuRsf5qdijn4KG0vXc6WZQmMQXWict72RQHmh7KKp0K71
         /hKHwZ/yyyaGDfbV990j4/0Ygaesi70IJ+XMe2VhtQMMGT3j5LC/M8lDWzLPtxcK+sSr
         ruJH6NqTpXl9HX0NUlh7vTcQCYD4ZDTMuTi9d81ah0FdN8ZzpV+BQx3fhYkGhQYhqaHg
         OC5X1SgcdOKgtoe3H6Qt0FMkNW9LrzD0NLKrVcgPojX7ZsrYYBks1diLov0Txo4dG8/b
         Q5dyO4ZOCiQTRr2MXnGJblm+RIFGESyo6SGcCDy4GWwxFgIU3/qu+kTYZvbe81A1zTo/
         frxQ==
X-Gm-Message-State: AJIora9AeZqa9a9YlvVduDDgBfuXrUt8WCdJwrGpuqeRgb2KK+sRDsaZ
        DZnDosZFukVA3FTP/UZoTA==
X-Google-Smtp-Source: AGRyM1sd5ltxxF/vOEbWSEiGGV5BuvPbMEZWDWSJXKzOFuKitTHspxtawWKkiyD3FCcuily70/lVpQ==
X-Received: by 2002:a05:620a:410c:b0:6b2:82d8:dcae with SMTP id j12-20020a05620a410c00b006b282d8dcaemr22769103qko.259.1658280711243;
        Tue, 19 Jul 2022 18:31:51 -0700 (PDT)
Received: from [192.168.1.161] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id dm53-20020a05620a1d7500b006b4880b08a9sm16015951qkb.88.2022.07.19.18.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 18:31:50 -0700 (PDT)
Message-ID: <19c1a301-13ca-d7cf-c0f6-a63f75b7f8eb@gmail.com>
Date:   Tue, 19 Jul 2022 21:31:49 -0400
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
 <a674920f-68b0-0b72-5375-da7c062543cc@gmail.com>
 <20220719211156.75ea9255@rorschach.local.home>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220719211156.75ea9255@rorschach.local.home>
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

On 7/19/22 21:11, Steven Rostedt wrote:
> On Tue, 19 Jul 2022 20:17:45 -0400
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
>>> More specific please.
>>
>> Steve, look at the man page for snprintf if you don't see what I mean.
>> This discussion has become entirely too tedious, and your _only_
>> contribution to the discussion on pretty-printers has been "why isn't
>> this using this thing I made?".
> 
> No, my response is, why should we replace something that is working
> just fine?
For you. For your code.

Look, Steve, I've tried to work with you. And I've given you reasons why 
seq_buf doesn't work for vsprintf.c, and more general cases. You have 
not responded _at all_ with technical reasons or discussion, all you've 
done from the very start is lecture me on process.

And, to be blunt, the time to have the printbuf vs. seq_buf discussion 
was months ago. I tried to start that discussion with you, and you 
ghosted on IRC when I started talking about the things in seq_buf that 
would have to change.

Like I said, I'll CC you when v5 is posted.
