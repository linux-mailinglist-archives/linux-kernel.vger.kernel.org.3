Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83C4B2750
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350632AbiBKNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:44:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:44:28 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007379E;
        Fri, 11 Feb 2022 05:44:26 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id o5so8534249qvm.3;
        Fri, 11 Feb 2022 05:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6lhbJS0GQ8mSlFcNag0PBxP0WGnDTDUPZws9Tz2PKEI=;
        b=7VQ64XmZWfWbj+mGlPWIvfY9DvMNsmAO7bbFq5dGzKPhL25zASsBW5yMKynb1/iYNS
         2FC+mMe93G31IeSZE/Nx8Jgelbxdu/tx01fWPZkvdkJ9xctAEuKCp1tgaS5tT0yNgoer
         mJ/j4vas6oZLNoRIuyd15B1Y2PVs9pN91MMvxafJDKRCJFFAZ2gSrnSZNRApxmgRDWA8
         I6/qh/KuGcvdt81MGXL13tmlQ2X3F33gKW8O0bo/CTuonpqKxSHARhtdIuaXR4m6rRvJ
         A0fDvHpWyYv5ABPPcJbfjKGJ2cfkyLNhtYOikG5uq7thxBa0x4dzQ4WeapKs26srKnwD
         lmAg==
X-Gm-Message-State: AOAM533RGt3GRPAfA+vODCRMyhZikLRinEFAhOhPh3sWaNeoii44nMj9
        sHmlDTgOsV9+lmdDiMkyLnaVpfqCK8/I
X-Google-Smtp-Source: ABdhPJz/GQx4DrcuRyumqsUxwIwOhB2hk1F87XYv+KH6T6GL86RJ8Ae/elMqLbPnS9bSFeuk3m9bXg==
X-Received: by 2002:ad4:5be8:: with SMTP id k8mr1052760qvc.118.1644587066095;
        Fri, 11 Feb 2022 05:44:26 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20dc:156b:8f01:9329:d9ca:df6f])
        by smtp.gmail.com with ESMTPSA id e1sm3913830qtw.71.2022.02.11.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:44:25 -0800 (PST)
Received: (nullmailer pid 266317 invoked by uid 1000);
        Fri, 11 Feb 2022 13:44:21 -0000
Date:   Fri, 11 Feb 2022 07:44:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-phy@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/4] dt-bindings: phy: Add compatible for D1 USB PHY
Message-ID: <YgZoNXpdzTz4mh5F@robh.at.kernel.org>
References: <20220203013558.11490-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203013558.11490-1-samuel@sholland.org>
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

On Wed, 02 Feb 2022 19:35:54 -0600, Samuel Holland wrote:
> D1 features one OTG port and one host port, like the A64 SoC, so its
> USB PHY supports the same set of properties. Add the new compatible to
> the existing binding.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
