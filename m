Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E164FDF71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353716AbiDLMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352924AbiDLMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:15:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168208B6DB;
        Tue, 12 Apr 2022 04:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2041B81CD0;
        Tue, 12 Apr 2022 11:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D552CC385A1;
        Tue, 12 Apr 2022 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649762171;
        bh=O1dHRmNJHk6atETn5sVKcrOo0eM+WqTM5zzDRoF33wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLpDTV/X+UcbTaEcSLZxhab2tUhfFmsREEXa/ywh5kkZkklvEGEX5sPIirz091u2e
         uUe5nQFHEOO2kuy8oRS++xIfgKIspYZ13wJcmXpVr2Eq9kPTEPuLSaoTAb+qD42aHa
         AvFX777GbvnJzYkcqOxhuJZYX/qlyv84OZOkWH8wxWuHGsBB1h6rmZNctWr2/BsxxN
         wMKxswZYmUYRFwHNbILYdEAin7pgGf1VsDnAvrMbDz39iqy/tp+NWRDYRqHtQfxD+3
         F4kivDhF/kSCig0vAILCugBo9MwS+Vvrec35/6Wu+Eo028xiksqizwPi5Qe129ucQh
         +yBjFSgvLjC0A==
Date:   Tue, 12 Apr 2022 16:46:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Message-ID: <YlVfd2oCSkYfwg/S@matsya>
References: <20220412124219.3738092c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412124219.3738092c@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 12:42, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the dmaengine tree got a conflict in:
> 
>   drivers/dma/mediatek/mtk-hsdma.c
> 
> between commit:
> 
>   5cfde5b82f05 ("dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to get the interrupt")
> 
> from the dmaengine-fixes tree and commit:
> 
>   bb40bb695ec8 ("dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to get the interrupt")
> 
> from the dmaengine tree.

Thanks, this should not be in fixes, I have fixed that up.

> 
> I fixed it up (I arbitrarily used the former) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
~Vinod
