Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1511F4E212D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiCUHVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiCUHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8D4D9D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB8B8B80F03
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD2FC340E8;
        Mon, 21 Mar 2022 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647847222;
        bh=X01V1jvi1hwJYC/3cIWgPiSEexz6hipgqZUepTSMngc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JEGoKuzf8BFGfgtf4oT5RcZH71zz2eJ/YWPYKKexodh+XmtXDmym3pMluhIunM6Iq
         xI+sY1O6NPrzfPxn6Cr7vNIb3XKAHiQFHZpHbq6+6lS5rS25qb4+ZnlObIUI6uIHQp
         PzeQUYZSXjhuzSimwJVklQ3drgpVKj5yFFB4zlwUbKXQ8hHV7J+uS/Y3GfxYoguNPx
         kLK8qbUy5wWh97eMmMgyxzu0oJQG+HbcAROcmtPZEYLYjHgo2BLvBG1BYIutfm/z9p
         bAwzmrHJ7bUXcm9tV0Xlqg5ZZ/naeM97/HEio+4ddkvIiCJUulyAyZ7JSV+aW8pBqi
         FPyTVJwB0WqXg==
Message-ID: <3950654e-885a-e298-b553-64a63b7ab1ee@kernel.org>
Date:   Mon, 21 Mar 2022 15:20:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: make gc_urgent and gc_segment_mode sysfs
 node readable
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220318191323.4167565-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220318191323.4167565-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/19 3:13, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Changed a way of showing values of them to use strings.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
