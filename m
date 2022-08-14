Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909459266B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiHNUwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiHNUww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:52:52 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7717318396;
        Sun, 14 Aug 2022 13:52:50 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id o184so6850618oif.13;
        Sun, 14 Aug 2022 13:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LAC26vuWWk3gCaDWJNm9l2Fjbt1ivPXsiX98d4JwYas=;
        b=o4c9+4kupgxsh77hMluN63oOQAbw2Jvte5DMCXOZ0WTNEI8jRy78ereWMmJnLQnEj8
         ubvGpHcTjMCFK1gnrFnqBHWPMl037ZmH1O4QpSI9ras9TyYJhZl+aQviUiIBt+cAKV55
         15r/dMCh3ZwF23XIf0TJPo4w51ULeknDzxrjqLDP1plMmwBgBk1p3CCpw6GHjZ43xBAS
         zxikUWGQX/HH0JtevH2OzKTIQiokT8GleAiDY/O0ccU/lHxWZ71KmGOxDcv0nJyP0fjU
         l7DJa4XPg6OgQR3vLe0g35flVLdWGa11vGQEpjZ5yXbs9ALwueApOevSs7ildTC3P+ib
         SNbQ==
X-Gm-Message-State: ACgBeo3Wa59FMt6QhmxlXF0BHFmKeI/1S84CF7NYjss0zhEF/kY19B9I
        J4Df6JUndqZE4Qo4kCmzdg==
X-Google-Smtp-Source: AA6agR5qLDjA8QtMseFcyx1GQkQvjA5AGWHakvvuyaJ/YcennDkUfVXafq0W8Qak+Lw5OPcU8XTUig==
X-Received: by 2002:aca:d17:0:b0:344:bea0:8c83 with SMTP id 23-20020aca0d17000000b00344bea08c83mr213854oin.104.1660510369785;
        Sun, 14 Aug 2022 13:52:49 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
        by smtp.gmail.com with ESMTPSA id k185-20020aca3dc2000000b0032e3cca8561sm1499282oia.21.2022.08.14.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 13:52:48 -0700 (PDT)
Received: (nullmailer pid 690769 invoked by uid 1000);
        Sun, 14 Aug 2022 20:52:45 -0000
Date:   Sun, 14 Aug 2022 14:52:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org, devicetree@vger.kernel.org,
        git@amd.com, shubhrajyoti.datta@xilinx.com, srinivas.neeli@amd.com,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        git@xilinx.com, linux-gpio@vger.kernel.org, michal.simek@xilinx.com
Subject: Re: [PATCH V2] dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi
 gpio binding to YAML
Message-ID: <20220814205245.GA690719-robh@kernel.org>
References: <20220810124109.34157-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810124109.34157-1-srinivas.neeli@xilinx.com>
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

On Wed, 10 Aug 2022 18:11:09 +0530, Srinivas Neeli wrote:
> Convert Xilinx axi gpio binding documentation to YAML.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V2:
> - Updated mainter email with s-o-b.
> - Updated few constraints.
> - Addressed few other comments.
> ---
>  .../devicetree/bindings/gpio/gpio-xilinx.txt  |  48 ------
>  .../bindings/gpio/xlnx,gpio-xilinx.yaml       | 154 ++++++++++++++++++
>  2 files changed, 154 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
