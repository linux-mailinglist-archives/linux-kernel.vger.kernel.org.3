Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802654C3A65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiBYAfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:35:49 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E12D24FA2B;
        Thu, 24 Feb 2022 16:35:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V5Q66IT_1645749311;
Received: from 192.168.193.153(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5Q66IT_1645749311)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Feb 2022 08:35:12 +0800
Message-ID: <d2c864c0-6535-acfd-6c2f-f1175ce8a719@linux.alibaba.com>
Date:   Thu, 24 Feb 2022 16:34:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, linux@roeck-us.net,
        mhiramat@kernel.org, ojeda@kernel.org, luc.vanoostenryck@gmail.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
 <69d351c6-a69d-6ebb-53bc-b46dfe4da08a@linux.alibaba.com>
 <YhZxVwoshSwwJkJO@dev-arch.archlinux-ax161>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <YhZxVwoshSwwJkJO@dev-arch.archlinux-ax161>
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



On 2/23/22 09:39, Nathan Chancellor wrote:
> On Wed, Feb 23, 2022 at 12:50:21AM -0800, Dan Li wrote:
>> My intention is to remind users that this is a compiler feature.
>> But since there is also a hint in CC_HAVE_SHADOW_CALL_STACK:
>> +# Supported by clang >= 7.0 or GCC ...
>>
>> Removing the specific compiler here also looks fine to me.
>> Would this look better?
>>
>> "This option enables Shadow Call Stack, which uses a ..."
>>
>> or maybe:
>>
>> "This option enables compiler's Shadow Call Stack, which uses a ..."
> 
> I do not honestly have a strong opinion around removing mention of the
> compiler so either looks fine to me (might be better to say "the
> compiler's Shadow ..." in the second one).
> 

Ah, yes, thanks :)

Dan.
