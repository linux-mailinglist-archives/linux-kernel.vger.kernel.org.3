Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B145C48BCB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348015AbiALBtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:49:11 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42675 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348008AbiALBtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:49:10 -0500
Received: by mail-ot1-f50.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so886247otr.9;
        Tue, 11 Jan 2022 17:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPHuh7nUlNhunmzxkS2DT0Z6Udi668Vku2E5vSgqzcg=;
        b=qkLOgWMh+4aF1B+Xo2OjNnZowfS6KxcO61qdlc6IFFsRt0cezKnnqvN+XQBK7vTnNl
         NwP0n4dyNEqsWzL1OBsBfzPfrq6E0xkIxIOEBcjhf0CbC1ipE8ShrENzWcW4jjUKtcCE
         fCR6ZBtRwQZaWllJT8+Ilq64O9ReZmXQmJ9bHhl/3ZUfPsl0BVFNPp6gVcvCeFb2i478
         YAuW+kuYFzYJfggoG/3/At2yRSw1G5blmyexG6erFnk6sLsqAXGBmZFMHGBdKjmMb/Bg
         qbdzaB5uAl66Aq7/05BX/90hFVgeC6gQeJaOh1cTIfXPKoLvaxC2MRA2e3rDFXzVOS9n
         NTbQ==
X-Gm-Message-State: AOAM5319hthdu4kBHU4fSytvSRCJ5qw3TP3CW6IkBb6UMVYmsls09O7L
        AOg+XTeUE/V/dwTDcpvatw==
X-Google-Smtp-Source: ABdhPJy+ZFeAfKBEgUiTlEDgUViJcPBXuLvv1l8zGjnO3HBnks6uNg5GCI3tJ/t8bhYXkYflB9kZlQ==
X-Received: by 2002:a05:6830:2785:: with SMTP id x5mr5269374otu.187.1641952149704;
        Tue, 11 Jan 2022 17:49:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d3sm2133809oiw.52.2022.01.11.17.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:49:08 -0800 (PST)
Received: (nullmailer pid 3896384 invoked by uid 1000);
        Wed, 12 Jan 2022 01:49:08 -0000
Date:   Tue, 11 Jan 2022 19:49:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mediatek: add compatible for MT8186
 pwrap
Message-ID: <Yd4zlMykh8GfZQtH@robh.at.kernel.org>
References: <20220107104633.7500-1-johnson.wang@mediatek.com>
 <20220107104633.7500-3-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107104633.7500-3-johnson.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 18:46:33 +0800, Johnson Wang wrote:
> This adds dt-binding documentation of pwrap for Mediatek MT8186
> SoCs Platform.
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
