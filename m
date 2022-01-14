Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7349D48EC1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiANPCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:02:39 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46810 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbiANPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:02:38 -0500
Received: by mail-ot1-f54.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so10304673otc.13;
        Fri, 14 Jan 2022 07:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvyf4+LULftRfY0lW4R2iBjAn/YHiM6bKcoc2P8kfrs=;
        b=TAnyHgBOaiGrvezmfCt4bSAg/yiZmuLFkqyyg2wMjOMYki6EYI8nq99DZ9eQ+evAtc
         oDEa+VGYx2f+AxXM2LKHg3x18GdJu4HXHgpwXCjTZEfWsbfw7UzCyUMvmNbxldlh6HFD
         uwFlB5CE55CCG0C9+g0MjCd1X56Y2euThUu37suGATNl6/KlyniuKrzXddOjBpMbG8vy
         l8fUHcVC7dr0YjIE1lK3DXGtQeiXkGE8fQgd/2qkasq3pfsczWzGdQTyLAeslHAvH4pe
         r44m6l1c7wW6VQlkd5u+LTCNeIJ74PcN8Gi4/tLuqHiQFvN2Law4z/aAll6pIZatjVDb
         xlwA==
X-Gm-Message-State: AOAM5335OeUILOhabcbV/E9ognfYCHaXFuoEx0IeeRdBChkLsJ+UbNOx
        CDH8NYPXHHeDlxe+LLVg91ihkuJG9g==
X-Google-Smtp-Source: ABdhPJwppZoXLYzDyJPHkW9X0n4TMl6Gb5Y/5YmIfCsh38GX4R/5XMiMByKDO7Lew3fByKOq+v27jw==
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr1405530otq.218.1642172558083;
        Fri, 14 Jan 2022 07:02:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d21sm1872884oti.5.2022.01.14.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:02:37 -0800 (PST)
Received: (nullmailer pid 1886400 invoked by uid 1000);
        Fri, 14 Jan 2022 15:02:36 -0000
Date:   Fri, 14 Jan 2022 09:02:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: vendor-prefixes: add 8devices
Message-ID: <YeGQjJtN9u6U1zfT@robh.at.kernel.org>
References: <20220113102842.GA4357@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113102842.GA4357@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 11:28:42 +0100, Stanislav Jakubek wrote:
> The vendor prefix for 8devices [1] is used in device tree [2], but was
> not documented so far. Add it to the schema to document it.
> 
> [1] https://www.8devices.com/
> [2] arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
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
