Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2824D53DAD1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbiFEIPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiFEIO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC8245AD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 01:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8892560E15
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE3CC385A5;
        Sun,  5 Jun 2022 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654416897;
        bh=MVT+s05L0sIcigbzPpxbYbcLSi9Rg2+EkvlahjbY9Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyP7lEsB+ml1VJ6Gr22ZBFqZTKjU9+0jat0laXUBKh/ZeoEC+9AbCD4mxN+W3Y+Yn
         QzmJdLdS2oIShWeNJf4yobF5gqq3hK18NJg3i3gnrCVRq6k3HKYv9QGQynnzi3g6mU
         IptZnYczrEjpbn1Oyrp6xXxE/Ev1KsELjyif2x5/wWv++EKKlYBokiwu/swURxUWq/
         N5SbFxINcaNekQXOujAofNTrnyhlPVT3D2ac+YZgNiXxbvEVjtnbuu4r9SmPuaEVBU
         AnoY0eutuA2w9uDZ4lCfqhIItErIs58RWi213v96Dfkl93Yznh0OOUY+L+vU5r4WOP
         5TXpoLi4S8YDQ==
Date:   Sun, 5 Jun 2022 16:14:52 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Yue Hu <huyue2@coolpad.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        shaojunjun@coolpad.com, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Message-ID: <Ypxl/MsOGQ6W4Rlf@debian>
Mail-Followup-To: Yue Hu <huyue2@coolpad.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        shaojunjun@coolpad.com, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20220605070133.4280-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220605070133.4280-1-huyue2@coolpad.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Sun, Jun 05, 2022 at 03:02:04PM +0800, Yue Hu wrote:
> I have been doing some erofs patches. Now I have the time and would like
> to help with the reviews.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Thanks for working on EROFS these months! Hopefully EROFS could have
a healthier development then...

Acked-by: Gao Xiang <xiang@kernel.org>


+ Jeffle Xu

(BTW, I'd like to request Jeffle as a EROFS reviewer too due to
 the fscache feature. Not sure if he's interested in it...)

Thanks,
Gao Xiang

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2691d8a219f..2d0e28d7773b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7308,6 +7308,7 @@ F:	include/video/s1d13xxxfb.h
>  EROFS FILE SYSTEM
>  M:	Gao Xiang <xiang@kernel.org>
>  M:	Chao Yu <chao@kernel.org>
> +R:	Yue Hu <huyue2@coolpad.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> -- 
> 2.17.1
