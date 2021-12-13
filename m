Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF981472EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhLMOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbhLMOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C5C06173F;
        Mon, 13 Dec 2021 06:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265FF61033;
        Mon, 13 Dec 2021 14:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E6AC34602;
        Mon, 13 Dec 2021 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639405211;
        bh=B0f4nv+4/uiTH9I2yU8r9fZqoURURZ8b4UkT4yxqh3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HepktJOmnXAiikWrordvHKZaDchiJ2iL3Nhl/7achqqm6umEeRRm9IHGC9qk7feBm
         0gqhr1cCfvatHpDqlXE2O7pZFt85+cKK1VrbnDBcnfd2f/FHe3IXobkRQB9Gq6zpmA
         pFJir67Bwi9e+C4gr1JCT7yygPg6I6rFXHZTZAYU=
Date:   Mon, 13 Dec 2021 15:20:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yuwen Ng <yuwen.ng@mediatek.com>
Subject: Re: [PATCH 1/3] usb: mtu3: fix interval value for intr and isoc
Message-ID: <YbdWmQMck/WGYJ4/@kroah.com>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:14:22AM +0800, Chunfeng Yun wrote:
> Use the Interval value from isoc/intr endpoint descriptor, no need
> minus one. But the original code doesn't cause transfer error for
> normal cases, due to the interval is less than the host request.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3_gadget.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What commit does this fix?
