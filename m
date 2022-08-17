Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AE5973A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiHQQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiHQQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:07:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243B26F7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:07:11 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oOLZS-0001EA-FB; Wed, 17 Aug 2022 18:07:06 +0200
Message-ID: <61698d9d-088d-a878-2b23-f5423045c00e@leemhuis.info>
Date:   Wed, 17 Aug 2022 18:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [Intel-wired-lan] ice: Error setting promisc mode on VSI 6
 (rc=-17) @ 5.18.x
Content-Language: en-US
To:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        "Siwik, Grzegorz" <grzegorz.siwik@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com>
 <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
 <CAK8fFZ6hS69JMtnvFnLVt9aiWEivZ9-izNgMHtB+KeAWAfaXaQ@mail.gmail.com>
 <6f52ccd2-8411-0c53-2deb-885bb1234ce5@leemhuis.info>
 <c89c993e-7a7a-15df-85ef-8d9b7be16b71@intel.com>
 <35814f70-26ad-8007-9381-e8edf4a6d77f@leemhuis.info>
 <2151f504-5244-5680-1d70-1fcd8ecd7022@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <2151f504-5244-5680-1d70-1fcd8ecd7022@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1660752431;c9e8f6c7;
X-HE-SMSGID: 1oOLZS-0001EA-FB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.22 17:59, Tony Nguyen wrote:
> On 8/17/2022 2:08 AM, Thorsten Leemhuis wrote:
>> On 05.07.22 15:51, Wilczynski, Michal wrote:
>>>
>>> Adding Grzegorz Siwik,  since he is working on similar issue and already
>>> has a patch that is being tested/reviewed internally at the moment.
>>>
>>> He can you a send patch tomorrow so you can test if it also fixes your
>>> problem.
>>
>> Tony, Jesse, I have to wonder: why is it taken so long to get this
>> regression fixed? The regression was reported 69 days ago and the first
>> patches to fix this went out 40 days ago. That's far from ideal.
> 
> Our validation found issues when testing the original fix which caused
> the delays as the new issues were being worked out.

Yeah, that happens, still I wish it wouldn't taken *that* much longer
then what's outlined in the docs.

Side note: this and a similar issue I had today made me wonder if we
need a tag to make "this is a regression fix" more obvious to reviewers
and maintainers. But I guess that overblown; should be enough if
developers make it obvious in their cover letter or description that
this fixes a regression.

>> Reminder: this regression ideally should have been fixed within two
>> weeks after the report, as explained here:
>> https://docs.kernel.org/process/handling-regressions.html
>>
>> FWIW, in case anyone wonders: the latest patch-series to fix this can be
>> found here:
>> https://lore.kernel.org/intel-wired-lan/1660310750-290943-1-git-send-email-grzegorz.siwik@intel.com/
> 
> I was going to point you to the newest patches, but you located them.
> Our validation finished testing them yesterday so the pull request for
> these will be going out to netdev today.

Great, many thx.

Ciao, Thorsten
