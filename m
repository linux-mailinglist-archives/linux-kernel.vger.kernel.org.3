Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD8483D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiADH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:57:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54666 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiADH5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:57:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5DFCB8116B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 07:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315B2C36AEF;
        Tue,  4 Jan 2022 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641283025;
        bh=NSJ0zTdBXcJWuUZOOPmyxo1EAOMSjDyoFTgmv/YJlAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kr2pK+rxZApN2H/ze4xyyXHbls1BroLStG49SrYoE2MLJxfZdI5yatFwTPW/PSVeS
         p2BhdOY1UoEu3MaXUSzhmYi+Wn6RMpxQeq3vMLe7jOBhNNyWbOsPAJgE7PUUgKs9nz
         iBAml9PJxzEAfAU+GvGNE4Z/RpwNWiYkMpkh2WrpaXynIk+WiTQbQLyG7fuwZL8y81
         /KBfb+9FFpOhT0+nav/HjW2gxcLopGurGp5SU0sLZBDGxC55iGCqtqO77SaKMjIFEf
         oHcdNCNfpsv77BrygfxHsbyT0VPhOLcaChIJEOfuEcq91xCHMslDCHQMDyII//GgDx
         2xfInguavBzog==
Message-ID: <2d841b67-27d0-df57-fff0-fa8fb2c4175c@kernel.org>
Date:   Tue, 4 Jan 2022 15:57:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/5] erofs: use meta buffers for inode operations
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-3-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220102040017.51352-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/2 12:00, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within inode operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
