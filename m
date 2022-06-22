Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929ED55534A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359157AbiFVSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359813AbiFVSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6EA3B01C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4D761CFE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8979C3411D;
        Wed, 22 Jun 2022 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655922684;
        bh=pzH6hj8j/kFXqthSTB8eJImhhYfeX2wo3uou69fArlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rv6ljAbirYNV2k94rRc26evmnqJIAnJNJoycxA2L5Zlo6narzRjbeOpTv7A/X6xtm
         2uFz59QZjmIouAN8kTlT5RfGOJPj5fQc7W+ex6kezvH47KK0x1VCCUuxONAe1oX0TL
         n/VRBNrevI6g0knfHIHWLJG85wKFjpYNs03TEu/r8lNrH+GRb/BJt8UXiQe6OixWiv
         JHL4eFjKpgDlgyOTge3E6tgbkkS0pcaSQ4jpn9SO1XJCmrS4ibrZ0dBB7Ttm03iXwZ
         LpZqG5LGlsWQRAKro3Ci9c+Uk0KNeKSJ/vOGW1LqxQ/jaKRHHr0JLl6dsRAppxyZmy
         3xsg7mKkNAOdA==
Date:   Wed, 22 Jun 2022 11:31:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     qixiaoyu1 <qxy65535@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12@xiaomi.com,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [PATCH v3 2/2] resize.f2fs: update man page for options -i, -s
 and -V
Message-ID: <YrNf+lVYFrlenL7L@google.com>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
 <20220620115629.9169-1-qixiaoyu1@xiaomi.com>
 <20220620115629.9169-2-qixiaoyu1@xiaomi.com>
 <b4861302-a4bc-9022-c1b3-084f16d8ee87@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4861302-a4bc-9022-c1b3-084f16d8ee87@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I combined two patches into one.

On 06/22, Chao Yu wrote:
> On 2022/6/20 19:56, qixiaoyu1 wrote:
> > Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
