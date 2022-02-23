Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE67C4C0EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiBWI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBWI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:58:38 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB357463A;
        Wed, 23 Feb 2022 00:58:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0V5Hmy0a_1645606685;
Received: from 192.168.193.152(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5Hmy0a_1645606685)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 16:58:06 +0800
Message-ID: <887572c7-b508-ca51-6cd5-54a2c9ecaa75@linux.alibaba.com>
Date:   Wed, 23 Feb 2022 00:58:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
 <f44612ce-5bb1-da45-d6cb-39464898c4ff@roeck-us.net>
 <CANiq72nhu+CtYYNfWLYxf19OscoEEZj=TATM0SHNU8ic1iDhyQ@mail.gmail.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <CANiq72nhu+CtYYNfWLYxf19OscoEEZj=TATM0SHNU8ic1iDhyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 08:59, Miguel Ojeda wrote:
> On Tue, Feb 22, 2022 at 5:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> The point here, I think, is to list the minimum gcc version.
>> It is going to be a long time until gcc 12.0 is the minimum version,
>> so I think it makes sense to list the minimum version number for
>> each compiler here.
> 
> Yeah, please list the minimum version (ideally `>=` instead of `>`,
> with the actual version where it first appeared). It makes it easy to
> then remove things that are not needed anymore when the minimum GCC
> version is upgraded.
> 

Got it, I'll use "gcc >= 12.0.0" in the next patch.

Thanks,
Dan.
