Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5E47FB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhL0JZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0JZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:25:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BCC06173E;
        Mon, 27 Dec 2021 01:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45866B80E52;
        Mon, 27 Dec 2021 09:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B19C36AEA;
        Mon, 27 Dec 2021 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640597097;
        bh=VhAMTzfqT4nPDMeMeXGCtngnvYq0SzqyMIvYv1M34Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ai6cdS0TZbbgVYUmwE58iznh19EMwmYc57ERUhnv/Kv3YlsbIkTErYZTld+13K9uV
         1tmSrnWWU8P3sKyElOfUVtROAC592ozaFJoE+sG2TY43Byttz8QM4uzHWFyX5DwPhn
         gw5+hXfzBbX612ZmdIehi7VhraQArVYfrWXdPRIg=
Date:   Mon, 27 Dec 2021 10:24:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.17
Message-ID: <YcmGP8sgYhdFaxL4@kroah.com>
References: <20211223123334.22485-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123334.22485-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 02:33:34PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the 5.17-rc1 merge
> window. The highlight are drivers for 4 new platforms. The details are in
> the signed tag.
> 
> All patches have been in linux-next for more than a week. No issues have
> been reported so far. Please pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.17-rc1

Pulled and pushed out, thanks.

greg k-h
