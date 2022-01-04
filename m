Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D96483D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiADIC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiADIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:02:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA3CC0613B3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 402FE612E1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C8DC36B02;
        Tue,  4 Jan 2022 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641283348;
        bh=QLZ6g2Ht0oArjMp/a0AaWtON7ynpwARL5ppGkT5fh7A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FEhzt3spd6tV89XViWZVhiGUVk9wmZHNgCl+HjA/iT92QUVZ499xqF9GLno8Cq50z
         FKAMaUZLF8TBGuPKWZ0ZpgVZ4XUcBs+oOsqinvuRubhZGcNfnLAZAAIuDSSZwHTaM1
         VoHh7suNxzBGZOiiY9rC1N8bO9Fqbq29Di+50SqIoJE04xeQImo14kTC8OqwMh6e1v
         xg8hI+XzYTwaYHPpbU0iTKw3CkgTW3+deiwhIb0C5h0LJXq2c361j2kBDn71Wa3GAR
         JzsRme55OMXOAwoM7I4QvUd2BbAabNN3VW/R4M6CfarKlstWO/4mR+ZqQ+nVlgQhc8
         TuDl6bxu0SOQQ==
Message-ID: <6151cc84-f2d2-f9e9-7884-567f202d65cc@kernel.org>
Date:   Tue, 4 Jan 2022 16:02:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/5] erofs: use meta buffers for super operations
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
References: <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
 <20220102081317.109797-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220102081317.109797-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/2 16:13, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within super operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
