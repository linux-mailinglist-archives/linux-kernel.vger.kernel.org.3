Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7D4720F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhLMGKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhLMGKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:10:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11094C06173F;
        Sun, 12 Dec 2021 22:10:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4E678CE0B0B;
        Mon, 13 Dec 2021 06:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EC1C00446;
        Mon, 13 Dec 2021 06:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639375850;
        bh=JN4dssyGpKnQ7oek17KavvX+yDdx4JvxmSAJzAs7p/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPq12Vjo110FkvjRD6pp3kiMDFSQEvUUQLz5qJKvmvjKVjQT72aNbENqDBVoFfU0X
         3m3z20VH33k8rNAsBuTgsBTv5IqgEpLQBkcR00UDKt21RUQTa3zM1F4C+B0QX4MvTB
         jVFBDGxbXWkbWk/udQIu4/VC9j+hU3Vb97IIYRBg=
Date:   Mon, 13 Dec 2021 07:10:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel <xkernel.wang@foxmail.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: check the return value of kmemdup()
Message-ID: <Ybbj470ocCf7bj68@kroah.com>
References: <tencent_1AB342AE1B4723454E78A4D2FD3F33C81306@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1AB342AE1B4723454E78A4D2FD3F33C81306@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:51:33AM +0800, xkernel wrote:
> kmemdup() return NULL when some internal memory errors happen, it is
> better to check the return value of it. Otherwise, some memory errors
> will not be catched in time and may further result in wrong memory
> access.
> 
> Signed-off-by: xkernel <xkernel.wang@foxmail.com>

Please use your "full" name, I doubt you sign documents as "xkernel". :)

thanks,

greg k-h
