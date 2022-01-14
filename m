Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4408548EC25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiANPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:03:08 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40452 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiANPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:03:06 -0500
Received: by mail-oi1-f176.google.com with SMTP id w188so12494548oib.7;
        Fri, 14 Jan 2022 07:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kq72DUdPZWUz6oFtBOiiM+HTLvrJT/SEdHZRNpmx2eY=;
        b=YOipbgut3aUtt4KtVHevdlAOfdSM6Gjf2b1nOx65GXv4n3zhhSZtO+txrBk486rXkT
         BHW2fFzgUfTrcb9qKEYxreR8OXbMQfTfjJUjo+bX2S2mn/DkzDIgQaiqfYmDdZKe2KaA
         av+HrkZAH3tNHpTF7yaAllUb5mOsdN2wPvy4wUBV3tdy8e/0U4wvwYGQCj1fhZf0zX/h
         wvP8dskCZX42blHkZVgskhBalIDBfzHZl9A2KVAAXwe/vLdSzqaz4bILYlhfhohzirXv
         pw3geEePCtz+L+KlFvHL9jFCggcJe/PK/pTSwScoi/ylBNtzOFtTFK0/+z15x9pKGwUF
         AoKw==
X-Gm-Message-State: AOAM531uobgCHtdVG3FUGICqYtJ/0y0OxDSQHbNMRyzij+9E3DRdOICL
        OyH/YLXMq1F3zeGVbxVDicpdC4YrEw==
X-Google-Smtp-Source: ABdhPJz9PQXdkgJNpZr6JGlD+D0/er0zkmcKHOyT8pczQxa6LmK/LqK29RKi/gFJVGdczL1VS8mJiA==
X-Received: by 2002:aca:907:: with SMTP id 7mr13625002oij.128.1642172586034;
        Fri, 14 Jan 2022 07:03:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be11sm2055118oib.43.2022.01.14.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:03:05 -0800 (PST)
Received: (nullmailer pid 1887330 invoked by uid 1000);
        Fri, 14 Jan 2022 15:03:04 -0000
Date:   Fri, 14 Jan 2022 09:03:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: vendor-prefixes: add Huawei
Message-ID: <YeGQqA6FJwrVoNZK@robh.at.kernel.org>
References: <20220113103005.GA4421@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113103005.GA4421@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 11:30:05 +0100, Stanislav Jakubek wrote:
> The vendor prefix for Huawei [1] is used in device trees [2][3], but was
> not documented so far. Add it to the schema to document it.
> 
> [1] https://www.huawei.com/en/
> [2] arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> [3] arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
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
