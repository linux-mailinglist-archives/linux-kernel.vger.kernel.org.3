Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43AC524832
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiELIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351713AbiELInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:43:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D2473BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:43:25 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1np4Pb-0003PL-R8; Thu, 12 May 2022 10:43:07 +0200
Message-ID: <3cf09576-66f2-b18c-0057-2635fc9452de@leemhuis.info>
Date:   Thu, 12 May 2022 10:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
 <Ynt1z0eZ19eMqp8I@zn.tnic> <YnvbLx9FKgQwZJ/F@mit.edu>
 <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
 <YnwP7QmPzyv5FhrZ@zn.tnic>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
In-Reply-To: <YnwP7QmPzyv5FhrZ@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1652345008;381e7f98;
X-HE-SMSGID: 1np4Pb-0003PL-R8
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.22 21:35, Borislav Petkov wrote:
> On Wed, May 11, 2022 at 08:55:34AM -0700, Linus Torvalds wrote:
>> On Wed, May 11, 2022 at 8:50 AM Theodore Ts'o <tytso@mit.edu> wrote:
>>>
>>> I would argue that it should be the patch submitter's responsibility
>>> to explicitly add a URL to the problem report.
>>
>> I agree in the perfect case.
>>
>> But in practice, we have a lot more patch submitters than we have
>> maintainers, and not all "leaf developers" necessarily know how to do
>> everything.
>>
>> So the maintainer should probably expect to fix things up. Not always,
>> but also not a "the developer should have done this, so I won't do it"
>>
>> This isn't so different from the fact that not everybody writes
>> English proficiently - people do hopefully end up fixing things up as
>> they get passed onwards.
> 
> And, in addition, what happens most often in my experience is I
> constantly get to point submitters to our process documentation -
> submitting-patches especially - as not a small number of them are not
> aware of different aspects of the whole patch dance: tags, SOB chains,
> etc. And the Link tag is no exception here.

Which leads to the question: can we (and do we want to) teach
scripts/checkpatch.pl to point out when a Link: tag is missing and
likely appropriate? If a "Reported-by:" is present there should be a
"Link:" as well, unless the issue was reported privately, via IRC or
something like that. A "Fixes:" tag is also a strong indicator that a
link might be appropriate, but not as good.

Ciao, Thorsten
