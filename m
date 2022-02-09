Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA56F4AE7B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbiBIDIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbiBIDGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:06:33 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C53C0612BC;
        Tue,  8 Feb 2022 19:06:25 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id q8so1174522oiw.7;
        Tue, 08 Feb 2022 19:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Q+2vnIsjejUqQ8ahgYrYH7fS2Q0Im+8Cgkb2EVwayM=;
        b=SgT824Irm9Eit68XAT1fXRkijDHnFy3BwNa1MHo6mo1pomeuRvEKDiVZWbMDeqG16m
         awbiUx3PZlIlPWWSEFTIwnX6L103oxS4l/ddDwN9etbNTZ+BepqioDGUvfwZ0EO6lwS/
         EEMzB2Z1eWVbi5VtpGSDzqsZGdZXEJsRMbfONEPFVQUdIpCt0k4BSLBWJQ+E/F5ybRrD
         sZ0V/Jy13V0FGge+zdII21w9J2MLVDWUzlpw4RaOo3kGYQD1zFqTSQHYe5HdYoIuLWmT
         yQEYMkyib1Id0mjpdLiQaLiRX9zeRRAWVT+H/A1hhhYRMWoUFuxYERz6ZKF7soA4j50b
         bhXQ==
X-Gm-Message-State: AOAM53362Z1RqAkgUboate8ECn6LWpSUQjdE7rzIu+k1Mn0LC+MP/T6y
        93Qx3tCtVaL9L+wfG5lHdw==
X-Google-Smtp-Source: ABdhPJyJtXTIsMjg464SoJfL0WpKl14WPLTJ6Yp9FfnS0DqO0gQTxSRxNfM/OduHB/yVod63K2o/qg==
X-Received: by 2002:a05:6808:1a11:: with SMTP id bk17mr89827oib.105.1644375984335;
        Tue, 08 Feb 2022 19:06:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s13sm6166559ooh.43.2022.02.08.19.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:06:23 -0800 (PST)
Received: (nullmailer pid 3545969 invoked by uid 1000);
        Wed, 09 Feb 2022 03:06:22 -0000
Date:   Tue, 8 Feb 2022 21:06:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/12] dt-bindings: usb: samsung,exynos-usb2: convert to
 dtschema
Message-ID: <YgMvrveS7KPp/48M@robh.at.kernel.org>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
 <20220123111644.25540-13-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123111644.25540-13-krzysztof.kozlowski@canonical.com>
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

On Sun, 23 Jan 2022 12:16:44 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC USB 2.0 EHCI and OHCI Controller bindings
> to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt    |  66 ----------
>  .../bindings/usb/samsung,exynos-usb2.yaml     | 117 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
