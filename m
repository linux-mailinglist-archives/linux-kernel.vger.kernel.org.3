Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4154BC57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351313AbiFNUwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbiFNUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:52:33 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE674F9E3;
        Tue, 14 Jun 2022 13:51:59 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i16so10693782ioa.6;
        Tue, 14 Jun 2022 13:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vEhKyiwSkvMhpQPqz27zvlhasbbXhfYI8itajPq3Tqs=;
        b=LiQHaisvST7R+JxyL8OHL1jgenDWyBIoiFCF/De60B6dUeQfwdVBKQzmXIVi029w+2
         gQxE7PZq4PUMagUXR5FmtXXtKKzL/3K5G8Lg62hSKO73xbThzQhMtM4o4KUy07I6Fu8M
         +wV5EoBqRGjl7d3q3vSbsPmQ+PdkqCnqF5opg9290UcoGeimapzj3mg4n3AwCrxJZUgi
         sjWCj8k8mAKdrgDVhu6JcMuoSBNJ+qtRdGqmuJcO3Z27ocid3G+jEnY4D49fyMrPSHbY
         Nhe/A+0NreYeNrh6qoVuOJ4kaw9+JXdY4Xa9d6B3TXB5+f4RoX0z4BwrhPmUuKsrpENH
         zx3Q==
X-Gm-Message-State: AOAM533OTPMN2R8Zp3oUmrQ/QaiocSA3iK3W1Vgb0APBJQDBjlgiozuM
        isssKUBCsqcZPFufqrvqJw==
X-Google-Smtp-Source: ABdhPJz05+Abh7ww6RIA19LasSuRYcdUbnQljhwuk8+Ahf+tw/53syf0W1+0o5HZdXTaf57au9MTvg==
X-Received: by 2002:a02:2305:0:b0:331:a026:b650 with SMTP id u5-20020a022305000000b00331a026b650mr3909034jau.314.1655239918349;
        Tue, 14 Jun 2022 13:51:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f7-20020a022407000000b003319a68d2f5sm5300808jaa.125.2022.06.14.13.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:51:57 -0700 (PDT)
Received: (nullmailer pid 2525434 invoked by uid 1000);
        Tue, 14 Jun 2022 20:51:56 -0000
Date:   Tue, 14 Jun 2022 14:51:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     git@xilinx.com, sgoud@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, srinivas.neeli@amd.com,
        michal.simek@xilinx.com, neelisrinivas18@gmail.com,
        shubhraj@xilinx.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH V8 1/3] dt-bindings: rtc: zynqmp: Add clock information
Message-ID: <20220614205156.GA2525228-robh@kernel.org>
References: <20220613125836.523449-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613125836.523449-1-srinivas.neeli@xilinx.com>
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

On Mon, 13 Jun 2022 18:28:34 +0530, Srinivas Neeli wrote:
> Added clock information and deprecated calibration support.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V8:
> -None
> Changes in V7:
> -None
> Changes in V6:
> -Removed dtc warnings.
> Changes in V5:
> -Removed quotes and _clk suffix from clocknames.
> Changes in V4:
> - Deprecated calibrtion support
> Changes in V3:
> - New patch
> ---
>  .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml     | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
