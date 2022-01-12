Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB148BC22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbiALBDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:03:30 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35524 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiALBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:03:29 -0500
Received: by mail-oi1-f176.google.com with SMTP id s127so1450985oig.2;
        Tue, 11 Jan 2022 17:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/xhQSNHh4barqJ4wt/GcMo2vn/zDoORZPXjcUuthMM=;
        b=pGjdvfyoY6KQaHCGg1TXGVEEhTKbh1ZH4aACfafVKOCCTouCtu9GzmnkcWuYr+TjwF
         me1206zVnBxWqSIKXsUaRAF3F2mT5NKx2QLLSmnK3I5mt1t+md3PfCgXItXz85+YCu7P
         QHhHNpQF277MmHaIup2kTGNLmmKpmhxFPmSxjIE/OfVO/g+UReAjzY2FSXzRZG21qe+O
         bL4WRbvoskOKHEbNyO+SZ1oBI0tN9j3bi6kPcVatysZtZ/pCwMmOwW3WHrwIgTvGBCkO
         xO5girKwWiZmaRcCdhCrZgxWzxcLSQtScGvSccoVGmPeLxC9NYFdJkfEzGCtA20Ilnrw
         7HMQ==
X-Gm-Message-State: AOAM530d40Hip0x+ZG+/JKWlboFNQCVsujEIVOqnxDYTcUzdCQ//S/oN
        TTaNbB945v8XTu3hsO+L3g==
X-Google-Smtp-Source: ABdhPJyQG3Sr8fAVbKno4jniidBsST5U8vWDMar2MLFyC03TyYk9cgComi6mOlJgJjqFJeS58CCZLQ==
X-Received: by 2002:aca:a8cb:: with SMTP id r194mr2635059oie.121.1641949409344;
        Tue, 11 Jan 2022 17:03:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm1974617oih.58.2022.01.11.17.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:03:28 -0800 (PST)
Received: (nullmailer pid 3831747 invoked by uid 1000);
        Wed, 12 Jan 2022 01:03:27 -0000
Date:   Tue, 11 Jan 2022 19:03:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, festevam@gmail.com,
        jassisinghbrar@gmail.com, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU
 support
Message-ID: <Yd4o3+LesMIc3RLP@robh.at.kernel.org>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
 <20220104062547.2103016-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104062547.2103016-6-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 14:25:45 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8QM/QXP SCU, i.MX8 SECO MU is dedicated for
> communication between SECO and Cortex-A cores from hardware design,
> it could not be reused for other purpose. To use SECO MU more
> effectivly, add "fsl,imx8-mu-seco" compatile to support fast IPC.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
