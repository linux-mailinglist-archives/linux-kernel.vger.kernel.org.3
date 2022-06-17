Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8A54F124
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380153AbiFQGne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380242AbiFQGnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:43:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93EB193DF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:43:30 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o25hZ-0007oZ-Gy; Fri, 17 Jun 2022 08:43:29 +0200
Message-ID: <8d5b1411-09a9-565b-89eb-0d7675170d89@leemhuis.info>
Date:   Fri, 17 Jun 2022 08:43:29 +0200
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
In-Reply-To: <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655448211;2eb95d87;
X-HE-SMSGID: 1o25hZ-0007oZ-Gy
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

On 11.06.22 15:53, Thorsten Leemhuis wrote:
> On 09.06.22 01:55, Ken Moffat wrote:
>> Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
>> blanks, disk activity for the write to swap, screen briefly has a
>> trashed display, machine powers off.  When powering up from
>> hibernation, after the saved files are loaded X starts with a
>> briefly trashed display before my desktop reappears.
>>
> #regzbot ^introduced v5.18..v5.19-rc1

#regzbot introduced 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71

