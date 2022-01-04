Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EBB483DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiADIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiADIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:07:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:07:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E50612DD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A7AC36AE9;
        Tue,  4 Jan 2022 08:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641283629;
        bh=tEIqXUPGXKezh7T3zqNrkDAki4hP2luXd7eY8IDlFqQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=spSQe3DntNAnVOisheBB/kIUxh/0TVCWMmUZLfv8OU3teA7uhApPzRIKCCBY/9vls
         6UHEONVwSkpm3G5Ol7d9diEh6eLp7SLYnJ73QnLvKsq5R5zIjLVu6pI5CumJY7XsjJ
         DaW0K1AxvwmXxRqPsN6PyqqAWUKPW7CDV/Fv8afpj0NxeBPMHwX0MmBHzAS/mXCJ/c
         HIule9t2Bs83RpUQm6SSQWkiCaZgbBq9TcO1e8ob2Q4FoWbiy90fL80+i06EXRvPXB
         YKpawanwUzdhsZN41wjEY9JysMv8XZVa4MEqAUsF0ysB4Au/5DmcR2lXRe/omEVYCD
         1eypsxDB86Kew==
Message-ID: <b3955e02-a467-9de3-cb41-d4f5b014791f@kernel.org>
Date:   Tue, 4 Jan 2022 16:07:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/5] erofs: use meta buffers for xattr operations
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-5-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220102040017.51352-5-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/2 12:00, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within xattr operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
