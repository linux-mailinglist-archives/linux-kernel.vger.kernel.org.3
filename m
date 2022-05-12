Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13152524549
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350068AbiELGAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiELGAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:00:06 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD921AAA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:00:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VCzNrKB_1652335199;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCzNrKB_1652335199)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 14:00:01 +0800
Date:   Thu, 12 May 2022 13:59:59 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] erofs: scan devices from device table
Message-ID: <YnyiX01VNkTM+8tX@B-P7TQMD6M-0146.local>
References: <20220512055601.106109-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512055601.106109-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:56:01PM +0800, Jeffle Xu wrote:
> When "-o device" mount option is not specified, scan the device table
> and instantiate the devices if there's any in the device table. In this
> case, the tag field of each device slot uniquely specifies a device.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v1:
>   tweak the error warning when device tag is empty

Thanks! will push out today.

Thanks,
Gao Xiang
