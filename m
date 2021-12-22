Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7747D6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbhLVS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:29:47 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46700 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbhLVS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:29:46 -0500
Received: by mail-qk1-f169.google.com with SMTP id a11so3128893qkh.13;
        Wed, 22 Dec 2021 10:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEshpyGQHS/pVav7gzTopQjVYTvop1Kq52uMv091xqU=;
        b=WLQwFTpaASlPX2Erl2N6tUXNBti+jxSPDS9oPegoalUGxMB8X/PPqj3vtZC8vpEmAL
         SJOXYW6cI4ZwhGdfvHkjmKPqYdsw7h0ZchZGNUyR0n/s6HN1by05fzM0jgqdqSkXpr6G
         qBJNJ3St4xnePBGIZp3IYNaz1dmjmdhV6vZ+25zj+umnVD7iLgwz8zRrZhFqW3S91oSq
         Av6lk+ZBI+lERo2QiN0RGQeTSi0OpQoUHI/69a00CSauqdjQbFH0MVuw1Us+IfWs0PjS
         ydqHurQjMxrM33Dzi3as9lLfNbQfYBL9WgM0TBftdpBzJPMZ2kNEeHqKktERsBkYBynf
         OpBw==
X-Gm-Message-State: AOAM5310wZEMrF7/EF5kAz1/o4NPaO2g6c2D2hCql2fRmMBg2XhLiTQ1
        LlafyDiYWnSaVVvYKa2SQg==
X-Google-Smtp-Source: ABdhPJzp/zJa2A6+Mc/1aZb51iGXrEa00upwEfuI4nc02X3O0XvOU62pvhKXBc5qts/WO57QHM+Vsg==
X-Received: by 2002:a05:620a:706:: with SMTP id 6mr2959169qkc.374.1640197784671;
        Wed, 22 Dec 2021 10:29:44 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id m1sm2317309qtk.34.2021.12.22.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:29:42 -0800 (PST)
Received: (nullmailer pid 2466254 invoked by uid 1000);
        Wed, 22 Dec 2021 18:29:40 -0000
Date:   Wed, 22 Dec 2021 14:29:40 -0400
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: Add i.MX8QM rtc binding
Message-ID: <YcNulKqtIg8Unm76@robh.at.kernel.org>
References: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
 <1640088948-3690-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640088948-3690-2-git-send-email-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 14:15:46 +0200, Abel Vesa wrote:
> Add i.MX8QM rtc compatible to the SCU bindings documentation.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
