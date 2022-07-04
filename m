Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851245650C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiGDJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiGDJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA31CFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:31 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o8IOX-0004ho-J4; Mon, 04 Jul 2022 11:29:29 +0200
Message-ID: <19fa2473-467f-92cd-dad2-1a8ab17f3bed@leemhuis.info>
Date:   Mon, 4 Jul 2022 11:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
 #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
 <8d5b1411-09a9-565b-89eb-0d7675170d89@leemhuis.info>
In-Reply-To: <8d5b1411-09a9-565b-89eb-0d7675170d89@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1656926971;632b1abf;
X-HE-SMSGID: 1o8IOX-0004ho-J4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.06.22 08:43, Thorsten Leemhuis wrote:
> TWIMC: this mail is primarily send for documentation purposes and for
> regzbot, my Linux kernel regression tracking bot. These mails usually
> contain '#forregzbot' in the subject, to make them easy to spot and filter.
> 
> On 11.06.22 15:53, Thorsten Leemhuis wrote:
>> On 09.06.22 01:55, Ken Moffat wrote:
>>> Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
>>> blanks, disk activity for the write to swap, screen briefly has a
>>> trashed display, machine powers off.  When powering up from
>>> hibernation, after the saved files are loaded X starts with a
>>> briefly trashed display before my desktop reappears.
>>>
>> #regzbot ^introduced v5.18..v5.19-rc1
> 
> #regzbot introduced 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71

#regzbot fixed-by: 202773260023b5

