Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43775A0DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiHYKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiHYKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:20:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E753A48A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:20:40 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oR9yY-0007wg-Fb; Thu, 25 Aug 2022 12:20:38 +0200
Message-ID: <da420331-b160-6675-d638-8abbbbb7ce01@leemhuis.info>
Date:   Thu, 25 Aug 2022 12:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [Intel-wired-lan] ice: Error setting promisc mode on VSI 6
 (rc=-17) @ 5.18.x #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com>
 <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
In-Reply-To: <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661422841;313f1d9d;
X-HE-SMSGID: 1oR9yY-0007wg-Fb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 19.06.22 13:50, Thorsten Leemhuis wrote:
> [TLDR: I'm adding this regression report to the list of tracked
> regressions; all text from me you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
> 
> On 09.06.22 08:58, Jaroslav Pulchart wrote:
>>
>> I'm struggling with broken network connectivity at VMs using linux
>> bridge at host after update of kernel from 5.17.x to 5.18.x @ Dell
>> R750 server with E810-XXV NICs.
>>
>> I noticed the kernel reports "Error setting promisc mode" in dmesg.
>>
>> # dmesg  | grep 'Error setting promisc'
>> [   24.863557] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>> [   24.878369] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>> [   25.045834] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>> [   25.129840] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>> [   25.144440] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>
> Anyway: To be sure below issue doesn't fall through the cracks
> unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
> bot:
> 
> #regzbot ^introduced v5.17 to v5.18
> #regzbot title net: ice: Error setting promisc mode on VSI 6 (rc=-17) @
> 5.18.x
> #regzbot monitor
> https://lore.kernel.org/all/CAK8fFZ68+xZ2Z0vDWnihF8PeJKEmEwCyyF-8W9PCZJTd8zfp-A@mail.gmail.com/
> #regzbot monitor
> https://lore.kernel.org/all/CAK8fFZ61mQ3AYpdWjWtyUXzrs-RVMW61mBLrjRDXBxB-F9GzbA@mail.gmail.com/
> #regzbot ignore-activity

#regzbot fixed-by: 79956b83ed4281c35561c39254558092d96a9ed1
