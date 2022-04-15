Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378650276D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351750AbiDOJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiDOJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F64674FA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAC06207E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3AAC385A6;
        Fri, 15 Apr 2022 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650015192;
        bh=6u7TYuQ7weOypGJkP6bl3bYHJlq3pb9zPmXx8u5MZTQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jYth1qlSNELLiQ77SD55B61KQA8qKZNCGH4eeI610PF658j6Bbd27mAzpAAdpzcoP
         ym1Oqz9AQYtiuJk1XZx7Bb9rEVx4HftG1A39SbZAcW6f6cH6Zan8ikJRM5zEgjRkdv
         45M94vVrYxleIukwB3Vrmg+8JbtO2aP6wlCSe0+pplPBLygVv17wdCCkFvyWSSzr1e
         HbJArlReu/eM39FFo7jriwNKkjCtK5DZcY8FegDphBVsxlYjxSJTQyhOS/5c8i1riU
         oaEhn+gRbWWQmVTBw3Mv1o4EZkM8fGIrSYFIBeN3S16ln29g2bCmiZlEDuEcDIPSKM
         wyGmwPBnnWylQ==
Message-ID: <dc6e857f-68bd-2028-35cb-ebb34d5facba@kernel.org>
Date:   Fri, 15 Apr 2022 17:33:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] f2fs: Fix signedness bugs in f2fs_gc_pinned_control
 functions
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 16:49, Jiapeng Chong wrote:
> Fix the following smatch warning:
> 
> fs/f2fs/gc.c:688 f2fs_gc_pinned_control() warn: signedness bug returning
> '(-16)'.

Oops, thanks for catching this...

It's better to merge this patch into original patch, if you don't mind?

Thanks,

