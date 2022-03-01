Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB504C8126
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiCACtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCACtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1646166
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:48:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5DF361604
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8820C34100;
        Tue,  1 Mar 2022 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646102916;
        bh=G2d75bdlzRrheNLw7+a1JdKZGmhfjGIrrcOU2ZLlt64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZP0VHhiZ6mI1LuF2JJbqQJcdj2lKsN2n7h+UA9P4yB3psb9IsRIVXUmNOaWZbBxkX
         nEE/H1m3ijo7ABJKlx7SCh/CXZKx2ck5zce2gaspIP1hj2ljHt9U12kS3Jiq3MWh/1
         UQ96GLAEC7nGJM/1I4/smtoQCiCZ7UOPzMXRh+9lbLeBUzBrMvVirFMKQS/j+op3oI
         ZT8zT6AzS5LQ+OQ9I0/BNyKCwipLLHPGz2QShRrzRA5qyXNJAPm9nns91uRafkc86t
         WXuMnFzSjS8Cgc2zwNuXmxSnE/9i3hFi6lvGLfoa060AVAj/0NSDuWo4d+wfodoaUy
         VhcQJYwUjgu6Q==
Message-ID: <32114417-fd17-9412-28da-10f0ff09530d@kernel.org>
Date:   Tue, 1 Mar 2022 10:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] f2fs: don't pass a bio to f2fs_target_device
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-2-hch@lst.de>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220228124123.856027-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/28 20:41, Christoph Hellwig wrote:
> Set the bdev at bio allocation time by changing the f2fs_target_device
> calling conventions, so that no bio needs to be passed in.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
