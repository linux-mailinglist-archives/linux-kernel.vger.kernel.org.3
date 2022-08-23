Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53D559E8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiHWRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344850AbiHWRLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5F15CE0F;
        Tue, 23 Aug 2022 06:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D4BCB81B79;
        Tue, 23 Aug 2022 13:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFBCC433D6;
        Tue, 23 Aug 2022 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661261910;
        bh=gNcuBVbZTH11tEmptRdziv6KZ2nBwZGGtxerR4UZk/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBQychxuVnBlnwSnKFGZWdNCjgjLWOAryCTjnRu4zWVeSrahmp7Wc8utuIPFoIcEP
         wvFhJ6MhioFh/5SUZNfTBLF9mdcClxrVs5kt07KMbMMyON8DOaw2Omgml9SR34NBbJ
         /DK80a6BsDsuHV/fIO6F2SgQsC2NLJIj1EY0PzC1gnM0GkSBWLrqsf7Lz6q5SwsRr0
         qN8hJM8r5RG5Wzr0HkUPAoNOXpDr+hVGkbNI0pEOHHtzGQW85b89sJ/9tftvDd3+Ig
         K5CUuedm5DLqUN7w2Vxt+4Qlll8YZGWhLIfN5x7NJcSpxZ4CHKZ4rH0Hol12uJGXfx
         Mfb/pxzHV3DSA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 11832404A1; Tue, 23 Aug 2022 10:38:27 -0300 (-03)
Date:   Tue, 23 Aug 2022 10:38:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com
Subject: Re: [PATCH v2] perf list: Add PMU pai_crypto event description for
 IBM z16
Message-ID: <YwTYU+xXZJr0kH5u@kernel.org>
References: <20220804075221.1132849-1-tmricht@linux.ibm.com>
 <YvOq3B02x8GqkVPA@kernel.org>
 <YwSdWUt02SFzrMUm@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwSdWUt02SFzrMUm@osiris>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 23, 2022 at 11:26:49AM +0200, Heiko Carstens escreveu:
> On Wed, Aug 10, 2022 at 09:55:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 04, 2022 at 09:52:21AM +0200, Thomas Richter escreveu:
> > > Add the event description for the IBM z16 pai_crypto PMU released with
> > > commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> > 
> > What tree is this? I tried on torvalds/master:
> > 
> > ⬢[acme@toolbox perf]$ git remote update torvalds
> > Fetching torvalds
> > ⬢[acme@toolbox perf]$ git log --oneline -1 torvalds/master
> > d4252071b97d2027 (torvalds/master) add barriers to buffer_uptodate and set_buffer_uptodate
> > ⬢[acme@toolbox perf]$ git show torvalds/master d4252071b97d2027 | head -5
> > commit d4252071b97d2027d246f6a82cbee4d52f618b47
> > Author: Mikulas Patocka <mpatocka@redhat.com>
> > Date:   Tue Aug 9 14:32:13 2022 -0400
> > 
> >     add barriers to buffer_uptodate and set_buffer_uptodate
> > ⬢[acme@toolbox perf]$ git show torvalds/master 1bf54f32f525 | head -5
> > fatal: ambiguous argument '1bf54f32f525': unknown revision or path not in the working tree.
> > Use '--' to separate paths from revisions, like this:
> > 'git <command> [<revision>...] -- [<file>...]'
> > ⬢[acme@toolbox perf]$ git log --oneline torvalds/master | grep "pai: Add support for cryptography counters"
> > ⬢[acme@toolbox perf]$
> > ⬢[acme@toolbox perf]$ git show torvalds/master d4252071b97d2027 | head -4
> > commit d4252071b97d2027d246f6a82cbee4d52f618b47
> > Author: Mikulas Patocka <mpatocka@redhat.com>
> > Date:   Tue Aug 9 14:32:13 2022 -0400
> > 
> > I'm applying it locally so that it gets included in testing, but please
> > clarify where is that 1bf54f32f525 cset.
> 
> Thomas mixed up our non public development tree and Linus' tree.
> Correct commit id + subject are:
> 
> 39d62336f5c1 ("s390/pai: add support for cryptography counters")

Ok, this is already upstream, with this note:

----
    Committer notes:

    Couldn't find 1bf54f32f525 ("s390/pai: Add support for cryptography
    counters") in torvalds/master, in what tree is that cset?
----

Not a biggie, the description was added, which is what really matters,
right? :)

- Arnaldo
