Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB6589B83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiHDMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E751A0E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5E361791
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A125DC433C1;
        Thu,  4 Aug 2022 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659615165;
        bh=5j6l0nt318EKz9/7uCaut+EvSc5ptwxPnHwqudG8ZGI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YpTzvFuVCbkZYhFzZIxNe44dMshRX8zEFBf4GjrjO1Z3uDlT6viqsiQugtRjRxHQr
         TQ7aQcVTb5YVufbsFU0BK1ZN36mOQc3ACeWBoNvRdcz2ROpOEaws6I8uKMN3OFvTAI
         kXuFeJK1jYrAaR1leYy+kZdyLgLZvWsw2t1sDbjHfmqVkU/rX39+nVxBvqDV+rFQi3
         hK08/Rt9EIw7rAExVO9TMSu10C7v7KC5WiEVbKcA+PZtxwqy0CJsFg4d+8osWbs/27
         dI2MnvxlhFrY+qZTfKf3KZf4Jf6komPd0wEL+GjQJpsIZoX/V496CHtNw1PGn3LXeS
         3Uj9A27GDe9Aw==
Message-ID: <faa1560b-e25e-2a5a-1675-65a474c80cd8@kernel.org>
Date:   Thu, 4 Aug 2022 20:12:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: revive F2FS_IOC_ABORT_VOLATILE_WRITE
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220801170808.1692711-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220801170808.1692711-1-daeho43@gmail.com>
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

On 2022/8/2 1:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> F2FS_IOC_ABORT_VOLATILE_WRITE was used to abort a atomic write before.
> However it was removed accidentally. So revive it by changing the name,
> since volatile write had gone.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Fiexes: 7bc155fec5b3("f2fs: kill volatile write support")

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
