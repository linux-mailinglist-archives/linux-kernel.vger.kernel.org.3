Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEF4D30B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiCIOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCIOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:02:35 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E34177750;
        Wed,  9 Mar 2022 06:01:37 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so2966533ooc.4;
        Wed, 09 Mar 2022 06:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9h+VgimDPzKmm9gQrMAZMjtCY2p52lqtdIgajQPtHeQ=;
        b=eElDoaYdaT3uywPl7dbk+R2+Kbi0IgsnYlbUKx1DRn0dpgSh1ZDQff6DiImcdAt3mc
         5jsXamm64t0X1EXFPnwyYyXHsj9Zlnwe8PwKnVJ6Vy5fxARte1b3kNRG7dwSI8l7XRpX
         l24jwsZFtzWSoQouI07rlvFU2yfPXeYW7KepVnIbjG5LCNxadrWy3KpDTKyM8bQt5UTT
         nou0AeECf/3wsu1FMfAgAgH4S7fXA8/3wuIMIxcuilRaMKl78fpF4T7cr8Wq3CvfyEvB
         tJ989qDQ6iwDITP4ML7liJoZpRy3kSpDrPSVIK3LCYbYpb1XL2XnUtxhxW3Kfp3rLSa/
         p8QQ==
X-Gm-Message-State: AOAM531Z9TZ/L+emEOO67fConFY1DlhwRoAZvUTHkKmX27IyLX2ROzNa
        R/oEKBp1v8zdz/nMxuOYtjG6cyjLiw==
X-Google-Smtp-Source: ABdhPJzcmvCDmpMAhswz9z1pW8O+P9wv8DfR5j7J/fWLXWXeXEI66XrMiuplmmJGklJzt/HLpZ24dA==
X-Received: by 2002:a05:6870:40ce:b0:da:5b07:231c with SMTP id l14-20020a05687040ce00b000da5b07231cmr5556887oal.284.1646834496465;
        Wed, 09 Mar 2022 06:01:36 -0800 (PST)
Received: from rob (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d12-20020a056871040c00b000d9eed0f8fdsm922917oag.14.2022.03.09.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 06:01:35 -0800 (PST)
Received: (nullmailer pid 2795989 invoked by uid 1000);
        Wed, 09 Mar 2022 14:01:34 -0000
Date:   Wed, 9 Mar 2022 07:01:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, robh+dt@kernel.org,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        linux-spi@vger.kernel.org, fancer.lancer@gmail.com,
        kris.pan@intel.com, rashmi.a@intel.com, mahesh.r.vaidya@intel.com
Subject: Re: [PATCH v4 1/3] dt-bindings: spi: Add bindings for Intel Thunder
 Bay SoC
Message-ID: <20220309140134.GA2795938@robh.at.kernel.org>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <20220308103331.4116-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308103331.4116-2-nandhini.srikandan@intel.com>
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

On Tue, 08 Mar 2022 18:33:29 +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add documentation for SPI controller in Intel Thunder Bay SoC.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
