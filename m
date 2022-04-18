Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF9C504FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiDRMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiDRMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:12:20 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFC1A803
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mr7U61Lv/iEwOWf4m7Y5C1lRiJrpx9ObNmLADe2a/u8=;
  b=ajsDAonmjyfq5jaJ2PpIgIMHc/OVqaQDouZOSs2mDr75YPBq7oIKB5X4
   BLjgr5Yh9/vtd8YxiHzVSouOBebsbCJj+FF8sh5qP9g6/KEGkOf/sGl4X
   HAVwaZGfYv3XEb8tbqpeJdWv8qfCnYLZHr5HuEOiZhwG3fT6Tq1q34aSL
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,269,1643670000"; 
   d="scan'208";a="11791691"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:09:37 +0200
Date:   Mon, 18 Apr 2022 14:09:37 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Aliya Rahmani <aliyarahmani786@gmail.com>
cc:     clabbe@baylibre.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: media: zoran: avoid macro argument precedence
 issues
In-Reply-To: <20220418115948.5456-4-aliyarahmani786@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204181408230.11986@hadrien>
References: <20220418115948.5456-1-aliyarahmani786@gmail.com> <20220418115948.5456-4-aliyarahmani786@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Apr 2022, Aliya Rahmani wrote:

> This patch fixes checkpatch warnings of precedence issues. Added parentheses
> around macro argument 'num'.

You should use the imperative.  This "Add" rather than "Added".

The subject line would be better as "add parentheses on macro parameter".
That describes what you did, rather than what you avoided (avoided how?).

julia

>
> Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
> ---
>  drivers/staging/media/zoran/videocodec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
> index 19732a47c8bd..925f90fd5885 100644
> --- a/drivers/staging/media/zoran/videocodec.c
> +++ b/drivers/staging/media/zoran/videocodec.c
> @@ -22,7 +22,7 @@ MODULE_PARM_DESC(videocodec_debug, "Debug level (0-4)");
>
>  #define dprintk(num, format, args...) \
>  	do { \
> -		if (videocodec_debug >= num) \
> +		if (videocodec_debug >= (num)) \
>  			printk(format, ##args); \
>  	} while (0)
>
> --
> 2.25.1
>
>
>
