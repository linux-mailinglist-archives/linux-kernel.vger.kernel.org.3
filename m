Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54B50E9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiDYTs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiDYTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:48:23 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3311168;
        Mon, 25 Apr 2022 12:45:18 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e93ff05b23so4088607fac.9;
        Mon, 25 Apr 2022 12:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nL+zI+HWL/Tih9Z10+rT6WnqT+vKhCLQplUzncGeQbU=;
        b=Nevxqm17qYNyJva4a1XbwzS93Gwg/i6CUhmKKmdclWckdkc5WsCIUry4BePUNJ/Kna
         +y/qXXX8wQM25+X4qprwgcnz6ZQGzIL1vDrVNanC5ync8KAbzK8qiNYAzzTME34SKRap
         a/RJWyclK5lBDYbqovOoI6YHSKmrMzDdFpcRScM7i/m32ACwZEWBL4S8g6inXoKKyTI2
         fjStQ4RpuJ89ure/Kx0iQ1J0h7Hn1t0Oz63Xog9QGxhIuVlrGtSk24J8xJ0feygTIJ6g
         b/QT17tNaCM9IQcONf/+r9L+EM3mQF3/hh3R3+m3D3253Y0OzLIQlKZS0xjjVzbnLa3r
         GYWg==
X-Gm-Message-State: AOAM532ZbwceNgaUj9TsmhoyiCJgEcAwWx9njP7MIZYY6/5j8x4Pxanc
        U8Y5JcAe1YlzZFIGbJs95Q==
X-Google-Smtp-Source: ABdhPJwU6Qvqcjkg3G5Dn0bvO1Vo7TQvRWAH7QA5M92uiSPM2Nm8T/EVBDnhSuaENAu2wfdcAu/93A==
X-Received: by 2002:a05:6870:438d:b0:e9:1da4:a027 with SMTP id r13-20020a056870438d00b000e91da4a027mr4468458oah.145.1650915918147;
        Mon, 25 Apr 2022 12:45:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568301e0400b006015bafee43sm4249922otr.46.2022.04.25.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:45:17 -0700 (PDT)
Received: (nullmailer pid 143488 invoked by uid 1000);
        Mon, 25 Apr 2022 19:45:17 -0000
Date:   Mon, 25 Apr 2022 14:45:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Fix incorrect compatible strings in
 examples
Message-ID: <Ymb6TfADJKd+a6Ys@robh.at.kernel.org>
References: <20220422192039.2590548-1-robh@kernel.org>
 <20220424171212.6d247854@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424171212.6d247854@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 05:12:12PM +0100, Jonathan Cameron wrote:
> On Fri, 22 Apr 2022 14:20:39 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > Fix a couple of examples using incorrect compatible strings.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> or I can pick these up through IIO if preferred.

Yes, please apply.

Rob
