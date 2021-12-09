Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731FB46F753
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhLIXVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:21:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E108C061746;
        Thu,  9 Dec 2021 15:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 824A8B82713;
        Thu,  9 Dec 2021 23:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE26C004DD;
        Thu,  9 Dec 2021 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639091857;
        bh=xYxQ2sEUPz3cBudfM1uJvOLpX3qfg8FKPJ7ncBv/TtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHU8X+dXD8BtY0zE5jqDqzYVde6ql5TbhKMLFS07euizCxxxIp5Y2vUy04ai6RCqU
         NS+xljLF0ipzmpWPKSqOQVmTpfRV07jKao0YrFAG+nCPwrNQmPGK8BK9iio980+808
         7gCHf4K5JhULbG2hwkAM9T2EjdzdwqJpPxwt4YUt5JGdEdGUu8Q6MbQ5nxBgr5oqar
         Y2Lv28JXc7OE3uJcA2dfQa96ezNInVY1EyNlNSJrRgTQIjh3usYy+51xaEMQpg4CPU
         YOSnejBtCu3uNSopdD46lhOvL1eL/EihNFgh58d+Cc1F/WN1uNbQ2TjBAjWAdmwOhE
         n6nN01et9uY9Q==
Date:   Thu, 9 Dec 2021 15:17:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/3] block: don't delete queue kobject before its
 children
Message-ID: <YbKOj3lBEdJLE8mr@sol.localdomain>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-3-ebiggers@kernel.org>
 <2a029611-10da-9114-b66b-345a68a5bd36@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a029611-10da-9114-b66b-345a68a5bd36@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:38:02PM -0800, Bart Van Assche wrote:
> On 12/7/21 5:35 PM, Eric Biggers wrote:
> > +	/* Now that all child objects were deleted, the queue can be deleted. */
> 
> Shouldn't the present tense be used above (were -> are)? Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

"deleted" is an action here, not a state.  I think it's fine as-is, but maybe
you would prefer the following?

	/* Now that we've deleted all child objects, we can delete the queue. */

- Eric
