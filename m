Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F158504FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiDRMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiDRMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:14:01 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13E1A810
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nlZTs2EHSVsUyk1Bfx1ucHBhq1nc96y85fwK/m4VS8o=;
  b=Ztt7IfzFy0k4GPLo5+lWjD1pdUNA//BQgMpRhdMXMTeRKWFiqkQ5s6Yc
   t8Jzt/OY2XlpCdk1Kxb6l5CDVSGiIXObShwXElOiEWXJwzfUFxxpuEDf6
   bIwlHANpRUE0P8LMwUlHpB3f/AL79uBMKoCG1ec3roHLgtNwdq82vuRcV
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,269,1643670000"; 
   d="scan'208";a="11791770"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:11:21 +0200
Date:   Mon, 18 Apr 2022 14:11:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Aliya Rahmani <aliyarahmani786@gmail.com>
cc:     clabbe@baylibre.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: media: zoran: Code cleanup - else is not
 generally useful after a break or return
In-Reply-To: <20220418115948.5456-3-aliyarahmani786@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204181409550.11986@hadrien>
References: <20220418115948.5456-1-aliyarahmani786@gmail.com> <20220418115948.5456-3-aliyarahmani786@gmail.com>
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

Just say concisely what you did in the subject line.  For example, "remove
unneeded else".  The reader can wait to see the message to find out the
details.  "Code cleanup" takes up a lot of space, and doesn't give much
information.

On Mon, 18 Apr 2022, Aliya Rahmani wrote:

> Remove the else without affecting the logic. Fixes the checkpatch warning: else is not generally useful after a break or return

Commit log messages should be limited to around 70 characters per line.

julia

> Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
> ---
>  drivers/staging/media/zoran/videocodec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
> index 16a1f23a7f19..19732a47c8bd 100644
> --- a/drivers/staging/media/zoran/videocodec.c
> +++ b/drivers/staging/media/zoran/videocodec.c
> @@ -98,9 +98,8 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
>
>  				h->attached += 1;
>  				return codec;
> -			} else {
> -				kfree(codec);
>  			}
> +			kfree(codec);
>  		}
>  		h = h->next;
>  	}
> --
> 2.25.1
>
>
>
