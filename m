Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23A4BA717
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiBQR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:27:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiBQR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:27:31 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F218461B;
        Thu, 17 Feb 2022 09:27:16 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id j78so712627qke.2;
        Thu, 17 Feb 2022 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5TBlHGHH+WgnstAw4WAM7waOCG5SUDRAM7hFFIagCrU=;
        b=HLY4SPMBxh4NKJbgQKdTkOF1EKwda6K8LQMPuV36UURJxnp7c4cFUN7jKyV05Ha0JT
         ubSD9THez92siIbroSve2L+60SunhnDrredJrG/kd8HxyGw1J6LhbEkgN3Lm+S0R8Dki
         qwO6hj1XbpB6NkUgQ84Oy/OV+Sbji6p57xqSFrRNZ8us8dbQ8sXhvvJ8PjS6Q/dT1ksj
         5rj3nmge7i+rX00ahzikCfer3Jv8T0UkehawWYdt12kZVJtj5akb4J+p2+UelxXYyfjI
         SFbE5tkLerjDF+R1tj2kzFP4jmcyOL2S0NwaAgmE6YAtuO/MVsoxtyRUuV7hWoF/vyPQ
         yzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5TBlHGHH+WgnstAw4WAM7waOCG5SUDRAM7hFFIagCrU=;
        b=PPvdBwa+oKJYS1FNHDC+SJLIxRjOiCzr5ntDpfSTTxRLtCNBPDdkl5Jq94XxH0LskZ
         JWNCE/PMi9VpcDRkRqrq4SsBSkyQLtDrNFTHzjzZ9r5HbRi1CyqKCQHsAaUHLeIWaio7
         i4VZpCYo5hNkKu634I5/LjEgZbjOzsILzA6VfHrpxb2bH9XroZk/JQL/MIAmKZKTJU8b
         e2ReMuI1DGp4eVVoLTFS6KaQRfiZFNAwI2zV2RdFEpNaoXjpvUUN6S2y7kYyzY1zOhT0
         SrKsEwBzzabyMx2w6UYMHNX2njI950lNyl6I5Gmpk/occ91FezVyRtjSY5zwMbyeyL2L
         WgVw==
X-Gm-Message-State: AOAM531V8tTMRaXWCDLlsd/YH8sEUMJD+UjCmrLp5GIJMzuEjNGlI+RW
        RNFSRtOKOV3nyDX2XWtHtU8=
X-Google-Smtp-Source: ABdhPJzA7isSR8GbbpDuUGZbNJH+0UydjEtjn1t9PHTbTZtMwobftpWsxxVxnjOdfRofyzr6m36xhw==
X-Received: by 2002:a37:5345:0:b0:47b:e4b3:48ea with SMTP id h66-20020a375345000000b0047be4b348eamr2287957qkb.35.1645118835811;
        Thu, 17 Feb 2022 09:27:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o17sm11404887qtv.45.2022.02.17.09.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:27:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef1b1d99-6172-2b4d-9612-7ecbe8fc6c8b@roeck-us.net>
Date:   Thu, 17 Feb 2022 09:27:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V2 17/21] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
 <96f418b4-0ba8-01fe-ead0-2028bfc42560@sony.com>
 <ba924008-c0ab-4800-aac4-d9d9ae930c32@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ba924008-c0ab-4800-aac4-d9d9ae930c32@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 08:27, Daniel Bristot de Oliveira wrote:
> Hi Peter
> 
> On 2/16/22 17:01, Peter.Enderborg@sony.com wrote:
>> On 2/14/22 11:45, Daniel Bristot de Oliveira wrote:
>>> Add a set of tracepoints, enabling the observability of the watchdog
>>> device interactions with user-space.
>>>
>>> The events are:
>>> 	watchdog:watchdog_open
>>> 	watchdog:watchdog_close
>>> 	watchdog:watchdog_start
>>> 	watchdog:watchdog_stop
>>> 	watchdog:watchdog_set_timeout
>>> 	watchdog:watchdog_ping
>>> 	watchdog:watchdog_nowayout
>>> 	watchdog:watchdog_set_keep_alive
>>> 	watchdog:watchdog_keep_alive
>>
>> Some watchdogs have a bark functionality, I think it should be event for that too.
>>
> 
> I understand. The problems is that I do not see the bark abstraction in the
> watchdog_dev layer.
> 

I don't even know what "bark functionality" means. A new term for pretimeout ?
Something else ?

Guenter

> In the case I am investigating (the safety_monitor/safety_app) the bark is
> outside of the "OS" view, it is an hardware action - like. shutdown.
> 
> Am I missing something? Thoughts?
> 
> -- Daniel

