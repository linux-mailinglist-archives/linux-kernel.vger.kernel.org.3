Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAF34CAF3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiCBUA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiCBUA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:00:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3CC1C96
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:59:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00813B8215D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C57C004E1;
        Wed,  2 Mar 2022 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646251180;
        bh=cPto51IUsodLLQ4d6UJ8qZDMzV0zrvpcHqkBWSSdXp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0epykNXgf1/rS0GnbmqWXBMGarXZFEZobMVVSUsfPcsRsxEW8PgOcQCWBAwHsqfnJ
         p7SzMCBQjCLGhUdZKI8aNkYVp8RfZ0gxBDaBKn7xXcekmFB5vESRyRKGAT0hP2/h9Y
         fd16A8k6Fyw+ce+/tvaUhLF5lZcGBWaYMr7avzt4=
Date:   Wed, 2 Mar 2022 11:59:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Jean Delvare <jdelvare@suse.de>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3] tmpfs: support for file creation time
Message-Id: <20220302115939.61896f0806c8b1c89e22ab56@linux-foundation.org>
In-Reply-To: <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
References: <20220211213628.GA1919658@xavier-xps>
        <20220211213628.GA1919658@xavier-xps>
        <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 11:43:02 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Feb 28, 2022 at 12:43 AM Xavier Roche <xavier.roche@algolia.com> wrote:
> >
> > Various filesystems (including ext4) now support file creation time.
> > This patch adds such support for tmpfs-based filesystems.
> 
> What's the odd huge-page noise in this patch?

I can't see such changes?

This v3 patch is the v2 patch plus Hugh's changes
(https://lkml.kernel.org/r/b954973a-b8d1-cab8-63bd-6ea8063de3@google.com).

I won't be merging v3 because this changelog lacks appropriate
decription of Hugh's changes and lacks a Link: tag to Hugh's change.


