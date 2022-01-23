Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5675B49709F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 09:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiAWIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 03:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiAWIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 03:52:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA6AC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 00:52:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF11EB80B2A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70560C340E2;
        Sun, 23 Jan 2022 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642927961;
        bh=NYsqCCt90fQdzerQuxJfqP64AtikesjKGjnT+TX77jM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=coeRNDIOzh6gBvra5K6VTCV60+ax8efalm/FFgnQcqJfCkR6iRVaYlwtUgn+MmF9J
         +G7qVm2q33VArHo+1aoyvFJbmtMxInlg0YuFDn8D8CKRGrkyRDS/cGNFWnKKMl+D3M
         8JzMMQMH30RKeViHql7c/PfYJH0hQl8FKZucjLdzf5viuu8vwlpw0nfS09nwblYQwl
         sGluMxfqKUgJI2aBqFOp5bNmO5O4+lOMAZ7KNcuIQRieiVI5hyyReQgsrhjHt9Paot
         vh+ymx5g+30EMuaqZuHfX2zXReH4DgZTInerOUYI0veTS9VJwmQAdgPzlH3DkFC1Zs
         dY5+kAaAj/c8A==
Message-ID: <5e2dcf6b-b2a2-868a-9287-3482c4a2287d@kernel.org>
Date:   Sun, 23 Jan 2022 16:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] f2fs: fix fileattr_set unsupported attribute handling
Content-Language: en-US
To:     Harry Austen <harryausten@hotmail.co.uk>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/22 20:59, Harry Austen wrote:
> FS_IOC_SETFLAGS ioctl should return EOPNOTSUPP if the file attribute
> (e.g. FS_NOCOW_FL) is not supported, rather than silently ignoring it
> and returning success.
> 
> Fixes: 9b1bb01c8ae7 (f2fs: convert to fileattr)
> Signed-off-by: Harry Austen <harryausten@hotmail.co.uk>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
