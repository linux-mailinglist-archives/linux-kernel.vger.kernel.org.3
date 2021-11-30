Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3C463FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbhK3VJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:09:56 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:33774 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343841AbhK3VJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:09:51 -0500
Received: by mail-oo1-f41.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so7123495ooe.0;
        Tue, 30 Nov 2021 13:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1qvFAfPGfMVn6wwgALZGAIXEcjF+CrrxtfhtyipeF/w=;
        b=iLTpFTaV/eUDXgTbLGAwcLeLh4f+rqCxnR5gzfvDlj8QvM8MZmYGsLP7rjBo5lKHt+
         khxUEWChxDH7EGvOv2f4jYIg87sVycbCVOlNGV3hGl5BN1VE85pXkgMiMvmQcJXnm99V
         LMGBtKvV3bY9/K5/QTZYroy8Uss3j+z0LpQsjMVsLMtE5mZnfwi1AQ0c+e6i2e9R0vRy
         sar1O8kd2yJMT0yrutqqEXpuQpO62iTPscQWJcvif40uV48Z7s6nBd6sd5JUTyoufZsQ
         4gnEMt5XY9SoAoXZCG6M0llQULPXrPv6YotHuMSVCxzNJ+ycwFphqPTKBpnkl3WEGEOK
         unow==
X-Gm-Message-State: AOAM532oQc+Pk/Yh9adZBzV9BhPF39013wrLtZjnlNiDcpVFC208epfV
        WBgqnteM/qwizSTlBjK7Icn23oGyYQ==
X-Google-Smtp-Source: ABdhPJy8TEBufTEXOCiqyXozwA17nAf2iUlb0g9SI0cQLD6pMvk5U6WdsCf5u/yDcWIsFu2b7pb4/g==
X-Received: by 2002:a4a:6215:: with SMTP id x21mr1181882ooc.16.1638306391707;
        Tue, 30 Nov 2021 13:06:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w10sm3382091ott.46.2021.11.30.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:06:31 -0800 (PST)
Received: (nullmailer pid 3012221 invoked by uid 1000);
        Tue, 30 Nov 2021 21:06:30 -0000
Date:   Tue, 30 Nov 2021 15:06:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Y Soft IOTA Crux/Crux+
 boards
Message-ID: <YaaSVug/aoQaLix2@robh.at.kernel.org>
References: <20211122162520.90211-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122162520.90211-1-michal.vokac@ysoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 17:25:19 +0100, Michal Vokáč wrote:
> Add devicetree binding for Crux/Crux+ boards from the IOTA family.
> These boards have the very same HW configuration as the Orion board
> except the usage of Quad/QuadPlus SoC.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
