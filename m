Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66624464145
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhK3W3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:29:19 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39772 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhK3W3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:29:17 -0500
Received: by mail-ot1-f46.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso32276595ots.6;
        Tue, 30 Nov 2021 14:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5Ah10MsV2Qrlb3rMfsmjki2NWNRCpXDmRzGLkbKHAE=;
        b=URPUo5jiatFA0rh4bIajv1Pw7VC8jMGQrWidw+PZFrMcvfG47FfkjEHzY2f/aBJLmr
         LlcZ564WJ3DTeVQRE/nasgLpqs3lB874v9KVL2T3M/binDRCAbHw67zKhxQwCCxpJVBU
         2/XblUxrIEvnjs+ypswomvEwqNXXDFBFB41MVU32fECvkz3Xn+5sbDcf2+hXstLbNEsZ
         5flu9o+GcpVmYOPQzLjzOK79CkvETBa1NsBA0XjALKv2MdO9jFZHqnC2u+9ZcvbwUXpV
         GHAHV776wUNbvZy5Vji+NUhqKaaiuhRS7SzjeSkeeuJgyt37LlZe0Ht/9y1rxFXflbqt
         tXIA==
X-Gm-Message-State: AOAM5332y4CqLDKpjLGdcL9qEexApTrnwu2AHmiCULzlDApu/XOr8DJs
        Rl0Ucxw7tEwF2OHSguONlQ==
X-Google-Smtp-Source: ABdhPJx5IOovxLuUgwbUpIzuvrOdjMa2KxU+h+ob8g2McovkZ2QOvSkyzks2NTnN4vEM9phsmUB5zQ==
X-Received: by 2002:a05:6830:2053:: with SMTP id f19mr1879997otp.295.1638311156854;
        Tue, 30 Nov 2021 14:25:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m22sm3205762ooj.8.2021.11.30.14.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:25:56 -0800 (PST)
Received: (nullmailer pid 3121667 invoked by uid 1000);
        Tue, 30 Nov 2021 22:25:55 -0000
Date:   Tue, 30 Nov 2021 16:25:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     aisheng.dong@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        michael@amarulasolutions.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, krzk@kernel.org, matteo.lisi@engicam.com,
        nathan@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        matt@traverse.com.au, tharvey@gateworks.com,
        meenakshi.aggarwal@nxp.com, ioana.ciornei@nxp.com,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com,
        jagan@amarulasolutions.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2
 boards
Message-ID: <Yaak8x2NwhN5FF8E@robh.at.kernel.org>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
 <20211123151252.143631-3-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151252.143631-3-ariel.dalessandro@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 12:12:49 -0300, Ariel D'Alessandro wrote:
> Add bindings for BSH SystemMaster (SMM) S2 board family, which consists
> of: iMX8MN SMM S2 and iMX8MN SMM S2 PRO boards.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
