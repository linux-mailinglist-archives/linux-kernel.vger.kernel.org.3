Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BF4AFC01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiBISwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiBISu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:50:57 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F62C05CB82;
        Wed,  9 Feb 2022 10:47:19 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id x193so3510098oix.0;
        Wed, 09 Feb 2022 10:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vi9Au0Crkys221dhKz7ZSE2Xq4A6zOmUcKMnPw7BPg0=;
        b=TnyB6MlpInW2Dhf71kV4Yh3uwcCN5h+lJbHeJzCr+vPNHy8GrGJ4DHUyTzbnfCg72g
         nX7y70fv0RbXah9p6lLR0GRE8wym69i4oZcgtEXrWwoQ9AGeuxS1QvbJ80PNsFkDIMZK
         TF94+oAzMX3yA75ri+FRuwy1ZQmS4aDS2C8almST+e53GSvUCst4ZnnaRkAW4nMhTSZi
         NV4/gkLF/uWfJQ1WaeumgeuwIAhS5zXAiUOd8GXb9cQ4J/zoTgi0/A3H4Km/8X5Xf4PC
         DaUpP1kNM5Tssp5ykKuu746m79+0t2Y5Va4pvSNR8FsuFneq+1JCGXAXZx/rtqQcKQku
         RwHQ==
X-Gm-Message-State: AOAM533uBrcx1aqrOtD4OxzWTQWR0QqmAKKZvar5y/bJbMh11FLyfzZ4
        5NVHAGHQOl2+ahmpYR2kmA==
X-Google-Smtp-Source: ABdhPJz2/34m/qedqsW5DnC2O+nTKA3JCDJGbT7oI2zsMJoDh9v3/cY/jxcuG92UIOEWq8AUGvWeXw==
X-Received: by 2002:a05:6808:1899:: with SMTP id bi25mr2020002oib.38.1644432438872;
        Wed, 09 Feb 2022 10:47:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g9sm454209oac.3.2022.02.09.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:47:17 -0800 (PST)
Received: (nullmailer pid 675998 invoked by uid 1000);
        Wed, 09 Feb 2022 18:47:16 -0000
Date:   Wed, 9 Feb 2022 12:47:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org, maxime@cerno.tech,
        huffman@cadence.com, liush@allwinnertech.com, xinhaoqu@huawei.com,
        behrensj@mit.edu, anup@brainfault.org, jscheid@ventanamicro.com,
        allen.baum@esperantotech.com, philipp.tomsich@vrull.eu,
        aou@eecs.berkeley.edu, wefu@redhat.com, arnd@arndb.de,
        andrea.mondelli@huawei.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        cmuellner@linux.com, drew@beagleboard.org, rtrauben@gmail.com,
        samuel@sholland.org, palmer@dabbelt.com, atishp@atishpatra.org,
        mick@ics.forth.gr, devicetree@vger.kernel.org,
        gfavor@ventanamicro.com, wens@csie.org, guoren@kernel.org
Subject: Re: [PATCH v6 11/14] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
Message-ID: <YgQMNKXytqFZFiib@robh.at.kernel.org>
References: <20220209123800.269774-1-heiko@sntech.de>
 <20220209123800.269774-12-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209123800.269774-12-heiko@sntech.de>
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

On Wed, 09 Feb 2022 13:37:57 +0100, Heiko Stuebner wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> in the DT mmu node. Update dt-bindings related property here.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
