Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C134E8F40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiC1Hpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiC1Hps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A4452E29
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C02BB80E76
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B8BC004DD;
        Mon, 28 Mar 2022 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648453446;
        bh=KQvnw2VdjQapVkNPLixYXqbz8sIzS2hoky7Ln+DnGMo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pfof0FOuBbu2zZI7KK8MX6JbsUvrluYHwQXAiGYvGuk1BljHjv7JQD2bzjkl23xKq
         lu1dIKhveMEuBIF2yJSeWDGqn/WiohwxSkzHY97EzTYNmFT++IdPxDMk5YtjtWdZ5S
         auiAfPj+54JjtHCKyAKx9zv53Ln/+OO58AK1593UmOXO8TOFjo2RhRj7iTFDzbccIu
         oPUgvZHOg64m2cESCerOLKtdOA+FirRiPixcOZcungCc+sP9Q+V4KTX38f3fVQrmFm
         P3f3sYqmqnW5F6l4A2aiTJ3IeCcTeA7gIZMgljHWH2fLr31mkfeDYilVbpxuErQOdx
         sZECYdzhB2Bjw==
Date:   Mon, 28 Mar 2022 09:44:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID for 5.18
In-Reply-To: <CAHk-=wh20x4=SCahsGyKT5QHRgSWn+mnxppVqZ64LsMh+85tpA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2203280714590.24795@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm> <CAHk-=wh20x4=SCahsGyKT5QHRgSWn+mnxppVqZ64LsMh+85tpA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2022, Linus Torvalds wrote:

> >   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
> 
> I'm going through my merges to check which ones were signed tags and
> which ones weren't, and this is on the latter short-list.
> 
> So just a note that I'd really like people to use signed tags. Yes,
> yes, kernel.org has strict security policies and I don't require them,
> but it would still be really nice..

I was just a little bit lazy to change my workflow, thanks for prodding, 
next pull request for my trees are always going to point to signed tags 
going forward.

(and yes, I understand we have to be now all careful given that

	https://www.reddit.com/r/linuxmasterrace/comments/tng5wv/oh_no_the_source_code_was_leaked/

:P )

-- 
Jiri Kosina
SUSE Labs

