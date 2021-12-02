Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3921466651
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347541AbhLBPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:21:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41350 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhLBPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:20:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DA740CE2302;
        Thu,  2 Dec 2021 15:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFF4C00446;
        Thu,  2 Dec 2021 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638458250;
        bh=dqyYaDn/E5myyUzU2SJe2NF7iZJAZCHUH8VQYzT8BAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldSHS6kXZwEItru1cto2wJlhTP/yjfMp5/iPKInwpWyOTr91bQnnaWRQjIOh0AlNJ
         b2UlNafILQK+jrxHhHRiET7+HxdxQLZIAjwOGZsrdwIenV8KNs0R7d+D2VMxUE82eL
         MbCXFpvIAUdKhcwbWEXwxUHxClfN8fJwBYXpEheU=
Date:   Thu, 2 Dec 2021 16:17:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robert Munteanu <rombert@apache.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, tiwai@suse.com,
        regressions@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
Message-ID: <YajjhwMDkX2CyrQD@kroah.com>
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:55:44PM +0100, Robert Munteanu wrote:
> Hi,
> 
> After updating from kernel 5.14.11 to 5.14.14 I am seeing the following
> problem:

Can you run 'git bisect' between those kernel versions to get the
offending commit located?  It shouldn't take that long as there's not a
lot of changes there.

thanks,

greg k-h
