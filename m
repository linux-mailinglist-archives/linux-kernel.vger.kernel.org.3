Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60894819F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhL3GhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3GhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:37:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 22:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D07A615F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A33C36AE7;
        Thu, 30 Dec 2021 06:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640846223;
        bh=kxs0yNf+JfJvs6MssFMgtJ/46fWVg6XcH0FrpZ6Cq+o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=aVWz3CKN5r+sl/I17t+2OyPKvaZO4m21tu3Rgmv/g593gfAjpXVgCWYlsXY2c+uy6
         I1RmOQzivk2Ex9UxPlQgFwAfWjFEV3zzBdl1noDuAtOJYRhaEvaUpKpuAbnAipEv8I
         1ZBKbnt76w38iqMamwnwTSMuI8sALnCCzGtNxZ01E1QDwsy79dctfvoJhFK7B/K5s5
         dl5LSyr/S2AY4e6puafU+AqDqrVpTojBkeerKSPsyLkH+CJYrNobCETmFwa7lw/ZYA
         Rqf2r7n9jqqNxeVXmoF5yPLl/k9ylmYwZDFfp0ZFP5KuIB4E+LN9UoqS36PE5gWbTw
         VIalmpTKMmkJA==
Message-ID: <953ccf2e-69fe-f8c6-03b9-8fd62162a21c@kernel.org>
Date:   Thu, 30 Dec 2021 14:37:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: do not bother checkpoint by
 f2fs_get_node_info
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
 <20211214182435.2595176-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211214182435.2595176-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/15 2:24, Jaegeuk Kim wrote:
> This patch tries to mitigate lock contention between f2fs_write_checkpoint and
> f2fs_get_node_info along with nat_tree_lock.
> 
> The idea is, if checkpoint is currently running, other threads that try to grab
> nat_tree_lock would be better to wait for checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
