Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33046B814
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhLGJ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhLGJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:18 -0500
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2FEC061574;
        Tue,  7 Dec 2021 01:52:47 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id uX9QmxupeQyExuX9Tm6Meb; Tue, 07 Dec 2021 10:52:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638870767; bh=xcBSzC84ENHyCJggetySzc9vha9XBNexfRqRB15Gr0I=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From:
         Subject;
        b=fYXdARPWvbWyUoa+WHSTDA+oaH/drdJkCy5PSdAQ4B5s7nQkqv4t+GCV2aP69/JV7
         W/B95/8Sxtn6Z2wltk04bZBLYmCyFIuB6YNHI6BFtlT53SnBYJMvClEdCHoYOBKoVl
         7acl3PBotq7iZudfqgxxDBJzVSqMBY82kn4FmmhTvlhpTDfYKaq15aXSmYV3MPzWsd
         i07VQSXNWyp7SW/U/B+x9Vkx/qjP2JO7G0wcNDuPZOu8OFyFlz9HxwSmoSm8dt3S+l
         s8i0wfMJnV3XimrQJos0MnhViDKp0QXpXIsHLmmIAowmpKk47G7uhWQR5RYk9P8ud2
         tdevhXN7TIUgg==
Message-ID: <0d80df0a-0d20-5048-1e6d-ad913dc986c7@xs4all.nl>
Date:   Tue, 7 Dec 2021 10:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/4] media: v4l2-dev.c: Allow driver-defined entity
 names
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
References: <20211207003840.1212374-1-ribalda@chromium.org>
 <20211207003840.1212374-3-ribalda@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20211207003840.1212374-3-ribalda@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfN0iEp9/KQRCtLK0nAhbuSENAmF4dmRxs9kDaBs7lL1M8xywzvJSdFObfvYFkXtn2YmIorpJy1V4jfC3xEdo6ZkoeulI2cElfC3HwlkI+9mCwr9SOe/1
 ubEM+17FmN4PxFvoECW5okgkdaYZ9uOovhtKMiuzeLAl23lWZsB4GUlraepRBue8gPR0CwdwvvIJllQK99gLbwcKrDdwrbUfOF7vUBwBywbNO0ocorNUhOGH
 0XzSWAsfdyNDXBlUM86M7UlmNdub5FVZeLf4wJvrNDdAzKDuXKRygnJqfajpgr2wp9rZLZCRIwX0ZEGj0J7pGXV9tyg5Cyl4zHVtevbqfzFZVJXonzPnnSH2
 cScZsd70fPWtui9o2QxNYmkNWfsPl1Uj0+Zjkk61iktRRyH9iazGHb/ByfL+deojmm8hlXLsPjBDCYMlHOx8Kzg6Cz9bN8tf/Poo70qHsBY8WyAG9IQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 01:38, Ricardo Ribalda wrote:
> If the driver provides an name for an entity, use it.
> This is particularly useful for drivers that export multiple video
> devices for the same hardware (i.e. metadata and data).
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  drivers/media/v4l2-core/v4l2-dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index d03ace324db0..4c00503b9349 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -832,7 +832,9 @@ static int video_register_media_controller(struct video_device *vdev)
>  	}
>  
>  	if (vdev->entity.function != MEDIA_ENT_F_UNKNOWN) {
> -		vdev->entity.name = vdev->name;
> +		/* Use entity names provided by the driver, if available. */
> +		if (!vdev->entity.name)
> +			vdev->entity.name = vdev->name;
>  
>  		/* Needed just for backward compatibility with legacy MC API */
>  		vdev->entity.info.dev.major = VIDEO_MAJOR;
> 

