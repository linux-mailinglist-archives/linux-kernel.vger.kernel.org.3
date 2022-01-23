Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BA49728B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiAWP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:29:25 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42949 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiAWP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:29:22 -0500
Received: by mail-ot1-f49.google.com with SMTP id z25-20020a0568301db900b005946f536d85so18770399oti.9;
        Sun, 23 Jan 2022 07:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBtMdDkgEqeEoPHKPJWwoHxHtflqXLir/arxsM9yH3c=;
        b=WxlYZ4VXlcBnknyMw4OJk3jValljIGXKJn1cWIcrYQAXXvfDaGOnRxf+3Vu9wmcI9h
         /FofjJFzDG6LH9ZntUXY/xgFmClv1Ou/CriWKpoD0kuV2vnoAasLe9Y0xEcZfzJopx5g
         vLpsgQXzeOipJGor/G+Z7gXTOxOebyBMJBLaING4qSrelIRutjbpO7BxYiFe+H9OBV+a
         oPg1YGPQL9BfK4I1ltLZq3GF+nPdNgGPgp2PpkN/Ng5vigURNijSP6bjyI1lwyNUnHmS
         oSP79fiaX39xADEy/KySguhX9Tpdl8G9hd1KY5amyZ+Pg2oNs5NpHPUW9c5dCQ7+7Ipp
         HhEg==
X-Gm-Message-State: AOAM532KCVjCybNdP9LXWzLO6Nt/rWLQIDNooblcFZaymYrcYPm7K7ME
        mf0QjqGYLONW6o12We+sIm9Vblqrhw==
X-Google-Smtp-Source: ABdhPJx7Tv3l6W2Jzt32MCAl8L7wdnDDZsXmhKpUpmfVvuHRqLbW4QxCzmIF3zxFhQqI/B7glrPFfA==
X-Received: by 2002:a9d:816:: with SMTP id 22mr9119261oty.297.1642951761581;
        Sun, 23 Jan 2022 07:29:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z1sm3723001oti.29.2022.01.23.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 07:29:20 -0800 (PST)
Received: (nullmailer pid 1429531 invoked by uid 1000);
        Sun, 23 Jan 2022 15:29:20 -0000
Date:   Sun, 23 Jan 2022 09:29:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-watchdog@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: watchdog: fsl-imx7ulp-wdt: Fix
 assigned-clock-parents
Message-ID: <Ye10TywgYxByt4rE@robh.at.kernel.org>
References: <20220120172333.1628990-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120172333.1628990-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 11:23:32 -0600, Rob Herring wrote:
> The schema has a typo with 'assigned-clocks-parents'. As it is not
> required to list assigned clocks in bindings, just drop the assigned-clocks
> property definitions to fix this.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml     | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 

Applied, thanks!
