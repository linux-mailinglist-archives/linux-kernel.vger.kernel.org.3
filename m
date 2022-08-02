Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315CD58797F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiHBJAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiHBJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:00:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C044E844
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 813A3B819EF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75B0C433C1;
        Tue,  2 Aug 2022 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659430806;
        bh=epl+ZZRl4pjX9N7ZuowMwifZiw9GkfImtKZEBKim6uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGComYh8UNk+6LnAGRhVKSu9K4mJVU7TXYxWiuYtqogTclqD1JMdPRw6P3uX/IBdx
         AiV1JSKWYY+yKkGZscP0l6IXsk053nWCVlISCYmYiwmG63hOO35jdZGNx6LymuzDG+
         Fs1gO0T6x9bI/TNIBghrByD/6KFkvYsLDOpJINJDu8nb48GFf3hnzHfq905ncuMuvK
         kbvmPFYh6XZFBmv3sUOFXbYToWUwMZLpo0qj4eEgOdNH8V9QHob4XwSTCAJHamnuAY
         gxIy5SbCLnpPYklhjC8HoYs6mJAI6cQnLIZdeA0bA14C+d2IKZCeH9vCPTcrZKvWJm
         vuSZYw0rq2qeA==
Date:   Tue, 2 Aug 2022 10:00:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: Re: [GIT PULL] arm64 updates for 5.20
Message-ID: <20220802090000.GD26962@willie-the-truck>
References: <20220729102205.GA24050@willie-the-truck>
 <CAHk-=wj=CQsmGPzDUZjey3DoMFsiCqn-O6kmCv6ZCW0AoO=kOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=CQsmGPzDUZjey3DoMFsiCqn-O6kmCv6ZCW0AoO=kOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:24:15PM -0700, Linus Torvalds wrote:
> On Fri, Jul 29, 2022 at 3:22 AM Will Deacon <will@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
> 
> .. and I can happily report that this works fine on my M2 Air.
> 
> Which I'm sure is not any surprise, but it's still nice to be able to
> actually test and run these things.

/me breathes out

Seriously though, if you could share any details about exactly how you're
running this (e.g. in a VM or native, .config, any extra patches on top)
then we could probably mimic it in CI to avoid any last minute surprises
with the pull requests.

Cheers,

Will
