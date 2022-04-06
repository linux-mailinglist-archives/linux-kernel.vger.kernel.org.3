Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375B4F67DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiDFR4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiDFRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:55:37 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F214405D3;
        Wed,  6 Apr 2022 09:05:12 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e2442907a1so3029327fac.8;
        Wed, 06 Apr 2022 09:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MpA4CfNVqRRzfNI0NZazohhpjC3Wdx9B0oPB6HfE+1c=;
        b=ZCruhWHRnvWp3O8B/q7fFIEsktNyHuDsn3qz7ofQHoZ3z+pHNPqKU5ybwV4BxLSEGb
         RAmGu0P1kYxH80xSL9gMkGgNkDsCoNxSCsCbRVjyd3oaBqIHyYk7N8tIW5Zoeh5wtJhf
         1PtPC/w5aHo+/CP4OlFE9h6kLVRwFolXRORDuBjynt9mHDIkoKCZJpVIVFmgcpfIMymk
         AnBfWbGeC1ETs2zJ2E5BuVx+4nkyG49PLe5kmAYC/c7L0K9BoCbV3QEWxVglKHHfdYjY
         ZNJsFw5cEE1f8X/jfPpUK8XDqBZVBSEACQGOvy7P8RL1vtZ2OOYKmGgBwEiDXuuF4fVA
         31SA==
X-Gm-Message-State: AOAM533QeTLZ3TuCCmzONbYhaxP2Qm2a62nbXKJ89Eq0kAnZ0qQmu3Eo
        tbcCD2Bn6OQ+VWaKjQcODA==
X-Google-Smtp-Source: ABdhPJxWnogmTkLiwRUqI1DLFzJoxqP9hindg9vBS92SZbO9tvjdBwxEVyklhAyB6REgphp91XXYvw==
X-Received: by 2002:a05:6870:5b9e:b0:cf:f6de:3e89 with SMTP id em30-20020a0568705b9e00b000cff6de3e89mr4372076oab.94.1649261111777;
        Wed, 06 Apr 2022 09:05:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w39-20020a056830412700b005cda87bbdcesm7033390ott.6.2022.04.06.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:05:11 -0700 (PDT)
Received: (nullmailer pid 2331636 invoked by uid 1000);
        Wed, 06 Apr 2022 16:05:10 -0000
Date:   Wed, 6 Apr 2022 11:05:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: novatek,nt36672a: add
 backlight property
Message-ID: <Yk26Nli4RXgV5KgK@robh.at.kernel.org>
References: <20220401001810.81507-1-jo@jsfamily.in>
 <BY5PR02MB70090BB5D8C7D655BEE0642FD9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB70090BB5D8C7D655BEE0642FD9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
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

On Fri, 01 Apr 2022 05:48:09 +0530, Joel Selvaraj wrote:
> Add backlight property and update example to include it.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>  .../devicetree/bindings/display/panel/novatek,nt36672a.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
