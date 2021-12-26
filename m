Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD13C47F675
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhLZKqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhLZKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:46:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2755C06173E;
        Sun, 26 Dec 2021 02:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF9ADB80DAC;
        Sun, 26 Dec 2021 10:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5595C36AE9;
        Sun, 26 Dec 2021 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640515557;
        bh=4X28jzWzEwgR4JdUV10LGAj76HzzQjNGXMTmeuHvMTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9uewQ8Fup9Ccevrtih0gAOw7rogOkjW+aht6PTbxGAHlNUghaTKlB4Tni/4AmyHn
         ILXZ3jN5LI8xf4gqRxghIry6IeN9yOsr4+V8DMihNQBf6IA6hGtAA7fcvcTz9Jf33f
         7/eswH8a94xxsn8DYs2tVFt+X+yzqJXyBm1koWsE=
Date:   Sun, 26 Dec 2021 11:45:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        xuzaibo@huawei.com
Subject: Re: [PATCH 1/3] Documentation: update debugfs doc for Hisilicon SEC
Message-ID: <YchH4g+mhfRQKXoX@kroah.com>
References: <20211225062718.41155-1-yekai13@huawei.com>
 <20211225062718.41155-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211225062718.41155-2-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 02:27:16PM +0800, Kai Ye wrote:
> Update documentation describing DebugFS for function's QoS limiting.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  Documentation/ABI/testing/debugfs-hisi-sec | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
> index 85feb4408e0f..9e50ceab94d2 100644
> --- a/Documentation/ABI/testing/debugfs-hisi-sec
> +++ b/Documentation/ABI/testing/debugfs-hisi-sec
> @@ -14,6 +14,16 @@ Description:    One SEC controller has one PF and multiple VFs, each function
>  		qm refers to.
>  		Only available for PF.
>  
> +What:           /sys/kernel/debug/hisi_sec2/<bdf>/alg_qos
> +Date:           Jun 2021
> +Contact:        linux-crypto@vger.kernel.org

No tabs?  Why not?

thanks,

greg k-h
