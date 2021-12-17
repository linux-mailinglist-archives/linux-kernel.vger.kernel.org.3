Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50864781FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhLQBMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:12:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLQBMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:12:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 026D4B82681
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB51C36AE0;
        Fri, 17 Dec 2021 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639703558;
        bh=dNEoYEQgjj/zA52x4TpNaVzOp8rqbZ3g+gwju71c1yY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RsYt1dh9l+cW+2LV8c+4GZPm5wPN4dUi4gsocaAjGENWnsa08X6cuOTRAYzPO+bhw
         O7s4h/P+up6O+1QEZDU/4XkDrdEofwGHFva5+dC7I22vO9nGynm0OO0IroxBFU6Hwg
         BVEX1cxwcRzpIv3EqBfc3uWsFtVCi+W5rjLtTEwyilvg6dSSwnm9WgzGuhbQphI3rO
         kvoX1eCRtTLLTW+JO+nfxk5as+R3tJmIQrCScTUAETpUFGrwImXU0MenyY0S+oZ+Vs
         el8pDk5hatdP4MP9XgCEkIRUiFJhHOG7bIf5uCCtL3ohNdR//iig7PjgUHQm9ThnRR
         zhmPfkJRaObeg==
Message-ID: <7e51b00a-ae83-66d1-8f0e-920423ac7fa7@kernel.org>
Date:   Fri, 17 Dec 2021 09:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -next] f2fs: Simplify bool conversion
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/15 10:38, Yang Li wrote:
> Fix the following coccicheck warning:
> ./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for fixing this issue, do you mind merging this fix into original patch?

Thanks,
