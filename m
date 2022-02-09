Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989F4AE763
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbiBIDCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359864AbiBIC5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:57:00 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C135C0613CC;
        Tue,  8 Feb 2022 18:56:59 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id l43-20020a9d1cab000000b005aa50ff5869so654869ota.0;
        Tue, 08 Feb 2022 18:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k4jpU9UQFFFu7MujThREpoXMQUlWam3Hqib4UzltPs4=;
        b=Rxa9oj8MolDHGLu2boLdHGRN8KUidAeKvJ9Jcnpe99oJhuqET3Ol3pZdyhTNp6DGUP
         3YLD6VokIxKmo54VVXxGoec9udT4N57TwOlcpCrfo6yxNBi+ifBhGbbpN55YgmIj2uTv
         HVMiqrRViihnce+GtZkzMbwkjv0VmPS9iLzy+VwQqPGq9fUctQr0zO2kD5y6B1z6hPsq
         eLdU5PBQvGcYGagFwQv4dvX4FlFnztmD93vXV4utyV6WK0Estah9N7HSEiIdpyXlRryu
         oOQJa0KJjIc8eqt1hvaxK14iKnqthOs9n4WG4VUf6dILa+x1oqfdaql/ZAFgorzpDC6a
         wpXA==
X-Gm-Message-State: AOAM533I0grf0DVZbKW7kz0Vees9aZ9gnlTu3cHIcipimBBo0E7PYCTm
        ABU0R8LptJ/dwTRL8dcYnA==
X-Google-Smtp-Source: ABdhPJyuEEHwaXQoQ4bZu/47mrhqhpTHJ9wxw/Lmz/yywPX8o8dqvkV8izjaX5Zlg+bO4bJkzKXEWQ==
X-Received: by 2002:a05:6830:1b62:: with SMTP id d2mr148286ote.66.1644375418738;
        Tue, 08 Feb 2022 18:56:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x17sm6008663oop.1.2022.02.08.18.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:56:58 -0800 (PST)
Received: (nullmailer pid 3530997 invoked by uid 1000);
        Wed, 09 Feb 2022 02:56:57 -0000
Date:   Tue, 8 Feb 2022 20:56:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        bjorn.andersson@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: qcom,pdc: Add compatible for SM8150
Message-ID: <YgMteWXliX4BInLw@robh.at.kernel.org>
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
 <20220119203133.467264-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119203133.467264-2-bhupesh.sharma@linaro.org>
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

On Thu, 20 Jan 2022 02:01:30 +0530, Bhupesh Sharma wrote:
> Add the compatible string for SM8150 SoC from Qualcomm.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
