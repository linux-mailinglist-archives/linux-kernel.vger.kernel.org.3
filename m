Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790052A57E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349510AbiEQO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbiEQO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:59:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C74AE26
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D289B818EB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC26C385B8;
        Tue, 17 May 2022 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652799543;
        bh=p8VXyt5c/PXmes006c5s9QtDLiYpUTe0IUEvEX9H0Hg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HbJZ+/R81HedWh/aBwu9GpKip7UrN85t7CmpIwZNHyX7gHYFfpLfdF7jQU2/IfL1/
         UpxVHgCH2d8Zdab0aBZyiT5V2PFwfo0ep+JvqnTiXXqTfF/xQzojegcQz/av5jf4Hp
         Pq2VlHML5N91XNkLg0hMz4OrK9jPo7TYQXqeW/akKQrT0LCGw0UKPtP3jTLVBKeKYj
         U95o6+rGj+yRcwFHLc3Iib71amMzwAdg8XBIctKq9+lBvGromURT1o7aJpADp1gMGw
         4ZK/sA0ppkWRqW/rzJFHmvsdTk7oWxSE38Qhp42AOlKtTfDCHS8KyBn3f1dfXErQwI
         wBxubHSg4UKsg==
Message-ID: <c2e64d18-dfcc-c032-c39b-6059683a617f@kernel.org>
Date:   Tue, 17 May 2022 22:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] erofs: refine on-disk definition comments
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
 <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
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
> Fix some outdated comments and typos, hopefully helpful.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
