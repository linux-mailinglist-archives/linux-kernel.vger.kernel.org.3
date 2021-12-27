Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09847FB53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhL0J3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:29:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40926 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0J3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:29:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC580B80DE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 09:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FD5C36AEA;
        Mon, 27 Dec 2021 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640597385;
        bh=sFGXAEEhqJdRNlJmljaOTBe+TDaEnYD/8uai49rdYtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NumuIB4egjfbKGk30/n46d/oNi/XZ/nqKBTLSF+xO6D/tgNkPfb+ufAzZSYPQw2vu
         71NAXetc2TgrRAKBK24oCe8xWmuTJfJQE7u+HfxWNGqYfVGZ9xjpq1+683bU4inNlt
         SEwL1fQtW0PQhv7KLh3+3NZP/pTEp+DldT1Iwjz0=
Date:   Mon, 27 Dec 2021 10:28:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.17
Message-ID: <YcmHWkb+eit8OZJl@kroah.com>
References: <20211227080350.GA469126@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227080350.GA469126@ogabbay-vm-u20.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 10:03:50AM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.17.
> It mainly enhances the driver to deal with extreme cases, such as
> reset-during-reset, events during reset and allowing monitoring
> applications to continue running during reset.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 1bb866dcb8cf5054de88f592fc0ec1f275ad9d63:
> 
>   Merge tag 'iio-for-5.17a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2021-12-22 12:33:01 +0100)

Pulled and pushed out, thanks.

greg k-h
