Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B54C28E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiBXKLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiBXKLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:11:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6928ADB1;
        Thu, 24 Feb 2022 02:11:01 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nNB5K-0002zQ-ON; Thu, 24 Feb 2022 11:10:54 +0100
Message-ID: <390abb1b-6d85-e6fe-ba0e-c47f7c80fca2@leemhuis.info>
Date:   Thu, 24 Feb 2022 11:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Alexander Dahl <ada@thorsis.com>
References: <20220224001403.1307377-1-keescook@chromium.org>
 <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
 <YhdWa41bXssNVrE3@ada-deb-carambola.ifak-system.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
In-Reply-To: <YhdWa41bXssNVrE3@ada-deb-carambola.ifak-system.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1645697462;718ac6e2;
X-HE-SMSGID: 1nNB5K-0002zQ-ON
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 10:56, Alexander Dahl wrote:
> Hello Thorsten,
> 
> Am Thu, Feb 24, 2022 at 09:19:24AM +0100 schrieb Thorsten Leemhuis:
>> On 24.02.22 01:14, Kees Cook wrote:
>>> +If you are a first time contributor it is recommended that the patch
>>> +itself be vetted by others privately before being posted to public lists.
>>> +(This is required if you have been explicitly told your patches need
>>> +more careful internal review.) These people are expected to have their
>>> +"Reviewed-by" tag included in the resulting patch. Finding another
>>> +developer familiar with Linux contribution, especially within your own
>>> +organization, and having them help with reviews before sending them to
>>> +the public mailing lists tends to significantly improve the quality of the
>>> +resulting patches, and there by reduces the burden on other developers.
>>
>> I like the section, but I wonder why it's needed here. Is there anything
>> specific to patches produced from research in it there I missed when
>> reading it? If not: Wouldn't it be better to include that section as a
>> TLDR in Documentation/process/submitting-patches.rst and point there
>> instead? We already have at least two places describing how to submit
>> patches, creating yet another one (even if it's just in such a brief
>> version) somehow feels slightly wrong to me.
>>
>> OTOH I fully understand that having things in one place has it's
>> benefits. If that's wanted, why not put that text as TLDR in
>> submitting-patches.rst and maintain a copy here? Sure, keeping things in
>> sync has downsides, but I'd say it's the lesser evil. A copy could also
>> be avoided by briefly mentioning some of the important bits found in
>> another document; that's the approach I took in my patches regarding
>> regressions. To quote:
> 
> Without further opinion on the topic or content itself: 
> If there's need to have "copied" parts of the documentation available
> in different places, why not put that to a separate file and include
> it in all places which need it?  [...]

Yeah, I already wondered if that's possible, but never actually
investigated, as I assume the "separate file" aspect you mentioned is a
show-stopper: it makes reading hard for everyone that looks at the rst
files directly -- and that's something we afaics want to support.

Ciao, Thorsten
