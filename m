Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5E4D9732
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346394AbiCOJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiCOJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:10:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D22DD5A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC1C6B811D2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBADC340E8;
        Tue, 15 Mar 2022 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647335375;
        bh=qjtgoi5NGl4oJrj4hfKOe5E1NWLCN6cFlqZz4tr9NqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qYo81yqDaPO1T4UlWcA5dYLBmQM2/DXS/eZUHLdheGu5fwRXEG9R5f1MkXgKrtH9y
         9j7LeTqAnkgHea+qJKudf5Zzl76nYCAMUwPZtKQi8/RYO251oG0+Mbp/bTDs+Q+lp5
         W/JWi3DgHgitbeL3ctURqEXZLbj4jsQVcpbwbG/mFxZIQio8+zzyfygi/WTz7seyiz
         7Ns98AvYXfQOn7TvuZ8LBptRX+8ysPVpeOgUY4ZfhwRMHlblqyhXBY7XjSdUru0/PO
         IQ7AExPzlzVUaFrp96zaM+6IUzSz9DR8B5c5k4Urhd7GTxU/hSsktahbyftKty7Je8
         uVIpswvdMynEw==
Message-ID: <419095e2-2167-ebd7-ed23-0d96ae8c095b@kernel.org>
Date:   Tue, 15 Mar 2022 17:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] erofs: refine managed inode stuffs
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
 <20220310182743.102365-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220310182743.102365-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/11 2:27, Gao Xiang wrote:
> Set up the correct gfp mask and use it instead of hard coding.
> Also add comments about .invalidatepage() to show more details.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
