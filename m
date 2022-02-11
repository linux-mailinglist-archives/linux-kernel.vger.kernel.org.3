Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7894B2A84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbiBKQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:37:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiBKQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:37:12 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE363D66;
        Fri, 11 Feb 2022 08:37:11 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id t1so9496288qtq.13;
        Fri, 11 Feb 2022 08:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7bDagNwTbyFCqC0y9Qh0lwkW/ExwbmxN6dXlrPUzBc=;
        b=BTisxNL7TMq/9unzK+BRkI6qOCi5/pGAtbxLPMO4g5R/aIvNLx5mm5TiO9BSv4kyLF
         ZZzqxk9+RvDJCN2BcD05uVZs3MAIdGpgmjQKPEUR0aKv7GSyzZV2CY1Vep3SiK0F7Rvn
         Llsh++VX7+Sn7sjpIxqrug4c0xQK/44pQAChbrCBxUgJCD84yikQmAHSeCXaOohQoQJX
         wumpho724AYtEoYekYQiXY2IdPRVGxNV4HvJzVe0zacPpy9VJ37oRdoIGyCUPLjrBwLN
         7QdUsjzaygF9/8x6E0LgMYGU6S0/TXo0u10FBWa7VP5B/boCsIkmBXicwoZKoPbQzN7T
         vGmA==
X-Gm-Message-State: AOAM531G4YraYC+r4ZCR8MwPQBuiV/FKggnoUp5MjwnpfTXYu36aSamv
        OTijVnB7NymkCipJ0jJhow==
X-Google-Smtp-Source: ABdhPJwS5gz4jcv3urGyIICGNL3GKL5M6Jwr1ZrlzxFL2O3CBFbKeJHfYN2m7+PETMq7D6CJRvSqFA==
X-Received: by 2002:a05:622a:1111:: with SMTP id e17mr1678572qty.229.1644597430840;
        Fri, 11 Feb 2022 08:37:10 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id g21sm13165066qtb.70.2022.02.11.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:37:10 -0800 (PST)
Received: (nullmailer pid 484793 invoked by uid 1000);
        Fri, 11 Feb 2022 16:37:08 -0000
Date:   Fri, 11 Feb 2022 10:37:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     wangjingyi11@huawei.com, kernel.yuz@gmail.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org, wanghaibin.wang@huawei.com,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Trivial typo fixes in cpu-capacity.txt
Message-ID: <YgaQtEpe29NfU3+k@robh.at.kernel.org>
References: <20220208070300.1610-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208070300.1610-1-yuzenghui@huawei.com>
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

On Tue, 08 Feb 2022 15:03:00 +0800, Zenghui Yu wrote:
> Correct the spelling of 'cluster1@max-freq' and fix the wrong
> capacity-dmips-mhz value 576 (which should be 578 instead).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
