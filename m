Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4554735FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbhLMUbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:31:36 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:34389 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbhLMUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:31:30 -0500
Received: by mail-oo1-f50.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so4473205oog.1;
        Mon, 13 Dec 2021 12:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Jz4O5bCit+lttjk1cWgGeasdedfgCU+0At2jS7RFSQ=;
        b=WcKl/R7Xblr8lT+3xop75dMYtdDAfdzESY2/kPgTjkjJ0fDUY7I53NmCfn365OYJp3
         sK36+uJ8V8geR2vn8WHGJCCpXwjwfW6jXfuzPgiozUCCvWAEK/oSyJ0r0L8sCTFcPUXh
         ZkWaFTLvhlEfbHg1rk/GRida77oMEPjsHTcx0Z6cOAnxCdlMFztmhaArdIrAm0qy9G7p
         m4Tnyx3+/tOocVWDhE2wOyJcHL2hsmfVbalZi16tIg329qWMryEOJFNZLopVSdiRvfUh
         y14uuV8fXVq/rGQV7XJz7xJJRsDz9C3Lgf9xkvpsKl4QdA0bhOdS2zX6NbG20NX4rkaO
         nrhw==
X-Gm-Message-State: AOAM530ak3f54J9el774me2SLvy2vcHKBQtgdQ/LzvIutcdItbLZ06Wf
        VxdVZvPzazPcYisjM0SL0Q==
X-Google-Smtp-Source: ABdhPJx7lUq1A20jc5mI60hoJ2qUBaBDpxbjw29ueJ948efm/GYtUpX11ooAyBeEUo7gl9BXh/sNbQ==
X-Received: by 2002:a05:6820:151b:: with SMTP id ay27mr535785oob.22.1639427489902;
        Mon, 13 Dec 2021 12:31:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m22sm2534192ooj.8.2021.12.13.12.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:31:29 -0800 (PST)
Received: (nullmailer pid 1520651 invoked by uid 1000);
        Mon, 13 Dec 2021 20:31:28 -0000
Date:   Mon, 13 Dec 2021 14:31:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        anan.sun@mediatek.com, yi.kuo@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, lc.kan@mediatek.com,
        linux-kernel@vger.kernel.org, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        anthony.huang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: memory: mediatek: Add mt8186 support
Message-ID: <YbetoA2JJtnXj7gm@robh.at.kernel.org>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203064027.14993-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 14:40:25 +0800, Yong Wu wrote:
> Add mt8186 smi support in the bindings.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml      | 4 +++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml        | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
