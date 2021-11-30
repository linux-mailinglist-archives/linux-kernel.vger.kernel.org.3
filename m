Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A958464147
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhK3W3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:29:40 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33399 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhK3W30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:29:26 -0500
Received: by mail-oi1-f172.google.com with SMTP id q25so44364689oiw.0;
        Tue, 30 Nov 2021 14:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHI+wme9D5ouAAhLxRK/kKZMVmuciGoxqaqn2jbJdxQ=;
        b=qO0aqy6ehDcFMxLZaF+20BjaAYsEMOG9fEG5PrAzy4kRQxv0Kss0ijeAiN0aR6kyLF
         F875Sqfkik18rtmy2wqcPhRWjQcvYcaUsppU8C8/zwmXiIj6s4TjKrr+fQXPkeCby7+O
         F2NNYh6Bl/QK5dyYA0tBNqfM1pKkQ72i6GgN3edHA7MmZ8LmCgi6/CBhBkppGCNQ3DAG
         voSS9LEiV6eyndIFGo/13eQbrPQwwVXAx+Y9tnocpq1TpzmcQai8Grg0md724VmkmbDi
         tb/t+dCzxlqjUE+xWepAcTRi5+pFWqYWQqjVSVsu0CT5dO1R9jIus1+iA6R4YSJtYE+z
         2aVA==
X-Gm-Message-State: AOAM533bux/1oGQv1W/GkyOIRV85ELgiK4hzD/I4m+VJzTdUDV59r5q0
        ffLV/NreZBdCEvLjmbo9/g==
X-Google-Smtp-Source: ABdhPJw7NJOWrDUV0r37lsRsZGGfJDaxOa8bfQ+czCbIH6EYVCFOgEHQze0QkE4BfDuLsJYBXPuEag==
X-Received: by 2002:a05:6808:168d:: with SMTP id bb13mr1942572oib.94.1638311166200;
        Tue, 30 Nov 2021 14:26:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s17sm3379390otp.20.2021.11.30.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:26:05 -0800 (PST)
Received: (nullmailer pid 3121999 invoked by uid 1000);
        Tue, 30 Nov 2021 22:26:04 -0000
Date:   Tue, 30 Nov 2021 16:26:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, krzk@kernel.org,
        ioana.ciornei@nxp.com, festevam@gmail.com, tharvey@gateworks.com,
        robh+dt@kernel.org, michael@amarulasolutions.com,
        aisheng.dong@nxp.com, s.hauer@pengutronix.de,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, matt@traverse.com.au,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, nathan@kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/5] dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ
 SystemMaster board
Message-ID: <Yaak/KG0YJmzElQz@robh.at.kernel.org>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
 <20211123151252.143631-5-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151252.143631-5-ariel.dalessandro@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 12:12:51 -0300, Ariel D'Alessandro wrote:
> Add bindings for BSH SystemMaster (SMM) M2 IMX6ULZ board.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
