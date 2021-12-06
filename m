Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB74690CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhLFH26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:28:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44318 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhLFH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:28:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED8A3B80FD4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7692DC341C1;
        Mon,  6 Dec 2021 07:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638775524;
        bh=QScjGn6TlXlzpIV3HO3Tk5k3eOowZMSZ03IK2zhZfEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDHGg/ET1ZMbW1bVHYahK6mGmYTHqxwWEG53MHPb1bpXw3EDiQ2JyRm0of2eX7PHV
         NUl1XnLtanCXbQ39bbzZa9NLR9oKje8ixl88681wdqgvOOodOlEqAzPSd+yw7r+ozG
         16Gh1CTEziIqMn2e3hHzomBO5RbDphZgKH6jRg84=
Date:   Mon, 6 Dec 2021 08:25:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2] uacce: use sysfs_emit instead of sprintf
Message-ID: <Ya264Nd3nfuHeZF0@kroah.com>
References: <20211206070943.45971-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206070943.45971-1-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:09:43PM +0800, Kai Ye wrote:
> Use the sysfs_emit to replace sprintf. sprintf may cause
> output defect in sysfs content, it is better to use new
> added sysfs_emit function which knows the size of the
> temporary buffer.

For these calls you have replaced, there is no real reason to change as
it is obvious that the buffer is big enough.  So there is no "may cause
output defect" here.

Also, feel free to use the full 72 columns for your changelog text.

> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> 
> changes v1->v2:
> 	modfiy the comments.
> ---

As per the documentation, the "changes..." lines go below the --- line
so that git will remove them automatically.

Please fix up and resend a v3.

thanks,

greg k-h
