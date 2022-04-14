Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207465009E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiDNJdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbiDNJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:33:40 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A670062;
        Thu, 14 Apr 2022 02:31:13 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 14 Apr
 2022 17:31:12 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 14 Apr
 2022 17:31:11 +0800
Message-ID: <ef55ac6b-a62b-2589-08ba-973ef83e096d@meizu.com>
Date:   Thu, 14 Apr 2022 17:31:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649837953-10984-1-git-send-email-baihaowen@meizu.com>
 <2ed01eb3-ff46-425c-75dc-81729a5c30a8@omp.ru>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <2ed01eb3-ff46-425c-75dc-81729a5c30a8@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/14/22 5:29 PM, Sergey Shtylyov 写道:
> Hello!
>
> On 4/13/22 11:19 AM, Haowen Bai wrote:
>
>> Fix this issue by freeing the cpg when exiting the function in the
>> error/normal path.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>> V1->V2: free both cpg&clks.
>>
>>  drivers/clk/renesas/clk-r8a73a4.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>    2 patches with the same name won't do -- you always need to include the chip name
> part of the file name in the subject (in this case r8a73a4).
>
> MBR, Sergey
Got it, thank you for your kindly reminder.

-- 
Haowen Bai

