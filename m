Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC44818DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhL3DPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:15:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45926 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3DPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:15:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31CBCB81A71
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73644C36AEA;
        Thu, 30 Dec 2021 03:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640834102;
        bh=EV4iXMF9x7LPsunktdUPpK6ZYJIRaiwC7eAQJyy1MTQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iIhu4vDCkM75mbyN+d9MH19q04FQtb8KF+1I4aZ5z0n4lwceyJB/m4K6tERKBasuF
         YYdYFUKLwxY6S1gI9a5pTs5SRmkuZuBchbU8D+GwjE1nWxTckqbzQ35UjufH2ejOk2
         4VzkoZ0HB2BY5MlbePOvjDG+ck7kAUjRDQ3F25U0x4Cy3m2Ze3c+8Q2d7vggzC9HW7
         Uf0/4QDLfza0zCsiadNOpEfAfMkxiu8t88ZdIT7EqlphpWUw86z2jN3lw2X/pPi66+
         dq4+GOVMa3mV8Sirm00QpJsvfjlSCU3wH1C1LvCzw/oqndtccURHvfal90rBv1hwGb
         du09IakoUC7kg==
Message-ID: <424807d2-17ce-70be-586b-70c642dcbc14@kernel.org>
Date:   Thu, 30 Dec 2021 11:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/5] erofs: support unaligned data decompression
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
 <20211228054604.114518-4-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211228054604.114518-4-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/28 13:46, Gao Xiang wrote:
> Previously, compressed data was assumed as block-aligned. This
> should be changed due to in-block tail-packing inline data.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
