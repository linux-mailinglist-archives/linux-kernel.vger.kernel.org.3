Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A5576C19
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGPFuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGPFuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:50:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E292C12F;
        Fri, 15 Jul 2022 22:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6BC55CE3201;
        Sat, 16 Jul 2022 05:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AF6C34114;
        Sat, 16 Jul 2022 05:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657950601;
        bh=j9DY9DQQSNgpJa+BVztQyf+TI2vr1A3e+XnYNtviNmQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RvSrOKDhe+8YNtHNwgIs2yzPR5fWTQWiYtplEMa5AnFuXeMlVvZ67lVZYaXczNJLD
         LX3yzNsKxy5FOk/Q7nXYWYBX4KC7ChQKYTT545BT6N2cBmXdlxMl4chZ9TS+85SruH
         VtuHl2CvsFOjuxYn9sEOdVz2+FY17xY4SROs/7CbG3subb0FwUAmwEvwakckW59bXj
         nd7p9jyTBefw2Gi6ZCVVQq7cF6XtIYsl7BmcDQ8NbK0dOXQaXXUp6MULSrvhTQYOTG
         fkeVz9Wiic5m+ihqUNrIvWMkm9f7B4ClFEgBFdo2O3/sHDM92lQSkQw1Tn5QmiHSJj
         YATVkuyNxJc0Q==
Message-ID: <7d7fc496-e990-07b6-0118-d54bf8d30651@kernel.org>
Date:   Sat, 16 Jul 2022 08:49:56 +0300
MIME-Version: 1.0
Subject: Re: [GIT PULL] interconnect changes for 5.20
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715101021.30109-1-djakov@kernel.org>
 <YtFjOW77wGnToYt8@kroah.com> <YtFjbhn3pveplLQb@kroah.com>
 <2a2bb00a-28ae-ecd8-760a-a83cc14c02fa@kernel.org>
 <YtJK4UYMrvlAs3il@kroah.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YtJK4UYMrvlAs3il@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.07.22 8:21, Greg KH wrote:
> On Fri, Jul 15, 2022 at 06:30:36PM +0300, Georgi Djakov wrote:
>>
>> On 15.07.22 15:54, Greg KH wrote:
>>> On Fri, Jul 15, 2022 at 02:53:13PM +0200, Greg KH wrote:
>>>> On Fri, Jul 15, 2022 at 01:10:21PM +0300, Georgi Djakov wrote:
>>>>> Hello Greg,
>>>>>
>>>>> This is the pull request with interconnect changes for the 5.20-rc1 merge
>>>>> window. It contains driver updates. The details are in the signed tag.
>>>>>
>>>>> All patches have been in linux-next during the last few days. No issues have
>>>>> been reported so far. Please pull into char-misc-next.
>>>>>
>>>>> Thanks,
>>>>> Georgi
>>>>>
>>>>> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>>>>>
>>>>>     Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.20-rc1
>>>>
>>>> Pulled and pushed out, thanks.
>>>
>>> Oops, nope, I got the following error:
>>>
>>> Fixes tag: Fixes: f0d8048525d7d("interconnect: Add imx core driver")
>>> 	Has these problem(s):
>>> 		- missing space between the SHA1 and the subject
>>>
>>
>> Apologies for missing this. This was in linux-next for more than a week, but nobody
>> reported it. I'll create a script to check for this problem to my workflow.
>> Now sending you v2 pull request.
> 
> That's odd, as my scripts come from Stephen's linux-next scripts, I
> would have thought he would have caught it before me.

I also thought the same, but anyway, now added your verify_fixes.sh checks to my workflow.

Thanks,
Georgi
