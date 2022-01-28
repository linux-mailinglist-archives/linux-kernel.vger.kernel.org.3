Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA449F6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiA1KNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:13:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37538 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244542AbiA1KNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:13:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E136CB818E0;
        Fri, 28 Jan 2022 10:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F4C340E0;
        Fri, 28 Jan 2022 10:13:10 +0000 (UTC)
Message-ID: <040ba85c-6cdd-8053-30ed-194548d23a18@xs4all.nl>
Date:   Fri, 28 Jan 2022 11:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] media: s5p-mfc: set V4L2_BUF_FLAG_LAST flag on final
 buffer
Content-Language: en-US
To:     Andriy Gelman <andriy.gelman@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200502194052.485-1-andriy.gelman@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20200502194052.485-1-andriy.gelman@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm going through a bunch of (very) old patches in my patchwork TODO list
that for one reason or another I never processed. This patch is one of
them.

I don't feel comfortable merging this, given the follow-ups that were posted.

If someone wants to get this in anyway, then please make a new patch. I'm
marking it as 'Changes Requested' in patchwork.

Regards,

	Hans

On 02/05/2020 21:40, Andriy Gelman wrote:
> From: Andriy Gelman <andriy.gelman@gmail.com>
> 
> As per V4L2 api, the final buffer should set V4L2_BUF_FLAG_LAST flag.
> 
> Signed-off-by: Andriy Gelman <andriy.gelman@gmail.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index 5c2a23b953a4..b3d9b3a523fe 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -614,6 +614,7 @@ static void s5p_mfc_handle_stream_complete(struct s5p_mfc_ctx *ctx)
>  		list_del(&mb_entry->list);
>  		ctx->dst_queue_cnt--;
>  		vb2_set_plane_payload(&mb_entry->b->vb2_buf, 0, 0);
> +		mb_entry->b->flags |= V4L2_BUF_FLAG_LAST;
>  		vb2_buffer_done(&mb_entry->b->vb2_buf, VB2_BUF_STATE_DONE);
>  	}
>  

