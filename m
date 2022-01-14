Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7348EC43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiANPIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:08:46 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46059 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiANPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:45 -0500
Received: by mail-oi1-f176.google.com with SMTP id t9so12478032oie.12;
        Fri, 14 Jan 2022 07:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YTYicPPhRFWsXY3QDuiSRKel4g1TKK3B9wUJLaZfDo=;
        b=D4lOPjvD/hjBdMLvSmQ0XQ6204rK/cwTroDeahRjYVsS9hP6zPa/NEAkRQjBH6bQCa
         72b7DUAvMRqLU0/Ng7n981xeC1hlz8sF29UwO36b5CY+aG+vZCXZjly0DcCuK2ydihVZ
         nMFdBtj0cm9VYhdLZfSGNOwkTIg0/AN3p/HwRt5jBIOMwgManhn7GqBFUIcWM9BiMH4x
         7IFwmdRnoQJ5D0Sb7yqZh3Tikkh9r0sq6eQ3BdlB2VDmwp/hvme3U1vi8MN8OJv9kmg3
         rfFH12k3iFKKYr+taz+nObn/zzmQ8eTIKO8674BKxVnA4q82ZcFZzaBzf18i7bU0+AoR
         /1ug==
X-Gm-Message-State: AOAM533RDZUsO2DQYtQ7jOYCWidQfkFCOQf/1u/b/zapaa09fEPoxbEr
        mX1u32mVUVFw64sOG93FQQ==
X-Google-Smtp-Source: ABdhPJyJz9FMKWj8TT6DhTW5ki3/8rWg2qdpES6uo9iy+RdVJLtxgSts2tF3YlyilgNN/n766RaAaw==
X-Received: by 2002:a05:6808:1a28:: with SMTP id bk40mr7551256oib.26.1642172924538;
        Fri, 14 Jan 2022 07:08:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b26sm2020571oob.10.2022.01.14.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:43 -0800 (PST)
Received: (nullmailer pid 1896020 invoked by uid 1000);
        Fri, 14 Jan 2022 15:08:43 -0000
Date:   Fri, 14 Jan 2022 09:08:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: vendor-prefixes: add Wingtech
Message-ID: <YeGR+wpFJcPfxmfF@robh.at.kernel.org>
References: <20220113103110.GA4488@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113103110.GA4488@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:31:10AM +0100, Stanislav Jakubek wrote:
> The vendor prefix for Wingtech [1] is used in device tree [2], but was
> not documented so far. Add it to the schema to document it.
> 
> [1] http://www.wingtech.com/en
> [2] arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in v2:
>   - Reworked patch description
>   - Rebase on next-20220113
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Rob
