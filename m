Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207B4AE875
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347884AbiBIELE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbiBIEDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:03:15 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78EDC061578;
        Tue,  8 Feb 2022 20:03:14 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id t199so1250726oie.10;
        Tue, 08 Feb 2022 20:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmY7PgTIB+xl2LL7tzgCE9G7RhMcwApZzrQupeWWqm8=;
        b=6h1d2t2G211pKh/J/W6mFYjOM/5w5c6d3YF0bnfFGeHhvt4FqSWWdZnH+5C+TFQlAp
         O9rPRCydoN1IOwcjDPgADWbMDtsEnSq6EFSBX2kSqloezP4AUgjdvaDNqdb+xZnAOxr6
         MH9PJZNgZUPtfoAlphTt/pABs+6HwL/4MqSA8tFdmtt6ZSmo0m1RNFTqM38k1IYt0L6v
         T7kW1K30FlGS9nzm74Hp/VSJdzqEmWVnUPx+UVCG/3Xrf5fn+HdFsw4rNTgn0zOMSJDi
         Z7xDpXsht4fSJCEAnyHZ3dFcBKPATaTJgqiCUQiT+tBRKDem6XwiP6+3FHjmTjVcVaN9
         JmKQ==
X-Gm-Message-State: AOAM5301JHXlMyJsF/ma/sthhrfX1aBLP5A1b29XNceATD9+cAHdpEGA
        N0hN544AUafdo5GXyOnl9g==
X-Google-Smtp-Source: ABdhPJx9qakOYsm8R9weCyJ5x50P3WxmBB4MhXyP6Tg54v2pjw/BqbvG0kz8V3sAEgcHwwz5Clokqg==
X-Received: by 2002:a54:4812:: with SMTP id j18mr514855oij.277.1644379394062;
        Tue, 08 Feb 2022 20:03:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 12sm2580297oam.5.2022.02.08.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:03:13 -0800 (PST)
Received: (nullmailer pid 3630578 invoked by uid 1000);
        Wed, 09 Feb 2022 04:03:12 -0000
Date:   Tue, 8 Feb 2022 22:03:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 01/12] dt-bindings: vendor-prefixes: add Nuclei
Message-ID: <YgM9AMFhzsvhd85O@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-2-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-2-icenowy@nucleisys.com>
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

On Thu, 27 Jan 2022 23:16:36 +0800, Icenowy Zheng wrote:
> Nuclei System Technology is a RISC-V CPU IP core vendor.
> 
> Add vendor prefix for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
