Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938404EA95B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiC2Ieg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiC2Iea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:34:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6B144B70;
        Tue, 29 Mar 2022 01:32:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4656A1F43A5D;
        Tue, 29 Mar 2022 09:32:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648542765;
        bh=AEzY3zrel2SS59cX50Wh3lYNuek+9mxJ6I+jtREm89w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YU6hJCLNE9jMBwWLxpeDSpOSZJt1hv0VfFyYfnkFKmetpz+pDRUVq2l+wy6UvVfaf
         fv73dNpr3VKyh25uf67PDgtDxWExJU8FyoniTAb4Q2QPR5vaxQKSXTlHUSWrnKxO/L
         FABs4PvSz3EeoPrOZ2W3hQWFAauzkMqAdbHR8r8TkQVAy/mhAjdZGxT1ZvfLaABHIs
         t77vF2Zr3JnrwIpt0sEw97I8uEvoYdDeEZ7peQTuhQU0pVJLsojs+65nqS5IJeoLlX
         CDGVKKCRvmAAh7a8YCxbP+PTOuDkCmf30eil9fOKUifvuZ9TimFzmtXvGWozg3AaVl
         aY+GYz/QFvfmg==
Date:   Tue, 29 Mar 2022 10:32:41 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/24] media: doc: Document dual use of H.264
 pic_num/frame_num
Message-ID: <20220329083241.ctatuvbbhkvswokl@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-3-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-3-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>These two fields needs documentation as they have dual meaning. It is also

s/needs/need/

>confusing since pic_num is a derived value from frame_num, so this should
>help application developpers. If we ever need to make a V2 of this API, I

s/developpers/developers/
(seems to be a common typo among native French speakers ;))

>would suggest to remove pic_num entirely.

I think that suggestion should be placed as a FIXME/TODO comment into the
source code as it is way easier to find for future developers creating a V2.

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> .../media/v4l/ext-ctrls-codec-stateless.rst            | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
>index 6541e4c32b26..f634f20bcfbe 100644
>--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
>+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
>@@ -649,10 +649,16 @@ Stateless Codec Control ID
>         :c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
>     * - __u32
>       - ``pic_num``
>-      -
>+      - For short term reference, this should match the derived value PicNum
>+	(8-28) and for long term references it should match the derived value

Minor suggestion, for short term you use singular (reference) and for
long term you use plural (references), I would stick to one of both.
(Below you only use plural so maybe stick to plural here as well)

>+	LongTermPicNum (8-29). Note that pic_num is the same as FrameNumWrap
>+	for frame decoding.
>     * - __u16
>       - ``frame_num``
>-      -
>+      - For short term references, this should match the frame_num value from
>+	the slice header syntax (the driver will wrap the value if neeeded). For
>+	long term references, this should be set to the value of
>+	long_term_frame_idx describes in the dec_ref_pic_marking() syntax.

s/describes/described/

Greetings,
Sebastian

>     * - __u8
>       - ``fields``
>       - Specifies how the DPB entry is referenced. See :ref:`Reference Fields <h264_ref_fields>`
>-- 
>2.34.1
>
