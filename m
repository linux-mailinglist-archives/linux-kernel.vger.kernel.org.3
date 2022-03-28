Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4F4E9C26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbiC1QXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiC1QXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:23:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E82AC68;
        Mon, 28 Mar 2022 09:21:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B65A92F7;
        Mon, 28 Mar 2022 18:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648484492;
        bh=sYyVQAYbWlYYf3LCLWan8M4vKcQxgsd1o1Zk+jlvkz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoD3+/VZrBPHhQ0Nx7+Kchdpy6OvqhSP/nkKptGX50Cwv7GhnvAOLgw4va1Rkz/ya
         oYmYZsizym77o9ECljNZBJqlzk29kBEnxAIe1x2Olme3lRwRSPhacOJAtMVOPeQyQZ
         ud3KSefCIn+wT8WyLZDkM02dx9bpldPiz4sEF1/4=
Date:   Mon, 28 Mar 2022 19:21:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] media: media.h: remove unneeded <stdint.h> inclusion
Message-ID: <YkHgim83Q7s9jx6p@pendragon.ideasonboard.com>
References: <20220328160153.169362-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328160153.169362-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

Thank you for the patch.

On Tue, Mar 29, 2022 at 01:01:53AM +0900, Masahiro Yamada wrote:
> Commit b3b7a9f138b7 ("[media] media-device: Use u64 ints for pointers")
> added this #include <stdint.h>, presumably in order to use uintptr_t.
> 
> Now that it is gone, we can compile this for userspace without <stdint.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  include/uapi/linux/media.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
> index 200fa8462b90..5754dce922a7 100644
> --- a/include/uapi/linux/media.h
> +++ b/include/uapi/linux/media.h
> @@ -20,9 +20,6 @@
>  #ifndef __LINUX_MEDIA_H
>  #define __LINUX_MEDIA_H
>  
> -#ifndef __KERNEL__
> -#include <stdint.h>
> -#endif
>  #include <linux/ioctl.h>
>  #include <linux/types.h>
>  

-- 
Regards,

Laurent Pinchart
