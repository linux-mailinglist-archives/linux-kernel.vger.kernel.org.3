Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6295466F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbiFJM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiFJM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5345FD770E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E370C612CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F831C34114;
        Fri, 10 Jun 2022 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654865784;
        bh=iRFjxovy5CkuRcx0ELJUlqBRymqdTN/K1av4ME90rVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ecATqeS8mHeey0vP4Cx4xZFO7etlCt711IK81DDRdNIOFj3WPV/yXlfB9/0StOZJU
         e4AFiYQKmYLVSW9KY5uux8J1lcexZ3KN8fM75sy6Z2RytfdFvgfH6+qvVEvWph2QDw
         21zKbBDVMwN5NF+WJuWC/oDMGFYbu2Ebzgz/niE89uhqXdSZoIImtijQpjg1fFED7p
         6JcjWbwEeYu0z+I8d3h0jY2fC1c/GWHW7RHUyE0EuPQuA4Y0b0zDRdNgN0mZ6j6Cxj
         UIdYpeJERKLzOytErKXaVRgQ774cPO6iFk2P70THuHRsy4xAAZCG0J5DI7AOJRySqV
         35JLcAwUy5A7w==
Message-ID: <cee0d433-6908-0824-acc3-05c1387ce448@kernel.org>
Date:   Fri, 10 Jun 2022 20:56:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] f2fs: refine comments for inline flags
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220602072449.998303-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220602072449.998303-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/2 15:24, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Currently, we use f2fs_has_inline_xattr() to check whether the
> inode can store inline xattr. However, it might be misinterpreted
> as the inode has at least one inline xattr.
> 
> The same is true for f2fs_has_inline_data() and
> f2fs_has_inline_dentry(). To be more intuitive and specific,
> refine comments of inline flags.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
