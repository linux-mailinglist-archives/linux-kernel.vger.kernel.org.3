Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E7485366
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiAENUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiAENUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:20:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B9C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 05:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C04B6172F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A623C36AE0;
        Wed,  5 Jan 2022 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641388807;
        bh=5DYH+Xsmw1j55OhJ3f6OPmp1X9UKdjHNAC16Jtgw5gI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l7vKgxPg1dyrBfvf1QiQ0MXjJmF8PkGXAQhkifQaofH5oCJqLv3JwvkkHAbolQDuG
         5srUtVayyFIiPOp9ZLT9kVYgvYHRQnd+nEbMr1r2m0bLPUZxDiJhUiHub80vCfM1Zu
         IqJpW17+RQwQppsxTO0vvJB7/5lOEaOr05G+KEpU24ylKpXijubkJwoxf5/n+pL1mM
         JCnJaedIxvgMUJdvb3kcee03/LHWgEHixIID3tasELG/9rkHT86zBJhILHiZK7UeYU
         WEXqNvOtThmRHZZ+nNMlfvE9RoBLQl1NjSWkhT6IPak1i/JVSfHVlSYmcLlvO6tnqO
         iSRDMpA0+VgvQ==
Message-ID: <f8c0d9f8-6a1f-e7b7-4dd3-fcd31272a0df@kernel.org>
Date:   Wed, 5 Jan 2022 21:20:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-5-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220104212419.1879225-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/5 5:24, Jaegeuk Kim wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
> use iomap for direct I/O.
> 
> Note that this may be used for other things besides direct I/O in the
> future; however, for now I've only tested it for direct I/O.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
