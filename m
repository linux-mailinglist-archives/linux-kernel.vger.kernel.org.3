Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38F4D5D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiCKIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiCKIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:21:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EB1B8FDC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE9B61E6F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA67C340E9;
        Fri, 11 Mar 2022 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646986803;
        bh=o8Xh2AdaEDIqnBziwekhg7TU+1OEG7Jo7u1pRDkEMNw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JFmKLACpUCKV2i2meReqkm53VUM6lMPjO8D+UCll4Juqmph77j71QLnEuhV6q29Vx
         cdNdzfunhxWamP2kpQRB/W6tSxYg0TGNofuIHxqsGjAg3lbB7DVMXyhW5tAUjiOrj3
         9/X7CwwUv2YJsGOdb05C9IlwNbnHPWUanmKDY8F+WySnZIvV4E7OPNxuDd3nYcn7J2
         Ex2yR1pcd5YNvG12eWXpOnS0HPSD+h3p98Dnf/YoQBK5PFy4WGcm+Fof1rnEMA9GvG
         pFIDzH7pxwn56AUeirmaFcA+NNAcAfjk2qvEnfH9FXmS648ERToH/XYVZ2asP3uzBT
         QSpxjdhb5M9qg==
Message-ID: <b00ca81a-82aa-3358-fd33-c0b1e8295207@kernel.org>
Date:   Fri, 11 Mar 2022 16:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] erofs: clean up preload_compressed_pages()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
 <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/2 3:49, Gao Xiang wrote:
> Rename preload_compressed_pages() as z_erofs_bind_cache()
> since we're try to prepare for adapting folios.
> 
> Also, add a comment for the gfp setting. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
