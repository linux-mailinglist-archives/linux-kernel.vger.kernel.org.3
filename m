Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6051BDED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354957AbiEELZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiEELZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37F4EF56
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4064C61CE6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43AFC385A4;
        Thu,  5 May 2022 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651749699;
        bh=IEGwp11v+XWOBcZIXxbJqS0+XkO/ZxJHw7PTpy7YXkw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uVWDH1F/bcDYSL1K2jAVsYwx5/Ue4/zMDYq9RD86PXqERhK1OvBTv9DZj0aZeU32u
         s3ibzjOX01kkdrb6lMVU++JepDSZVluYjc+w4G6rjtEZClVWi3WF1nvSQZ+xkvG3Vv
         NOB8Sj6qjI3Eh6Q4/WTxhjSCewUafhzC1gr7lN/36QzmPcc6Wir5tNyOuFpx4+i6BX
         iZLgMy5pkSVqlZGgPScNzsa4G66WoblShQXl7sOeAHYCfuqsAV1cijYohwCq2INy0e
         Ps6PJ/Co7z/i8BBeROx22t4vn9OJjT1jL3jT65bFjZ5/7sslKdgLIO5ohFy7oQ0gMr
         6ILJoijzSFQQg==
Message-ID: <5157b1b3-520a-769c-b031-5a9d1f7039dc@kernel.org>
Date:   Thu, 5 May 2022 19:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: write checkpoint during FG_GC
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Byungki Lee <dominicus79@gmail.com>
References: <20220503203040.365028-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220503203040.365028-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 4:30, Jaegeuk Kim wrote:
> From: Byungki Lee <dominicus79@gmail.com>
> 
> If there's not enough free sections each of which consistis of large segments,
> we can hit no free section for upcoming section allocation. Let's reclaim some
> prefree segments by writing checkpoints.
> 
> Signed-off-by: Byungki Lee <dominicus79@gmail.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
