Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F93582774
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiG0NPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiG0NPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB662019B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F47616E8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED042C433C1;
        Wed, 27 Jul 2022 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658927728;
        bh=+YT+ojoK3bYTC00tyuvmILyv2F2d7TCBW5svs+Jz8OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKcxWSE27As7BZFD/QEEnFfa1/w1NtyCUV4fIphw+Ii2MRRPPr7pUBZwMKy+fyDaT
         k06w5zwLlP+IR/MBHxp2l9+EgOictrpwPimQeJQdl+Gq2DpjBbpAXWz8c4mrzkjUqj
         wdwjXJ/97uesu1//W3Qkqoo8FxDxirTAQi/Dypvo=
Date:   Wed, 27 Jul 2022 15:15:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH 2/9] tirnity: Add dma memory module
Message-ID: <YuE6bQeTI/pcbLZh@kroah.com>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p3c691bbc54c84775524b97c4b717c7ce7@epcas1p3.samsung.com>
 <20220725065308.2457024-3-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725065308.2457024-3-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:53:01PM +0900, Jiho Chu wrote:
> This patch includes memory management module.
> 
> It provides abstraction layer to handle DMA buffer.

Again, no abstactions please.  Get this working and merged properly
first, before worrying about any sort of additional hardware models or
abstractions.  It just makes this so much harder to review and to
determine what you really are, or are not, using here.

So far, it seems you aren't using any of these new abstractions, which
is odd.  Or I just can't find them.  Either way that's a huge sign this
code is wrong and needs to be cleaned up.

thanks,

greg k-h
