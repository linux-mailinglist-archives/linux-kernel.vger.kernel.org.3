Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50E4B26CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350401AbiBKNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:06:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244052AbiBKNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:06:30 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DBF42;
        Fri, 11 Feb 2022 05:06:29 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id 9so11289774iou.2;
        Fri, 11 Feb 2022 05:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4xmlfWf50tUZ3D+L/8jhw70jc49jQiJ9ef/u+8mWoE=;
        b=lZ1/6XgEZJLZ1rbdDhSlM7qMJd97Mk89P14PWnN+f0FK9MXXqWF4Uebq0qaDusILq3
         YLQOFehAMHSoPnuPSc1vyIThJ22xI9BtOUN3OH/tfMyXlYHfRBPYvQMyBY/9D3FuEU5p
         Owe0gzwj3p/c6BS+8uqxml0v/6R6oiwtiFXFvyMM6FPQaIj6ySUPTPCmfc4crdGd0IR3
         pBGOQ9t2ge8txpHjvynFzTORvvWphDjq/pzt/kalX6AAx/vyXwicuogX2w85h/3O8ldZ
         Satlv5DS7Yz72gdGUCKrFlf/9Z68EptHoO8/devRau/y9lOH+GaINrCTiF649Dntfq4/
         rnOw==
X-Gm-Message-State: AOAM531/luq3CZSKyxLWynsSfkmOayRsGwE2RX1hxQJFHGOYgpYn9Y4l
        /CnIAqrPOYai6K1U1c/E+oHgEIUB4A==
X-Google-Smtp-Source: ABdhPJwsXOr7w/y2ekhPWdz1akMnkso7KXgn8VNly3qhs14KGK64S5TgW8GCF8ZaiBq4o4WJEhsr2Q==
X-Received: by 2002:a05:6638:3045:: with SMTP id u5mr777825jak.105.1644584789123;
        Fri, 11 Feb 2022 05:06:29 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.139.71])
        by smtp.gmail.com with ESMTPSA id 12sm3532659ilx.20.2022.02.11.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:06:27 -0800 (PST)
Received: (nullmailer pid 223535 invoked by uid 1000);
        Fri, 11 Feb 2022 13:06:24 -0000
Date:   Fri, 11 Feb 2022 07:06:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Injoinic
Message-ID: <YgZfUCMUmjJ2w/3e@robh.at.kernel.org>
References: <20220129222424.45707-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129222424.45707-1-samuel@sholland.org>
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

On Sat, 29 Jan 2022 16:24:22 -0600, Samuel Holland wrote:
> Add prefix for Injoinic Technology Corp. (http://www.injoinic.com/)
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
