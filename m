Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C05336AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiEYGMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiEYGM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:12:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A946EB38
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B236B8172B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7E3C385B8;
        Wed, 25 May 2022 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653459145;
        bh=lhA/0pJw9m7uPyymseXWwqy/0K+vqZapCK3sQZDQTCk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cQ9+wQcJ5vQpIhGQCv2F+sBT5TcaY4VYj3+puikxi9l/RKkmi6D2eFXCcIWQbm57v
         oxaH2bvxLgDJZa6gTRlIkp/Yn4x0zwignUgiQOsR57yZYiVP4cBfSNsc0kT8EfW4hI
         7fInkyanPOQB3WGVx1wMAQoGyNladzekWrswH0EDQGpbIjiQTopNP2EwC775ZIJq1p
         WIj3t6vw5g0IMFfeY3JRbVq3PrlLRrHmi54/dCKzmwiOygdJ8GVe0xCmXAGidHPZpd
         4HfaToau1V6j4SErE1rM/JAPHXoOu2P5u3EgPt29+toyNiPeEIHjWuL83U+ovW6c7K
         aB2quiESVBeug==
Date:   Wed, 25 May 2022 08:12:22 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID for 5.19
In-Reply-To: <CAHk-=wh91nMR037ps4B=AUOEemZVr_UKDdUmpSTpYGtV2909kw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2205250811140.28985@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm> <CAHk-=wh91nMR037ps4B=AUOEemZVr_UKDdUmpSTpYGtV2909kw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022, Linus Torvalds wrote:

> >   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022052401
> 
> I've pulled this as you can tell from the pr-tracker-bot reply, but
> please improve your merge messages.
> 
> Some of them are fine (eg that uclogic merge has explanation of what
> it does), but others really only say "Merge branch xyz into for-linus"
> with no actual information about what the branch does.

I usually skip the messages for merges that don't do anything substantial 
that'd be worth explicitly mentioning (like code cleanups or new device ID 
additions), but I surely can start adding a few words even for those.

-- 
Jiri Kosina
SUSE Labs

