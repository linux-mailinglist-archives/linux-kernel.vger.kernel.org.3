Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951E749BD41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiAYUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiAYUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:37:13 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC6C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:37:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o3so5479485qtm.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+JbdAIL0dHyu/M74p8aA5YjzfndB90rS3t+uZU/cRXU=;
        b=gCddeVXrtQ7+W7o/2Ko4QmrY/BNb9ES0f4KiJhyudrPTflhDjql1piebHPEv4SGzL4
         qcCowEutu1cEkwHQf65JrBiPw0FmGP+5P1GIfR4ejHnGJ9h8ZHtfzCbwldCpDvdsZxRn
         BFlctXIIcTNRfxLZrpkUrF/zlgB6qDXnRvq25J/TLY25qU26m1W6MKuoNS8t8JlBT7En
         TnJ9ZsUf3nNy20c0hKjqFw5UvO49GOuct8zrcINVsxsYv7vwrQ8fBe/Ivc5FLEvXX/Mv
         dWMY+TovISqsN7YPTr9yiyYjE6PhUtwMdN+izjdxIgQ2sNXhJovxkJXtEEr5/fYn0q86
         7Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+JbdAIL0dHyu/M74p8aA5YjzfndB90rS3t+uZU/cRXU=;
        b=VdOv/URTkQg4KISb4BAnG9/yEgIFcD2AnIFDN89M+8gPTExCrBTSi6PBfV5guiVXlq
         uoHa4G1yKwqbrCMforWt4KkRPKs+8bPog8bmOWrt+Z9b9XaW6etp7v67RNKgO6pUMjNL
         o70aJ650wHwW7xbuXYltkRYXKCkeiKEJR+gReaoV1o/kvR0gJqaaTV3Th9PzsUKmVgpD
         vxCWUoCACVjawHpGxh+LaIbv5nBqQgVTDBKRNccMYCE3k3lluNKN2ERh/0DF8+KML6o2
         bfdHKxC2ED9XYlDHDhjVepJusOohX1Cu389m5223yW3/kz10h4HGyQ4XG4kJhCSNr/uY
         bk4g==
X-Gm-Message-State: AOAM532gQXrrTp9X4tj9VTkzEVG7QA7o4Ynxm0jxJU22uqx9+huO1Zlj
        OncROQorjAo+nqNJ0KWVE780hw==
X-Google-Smtp-Source: ABdhPJzOnHSEe2sQobYdCVpNGc6vOQyPkuT9p1HchozV1ea6U6F7yfbM6V2pUl0cETahJ/Y0Gl/uuw==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr3342837qtx.677.1643143031929;
        Tue, 25 Jan 2022 12:37:11 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id o10sm9467348qtx.33.2022.01.25.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:37:11 -0800 (PST)
Message-ID: <8be37d34b7090e3d3adca5b0d298c4b1b5639fa1.camel@ndufresne.ca>
Subject: Re: [PATCH v2 3/3] media: docs: dev-stateless-decoder: Document
 frame type flags
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        kernel <kernel@collabora.com>
Date:   Tue, 25 Jan 2022 15:37:10 -0500
In-Reply-To: <20220116185556.10657-4-digetx@gmail.com>
References: <20220116185556.10657-1-digetx@gmail.com>
         <20220116185556.10657-4-digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 16 janvier 2022 à 21:55 +0300, Dmitry Osipenko a écrit :
> Document that frame type flags must be set for the coded buffer.
> Decoders, like NVIDIA Tegra h264 decoder for example, won't work
> properly without these flags.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../userspace-api/media/v4l/dev-stateless-decoder.rst          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> index 4a26646eeec5..845f4481d34f 100644
> --- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> +++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> @@ -271,6 +271,9 @@ A typical frame would thus be decoded using the following sequence:
>            we are not sure that the current decode request is the last one needed
>            to produce a fully decoded frame, then
>            ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` must also be set.
> +          ``V4L2_BUF_FLAG_KEYFRAME``, ``V4L2_BUF_FLAG_PFRAME`` and
> +          ``V4L2_BUF_FLAG_BFRAME`` must be set if relevant to the coded
> +          format.

I think I would rather keep this in the CODEC specific APIs (BFrame being an
MPEG specific concept). If I knew about this before we made the API final, I
would have added the slice_type bitstream parameter in the
v4l2_h264_decode_params structure. But as the types are rather limited, I would
preserve our "reservered" space and make that part of the
V4L2_H264_DECODE_PARAM_FLAGS_{} instead. Do you also need that for HEVC ? (do
you have HEVC on that generation of tegra ?)

>  
>        ``request_fd``
>            must be set to the file descriptor of the decoding request.

