Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685F346C67D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbhLGVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:17:53 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44970 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbhLGVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:17:51 -0500
Received: by mail-oi1-f171.google.com with SMTP id be32so943050oib.11;
        Tue, 07 Dec 2021 13:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=asvIIgcfdstNfjFsb5JYamSeC7BkZaM5BJh8bn9MdF4=;
        b=uiV8ApIC7s9cvXVLss9Uo2EZMZQRkWwXufL9D9vx3wkAFzsSLAIoLOmcLc9Y4zCgsa
         Lq6583GsHNqzao+6NeKkJhuFIwDqR05hZZe/Hjv+sSYaSt0TX4LX09wpNHLkf7BEA+gC
         80y/l9pbVIVDXeL8U29ZQ4/DTnrXeEn08BwKFbiHUzWgro+qManjHdh1zRn57PtbBFQ7
         MIkPqP1Oji1zqVWRBH51RGQM+eWh21bBKi1n10LHDgt/ZUJ7deA6uy4tFDRW6mnB+W8x
         jC14zHeIXZyKvaQzKFJvgv5p5slbTrYhxe6zkr9iBFWIWA1zhBVowqoRFLu/yhQh1ZO/
         DUwg==
X-Gm-Message-State: AOAM531dajfrmZynyI9j4aOGErvGrhDWsJVCBdW48xAnOJOq6S1/kZue
        mvYWnIj9vHDF9S4JBRpSTQ==
X-Google-Smtp-Source: ABdhPJxc/AHj+LnGGT6zJnz1p3C+dMtJOu6aTpY+Io5e+BMbWIEn0nwFat+1MwVmkTIt17nn/3xhGw==
X-Received: by 2002:a05:6808:11c6:: with SMTP id p6mr7741859oiv.44.1638911659363;
        Tue, 07 Dec 2021 13:14:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v19sm146773ott.13.2021.12.07.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:14:18 -0800 (PST)
Received: (nullmailer pid 842210 invoked by uid 1000);
        Tue, 07 Dec 2021 21:14:17 -0000
Date:   Tue, 7 Dec 2021 15:14:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     andrzej.p@collabora.com, linux-staging@lists.linux.dev,
        linux-media@vger.kernel.org, gregkh@linuxfoundation.org,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        nicolas.dufresne@collabora.com, linux-kernel@vger.kernel.org,
        mripard@kernel.org, linux-sunxi@lists.linux.dev, wens@csie.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/9] media: dt-bindings: allwinner: document H6 Hantro
 G2 binding
Message-ID: <Ya/OqXg7vVKPwudd@robh.at.kernel.org>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-8-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129182633.480021-8-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 19:26:31 +0100, Jernej Skrabec wrote:
> Allwinner H6 contains older Hantro G2 core, primarly used for VP9 video
> decoding. It's unclear for now if HEVC is also supported.
> 
> Describe it's binding.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../media/allwinner,sun50i-h6-vpu-g2.yaml     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
