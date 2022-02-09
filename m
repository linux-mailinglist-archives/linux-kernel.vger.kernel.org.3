Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8624AE7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiBIDIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347986AbiBIDGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:06:22 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C1C0302E8;
        Tue,  8 Feb 2022 19:05:04 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id t199so1143627oie.10;
        Tue, 08 Feb 2022 19:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9SICioeHep4TWtT/qww/zgThNzMf9twws3N+ad7OYVE=;
        b=O27jQTfOLQZZjRbN6yqUEMsnpjAnVx7Qj8AqsF7uOSCypp2hYUFNTfyjjm4J9oMYvO
         BOgN/1mxALzixxSmLuC4Opuk9rm6E1qQSP+tiIQ6MpFGzb75kXNn4d8CPPDxx1QE+k64
         0/Fh/PTWSYDqFc2Gn/kynDip86Az1U4mllo2vf40qYglApJ9F2kNa2zrGhXpCeoaQBcy
         3vjA0OS/XBWoYjGp/fUYrOtX58Q+Tm/shRej6bbP67jsDsi61vhxKvKpzaDc+m3T1pRQ
         lDKfPG2fCUFfvg/jy5JgTpdFf9qedV0+/wnhn7QGotRh8OtOGJjgc9fdWrmssdgdMTUY
         AeKg==
X-Gm-Message-State: AOAM531vhEzBy4Urgdq8vecdScEp3eM2sQAnQV4uiOi7orlQ+7WzGeuq
        r4+tkThdKw9eJfsZTObk/Q==
X-Google-Smtp-Source: ABdhPJyi/x6jit4hCoZBlLoQ2fkA51bgTeDVYoLfGZn2ooJlh4b5KrSykYY6YiQA6lZZuMKzvu1c5A==
X-Received: by 2002:aca:6509:: with SMTP id m9mr94672oim.76.1644375902857;
        Tue, 08 Feb 2022 19:05:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m15sm5994060otr.37.2022.02.08.19.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:05:01 -0800 (PST)
Received: (nullmailer pid 3543787 invoked by uid 1000);
        Wed, 09 Feb 2022 03:05:01 -0000
Date:   Tue, 8 Feb 2022 21:05:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] dt-bindings: usb: samsung,exynos-dwc3: convert to
 dtschema
Message-ID: <YgMvXTZvQ/7hgUSJ@robh.at.kernel.org>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
 <20220123111644.25540-12-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123111644.25540-12-krzysztof.kozlowski@canonical.com>
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

On Sun, 23 Jan 2022 12:16:43 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC USB 3.0 DWC3 Controller bindings to DT
> schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt    |  49 -------
>  .../bindings/usb/samsung,exynos-dwc3.yaml     | 129 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
