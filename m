Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BB5626AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiF3XS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiF3XSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:18:22 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F8B05;
        Thu, 30 Jun 2022 16:18:12 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id d3so681082ioi.9;
        Thu, 30 Jun 2022 16:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9gNUQLHFQPHo0E6Bk43UyIkswDGTVgKImpHtKfx0xvg=;
        b=k8FAvHCTXex7ryloSNa6RtOC1axvQQFUzg1rBPL5WVT21XDUP1KKbuGi/k6VzeEVJP
         flx8Vc3aeyHY8qRXnCKK/SxAFKhKcvBOLXCyfLBbJhz0JqmeQlHlzM8E1IhL5I0O9DhD
         qiygQ1gP5TW0xElpF+fpL48cVBPeGyKlXLsE/f4iQwfts/LWCoWyVWY+wRdDYHL/qeUQ
         lhVsARKeoeTSk7MmCcE1U7CfQXiPoyGyp1qdCZMUxPo0G/r7RI83LJmo27TeiKVXEI7o
         ap8vw1GnUqvn0ldsmr1alpRgJl8ewujy+UXF/AnkmrUfQe7+83mJoOQDE5NNBhb9ee4C
         eS+g==
X-Gm-Message-State: AJIora8E81FX8W3Nn/3jw2t+pHe/vuMVcUwUdVSIi1gOWSWCFeANaTZ5
        LsC6pe+53Pptsoz1aK302g==
X-Google-Smtp-Source: AGRyM1su16XuZ3P1C/gSpnPqv5Wj9auvAHesaclQYdz2S96RxT7/OA1S+mZcS20iiJlEwB9ke8UXdg==
X-Received: by 2002:a05:6638:410e:b0:33c:d3b8:a4bd with SMTP id ay14-20020a056638410e00b0033cd3b8a4bdmr6441419jab.264.1656631091659;
        Thu, 30 Jun 2022 16:18:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s8-20020a92cb08000000b002d900368a19sm8478492ilo.22.2022.06.30.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:18:11 -0700 (PDT)
Received: (nullmailer pid 3516208 invoked by uid 1000);
        Thu, 30 Jun 2022 23:18:09 -0000
Date:   Thu, 30 Jun 2022 17:18:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?77+977+977+9zrHvv70vVGl6ZW4gUGxhdGZvcm0gTGFiKFNSKS/vv73vvLo=?=
         =?utf-8?B?77+977+977+977+9?= <inki.dae@samsung.com>
Cc:     'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        'Seung-Woo Kim' <sw0312.kim@samsung.com>,
        'Kyungmin Park' <kyungmin.park@samsung.com>,
        'David Airlie' <airlied@linux.ie>,
        'Daniel Vetter' <daniel@ffwll.ch>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        'Kishon Vijay Abraham I' <kishon@ti.com>,
        'Vinod Koul' <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/exynos: MAINTAINERS: move Joonyoung Shim to
 credits
Message-ID: <20220630231809.GA3514176-robh@kernel.org>
References: <CGME20220626163558epcas1p3f525431b9fb237bd420ad1453daaf1ac@epcas1p3.samsung.com>
 <20220626163320.6393-1-krzysztof.kozlowski@linaro.org>
 <0de401d88c38$23aeb8e0$6b0c2aa0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de401d88c38$23aeb8e0$6b0c2aa0$@samsung.com>
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

On Thu, Jun 30, 2022 at 01:16:14PM +0900, ���α�/Tizen Platform Lab(SR)/�Ｚ���� wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> > Sent: Monday, June 27, 2022 1:33 AM
> > To: Inki Dae <inki.dae@samsung.com>; Seung-Woo Kim
> > <sw0312.kim@samsung.com>; Kyungmin Park <kyungmin.park@samsung.com>; David
> > Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>;
> > Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul <vkoul@kernel.org>;
> > linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > samsung-soc@vger.kernel.org; linux-phy@lists.infradead.org
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Subject: [PATCH 1/2] drm/exynos: MAINTAINERS: move Joonyoung Shim to
> > credits
> > 
> > Emails to Joonyoung Shim bounce ("550 5.1.1 Recipient address rejected:
> > User unknown"), so move him to credits file.
> > 
> 
> Applied.

Both patches or just this one?
