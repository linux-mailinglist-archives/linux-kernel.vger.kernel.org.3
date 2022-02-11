Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704CC4B2A81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbiBKQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:35:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiBKQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:35:44 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3ABD68;
        Fri, 11 Feb 2022 08:35:42 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id bs32so8754713qkb.1;
        Fri, 11 Feb 2022 08:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1udRbf1uC+kDWQeOZj9JBiNWHoKMYK/y5Ub9jmuMho=;
        b=kad5V+SWXGiEAwLNzSBh0EoJYkSt7VCV4Mcdon0i2pgORVd+nIW9ppXE05T2mbWvnO
         0DulOdHXg075siaV4DJrefD3C5TrJApdJlDfweiyxId965kTZIewevE4jndWJNzDogOT
         8inLbF42W1MMj1Ei5h0ZV1hBxUgSrVt1TJpiL12nB+QmYsBppORGZjycbs8AmEeXHAzZ
         VMJ6iH//D+t6vxuorXi7vxEN33Hcz/suoqRnJKTLH47dn35Yk0sOFyl5I0+EsM5wdIvB
         xt9+mI77NtVcbkygTFtSWlol8JWYmDQyxknIbr+b/VcA+7pRMx40lNwBew8AcDkC28ky
         0eog==
X-Gm-Message-State: AOAM530pxkrTtTw9GTjjAQrgVL3fkBev2JuJEv2+/xSG63ctDcLhk6Ij
        xdiZDY8017LIzMnNvZUuDFUbBYCOhA==
X-Google-Smtp-Source: ABdhPJxo705niC2XVKpENdkx7eVh/hoikJc4qjsb1wAnlhFIyJaF30haPmhwmT0rm9YpC7VLkkhDFQ==
X-Received: by 2002:a05:620a:13ef:: with SMTP id h15mr1169914qkl.713.1644597341787;
        Fri, 11 Feb 2022 08:35:41 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id y20sm12427633qta.9.2022.02.11.08.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:35:41 -0800 (PST)
Received: (nullmailer pid 482563 invoked by uid 1000);
        Fri, 11 Feb 2022 16:35:37 -0000
Date:   Fri, 11 Feb 2022 10:35:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-usb@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: usb: Add binding for fcs,fsa4480
Message-ID: <YgaQWWTQrvb3kDHC@robh.at.kernel.org>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-6-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208031944.3444-6-bjorn.andersson@linaro.org>
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

On Mon, 07 Feb 2022 19:19:43 -0800, Bjorn Andersson wrote:
> The Fairchild/ON Semiconductor FSA4480 Analog Audio switch is used in
> USB Type-C configurations for muxing analog audio onto the USB
> connector, and as such used to control the SBU signals for altmodes such
> as DisplayPort.
> 
> Add a binding for this hardware block.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - None
> 
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
