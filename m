Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EB589CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiHDNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiHDNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:42:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6CE39B98
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78BE4B82431
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77679C433C1;
        Thu,  4 Aug 2022 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659620535;
        bh=/XC5S4YiMuClwldjj+UXqlc4TOiJVqClkgdfFwzoNSo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=me97mjwwtm8931nbsJzE5o4eIJ/uGRgfJEEh72ynWwhWgzLUHhEVSZjqrQcIM4BFC
         rKGV6yDH1JgIWmE3ogCBThjOSbZsGD3MVMQVnauR2IKajnk9huT/gQPTUmkKeDTpwR
         O78L7WlAyEprpkIyaZ7o0PFbS1AYB0GE2plcbRn9+ACx+fSRc0DF7BwwLwToR0l+7F
         BEOItp4getVa226gkMY0V+zqEoU6bbIEzbBXIzoTZ18wxW3+ZafVUCMT7AB/h8Xt7h
         XXnbU6mGdw/UhlZIDMhhA12WahtnUWP8iGiSxzqjdTswcYo5K6KOiLhIsSljq1rt6m
         FHk/rifJkiDew==
Message-ID: <0b07d2ae-b3c0-1b13-37d0-068a342c7b8f@kernel.org>
Date:   Thu, 4 Aug 2022 21:42:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not set compression bit if kernel
 doesn't support
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220804034146.3357114-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220804034146.3357114-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/4 11:41, Jaegeuk Kim wrote:
> If kernel doesn't have CONFIG_F2FS_FS_COMPRESSION, a file having FS_COMPR_FL via
> ioctl(FS_IOC_SETFLAGS) is unaccessible due to f2fs_is_compress_backend_ready().
> Let's avoid it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
