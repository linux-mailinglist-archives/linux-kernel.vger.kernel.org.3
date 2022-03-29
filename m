Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619694EAEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiC2N66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiC2N6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B39228D23;
        Tue, 29 Mar 2022 06:57:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DB0E11F43F3A;
        Tue, 29 Mar 2022 14:57:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648562228;
        bh=CWwJL6bMlDPp2CQbc/HxuRnjx9VOYr+8kAx3Y41PIZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMp/O0hatVpYNcPXNLV3vCUnF6OqX/Qjz1agDhgqEQilhctHoeBCrix42o5l2MB/h
         B/lVC75lIXL4a4PcGeK+Y0r4fuL2PCyb+Kyovp4XKkdROugexgCLPSf6bg9RyinPw0
         wWGrDPh5fybXnNncfDsXG5Mk9A3dKhFxiOx7PUpGjwz00xnyy6ovmrMemLxxtmNBJF
         asHu8hg6A/+n0V9XoIdNtxXr/6LYLq4ufdtuwhho1vyk76V+tO2RAQ1TUm47dqcH14
         5bl33pfLwwy2u3A4ltwDjfqSCebXKS/kCXFJgh83B1kJtzzN+4D18cdEKe32z/1B6i
         VacXu4WD9Pdvg==
Date:   Tue, 29 Mar 2022 15:57:04 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/24] media: v4l2-mem2mem: Fix typo in trace message
Message-ID: <20220329135704.t32g4ksojxrjggov@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-10-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-10-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>On -> One

Hmmmm the message "One job queue already" doesn't sound correct. I think
the message wants to say that the buffer is already on the queue.

We could maybe enhance the message like:
"Buffer already found on the job queue\n"

But this is not a typo from my POV.

Greetings,
Sebastian

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>---
> drivers/media/v4l2-core/v4l2-mem2mem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>index 675e22895ebe..53c2332d5cbd 100644
>--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>@@ -316,7 +316,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
> 	}
>
> 	if (m2m_ctx->job_flags & TRANS_QUEUED) {
>-		dprintk("On job queue already\n");
>+		dprintk("One job queue already\n");
> 		goto job_unlock;
> 	}
>
>-- 
>2.34.1
>
