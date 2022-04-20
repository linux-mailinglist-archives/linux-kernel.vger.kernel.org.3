Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1585091B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382324AbiDTVCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382350AbiDTVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA321E0A;
        Wed, 20 Apr 2022 13:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4566126E;
        Wed, 20 Apr 2022 20:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D09C385A0;
        Wed, 20 Apr 2022 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650488394;
        bh=zZMgt2ff5GhXR6JN/lFzsN7Rz1ki9wO1j0wwGbU1U4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0bVK2iLSe0JeLmh2sX7EzeXo54tmdj3eBnktlDH2H2UABkNoGQgV7HjmRq2y2bzkd
         sa4zV4GtivzqDWm2BII8BVa0Yr5XFeI1Z95yKLkknLxYLoSubwIvhbCFSWBDrowDJZ
         nLXWK4DeANKkHYJeyeU++oO5W0hZUyqfsCqnMI48=
Date:   Wed, 20 Apr 2022 13:59:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        david@redhat.com
Subject: Re: +
 mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch added to -mm
 tree
Message-Id: <20220420135953.19a10180ef25a9c07198bf86@linux-foundation.org>
In-Reply-To: <c3195d8a-2931-0749-973a-1d04e4baec94@suse.cz>
References: <20220413213339.1A60DC385A3@smtp.kernel.org>
        <c3195d8a-2931-0749-973a-1d04e4baec94@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 11:12:16 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/13/22 23:33, Andrew Morton wrote:
> > The patch titled
> >      Subject: mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix
> > has been added to the -mm tree.  Its filename is
> >      mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
> > 
> > This patch should soon appear at
> >     https://ozlabs.org/~akpm/mmots/broken-out/mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
> > and later at
> >     https://ozlabs.org/~akpm/mmotm/broken-out/mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
> 
> It seems to have disappeared? Also doesn't appear to be squashed in the
> original patch?

I have it, but I haven't done an mmotm for a few days.   Working on it.

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/pc/devel-series
is the most up to date copy of the -mm queue.  I push this out probably
twice a day.
