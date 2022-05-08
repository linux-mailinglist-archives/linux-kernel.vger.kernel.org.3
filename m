Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8951F1FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 00:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiEHW6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiEHW6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 18:58:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A00DF1C;
        Sun,  8 May 2022 15:54:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D5C7484;
        Mon,  9 May 2022 00:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1652050482;
        bh=g4+dHbhDuhu/7jnHM3JqtmGxUTNuP+BdvOlkxJatT0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wn6QGAyp9gWOuVRhO8TaTWXUTggvoLCE+wTYsZDKoUj/IZqbvFAaTU0+hSlVL2sSQ
         +nTfpBEtnDAZxtzbD5QrZr8rbn/sl8O3G8azRtlvTJb9OJtpB+sH4r1Q+ZzSH8b9+5
         eC0mPnftqBlcPcReV1QXoGD0zIylZebeuywxZSh4=
Date:   Mon, 9 May 2022 01:54:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <YnhKLsCyL66vigEI@pendragon.ideasonboard.com>
References: <20220509082623.37c008f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509082623.37c008f9@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 09, 2022 at 08:26:23AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   18a9b21f7a9d ("media: uvcvideo: Fix memory leak if uvc_ctrl_add_mapping fails")
> 
> Fixes tag
> 
>   Fixes: 07adedb5c606 ("media: uvcvideo: Use control names from framework")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 70fa906d6fce ("media: uvcvideo: Use control names from framework")

I've added a check to my git-request-pull wrapper for this, it won't
happen again.

-- 
Regards,

Laurent Pinchart
