Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2457E512BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiD1GyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiD1GyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED2985B8;
        Wed, 27 Apr 2022 23:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B80E61E28;
        Thu, 28 Apr 2022 06:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C88CC385A9;
        Thu, 28 Apr 2022 06:50:56 +0000 (UTC)
Message-ID: <5c04f8e6-6522-d26c-29fc-60eb18d4ad90@xs4all.nl>
Date:   Thu, 28 Apr 2022 08:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation/media: Remove incorrect statement
Content-Language: en-US
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
References: <20220422074024.1329082-1-dorota.czaplejewicz@puri.sm>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220422074024.1329082-1-dorota.czaplejewicz@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

On 22/04/2022 09:50, Dorota Czaplejewicz wrote:
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
> Hi,
> 
> I tried to debug streaming in libcamera, where I stumbled upon this. I asked around on IRC where I was told that this statement in the documentation is wrong, so I'm submitting a removal.

For future reference: a patch needs to start with a commit message,
followed by your Signed-off-by, then '---' and the patch itself.

I've taking the paragraph above as the commit message, so no need for
you to do anything here.

Regards,

	Hans

> 
> Cheers,
> Dorota Czaplejewicz
> 
>  Documentation/userspace-api/media/v4l/vidioc-streamon.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst b/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
> index 0bc86f06947b..1a79313a29fa 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
> @@ -43,8 +43,7 @@ the capture or output process during streaming
>  Capture hardware is disabled and no input buffers are filled (if there
>  are any empty buffers in the incoming queue) until ``VIDIOC_STREAMON``
>  has been called. Output hardware is disabled and no video signal is
> -produced until ``VIDIOC_STREAMON`` has been called. The ioctl will
> -succeed when at least one output buffer is in the incoming queue.
> +produced until ``VIDIOC_STREAMON`` has been called.
>  
>  Memory-to-memory devices will not start until ``VIDIOC_STREAMON`` has
>  been called for both the capture and output stream types.

