Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2507B46D20E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhLHLZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLHLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:25:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D3C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B86ACE2139
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D0CC341CE;
        Wed,  8 Dec 2021 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638962527;
        bh=5SCZDZx8rEnwxKyk8CGCVkI0WR9NMr7PX3XmVrOuKN4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TrH76gdUbxX5QchyiVOudntAXhYRDf/DqehtIGzzO4z8HVpn2Lx5+v7U8Z5g52MYd
         W/bmczM1WJCCUEnHvpMoSmpT907AZ7NQdqeNRw+/9wo+/zOyGkZy4CqySzYmq9e7wH
         qnyo+iyumOJJp2Yw2WxAsVdCSdgWqxc8trL1NNMF+TUSxHc8tm7FYSi/H6a42U+5hg
         HnhkN+y7zvQSMDY1KlfHOTNCenY52d8m/VRQVoVKz9yyANXr8T5BHJ0Kv/SzqnaJkz
         I4Qo2O2NN7v4IduBg3rSuGwMCJa1hqauAWj70po3U5GpCz/A9oRhYEW0MzXGdiwmA3
         iA5a4stIBO1Rg==
Message-ID: <660bd307-87eb-8b23-344e-b3cbac396665@kernel.org>
Date:   Wed, 8 Dec 2021 19:22:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid duplicate call of mark_inode_dirty
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211204190158.3158405-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211204190158.3158405-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/5 3:01, Jaegeuk Kim wrote:
> Let's check the condition first before set|clear bit.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
