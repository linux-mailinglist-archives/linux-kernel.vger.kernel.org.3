Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20650015B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiDMVu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiDMVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:50:53 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B345AF3;
        Wed, 13 Apr 2022 14:48:31 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so3394017fac.11;
        Wed, 13 Apr 2022 14:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZ5IzuZnas4l985nK14wT3+DopEhh7ikMHaxt3BDgXM=;
        b=jTeD2grer85EVV7c14K1izk+fMAj+iMONrrjYMf2DBxfsSfwZFf2C6fzfLtOggeRKY
         yAotS7AuhPfkGs0AqwwYDYL1iQy5HMT97/a5ABQLfGGeBRyuCdJHLx8Q+iSB11q4fHtD
         xvOEV8ngSWpbkOVqRc3MbTeA8kDiT3Bdg+pMS+775nzXS2h3ztpDZn5HlYyCzLm3mibC
         eOdteqBSr+K6R2RsLf7802e7bxXML5nRpcnBxLg9j8kOzDcbcs/8HwjkgxAtUm9PN+Bj
         TYCioqh97oevE1xi05pPb/oDnmA7tvGKeoMSS04w8/KAL5c80JMSGWpmS0GNC4gvemc9
         Ln8Q==
X-Gm-Message-State: AOAM532DVOQCQcx6bEH7MwmykNPBTd5ZEkZ67ehrulF0mJrSPMYdlfTL
        aBkDz0fnpZ8jgooXNdt0wQMbE2YkeA==
X-Google-Smtp-Source: ABdhPJw4ZdAXg+C2H30RcFzAEja9aJehGfKq2X8p4MbBKy7GLUywETryMRUNad86bKsFuDke8FIigA==
X-Received: by 2002:a05:6870:ea81:b0:db:3e68:7ae0 with SMTP id s1-20020a056870ea8100b000db3e687ae0mr333225oap.9.1649886510444;
        Wed, 13 Apr 2022 14:48:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fu17-20020a0568705d9100b000e2b43e7fbasm85105oab.16.2022.04.13.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:48:29 -0700 (PDT)
Received: (nullmailer pid 4000263 invoked by uid 1000);
        Wed, 13 Apr 2022 21:48:28 -0000
Date:   Wed, 13 Apr 2022 16:48:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle gpio pin
 property
Message-ID: <YldFLAVMWhcpn1QC@robh.at.kernel.org>
References: <20220409211215.2529387-1-dfustini@baylibre.com>
 <20220409211215.2529387-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409211215.2529387-2-dfustini@baylibre.com>
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

On Sat, 09 Apr 2022 14:12:14 -0700, Drew Fustini wrote:
> Document Wakeup M3 IPC property that indicates a GPIO pin is connected
> to the enable pin on DDR VTT regulator and can be toggled during low
> power mode transitions.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [dfustini: converted to YAML, removed unnecessary "ti,needs-vtt-toggle"]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Applied, thanks!
