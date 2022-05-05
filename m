Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3E51CC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386353AbiEEWhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiEEWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:37:53 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB045DBF5;
        Thu,  5 May 2022 15:34:13 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id l16so5811153oil.6;
        Thu, 05 May 2022 15:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+Gp8y6AxYwsLaD1GmNXpXLFzoVgQnSYTYyRgrz67PQ=;
        b=IW0PDxUcTpf4yNSmyMKMX7/PkXoOPks5kmzS1NDw4czCgRjkqTftWk7wINAdCq9cE9
         Fh/38ksqt2lYhF0Fa7oTYGf/7t7LCA8TmsRYJlUCfHqObilC7L3Pc0CsRhfr7Jogzwr6
         3kzqGjtnqPrhhCLh+l8t9zjVTWkYniaNXHE3dknnONNX/j18/m+e6UVnsAbfKedSE977
         S2SY0la5wGDhmYqwURTxbovgJ6zMooN8M7i0fn+Anqwj2apk/+tujsP2cABllQrj9KyO
         Kdm06hYIBUq0JCCwnz82TXBSCQSwAQDrMylU51pCMymBjMsMAGx+cJSvQR6AYbAliUle
         PwwQ==
X-Gm-Message-State: AOAM533LoqalkMEnQZtEy3UsrIElEAXoNGfzrye4R4WKF2PRHcAG5TAS
        02X7pIaHXWVWVOt1a6+U5Q==
X-Google-Smtp-Source: ABdhPJwk/3PSlCYefmrHUoAVQxOOHyS1icmf4PYkQDgH+ehi0kExi085swYRKdAwFVklmawPVf/pZQ==
X-Received: by 2002:a05:6808:1710:b0:2f9:6c36:70cd with SMTP id bc16-20020a056808171000b002f96c3670cdmr195020oib.299.1651790052506;
        Thu, 05 May 2022 15:34:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c6-20020a0568301ae600b0060603221238sm1072314otd.8.2022.05.05.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:34:11 -0700 (PDT)
Received: (nullmailer pid 319908 invoked by uid 1000);
        Thu, 05 May 2022 22:34:11 -0000
Date:   Thu, 5 May 2022 17:34:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: sunplus: Add bindings for Sunplus
 SP7021 SoC boards
Message-ID: <YnRQ4ya2trphqQuo@robh.at.kernel.org>
References: <20220505064430.124657-1-qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505064430.124657-1-qinjian@cqplus1.com>
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

On Thu, May 05, 2022 at 02:44:30PM +0800, Qin Jian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> This patch is separated from the patch series:
> Add Sunplus SP7021 SoC Support. [1]
> To simply thing, I extract it from the original and resend this patch.

This information doesn't belong in the commit msg. You should put 
context like this below the '---'.

Who suggested splitting this out? Normally, new SoC families series are 
applied as a whole by the SoC maintainers (Arnd/Olof).

Rob
