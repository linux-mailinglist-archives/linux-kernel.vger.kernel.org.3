Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4314A4DBBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354127AbiCQAbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349258AbiCQAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDF61C93B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68009616F7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B221C340E9;
        Thu, 17 Mar 2022 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647476982;
        bh=Hdocd/5ZlPbFYEa5t6OfwSG3tyIiffmqWFq4OlJz3SY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jBP2BpDbQ15WLaUz/QzJoCvZIjel395dOCiKEaIEbWj2MePoYbwilxiPPIPQ72iIj
         hrjr0N16ew2FI1KZYBBBSQOGt09TthdSB54ivZm/gbivL9AsyYElF2R4atSgywtjIu
         4MpPlCXW09KhzKZK0ZzWEWvNWcNkzJOSHuMdnfmnAHeLlnTiSAczQbmHz+wltGCzav
         4mXs+TOiT0tJ809/sQHx/K4N48fmvv27vzYqynTs0WNcqgS8lnLN16x2l+lAnypf2V
         ER2kb/U9dyVtd/BszdIKmpIKTHJXr2SabdepeHlM62n49hjrIYSDdOL5/ygnbiPhbn
         Fl8GLzOHwt9Qg==
Message-ID: <bfce3a4d-b937-de8e-84c9-418f34e3a0e0@kernel.org>
Date:   Thu, 17 Mar 2022 08:29:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce gc_urgent_mid mode
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220316041414.1738616-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220316041414.1738616-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 12:14, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need a mid level of gc urgent mode to do GC forcibly in a period
> of given gc_urgent_sleep_time, but not like using greedy GC approach
> and switching to SSR mode such as gc urgent high mode. This can be
> used for more aggressive periodic storage clean up.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
