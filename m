Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EC506D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbiDSNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351862AbiDSNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:07:40 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625563897;
        Tue, 19 Apr 2022 06:04:57 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-e2442907a1so17365021fac.8;
        Tue, 19 Apr 2022 06:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmv7BCoG9xMuTHy7XQpuDdOYvPkOMNXrFUTmk6cE7FI=;
        b=WPpkprkBmLhbjM2M/ChvvDDSmcv+A7E9xjsa2YirxJR+2tSwI32RRKQ2ShArthNBR9
         /l1fmd09yCeW0i4I5xlthMkjk74Hm98nszYfUQPXc6DLLMqxFRIpN4jkvO1xa1t86D+c
         h3DFivk27yrNid9+f+KbHsZtCe/To5cTH97WOO0BX34PsxymfazvlQ8kFvdOwkFoEkXJ
         /qkdHpQjWj15BmhQ00lE18h8urRhY5AyUlDvYboCTRIWJr7k8M2jYoDMpzS+652Nzzl+
         sc0dxFbzum3nxGq7Q3vHMLwzbC+ZEJ4kAtCCZIk0j2htgz0c6vLFsRKDwqUE6Lvmf34u
         YkFw==
X-Gm-Message-State: AOAM533wthEaoiIF2aRou5LvFTYfExTXSaMn0N2sKinz3UoJPvf3tiLo
        FDFwN+lSQvHLluAXLWSBzm0HX4Udpg==
X-Google-Smtp-Source: ABdhPJzCnK5W/ao6T4hWW6UKbG98kmw2fUOYc1OlcalHsw1nMMRHO8pUpp1tQ+BR6PjNWJHfYHLhYQ==
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id ej19-20020a056870f71300b000d28adbaaebmr6467542oab.111.1650373496712;
        Tue, 19 Apr 2022 06:04:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a056820028100b00335f00b5b9bsm5268538ood.15.2022.04.19.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:04:56 -0700 (PDT)
Received: (nullmailer pid 2242450 invoked by uid 1000);
        Tue, 19 Apr 2022 13:04:55 -0000
Date:   Tue, 19 Apr 2022 08:04:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: wkup-m3-ipc: Add ti,set-io-isolation
 property
Message-ID: <Yl6zdxYUyGiO9AG7@robh.at.kernel.org>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
 <20220414192722.2978837-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414192722.2978837-2-dfustini@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 12:27:23 -0700, Drew Fustini wrote:
> Add documentation for the ti,set-io-isolation DT property on the wkup_m3_ipc
> node which tells the wkup_m3_ipc driver to use the wkup_m3 to enable
> IO Isolation during low power mode transitions on am43xx platforms.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [dfustini: convert to YAML, make DTS example that passes check]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Changes from v2:
> - correct indentation of the 'allOf:' block
> 
> Changes from v1:
> - correct typo of 'ti,set-io-isolation' property in subject
> - make 'ti,set-io-isolation' only valid for 'ti,am4372-wkup-m3-ipc'
> 
>  .../bindings/soc/ti/wkup-m3-ipc.yaml          | 78 +++++++++++++++++--
>  1 file changed, 73 insertions(+), 5 deletions(-)
> 

Applied, thanks!
