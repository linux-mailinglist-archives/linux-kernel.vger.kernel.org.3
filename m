Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB486497A96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiAXIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiAXIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:47:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685BC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D5E8B80E91
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8791C340E1;
        Mon, 24 Jan 2022 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643014068;
        bh=HZnUCYDMYPExwgg8l+2jKgG2vC3k8LkS337NzZjY9ow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VFN/jRr3qc85voQcohH3lFZn4SfTddsIg5JiyZJUafhLLo/hjVpaQgCgt6/hANh2b
         cVqydYjIyfc1OfVSM/1jNkO4djf+Nnbt3ddigda4dUO6mynA0lqE/IotzoIb9UuDgA
         n/6D1uqgQ8JgHuWnY5Sqs+pXMhA8jxuqreD1XX1EPL/nf0kAfKcEZs7zcAqfX0BZ0x
         XaSqHfWE/DV0bHYqyJEC2JHwjJEy8HtuPlgXtovuQOqUTdm26F0PhxGsDe5U31Zm2Y
         NWIsn70jJBOQCIwu4xh06UBXzyo9J+y4aKM4HCg82xBbOU/QIOFBORXuLVRQ8tH4ET
         ADBpF4hOJUsdw==
Message-ID: <280ffeb4-4145-79c6-d8b8-081cab0ba1b0@kernel.org>
Date:   Mon, 24 Jan 2022 16:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] erofs: avoid unnecessary z_erofs_decompressqueue_work()
 declaration
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/21 17:14, Gao Xiang wrote:
> Just code rearrange. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
