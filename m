Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB844AE864
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbiBIEIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiBIEFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:05:25 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21DAC061577;
        Tue,  8 Feb 2022 20:05:24 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso726643otj.2;
        Tue, 08 Feb 2022 20:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2qiG7G2GNRQ6LqjEvueRABe8KlaGUPbqxlWckqcNpAQ=;
        b=tf74ohZJaKRghj+XCDO0JZyg8sDNh8lzrUqW7K6h0fWEn6z5zDMwpnH6tEXHd8WGYW
         XxO0SQL26kpZ9vokZ1zTNJV8jFO5hXL5Pq6h/v8ZvPdQUuOX8PDhZDcdgGgpmpNo69GW
         Sl7QinJ1uLup7p6OWyJhQfdWJiXQ0GC4MEnBTqRwdxeg4QUdXEp+RcYFE8AfY46Nkj90
         2q/30xZmceRvqJ4c28BrjSnh6vTB82+uQodc/mmHLJ+lrMl2bOQHBCQDywfd9RVp/9r9
         IIAs8kXwgwhc54o4ZDbZZFVdXc7JdXAXOWCAeM83XYpgfrxJK3OD+OAojjggHkqsaocq
         aY3w==
X-Gm-Message-State: AOAM531qkLVhF3ymQZmhggu+wVnuYe3QdDTEBEUvjE5DxWFEzPKcRKow
        nJl/P+Lrb0Fust20ychDjg==
X-Google-Smtp-Source: ABdhPJynH5fEDWLtkyVZ8PCGjm16IhKQQhYktEgLlsd+uWoGQKCSWN+0Xt8uX2xw3Pvao+5XKQLBZg==
X-Received: by 2002:a9d:6041:: with SMTP id v1mr216308otj.35.1644379523866;
        Tue, 08 Feb 2022 20:05:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 128sm5696608oor.15.2022.02.08.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:05:22 -0800 (PST)
Received: (nullmailer pid 3633432 invoked by uid 1000);
        Wed, 09 Feb 2022 04:05:21 -0000
Date:   Tue, 8 Feb 2022 22:05:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 03/12] dt-bindings: riscv: add compatible strings for
 Nuclei UX600 series
Message-ID: <YgM9gZ0e/yoiHys9@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-4-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-4-icenowy@nucleisys.com>
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

On Thu, 27 Jan 2022 23:16:38 +0800, Icenowy Zheng wrote:
> Nuclei UX600 series are 64-bit, MMU-equipped CPUs, which can run Linux.
> 
> Add compatible strings for these CPU cores.
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
