Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6E554AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353850AbiFVNVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiFVNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:21:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D15D2F01F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AAD2B81E81
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FEBC34114;
        Wed, 22 Jun 2022 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655904073;
        bh=XPeefldeWzVHWZ+odjgCZnRDW8+RxfcMoP983LsW+k4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BZJXRsYxOVmdQeiCNS9zsS87ptVZ+z9ATiduX6Y7eh8IPiEFCkNlgh5FAap/I0yB6
         c0ScG7ud+SQsrVEYVuz4N6wtNHZFj7gb8Thny5vMudxOINJqHVxLSBGPvNpPEOxhzv
         IUU4ak+76hDq5W9zwlcChscIx33Yv1wi9iIke/RD6+FU78ZBhIdrwbBe+eC6Tntk9n
         W047yXuUzy+QpTEzbOBdSWTDS2WvyPdhymL3kAK5Bav2UqW2r4FX5hkmMciN0U5Fx+
         gV5QfsEn7ZcB66BiYiRMoitodVPyVvTFcRHI/DNCXD0nA1XiOSk5eW9/YDNkXSXywX
         dTTGkid4W2F3A==
Message-ID: <b4861302-a4bc-9022-c1b3-084f16d8ee87@kernel.org>
Date:   Wed, 22 Jun 2022 21:21:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] resize.f2fs: update man page for options -i, -s
 and -V
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12@xiaomi.com,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
 <20220620115629.9169-1-qixiaoyu1@xiaomi.com>
 <20220620115629.9169-2-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220620115629.9169-2-qixiaoyu1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/20 19:56, qixiaoyu1 wrote:
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
