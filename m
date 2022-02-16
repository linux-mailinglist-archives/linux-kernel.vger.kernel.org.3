Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08E4B8CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiBPPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:43:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiBPPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:43:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378382944ED;
        Wed, 16 Feb 2022 07:43:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84836197E;
        Wed, 16 Feb 2022 15:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21298C004E1;
        Wed, 16 Feb 2022 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026194;
        bh=4HECk7RNZ5X2T8TgSjopIPUWXgzRsIT+6tskb9kRt34=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oYAuSxPw4iDgjJk9SKZN5etPShh8Vc7f7JReTNPv+cMQUCVyaE3Jrmlvij0LFjkyX
         PivKWB4HCgFfzGKSfVau422sA2kCe5ZLy1nhbwCpaX5PNA5BgRSj7C4fNBMW/C9RSE
         ifO5zIwAHJqs/G6LNCv3tO0xmzI5F1gbA8H1Pb+HB2HJ+6zJ20g1dy5t1PA5tR1QXb
         o/f4f3/3qmpNZRbc7AWVDoF2t1BBvAl6XLMfJSlg88l/Pt+uOVAwLjiEdWMpOZjeCf
         XqrFtLv2CLeuWD+bZkWtdg7dZM/k9x/H1dm7m1eNsIDz81DLLZFwzN1EilzUPlrddg
         agXad81CGtQVw==
Date:   Wed, 16 Feb 2022 16:43:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] DIGImend patches, part one
In-Reply-To: <20220210190437.50152-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm>
References: <20220210190437.50152-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022, José Expósito wrote:

> I'm working on the UC Logic driver to add support for my tablet.
> After some work, I noticed that I needed some patches from the
> DIGImend project [1].
> 
> Instead of cherry picking what I needed, I decided to go the hard
> way and upstream every change present in DIGImend but missing in
> the kernel with the intention of making development easier in the
> future for everyone and providing better hardware support.
> 
> In a private conversation with DIGImend's maintainer, Nikolai
> Kondrashov, I asked him for permission to upstream his changes and
> he said it was fine :) All credit goes to him, I only fixed his
> patches so they apply, fixed minor checkpatch errors, squashed
> related changes and reviewed and tested them when my hardware
> allowed me to.
> 
> This is the first series of patches from DIGImend. There are 37
> patches in total [2], but I can imagine nobody wants to review such
> a long series, so I'll be sending small groups of related patches...

Thanks a lot for consideration :)

> Unless someone feels brave and tells me to send all of them ;)

Definitely not me :)

The patches look good to me, and I see Nikolai is CCed, so I've now queued 
them in hid.git#for-5.18/uclogic

Thanks,

-- 
Jiri Kosina
SUSE Labs

