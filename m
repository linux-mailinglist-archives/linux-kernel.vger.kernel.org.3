Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B375774F0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiGQHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:23:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF61835A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39E67B80D1D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20969C3411E;
        Sun, 17 Jul 2022 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658042608;
        bh=s8rXbFsbsWSW4DLeRPcbLqxDQ+kDUrSs5IV2B3SPpoM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=lQUlzztexfj5dkcTO3Ql7Q24+k6QaY9mtco/H7/qq4+v+GB5ZUbH9eUGZulAH1DLG
         IUhMQYQHXaX1SUA3CVhPvJf7Je95nYopGCujYd3FIfEJkl07LFnavhqeOO/3gzyevq
         bs0/YOyPEtvO5oT8c+J4fwlqRpBzfIBeJIW+JcQ14bunSrSMWI3xKBWP5pE3ZDllJ2
         3/5M4A3B/hIejmnpyNYXZzHI1thwwriTLdeyfHqfNi7Uk3eoNYjxNsNUMaZ+RUBUl6
         MbSlTx7we5gXxEw9qvAxZFDIlUMPzpl+WNg8UEA6KeIXoxRZORU7YhqjF6932VKnXY
         pRhnsXpD9hWyA==
Message-ID: <feac68ff-c70f-fe7d-bc5a-63e53dad9a2b@kernel.org>
Date:   Sun, 17 Jul 2022 15:23:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: adjust zone capacity when
 considering valid block count
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220628234733.3330502-1-jaegeuk@kernel.org>
 <20220628234733.3330502-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220628234733.3330502-2-jaegeuk@kernel.org>
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

On 2022/6/29 7:47, Jaegeuk Kim wrote:
> This patch fixes counting unusable blocks set by zone capacity when
> checking the valid block count in a section.

Good catch!

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
