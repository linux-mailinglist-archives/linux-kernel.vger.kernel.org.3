Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A527F4735EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhLMU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:29:21 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41956 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhLMU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:29:20 -0500
Received: by mail-ot1-f45.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so18723233otl.8;
        Mon, 13 Dec 2021 12:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sp7soaG+93uM6HIRElJy0T0BN+OSm+e/LYzCLa9P4m4=;
        b=zi7st9vLUwnQjxgYOk4SbvtP4A2MeQ6Ma+dHpyoGRewLc/oO3dgDVvnvB7irOj2D/3
         CP9CwzhVJFvc/qlrVYb0jNizYF5lVGg3DeqDyAaYckCM3854QzzO49GQFEW98F8Wm4/8
         KTsmuG5oFNXV3KHSs+76SwT77YDgRb3imQ8a4qhl9HLo4yp94xoNzvf+tfHmM4Fl7x9/
         VWG789c/fHEF3b+IuKcnWZR5n8wtPebFfGFeVwoA69MFIYZgzWsYx6K80WHcrUyyh63D
         9AjSjyOxdthjvz28VSnTPt85vhSE/umxe0B1spDLCPDQvwmgRflMhhPfpgmVulxtpBzh
         NQvw==
X-Gm-Message-State: AOAM530Jy00r6mMxWJG4VjVRWEfmBtRLed4e69AbLFdBPhv+9yvm2CzF
        +an0X3aOwsxS6hGcXFGACKEQcy8+Vw==
X-Google-Smtp-Source: ABdhPJwGTNJ0ypFWisjlBwDJw2AzFfuOaKfZPNCdJD2ujguuasN28S1+P/yQ1DAcPHPDpZ17m4Whew==
X-Received: by 2002:a9d:17cc:: with SMTP id j70mr649269otj.313.1639427359961;
        Mon, 13 Dec 2021 12:29:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a5sm2358231otd.74.2021.12.13.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:29:18 -0800 (PST)
Received: (nullmailer pid 1517332 invoked by uid 1000);
        Mon, 13 Dec 2021 20:29:17 -0000
Date:   Mon, 13 Dec 2021 14:29:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Changming Huang <jerry.huang@nxp.com>
Cc:     sebastian.reichel@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, linux@rempel-privat.de,
        olof@lixom.net, marcel.ziswiler@toradex.com,
        jagan@amarulasolutions.com, festevam@gmail.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org, arnd@arndb.de,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, soc@kernel.org, tharvey@gateworks.com,
        leoyang.li@nxp.com, dev@lynxeye.de
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add ls1021a-iot board
Message-ID: <YbetHRxKVSF1Ex2a@robh.at.kernel.org>
References: <20211203031332.902485-1-jerry.huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203031332.902485-1-jerry.huang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 11:13:31 +0800, Changming Huang wrote:
> Add the board ls1021a-iot in the binding docuemnt.
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
