Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBE502FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350393AbiDOUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiDOUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:30:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0498B8878E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7DCEB82FB0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F91C385A4;
        Fri, 15 Apr 2022 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650054499;
        bh=5LhCldaKUglJbfoWnEQxZzw+7Zmu3f9fJ46Dxq5veQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVDLpEtc/GTYhd8fugVuHefpB+lgG4aazDY3FeL0jHIUXwc8T3QDeqjq0fBcgYcSQ
         DrGJ+YnEv8Fr/CW4Y5qw9n80ZYIR7B3sNP/0k50Husd2kTiEAhZC+rwdJnE3cYAfkM
         6GaTYE8zEccEfJSbz5rS8GVATfwl4n+EFYtXX0ZiPXdO8MC2+I2vdNjFJl0JoAn8sH
         qOoOJonCvYOBDBWZLIVjC/i1ArC8etnHObYQurMKLjG9yurB6A0GuAVwjn13pAGMiO
         LUe0VCQgk94PUzXnpu/jlMsyJngKXRFyGCdXlS2oEJadRq5xgYvb+ozuUNI6Jk40DX
         6TL0x6N71KVHQ==
Date:   Fri, 15 Apr 2022 13:28:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] f2fs: Fix signedness bugs in f2fs_gc_pinned_control
 functions
Message-ID: <YlnVYb34gNtFcQzt@google.com>
References: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
 <dc6e857f-68bd-2028-35cb-ebb34d5facba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6e857f-68bd-2028-35cb-ebb34d5facba@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Chao Yu wrote:
> On 2022/4/15 16:49, Jiapeng Chong wrote:
> > Fix the following smatch warning:
> > 
> > fs/f2fs/gc.c:688 f2fs_gc_pinned_control() warn: signedness bug returning
> > '(-16)'.
> 
> Oops, thanks for catching this...
> 
> It's better to merge this patch into original patch, if you don't mind?

Applied.

> 
> Thanks,
