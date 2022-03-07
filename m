Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447154D0460
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiCGQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242874AbiCGQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:44:21 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428056E8E1;
        Mon,  7 Mar 2022 08:43:25 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso18448031ooc.7;
        Mon, 07 Mar 2022 08:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ahRBp9yt0ZPpBFG2Tzui7hdIn/8fP27GT8DryPqqNA=;
        b=BEZjuzVKmBIVzC5et7bQJ/zG7qxAgFJwhePePnLG76JizQSq+PHtoSVaiPS4rxmZ0E
         JSpFF+TyNyrBOwNUB5knDd1L4/ebBWpsU7jby4gEFD0l1CGOsa/T6YpKqjGhw1NinWe5
         MTGpGjzjk0HXQA0qIzzp+MvlUmO5w0fC3b0QLqT5zNNoIM+g2V1fFoyV/CKDbO7NfjmH
         pV9IASbYcyIT18NX8U+82ELycLQQkWuIcmxnzjkUxKXDMqCYqPNBO9Khq7z2hidEtNBR
         C27I3Ks8YwsKXJyiKb6Hy9gQ8dQi5bAw9oV3NaXwTt/u7bK7oWj+LFMvy93HqT49jTfb
         iIRQ==
X-Gm-Message-State: AOAM5303jBsyDiIV0AXjvM5N2yaSMqrC80CtdtghFkca6XI66zJymnTy
        8n9a5QTfEhGVo11A/aLcOw==
X-Google-Smtp-Source: ABdhPJwK7Z8VahsxmcSCvl23V4RUpi+Y1xGPVc+4r9GinlZLpWcbqoisF16Xe98HLqEc7r2Fua2VNA==
X-Received: by 2002:a05:6870:315:b0:d9:a20e:c0bf with SMTP id m21-20020a056870031500b000d9a20ec0bfmr6530459oaf.128.1646671404592;
        Mon, 07 Mar 2022 08:43:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g2-20020a9d5f82000000b005af678c9cfdsm6527808oti.41.2022.03.07.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:43:23 -0800 (PST)
Received: (nullmailer pid 2731161 invoked by uid 1000);
        Mon, 07 Mar 2022 16:43:22 -0000
Date:   Mon, 7 Mar 2022 10:43:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     airlied@linux.ie, daniel@ffwll.ch, matthias.bgg@gmail.com,
        xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v1 2/2] Revert "arm64: dts: mt8183: jacuzzi: Fix bus
 properties in anx's DSI endpoint"
Message-ID: <YiY2KiXz1qsFQvuM@robh.at.kernel.org>
References: <20220307154558.2505734-1-robert.foss@linaro.org>
 <20220307154558.2505734-3-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307154558.2505734-3-robert.foss@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 04:45:58PM +0100, Robert Foss wrote:
> This reverts commit 32568ae37596b529628ac09b875f4874e614f63f.
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index e8f133dc96b95..8f7bf33f607da 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -171,8 +171,6 @@ port@0 {
>  
>  			anx7625_in: endpoint {
>  				remote-endpoint = <&dsi_out>;
> -				bus-type = <5>;
> -				data-lanes = <0 1 2 3>;

Well, this was clearly wrong. Connected to a DSI output, but parallel 
interface with lanes...

We should have a schema to disallow this combination.

Rob
