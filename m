Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D817B4EE4E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiCaXqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbiCaXqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:46:48 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700AA1C9B63;
        Thu, 31 Mar 2022 16:45:00 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id q189so1155446oia.9;
        Thu, 31 Mar 2022 16:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6mtxbYAAiRsPFMK/tL1H1rQ1Kmj2pVg6YIYinuDAw4=;
        b=xEAGxc2tXX6ap4Gy7zGl9HoqU+2TPoUkcZn+9i00zCOxDrbKi7zd2YPjAJyXutvUF6
         KJZ15z/UGECL3Kodrsl7MkNf0ZP3T5TSOtLrzgm2AM2xMYyC2H6Le6nzer9LUdcZjMyY
         pE+YVOUhQi7BiPVxyefEmSS43j0OwxugdgMvv924sN/yqQcARNr6Z/OpWfsI92JwJDGz
         L/rNbdaVKhhDcXh1psNBKdDydCuRLLHnxit2lLSskdTdsYzmamPEikpeFFpFKN+2C0Y6
         UP0PWFxTk/hF7SXRm6vmkWd2/U4xDgbNqIjd8wTQFiJ5h4eCW9Ac7CrO4epz2Nh+K7ZS
         bSgg==
X-Gm-Message-State: AOAM533WhP5X5UlH6etPmejF6JF/1DKShRijbFWlUFYDP8Z1JA9rSUCN
        vGdPTaIJQa7gzIk2ZTAekIkRp+KVow==
X-Google-Smtp-Source: ABdhPJzcJTikTpcNMLinxP9sVo0KCKV1+n2mF98uXathWXEvHlZeRZiDR5JjErBsNWB2HSTSm57dtQ==
X-Received: by 2002:a05:6808:189a:b0:2ec:c59c:71e9 with SMTP id bi26-20020a056808189a00b002ecc59c71e9mr389518oib.153.1648770299780;
        Thu, 31 Mar 2022 16:44:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k14-20020a056830168e00b005b22c20b195sm485058otr.45.2022.03.31.16.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 16:44:59 -0700 (PDT)
Received: (nullmailer pid 1719043 invoked by uid 1000);
        Thu, 31 Mar 2022 23:44:58 -0000
Date:   Thu, 31 Mar 2022 18:44:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        krzk+dt@kernel.org
Subject: Re: [PATCH V2] dt-bindings: serial: fsl-lpuart: Add imx93 compatible
 string
Message-ID: <YkY8+lYorUkQ8pIn@robh.at.kernel.org>
References: <20220323093659.1722463-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323093659.1722463-1-peng.fan@oss.nxp.com>
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

On Wed, 23 Mar 2022 17:36:59 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The lpuart on i.MX93 is derived from i.MX7ULP with some industrial
> enhancements, it uses two compatible strings, so update the
> compatible string for i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Drop fsl,imx93-lpuart-v2, that is software controllable per Design team,
>  so we may update driver for that.
>  Update commit message
> 
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
