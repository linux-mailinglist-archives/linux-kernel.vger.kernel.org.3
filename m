Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB8152A578
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiEQO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349423AbiEQO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACE3669D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FCD6167E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA40EC385B8;
        Tue, 17 May 2022 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652799409;
        bh=9G4bRLZbkmaoTeyxyDS0FY/VhwuNvTEg2IWb6RR7uDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qGBxyzRKO/VviBndF4dA0oxNkyStZ0yhkdRZvuYHuIqsomujGyf3QiKOPZPYJ6Ei2
         G3NTdNxBWb5NRgZkG84x31DrNH8qg82lPljsdLPtknwV/fyp2rD11hmrbTeOGRp2BJ
         SfR0Fbdq0MpiC/+r9AICVWlig49y8Tsr8BBmh5WM2a0C0oD9+2dxEy3OvKdII/0PBL
         Tsjv0lEu3YT4PCqfY1+JxxOz8QqYNZHzMxE27iQRGJfkzpJSSIHjf7Y2fTY7ZP8XAl
         RH2zp/4r93qMfayhYirj/XN2I1AcJMfuIYsyKruvzlWS3BQev+RJ7D4ftvZCJODnyU
         QW77kam9yUszQ==
Message-ID: <2cf13dcd-7fa3-4216-a67e-0a4ea66ecf95@kernel.org>
Date:   Tue, 17 May 2022 22:56:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] erofs: remove obsoluted comments
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
 <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/7 3:46, Gao Xiang wrote:
> Some comments haven't been useful anymore since the code updated.
> Let's drop them instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
