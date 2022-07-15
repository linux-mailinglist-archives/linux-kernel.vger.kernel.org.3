Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5B576470
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiGOPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:30:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF441BCA3;
        Fri, 15 Jul 2022 08:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FC7DB82B2F;
        Fri, 15 Jul 2022 15:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D07EC34115;
        Fri, 15 Jul 2022 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657899040;
        bh=ixWSEZVq8UAZCy7EiJgHXCvLTjmFAOR1viXI1mwA0qM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VnzBR4fN3GrIY6Qbu8pMunO5pb72uk48+ZNXhnp91JFsEOZ4TIVFeTPkDkwp4Ru2a
         HDJHdwPepNFaF/merK08o864CyOjpG3HUkZzeh780cV184NiHBMt/fHeD8tutqYLIg
         w3dXvaDU19luKep5g+RdSD68iYc2pojFbZ44eWtj85FltZFBtXnjUSLE9UXgf94V/M
         h8USHgPK2yNNqt7D/zNbP3e1t8hlNcDNx4F/sLvK3EQIegdf8rH9Af7YO3hq5nc97H
         YFoQpfqmCnpRXyi01A13G2sDnn5oCweyOHOJFFjHU6/Hp4lV8ngAbm7g/N3dY7v//5
         HqOzmY7iTX98Q==
Message-ID: <2a2bb00a-28ae-ecd8-760a-a83cc14c02fa@kernel.org>
Date:   Fri, 15 Jul 2022 18:30:36 +0300
MIME-Version: 1.0
Subject: Re: [GIT PULL] interconnect changes for 5.20
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715101021.30109-1-djakov@kernel.org>
 <YtFjOW77wGnToYt8@kroah.com> <YtFjbhn3pveplLQb@kroah.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YtFjbhn3pveplLQb@kroah.com>
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


On 15.07.22 15:54, Greg KH wrote:
> On Fri, Jul 15, 2022 at 02:53:13PM +0200, Greg KH wrote:
>> On Fri, Jul 15, 2022 at 01:10:21PM +0300, Georgi Djakov wrote:
>>> Hello Greg,
>>>
>>> This is the pull request with interconnect changes for the 5.20-rc1 merge
>>> window. It contains driver updates. The details are in the signed tag.
>>>
>>> All patches have been in linux-next during the last few days. No issues have
>>> been reported so far. Please pull into char-misc-next.
>>>
>>> Thanks,
>>> Georgi
>>>
>>> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>>>
>>>    Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.20-rc1
>>
>> Pulled and pushed out, thanks.
> 
> Oops, nope, I got the following error:
> 
> Fixes tag: Fixes: f0d8048525d7d("interconnect: Add imx core driver")
> 	Has these problem(s):
> 		- missing space between the SHA1 and the subject
> 

Apologies for missing this. This was in linux-next for more than a week, but nobody
reported it. I'll create a script to check for this problem to my workflow.
Now sending you v2 pull request.

Thanks,
Georgi
