Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7352259676F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiHQC3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiHQC3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:29:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3567445
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=noP0tGHCb/BAHE2fzmHsuvX65aJ7RDKVDN/j9ECF9JA=; b=RxffMpfS4/REndNgAi4E/YY0DK
        RsKhisdEscCVNILJkWtcBFzbOna0BxL6XUCpZvsnhiy7IPZdnMBVZXwNEV084VG/SWVGyP5XqoDVy
        ElQdD/6M/TErIrn39y4exs2Im9nEgaMnS51Biuw1ac3ws7sHspDFVMY2CvBbWfUmhMLvLnMhnNULm
        k5mfB60ZUoIBDDsXTBfAU29hlOzcBkztPg4N1uuuN20JAw6RpDHpO8KTvAPH4CUcyfHFKTBNUL4kx
        xu7J1gTtwFrKIn9GmRT2tEKLLVSFzFbhhRsj9r2AlJ89khUzternicU6LFW7F8NZVP7Ly0EXigIFx
        wyD1QNtg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO8oH-00975V-5L; Wed, 17 Aug 2022 02:29:33 +0000
Message-ID: <77d8e180-9931-55ef-631e-f3e0ecb9fd36@infradead.org>
Date:   Tue, 16 Aug 2022 19:29:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] improve the kernel quality and reduce the amount of BS
 patches
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain> <YvxNvpF7n1VqNnbD@ZenIV>
 <YvxP3LrvHLhFClBd@ZenIV>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YvxP3LrvHLhFClBd@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/22 19:18, Al Viro wrote:
> On Wed, Aug 17, 2022 at 03:09:02AM +0100, Al Viro wrote:
>> this idiocy has gone too far    
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> 	Seriously, folks - the stream of patches with no better
> explanations than "The Most Holy checkpatch.pl Says So, Must Appease
> The Spirits" ought to stop.
> 
> 	If you are changing something, take care to explain _why_
> is the change made.  Reference to a tool that has pointed you
> towards the location you are changing does not replace that.
> checkpatch.pl is a script.  A dumb one.  It's a bunch of heuristics
> that correlate with code being potentially fishy and worth looking
> into; those are occasionally useful, but it's not an oracle.

Yes, just saying "found with checkpatch" is not sufficient.

It's even documented to be a dumb advisor:

"""Checkpatch is not always right. Your judgement takes precedence over checkpatch
messages.  If your code looks better with the violations, then its probably
best left alone."""

and

"""Note, though, that the style checker should be
viewed as a guide, not as a replacement for human judgment."""


-- 
~Randy
