Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07D58B838
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiHFU3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiHFU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:29:04 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D99FE8
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:29:03 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E46AE641; Sat,  6 Aug 2022 22:29:00 +0200 (CEST)
Date:   Sat, 6 Aug 2022 22:28:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
Message-ID: <Yu7PBwJy8LbI/aTs@8bytes.org>
References: <YuzlAT7RW1U36+ap@8bytes.org>
 <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 12:39:54PM -0700, Linus Torvalds wrote:
> I'm currently bisecting a boot failure on my desktop, and it's gone
> into the iommu code.
> 
> I'm assuming it's the 64-bit thing, but I'll bisect further to make sure.
> 
> If it is, it will be reverted as hopelessly optimistic.

A faster way to track down whether this change causes the boot failures
on your machine is to boot with iommu.forcedac=0 to disable the new
behavior and see if the issue goes away.

Please let me know if I can help with anything.

Regards,

	Joerg
