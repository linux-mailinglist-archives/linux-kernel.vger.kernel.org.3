Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD07533515
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbiEYB7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiEYB7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770056C2D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA874614EE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B2FC34100;
        Wed, 25 May 2022 01:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653443979;
        bh=XjmXm7nrnLES/MEJ9AdsYRA3wQbvOl6+CmiwIjSNZHk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VnvMC35gUOYsOp5u5wfRFSI+qmAczcnTF0zCByyJZhoBE4T3ZI46nIq9ZugWBkyV8
         U1kXZjhohgMGPd0Bf0Vv+1c/qI8xjcx+xjNKP2330rr6QD48ihCTIlu8EiGr0U/Gwh
         atOvkTWNxuzIQ3UHU2JSJTcLN7w772EMX678Z+Z60xvTb1f9JXw4TlIH1Xnbm/Yi5K
         hubre4f3Ud56IgPT6hHDWjh9WkAz6HpdNsyzC7K4EcABJGpXjGaPAf+1BsqbcrdGRa
         Uo+FpGV3e6FITr6g5enOM4riDGoudENe2/7wVGFIniLvxL/JnbOCwFBwC4uNsAkR3e
         DDttGd/S9sxMw==
Message-ID: <699928df-b43a-aa9f-c0b2-48308dfc5d02@kernel.org>
Date:   Wed, 25 May 2022 09:59:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] f2fs: allow compression for mmap files in
 compress_mode=user
Content-Language: en-US
To:     Sungjong Seo <sj1557.seo@samsung.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, daehojeong@google.com
References: <CGME20220524022214epcas1p28d7b7de846e44cedf825eb4f5973932d@epcas1p2.samsung.com>
 <20220524012911.725783-1-sj1557.seo@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220524012911.725783-1-sj1557.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/24 9:29, Sungjong Seo wrote:
> Since commit e3c548323d32 ("f2fs: let's allow compression for mmap files"),
> it has been allowed to compress mmap files. However, in compress_mode=user,
> it is not allowed yet. To keep the same concept in both compress_modes,
> f2fs_ioc_(de)compress_file() should also allow it.
> 
> Let's remove checking mmap files in f2fs_ioc_(de)compress_file() so that
> the compression for mmap files is also allowed in compress_mode=user.
> 
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
