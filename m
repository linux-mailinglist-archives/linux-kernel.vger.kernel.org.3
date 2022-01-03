Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78F4831A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiACOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:01:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6320C061761;
        Mon,  3 Jan 2022 06:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E89B0CE1102;
        Mon,  3 Jan 2022 14:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC19C36AED;
        Mon,  3 Jan 2022 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641218492;
        bh=YFKYMANxHUBm2ZkV0SrjcH7TDlxFufpUx29gN13fwLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5RM6ASmxjqaZYuKFqBFtLm+zqCxLYJ9pE273n2wa9O5qD9NuLzFcLThIe8h4w1jN
         M9HDjydI/d4w7i9DQsaxEUQFhZ/kplVhKeIPPy/c6IyEj785c6LKpmuQCTJhHxPUov
         sNOQyZWrynavuN76Y1tM5oamE05tSDo94kXvROFE=
Date:   Mon, 3 Jan 2022 15:01:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/2] docs: add a document dedicated to regressions
Message-ID: <YdMBub0ugeNIOTI2@kroah.com>
References: <cover.1641203216.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641203216.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 10:50:49AM +0100, Thorsten Leemhuis wrote:
> 'We don't cause regressions' might be the first rule of kernel development, but
> it and other aspects of regressions nevertheless are hardly described in the
> Linux kernel's documentation. These patches change this by creating a document
> dedicated to the topic.
> 
> The second patch could easily be folded into the first one, but I kept it
> separate, as it might be a bit controversial. This also allows the patch
> description to explain some backgrounds for this part of the text. Additionally,
> ACKs and Reviewed-by tags can be collected separately this way.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

