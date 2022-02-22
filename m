Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1F4BF380
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiBVIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBVIXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:23:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD410A7DF;
        Tue, 22 Feb 2022 00:22:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 812251F41031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645518157;
        bh=A+DJP3gTPPF+U3zpg6uQqD55KcoMSjlXo80aszbcWLQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TzMCKLQx1ymEpxVDehvsyNEzr6CGdVNxtAtmENg05cZfLudIwmSUabW0hnKzHi3Uu
         l3x9TBQFELcKFUENkLfMCGJbDOYi948qCtfCSrWTJAs8+HQ9X51rXnLfoOulfGCc6Q
         r2tBblKO1ZC5lr1wlAITGt0BrgHy3v0JShS09huEZcPIC/aKoQSxvKyC7CM14CDWQQ
         nsXjKBAhTGpoX6TGp/09cQYC1Z5I5e1YTb4cDGY0re6PRryfRza6oHgtoz3S13OqfG
         eakOEe7EM3aUa8UCei2YcGWa/orybdHDoUwtcgy/k6acAei6/m+OHs07Lpr2XGzYih
         m13vy50ec/rZQ==
Message-ID: <ae6ca701-2296-8907-cead-cb2c1f469d4a@collabora.com>
Date:   Tue, 22 Feb 2022 09:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] doc: media: Document VP9 reference_mode miss-placement
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220221193728.808414-1-nicolas.dufresne@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20220221193728.808414-1-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks,

BTW There's a typo in the text, please see below, but other than that

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

W dniu 21.02.2022 o 20:37, Nicolas Dufresne pisze:
> The reference_mode derived syntax is part of the compressed headers and
> should have been moved into the corresponding control structure. Document
> this mistake. The value can be set to 0 if the driver does not require
> compressed headers information.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>   .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst  | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> index cc080c4257d01..ec48e4acb5ece 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> @@ -1692,7 +1692,12 @@ See section '7.3.1 Tx mode semantics' of the :ref:`vp9` specification for more d
>       * - __u8
>         - ``reference_mode``
>         - Specifies the type of inter prediction to be used. See
> -        :ref:`Reference Mode<vp9_reference_mode>` for more details.
> +        :ref:`Reference Mode<vp9_reference_mode>` for more details. Note that
> +	this is derived as part of the compressed header parsing process and
> +	for this reason should have bee part of

should have been

> +	:c:type: `v4l2_ctrl_vp9_compressed_hdr` optional control. It is safe to
> +	set this value to zero if the driver does not require compressed
> +	headers.
>       * - __u8
>         - ``reserved[7]``
>         - Applications and drivers must set this to zero.

