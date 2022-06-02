Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993C53BA09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiFBNpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiFBNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:45:11 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6075E2997BA;
        Thu,  2 Jun 2022 06:45:10 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f2e0a41009so6777631fac.6;
        Thu, 02 Jun 2022 06:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QsEpPPAD6QGNrjKZg/Z6uX8TAObYx6G5aPX9DKMETYc=;
        b=cBQF03rsvw+BNxAa8N2ZMb/dilxrn+DG7R1K0TbRhQjNOF8zwSL6NFPmPDpH+HUWhr
         ZN3DlPJP+tynLPfoJLB/hGEWLMAIV/NtOhc/75uxXbjl/nsHsVzN0iOchXN2hDhI5E+5
         gmtFaAOHxnyK6RDoJS/5P8L4Ym0bbz7CidiWB2faq8CRow38kIve1K+Ku5O7iIiYVZts
         PULBVzWykySjJC74IbBr4ux3hk2pp6SBulfiejayf/hhfRIfWO3mpdwXnmBytVlphPgs
         Q0UWQ8liY9yxRFmKhb22bgE2E52r5bVnG8AgaUcbI4w+9ctSPETi9R5Qq2zZzpQsm9Gz
         lyxg==
X-Gm-Message-State: AOAM533o8NlwAmngBae8uVqKQ+PIBqYi0NstiEfLFK4pPp62Cpn0gRlH
        EMlqg9Yz0w3lUxoF871upw==
X-Google-Smtp-Source: ABdhPJymXyLv9Wr0NBlN0joQq5pJOGQRGVFvY4wxPiFicadD7AnLM8zBnL30SrtGXTSANgRBpFBYVQ==
X-Received: by 2002:a05:6870:4201:b0:f2:a980:2bb2 with SMTP id u1-20020a056870420100b000f2a9802bb2mr19135087oac.230.1654177509685;
        Thu, 02 Jun 2022 06:45:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a17-20020a056870469100b000e686d13883sm2048577oap.29.2022.06.02.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:45:09 -0700 (PDT)
Received: (nullmailer pid 2178259 invoked by uid 1000);
        Thu, 02 Jun 2022 13:45:08 -0000
Date:   Thu, 2 Jun 2022 08:45:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0
 support
Message-ID: <20220602134508.GA2178226-robh@kernel.org>
References: <20220525151040.24024-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525151040.24024-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 17:10:40 +0200, Wolfram Sang wrote:
> Add support for R-Car S4. The S4 IP differs a bit from its siblings in
> such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
> are not routed to the INTC-AP but to the ECM.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/thermal/rcar-gen3-thermal.yaml    | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
