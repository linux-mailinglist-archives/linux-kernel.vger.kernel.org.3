Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7547F9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 03:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhL0C06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 21:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0C05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:26:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A23FC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 18:26:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0691CE0DC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE7EC36AE8;
        Mon, 27 Dec 2021 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640572013;
        bh=SkwoH0pcS6jBuRjzm7Hv7BMeiIl1c9ow9BrQdEKuqVE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hHI1kTM7XHXzx+r41zLGVnuu8HYDv3bRJ8atfPDRbantqI4XFUOFeUoJaMxOdIlbo
         IQgO8Skt955qDaGaZQBP8TQ9kXiaXHiqG23jzFZkRK2gnNYvez/9d72cnjo7Bx59F5
         4XXu2Xbur3554jB2CgzxUhtDqhtnnJfyjqhJiLJLrLHGTTMhOHl1wpuA9jC2fcNPvo
         hxs0ekOyRp9HSt9QmxCFIX1rmO9+iPqiBscCNT8Yv7C7lyrJGG1jmCryaXjFce2eD7
         7B0XqvMlHAbEXXmQZghiSg1WSqlb1Qt3fAIyKejMd2UZw6NfNq4QuMV1VtkmsBoXHd
         g0jV2HtIH7nnw==
Message-ID: <872ff3d8-199b-8272-234d-c05075afe619@kernel.org>
Date:   Mon, 27 Dec 2021 10:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/5] erofs: introduce z_erofs_fixup_insize
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-3-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211225070626.74080-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/25 15:06, Gao Xiang wrote:
> To prepare for the upcoming ztailpacking feature, introduce
> z_erofs_fixup_insize() and pageofs_in to wrap up the process
> to get the exact compressed size via zero padding.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
