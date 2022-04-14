Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B33501B10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiDNS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiDNS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:29:11 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F2E38B9;
        Thu, 14 Apr 2022 11:26:43 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru DFC32233D6F3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1649837953-10984-1-git-send-email-baihaowen@meizu.com>
 <2ed01eb3-ff46-425c-75dc-81729a5c30a8@omp.ru>
 <CAMuHMdVCRRbhYEnk4bjvPugrosw4mNQCcHQqsNrx0RhFL+dJDQ@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <ad8972c2-5261-406a-c98e-d8c3d382fc7d@omp.ru>
Date:   Thu, 14 Apr 2022 21:26:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVCRRbhYEnk4bjvPugrosw4mNQCcHQqsNrx0RhFL+dJDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 12:32 PM, Geert Uytterhoeven wrote:

[...]
>>> Fix this issue by freeing the cpg when exiting the function in the
>>> error/normal path.
>>>
>>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>>> ---
>>> V1->V2: free both cpg&clks.
>>>
>>>  drivers/clk/renesas/clk-r8a73a4.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>    2 patches with the same name won't do -- you always need to include the chip name
>> part of the file name in the subject (in this case r8a73a4).
> 
> Oh, they were for multiple drivers?

   I counted 3! :-)

> I hadn't even noticed , as Gmail collapsed them all into the same thread...

   Hm, they weren't actually posted in the same thread...

> Gr{oetje,eeting}s,
> 
>                         Geert
[...]

MBR, Sergey
