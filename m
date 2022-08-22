Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0528759C875
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiHVTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiHVTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:16:29 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650922523;
        Mon, 22 Aug 2022 12:16:28 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso5944973fac.7;
        Mon, 22 Aug 2022 12:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gMA4pmvbAIzu8POkA7NjNp6+LJSojIReqzmKNcU93h8=;
        b=gnRVCAhrdOjArYj7mpz8FX8ZEwS5FoNWLYHGsFN40go0Y31Ye6bxfZ2oSsA0Axi4MM
         43jLTS3CMtRNMUGKmYvs8K2Ul3CgmjmT2VVEcTTDqkLcKv75or7uX7eSbdC0hL0Z/v7F
         KvwN46GKlj/mQvdFaxGLNE3HVEbs3b89JFPy3sp/7et8i14HUbybcPtU8Yz1B+BOv9SE
         K/djv4hylhN4bvTHGcZdPgwsxRn9tvvAdziSPVc0Tn2g1mmcJv6j/gl01b8QpQGZR5Pc
         y5XtTDo3Yx2F8zPlH5Sr8Fx7E7rlL0sEO++1YAp1fC1fP7zlz20xdLDcgivz46ONSENV
         98QA==
X-Gm-Message-State: ACgBeo2OPrGFi1SYEu1YvrdvRQuNa528tFSXbEYW+f+nU+t7wHMzd0hW
        O7vRT0mOz2epDUclJcLRFw==
X-Google-Smtp-Source: AA6agR6CXNkeEGo+jWOdyhpnUOchEq69vi/hvM4iiGR1AphweacC5SrahLzHduTgXO4s0b1KnVEQrg==
X-Received: by 2002:a05:6870:1787:b0:11c:eb96:7748 with SMTP id r7-20020a056870178700b0011ceb967748mr6707396oae.63.1661195787861;
        Mon, 22 Aug 2022 12:16:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t2-20020a056808158200b00344a22e71a9sm2746134oiw.9.2022.08.22.12.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:16:27 -0700 (PDT)
Received: (nullmailer pid 260673 invoked by uid 1000);
        Mon, 22 Aug 2022 19:16:26 -0000
Date:   Mon, 22 Aug 2022 14:16:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: Fix 'dma-coherent' was unexpected
Message-ID: <20220822191626.GA260589-robh@kernel.org>
References: <20220819190729.32358-1-a-nandan@ti.com>
 <20220819190729.32358-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190729.32358-3-a-nandan@ti.com>
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

On Sat, 20 Aug 2022 00:37:28 +0530, Apurva Nandan wrote:
> dma-coherent is mentioned in almost all TI K3 platform mmc
> nodes. Fix warning generated due to its missing match in
> yaml schema.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
