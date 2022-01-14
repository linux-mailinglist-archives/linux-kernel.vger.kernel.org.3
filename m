Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B948EC22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbiANPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:02:58 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39840 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiANPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:02:56 -0500
Received: by mail-ot1-f54.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso10344958otr.6;
        Fri, 14 Jan 2022 07:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2HGArq4E1KPJM5o8TUjuQ3yPvy2Qb4vpcyeSp8h8BYU=;
        b=nqIuN4diokiMuWgY510yR/6nkLnIzxCxRH+aVHit3iZEZcLIGSI8IexBUpYmEujtoC
         F6GEJRIljxOH4YyyBP5xcaavnYZeDoLzQ4ajUdj+zHN/agLB3imYkMul5f0AZ2PWWpwc
         1eVbkYNZl5+JS0aG4WSDi9IooCPGlB4evn7+VfWKjvq1eowCs6hIqdOQ+WP/nr6a7YMN
         SPQhP6xtkgUpORm85F6Ey9/pf9/pgDpHr130nxpJqZRD4M/tk0AuqUeVS/pEnWe5R9MJ
         cURadr1aiXz6seIo/bcQnxw69IbkO0Q3bemluyUokaymNmc2mofKkjLPD+LbWlGKth5L
         gqVg==
X-Gm-Message-State: AOAM530oVzi3eYiJFVPX0I/TiNrUVW8g1cksGs7v+CyXuzlKD76NxELw
        X/fKBBztVZ6G7rOuR5aVtw==
X-Google-Smtp-Source: ABdhPJwq5AUcIy5G8Wi5cnod8eZNza0Sb3x+BLBLjYSErbUAF7HQivI9EEet/RkHF2nnEjJ2Sk27dA==
X-Received: by 2002:a9d:465:: with SMTP id 92mr7124414otc.35.1642172572717;
        Fri, 14 Jan 2022 07:02:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o12sm1974965ooi.15.2022.01.14.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:02:51 -0800 (PST)
Received: (nullmailer pid 1886880 invoked by uid 1000);
        Fri, 14 Jan 2022 15:02:50 -0000
Date:   Fri, 14 Jan 2022 09:02:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: vendor-prefixes: add F(x)tec
Message-ID: <YeGQmqxGQiYI2Mgt@robh.at.kernel.org>
References: <20220113102926.GA4388@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113102926.GA4388@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 11:29:26 +0100, Stanislav Jakubek wrote:
> The vendor prefix for F(x)tec [1] is used in device tree [2], but was
> not documented so far. Add it to the schema to document it.
> 
> [1] https://www.fxtec.com/
> [2] arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in v2:
>   - Reworked patch description
>   - Rebase on next-20220113
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
