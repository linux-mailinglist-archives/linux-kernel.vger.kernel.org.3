Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08734B2B55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351936AbiBKRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:08:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351922AbiBKRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:08:05 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2792E8;
        Fri, 11 Feb 2022 09:08:04 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s24so10251456oic.6;
        Fri, 11 Feb 2022 09:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7TWwHQgq/gUi7lhU9NsZIWS2INPHgAbX9uQVxuU8C8=;
        b=Fepv0LqUzFUydBeBplvgfZ7Y4fkMAnrFomcsfjzIusUtavw9N05rl2ZYVvENGMHKN8
         ZitD2EjrUyUMJoEmuNOeSJbuqNhJX2JqfnVPWv6sOcnf5SxXqt/mtGAn1ILVHc50+I9A
         m9JCIN/Gtlh6M4YxE15mj68c5FHzzwfDkGc8w+Tttm+IWg5cZp5bg+IheDp5lJWh9ind
         rdwgvoBFEtXWPois/G4cLEzCL1ooLWf4Ci+uHATiwUGMEg1j1EX4f3AmLrvl4E5MLjYj
         0gFlnuB0SAeUsI/Q0gKDW8LWZJvPO0ccxvWdILoPLNknK9ka6pF6s6R6sJIGgDAjsGB6
         JbLg==
X-Gm-Message-State: AOAM53103ssEfAzS6SFtki3cg+53EaTuKptP8k87iMkkYXAAIvvTvfhP
        gXqgLv2xwR12Gb1bPSVF4+pFRUuMVQ==
X-Google-Smtp-Source: ABdhPJyxSa9G6VEbAaX4cveou0lyE+/EhRjxN4fbYgq4kSA+bQ00S52Xggx1BCfmuOEo2hhcrNR4DA==
X-Received: by 2002:a05:6808:221d:: with SMTP id bd29mr675535oib.63.1644599283411;
        Fri, 11 Feb 2022 09:08:03 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id z4sm9269527ota.7.2022.02.11.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:08:02 -0800 (PST)
Received: (nullmailer pid 530607 invoked by uid 1000);
        Fri, 11 Feb 2022 17:07:59 -0000
Date:   Fri, 11 Feb 2022 11:07:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Liang Chen <cl@rock-chips.com>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v6 1/5] dt-bindings: gpu: mali-bifrost: describe clocks
 for the rk356x gpu
Message-ID: <YgaX7ze76nFtEcN9@robh.at.kernel.org>
References: <20220209215549.94524-1-michael.riesch@wolfvision.net>
 <20220209215549.94524-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209215549.94524-2-michael.riesch@wolfvision.net>
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

On Wed, 09 Feb 2022 22:55:45 +0100, Michael Riesch wrote:
> From: Alex Bee <knaerzche@gmail.com>
> 
> The Bifrost GPU in Rockchip RK356x SoCs has a core and a bus clock.
> Reflect this in the SoC specific part of the binding.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> [move the changes to the SoC section]
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
