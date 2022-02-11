Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311304B2793
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350680AbiBKOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:10:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBKOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:10:41 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD9C47;
        Fri, 11 Feb 2022 06:10:40 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso6125883otv.13;
        Fri, 11 Feb 2022 06:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Uhr9cYX78qEIUsBkMhMqNMlXrRmPdKykvEXZjo7HdU=;
        b=vjmRkSA6C8X5IHCqk1PZPqqd2lHLIyLHcKDDQvBmEgbSBonnwxeX56j1qEyaCXs35u
         WDDPR7uO4fmkZ+Lj6Orvy3L705nB4U9H9H7vI2NjjIjwvxVgESsOQvifiaDNH0O72uka
         ZT+Q0eJHkZwgLsSX8wR+QQiNTkcBC4DFcCero20DPL1MgfFS+VZBHFywnJ2KKkH3bzBI
         lqcAIS/wMIDnwbdpLL7vWbiESNekaecWvqFuZzg3D4ufcvp9O7l3Q0kv07ijNkHf6mPH
         8veLaygop5p8uNMJ2KzI8awMGe22fh49c7s5edjFzPIqCHnrykgIzzuuV4VtXswDVvB4
         69ZA==
X-Gm-Message-State: AOAM531lYzUCQTt/ZLGiYtPqPK3TKBE5S2gn3lW44VFaA1zPLqfIH1Qv
        k7U4BUZVdacX4aMKnEmLxytKx2xgfQ==
X-Google-Smtp-Source: ABdhPJwmHy8wVVTgC0lq727cl6IABGxMi9jl4aT/u77Oly3Y77xIIHl2c33ygoRFzepL98cEHqf42g==
X-Received: by 2002:a9d:1ca5:: with SMTP id l37mr614305ota.221.1644588639300;
        Fri, 11 Feb 2022 06:10:39 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id m26sm9465959ooa.36.2022.02.11.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:10:38 -0800 (PST)
Received: (nullmailer pid 287630 invoked by uid 1000);
        Fri, 11 Feb 2022 14:10:35 -0000
Date:   Fri, 11 Feb 2022 08:10:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: SID: Add compatible for D1
Message-ID: <YgZuW9Fcg8wsGDM0@robh.at.kernel.org>
References: <20220203012502.10661-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203012502.10661-1-samuel@sholland.org>
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

On Wed, 02 Feb 2022 19:25:00 -0600, Samuel Holland wrote:
> D1 has a SID like other Allwinner SoCs, but with a unique eFuse layout.
> Add a new compatible string for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
