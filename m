Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA755CF89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiF0TOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbiF0TOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:14:36 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48462D7;
        Mon, 27 Jun 2022 12:14:29 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id a10so10563760ioe.9;
        Mon, 27 Jun 2022 12:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VKesCXfY04/5OFDon+mnSwk30hKS4yzZQW5j1iQ74Mw=;
        b=7uPcl0OKipmgAwT1zirTq/ukYXdfxIPe0VwprdRnryCYJ30zVFoIE0CEZaqZuNvcI3
         mNQ8y97MJ4J3i1WkH3tPU8xdeTwwG2+eA9v/SefM0/td58ceYLv4QP0PYoPdi/6ij6wX
         S+jsk5pZauR6t/sO+wm9tlflcK8Lv5KK+Ro+ElGebRTSWHwCCrkdurGMdQKMfHiydOoX
         LVq+mDmOlxygMPah5twSPbVcwzDMCzE+JGMZIhdRPzkOfGMAA0ICteww/iEZ/Hi4wWlb
         CIYt/znZ6lmDDH06V87Qn+Dl97X3KQaCS6bEKWVx+EHvp790OZiSfleGZTFCELWaYbUB
         6jbg==
X-Gm-Message-State: AJIora+SiS9X1WIICjHpo/3qZhkTN7enl8eTtFV6AdwTIevDL45Z2JvV
        /dr8AHHno0g27CYyLYCDrA==
X-Google-Smtp-Source: AGRyM1szasLJONCvA4WTwr8Z5fqYjv+SfDLCHX6hp3qABewkH9cCoQk8RJkFDuKHg7FszYv6EDT/2A==
X-Received: by 2002:a05:6602:14cb:b0:669:e8a5:71b3 with SMTP id b11-20020a05660214cb00b00669e8a571b3mr7625062iow.150.1656357268879;
        Mon, 27 Jun 2022 12:14:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t9-20020a056e02010900b002d928e265ffsm1917811ilm.81.2022.06.27.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:14:28 -0700 (PDT)
Received: (nullmailer pid 2788947 invoked by uid 1000);
        Mon, 27 Jun 2022 19:14:27 -0000
Date:   Mon, 27 Jun 2022 13:14:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: lp50xx: fix LED children names
Message-ID: <20220627191427.GA2788859-robh@kernel.org>
References: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 24 Jun 2022 13:13:25 +0200, Krzysztof Kozlowski wrote:
> The lp50xx LEDs expects to have single-color LED children with unit
> addresses.  This is required by the driver and provided by existing
> DTSes.  Fix the binding to match actual usage.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Fixes: dce1452301e7 ("dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers")
> ---
>  Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
