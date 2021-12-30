Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885734818F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhL3D3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:29:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51122 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3D3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:29:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2A8B81AA0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF7CC36AE7;
        Thu, 30 Dec 2021 03:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640834979;
        bh=/MHAZ0T++Ohsl1IAW4FV+tbuCr4SJG0o5acbueps7WY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=etRGCZLm1ht++MQrzF50w9Jkc5Tf5JXMNnfQgMoZl5OwkQOwObdAopRt1atPPUKMY
         Zm6JeguIxZ0zL8wKPee0GScIGqCxw10LsqOJkrcfQrBhxxMeRtWxD2uv40R5ITUm1G
         oXc8/rPkVxwMBbTw35V8+GRIvMDGdv3nh0O1YN9qbmItXf+AisdILAzg8MfpSwiKdr
         xzEkuL2CPQruU9ubCrS1myB9FaVM32MpjdmpNkFo3KtmcjBcvo41ed6dCYiwfcrpkr
         20mtE5yuXXU0ymGva5D9sNX03qG1tZVbu775vBS+p4RHFFsiOSrHW9tvTCbaS/EMr8
         L0mtBIoLvKdYg==
Message-ID: <04f184a7-3c34-0dd7-4bac-3815ebeaba10@kernel.org>
Date:   Thu, 30 Dec 2021 11:29:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 4/5] erofs: support inline data decompression
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-5-hsiangkao@linux.alibaba.com>
 <20211228232919.21413-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211228232919.21413-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/29 7:29, Gao Xiang wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, we have already support tail-packing inline for
> uncompressed file, let's also implement this for compressed
> files to save I/Os and storage space.
> 
> Different from normal pclusters, compressed data is available
> in advance because of other metadata I/Os. Therefore, they
> directly move into the bypass queue without extra I/O submission.
> 
> It's the last compression feature before folio/subpage support.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
