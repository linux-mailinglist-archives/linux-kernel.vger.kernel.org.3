Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C94EAAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiC2KBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiC2KBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:01:33 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC34C7BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:59:49 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 29 Mar
 2022 17:59:49 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 29 Mar
 2022 17:59:46 +0800
Message-ID: <d293aee5-6065-9d87-0906-438542a8be84@meizu.com>
Date:   Tue, 29 Mar 2022 17:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIFYyXSBzdGFnaW5nOiByODE4OGV1OiBE?=
 =?UTF-8?Q?irectly_return_=5fSUCCESS_instead_of_using_local_ret_variable?=
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "martin@kaiser.cx" <martin@kaiser.cx>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1648457028-4226-1-git-send-email-baihaowen@meizu.com>
 <YkF2MRdxlUWow0UC@kroah.com> <be09d628f09041ac8f2c7bf2e9d5a13d@meizu.com>
 <YkF78wyXCaQIwkB2@kroah.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <YkF78wyXCaQIwkB2@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 3/28/22 5:12 PM, Greg KH 写道:
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Mon, Mar 28, 2022 at 09:07:44AM +0000, 白浩文 wrote:
>> Hi, Greg KH
>>
>> Yes, I think sync rtl8723bs and r8188eu will be better as they have same problem.
>>
>> commit 067756acdac8e0dd91edf4800e844fcb6e0cc72a
>> Author: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>> Date:   Mon Jul 15 23:16:18 2019 +0530
>>
>>     staging: rtl8723bs: core: Change return type of init_mlme_ext_priv
>>
>>     As init_mlme_ext_priv function always returns SUCCESS , We can change
>>     return type from int to void.
>>
>>     Fixes below issue identified by coccicheck
>>     drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:464:5-8: Unneeded
>>     variable: "res". Return "_SUCCESS" on line 492
> Yes, that would be good.
>
ok, got and learned a lot as a newbie, thx.

-- 
Haowen Bai

