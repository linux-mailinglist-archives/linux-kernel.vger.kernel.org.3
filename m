Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5094E1C80
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiCTQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiCTQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:12:09 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3F124C21
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 09:10:45 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.4])
        by gnuweeb.org (Postfix) with ESMTPSA id C10237E2DA;
        Sun, 20 Mar 2022 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647792645;
        bh=dsJdUh+T4o4CkeRokxwRKKTn2CCZM6SeZH4yOvaizts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bmway3T5A0GJ34JkuStzH33Gn3HMyODKRkg1OLEADWWgk+Op9StEHm5pZxtvGGGT1
         gqHbaKcmEHZWbepT1LgecT2ek6VYGnnHXH24A/3mlAR06bMMdrx2KCPFShBoVkKdo6
         zlD8WsHCuA73xpuqWoALyiiNX5qRkkaSUJfEnxFSMo75wurH6s2S4N3cybH5WF1GXk
         jeRM6iG6vyU4EoeLrZ410FTe3P4kseduLPuNKpBBjyO6i+UfH1igYbSjc+5+T2IuMP
         kBhNg30q91FC+EVofhzBjUPM0p6PhPkQIxqXgAhO/I0xpDbaDktVTGRQLOYBWg+OYH
         xEyY6t/VayUvw==
Message-ID: <88ddd139-b6e0-81f3-1ebe-30643757962e@gnuweeb.org>
Date:   Sun, 20 Mar 2022 23:10:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()` and
 `strndup()`
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
 <CAOG64qPc7ZT414CS6HoYF+mvDgYGomFCSpMqsb_FznnwHjU6dA@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAOG64qPc7ZT414CS6HoYF+mvDgYGomFCSpMqsb_FznnwHjU6dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/22 10:55 PM, Alviro Iskandar Setiawan wrote:
> On Sun, Mar 20, 2022 at 4:37 PM Ammar Faizi wrote:
>> +}
>> +
>> +
> 
> (Trivial) Got double newlines here, one newline should be good.

OK, fixed.

>>   static __attribute__((unused))
>>   size_t strlcat(char *dst, const char *src, size_t size)
>>   {

-- 
Ammar Faizi
