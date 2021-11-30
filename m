Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74046464143
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhK3W3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:29:06 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:33522 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhK3W3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:29:04 -0500
Received: by mail-oo1-f41.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so7182833ooe.0;
        Tue, 30 Nov 2021 14:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FBQlY82UKqevuE9xMDFS712C+e6F8zeUBE2UjMq3WhY=;
        b=vSDTM2gyouv5GJmUGHp6yL6l+PB/YViEdwl8HSws+ejrpp1cwfG62uuAPSkWhBPf1J
         r2CxCVcVxZX30M1yPRMnZb0FzH88oFuXL9goec27N4i4A2G6lWzzFbvqaEaV9eMLByiP
         HGBZDurIUPSxi+gm11OUcoQC+sIL+wTpWMBrc+yCf7Npw5osY+amchqQ0Wp3gi3o2o+k
         tefTG6khVmAAoGm49GOliTUDWuObKvJPscq7jNLlazBN2kBx4QFDR8TC1PS+Jq/mGym2
         8xdY9AFg0T0xhajZcQUpqHlhchv3ALEfLdpvEq1zapiP4TWkRlU5Csdre8qA5rqBFSZu
         zdTg==
X-Gm-Message-State: AOAM530W5pjO1KY7O9k/T2lxNjjX4qD39DqzO/GoSRPG8HOZ2Xu2+e/L
        OaBNEGZ6G7Bh+VovHN1uQQ==
X-Google-Smtp-Source: ABdhPJw3YgL0MFGmZE3p/2IninVIBDiDcAGDCLwlPWd37Bf3usKwkz8Mh1gMZXnxZESJVttW+Qj3yg==
X-Received: by 2002:a4a:5a43:: with SMTP id v64mr1467360ooa.26.1638311144461;
        Tue, 30 Nov 2021 14:25:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x17sm2983698oot.30.2021.11.30.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:25:43 -0800 (PST)
Received: (nullmailer pid 3121274 invoked by uid 1000);
        Tue, 30 Nov 2021 22:25:42 -0000
Date:   Tue, 30 Nov 2021 16:25:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     linux-imx@nxp.com, michael@amarulasolutions.com,
        tharvey@gateworks.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, nathan@kernel.org, ioana.ciornei@nxp.com,
        meenakshi.aggarwal@nxp.com, festevam@gmail.com,
        matteo.lisi@engicam.com, linux-kernel@vger.kernel.org,
        matt@traverse.com.au, robh+dt@kernel.org, krzk@kernel.org,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v2 1/5] dt-bindings: Add vendor prefix for BSH
 Hausgeraete GmbH
Message-ID: <Yaak5g6wWHR6WfwC@robh.at.kernel.org>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
 <20211123151252.143631-2-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151252.143631-2-ariel.dalessandro@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 12:12:48 -0300, Ariel D'Alessandro wrote:
> Document vendor prefix for BSH Hausgeraete GmbH ('BSH Home Appliances',
> B/S/H/) manufacturer.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
