Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36350F888
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348960AbiDZJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiDZJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:17:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9419A486;
        Tue, 26 Apr 2022 01:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27798B81C76;
        Tue, 26 Apr 2022 08:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4BCC385A4;
        Tue, 26 Apr 2022 08:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650963221;
        bh=el/6i0KSNcueiz7574hLB0Xq14egIyCJgB4a4fvIvWA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=BRaz1oPVwUTnqVovkB0aOEn8l3EzvRL/bu7pyRR90LDtF6q62n42N+9V86K6DiGFS
         c2FsrYXQc/33ZO5OGswH+Xacv97XeR+IoA9fRhUQ7h28cL86qKenWzsh86HJUyjmeu
         aXbRZv8EylMlORYRj1mVLkvrHNUc4EfOMD5CrnqIu3oJI1hVZuyYvJZ4yXxr9tCssP
         qAERgpBolu6EaCkzxFBo4GKIZ+MeYdC3bJW1gbuhz/pLp3XhIC6n3UEVEvgi7YmyfG
         zXVURgfcbhexP5gGDe/KlNQUEmTBL5bMIAOmdcs1aP12kJWKGRJqM5FC7A53yHdxJ4
         PPBkZUY4a0pRg==
Message-ID: <bbd09bf0-4027-a250-e305-e59c7f7ecb60@kernel.org>
Date:   Tue, 26 Apr 2022 10:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: Signed-off-by missing for commit in the mediatek tree
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220426080706.26c6816b@canb.auug.org.au>
 <60b73431-ea41-bcca-8374-1836488b399c@gmail.com>
 <55c9dd79-2703-b7f5-f593-3324d09085e5@kernel.org>
In-Reply-To: <55c9dd79-2703-b7f5-f593-3324d09085e5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 10:52, Krzysztof Kozlowski wrote:
> On 26/04/2022 10:48, Matthias Brugger wrote:
>> Hi Stephen,
>>
>> On 26/04/2022 00:07, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Commits
>>>
>>>    775ef8aaa66e ("arm64: dts: mediatek: align thermal zone node names with dtschema")
>>>    c8b8db1a173d ("arm64: dts: mediatek: align operating-points table name with dtschema")
>>>    c01d9aa630b8 ("arm64: dts: mediatek: mt8183: align Google CROS EC PWM node name with dtschema")
>>>    75a3c81bc634 ("arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS")
>>>
>>> are missing a Signed-off-by from their committer.
>>>
>>
>> These patches are taken by Krysztof and merge into my tree via a tag [1] to 
>> avoid any conflicts. Please let me know if there is anything I need to do to fix 
>> this problem.
> 
> Hi Matthias,
> 
> Before you merged my branch, which was fine, but later you rebased all
> this thus making yourself committer. Commits pulled from other trees
> should in general not be rebased, because it creates duplicates - there
> are ones in my tree, and separate in yours.
> 
> Additionally, such rebase changes the author, so you need your SoB.

Minor update - you not only rebased these commits, but also kept my
branch so even in your tree they are duplicated.

> Since you already rebased it, I propose you add your own SoB to Mediatek
> patches and drop the one hisilicon (75a3c81bc634). I will do the reverse
> - drop Mediatek and keep hisilicon.

Best regards,
Krzysztof
