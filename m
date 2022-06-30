Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DF561F18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiF3PUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiF3PUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:20:44 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18195377E4;
        Thu, 30 Jun 2022 08:20:44 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id m13so19521789ioj.0;
        Thu, 30 Jun 2022 08:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/1HbS2XeFkAq2TGo4tfRIV4kCjKVeXOWKZ5BjlPxEG8=;
        b=dQ9s7+9OS7r6QlgA0KpDGAVSdfr1ZXkcU88saRA8GoyPNEa4FK4qYcAwn15VjHb9sL
         LbJW+fnDfEjNHMmKL9xbIoziHCnyaMdpdvOmwT1yyR363ByQRuGsA/MfiUvgocQSvf0r
         73xeR3YX70dSZeWFHawF/5IMfZ8gy5g2poBzrKBdg7vgSAXdcKsCfzi78WYCk2EkiviH
         CYsdGkbCoTQ7im5b1RpdCjYGMVszEe3b/Iwl0TVJlDlMF/26SCI/zt6CzdTH2jXxVMHj
         XMnx6cuEOKLi+upKf8l7N4Rvjivt4RGVDH758hlbWno8lXfcy8pp+U56xDWVgUyyjl0C
         4o6g==
X-Gm-Message-State: AJIora8fP84O5zdRSNEUEQQaNjPy8d4fQiUGLRGGy+btXxh/wdyq1LwM
        IZAFAPu45XbWLmj0OaSXLg==
X-Google-Smtp-Source: AGRyM1vM/iFlvYVryv12Rx56X63E6E8m1CYyPidUegMYK9NrgRMC6l0oefCLQrMCdbepwDwdiiZ5tw==
X-Received: by 2002:a05:6602:1682:b0:65d:f539:e30 with SMTP id s2-20020a056602168200b0065df5390e30mr4625406iow.81.1656602443355;
        Thu, 30 Jun 2022 08:20:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 124-20020a021d82000000b00339a0e19e8csm8632463jaj.90.2022.06.30.08.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:20:43 -0700 (PDT)
Received: (nullmailer pid 2731040 invoked by uid 1000);
        Thu, 30 Jun 2022 15:20:41 -0000
Date:   Thu, 30 Jun 2022 09:20:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7/v3 09/22] dt-bindings: Add bindings for Tegra234
 Host1x and VIC
Message-ID: <20220630152041.GA2730974-robh@kernel.org>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
 <20220627142008.2072474-10-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627142008.2072474-10-cyndis@kapsi.fi>
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

On Mon, 27 Jun 2022 17:19:55 +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Update VIC and Host1x bindings for changes in Tegra234.
> 
> Namely,
> - New compatible strings
> - Sharded syncpoint interrupts
> - Optional reset.
> 
> Also, fix the order of descriptions for VM/hypervisor
> register apertures -- while the reg-names specification
> was correct, the descriptions for these were switched.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> * Add back 'required' for resets/reset-names on older SoCs
> * Simplified reg descriptions
> * Updated commit message
> v3:
> * Split out bracketing change in example
> ---
>  .../display/tegra/nvidia,tegra124-vic.yaml    |   1 +
>  .../display/tegra/nvidia,tegra20-host1x.yaml  | 106 +++++++++++++++---
>  2 files changed, 93 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
