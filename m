Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC474E348D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiCUXkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiCUXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:40:03 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1EFE435;
        Mon, 21 Mar 2022 16:38:09 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id q129so15933025oif.4;
        Mon, 21 Mar 2022 16:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8b7Epipii5BGkqqnIUmpeTC0jmBsZOQ1Tko6IQuWeXc=;
        b=EeQNjBydUtHGwXexVkxBBNE6t6IVoTapMhzNjqpRq5yYbBluPn9kI51I691jf7XN/+
         xbltQHyxgq38HltZMSwMG761QRmyecJHtfbHJOzCOH+EOeTR2c9x+ew7OLoNRPJ5Oq4O
         weUPiywRhK2Ztggbl0qon3N2aDzBAhevG+EwdLQx0LzCiZaHN25z/Re0SJqXZVtfmuWT
         nMdxzX3TZbXXdG4NlUbKsfdDuEpshO3mNLKw/ZbDyFvqDtQPhWtU/6FwNBcKaUng7PFe
         TgNTyLURB3NyKpnUoeaE8SQAEaoAjBGBe13xUbukUqIAor+UWWvhjDElscCWd66pRuGG
         DOGw==
X-Gm-Message-State: AOAM533ipkOEv9z0M7xg6rSJhoPt/8lxkfq5S61noh4IL4kj4xx99rB5
        /HgCIP+tl3MLSI1viLbiaQ==
X-Google-Smtp-Source: ABdhPJxCD1OsOX4lizds5dSzn7Refv1mW/OIYri/zgYxYxIMkJZDVP/QLjzeYyI8RQgJfaT60iQ2qA==
X-Received: by 2002:a05:6808:9b9:b0:2ef:7562:1586 with SMTP id e25-20020a05680809b900b002ef75621586mr772018oig.261.1647905888839;
        Mon, 21 Mar 2022 16:38:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l13-20020a056830054d00b005a3cce351a1sm8235978otb.28.2022.03.21.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:38:08 -0700 (PDT)
Received: (nullmailer pid 757601 invoked by uid 1000);
        Mon, 21 Mar 2022 23:38:07 -0000
Date:   Mon, 21 Mar 2022 18:38:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/22] arm64: dts: mt8192: Add the mmsys reset bit to
 reset the dsi0
Message-ID: <YjkMX6loduiyQdZy@robh.at.kernel.org>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 22:45:31 +0800, Allen-KH Cheng wrote:
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8192-resets.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
