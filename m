Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3177F47C7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbhLUTsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:48:18 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43936 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhLUTsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:48:17 -0500
Received: by mail-qv1-f53.google.com with SMTP id fq10so237705qvb.10;
        Tue, 21 Dec 2021 11:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEEn7W+abTOSJCOoEABxlh4oQei3MK0PGB8mi7Ij2yQ=;
        b=EpXT/2e/tZ87jlQ66Nstu8ZLU3uf5OqTeka1HQbz7IZqSjvDk3/1pLeDE0S9gTxGQY
         wp+5+2okgf9UoPwoAwHr9eHIl1sDmNL30D1ICs+KGmWpAoG6QlMM90phpnrJcu60VTKj
         fDXQsuLY3BxIhRwT5o/jiGd0dsD615VK6VjHBNP7pbetQZRjEoToO8mjwjOeSVYZl5Tg
         4XDc/agavwVTIgV3teFRngUYEzN/PK9lSkZnQqIF3d1Ag6cti+QX1E9jP+CTPKNCaDqN
         JPudkCc7g3dAZK96FLPryBpRtie7TF3CsYuMnJRiA3ZX/vbcamiZKJZZBFNibqDwC70J
         zUMQ==
X-Gm-Message-State: AOAM530EtesyiXRG3qica/l9IvMtngx67zozemxoW6kB8JldA6BbZiIK
        8Cs9V7tbNw1boLRbKOtQIA==
X-Google-Smtp-Source: ABdhPJzgmDHlA9Zo+gFHuOAv5btwwZK7lHQ8X/OVnBRyRkKvS/dXMCrGDSok0rkg99yE4yk7Ag3u+w==
X-Received: by 2002:a05:6214:2345:: with SMTP id hu5mr4013203qvb.130.1640116096424;
        Tue, 21 Dec 2021 11:48:16 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id h13sm18492494qtk.25.2021.12.21.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:48:15 -0800 (PST)
Received: (nullmailer pid 1635267 invoked by uid 1000);
        Tue, 21 Dec 2021 19:48:14 -0000
Date:   Tue, 21 Dec 2021 15:48:14 -0400
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Subject: Re: [PATCH next v2] dt-bindings: nvmem: convert mtk-efuse.txt to
 YAML schema
Message-ID: <YcIvfkynRGRqQR2X@robh.at.kernel.org>
References: <20211218081515.4971-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218081515.4971-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 16:15:15 +0800, Chunfeng Yun wrote:
> Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2:
>   1. remove description of subnodes which is covered by nvmem.yaml suggested by Rob
>   2. change the example which is commoner than mt8173's
> 
> ---
>  .../bindings/nvmem/mediatek,efuse.yaml        | 86 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ----------
>  2 files changed, 86 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
