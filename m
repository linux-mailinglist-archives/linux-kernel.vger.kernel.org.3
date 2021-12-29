Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4090B48116A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbhL2JtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbhL2Js7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:48:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213CC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:48:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b73so13229017wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rnqIJ93SIBVZUCI9X/AetRRmoWOd4XV45kkwiBxzW8w=;
        b=ib8gT5tuuhPV1gSybVe/tlInOl9+YYFC5ZplG96nqVmFy5mTQR6P6c1hXW8XUWxLWD
         4To2qEahL1IQm+9/ouJHjN3SLgcUCcA8ADb6RmJ9CwoMnWhoGB1/Qck44u/ENM3g9c+V
         C6gRMZzf7e92RbkUiKQ0kj326LcMAWnnnBZPuvUX4lX0sJgo2Xbu7jgwGpjWrHLhyhI+
         D+OcZMONTeFWPRpbE8kRq3RwrdSIlA25EFtBiwgH2U3Mok/qTHpDjsP2SxgJ31E2wCpb
         eRt+55Ww7ujnKRSkR8g1OgcrKl+WJN+9aLRaBgnWZK6/NbeHNwcDGDwzJGxE70Jia1GW
         7NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rnqIJ93SIBVZUCI9X/AetRRmoWOd4XV45kkwiBxzW8w=;
        b=GJ5oSS9oVYySHBQiABm91iOgJODMQqsKQ45PqD3HmI0jnNaxgHzFXXUnlshQlDqsVE
         F8rlxiBHIGaolB2OtGCugDj8T0poachLlxQhXV7xFwnOB6NOyItFcK/G9VLku8E6eWh6
         60eKhgklrTpkAVOvoOLnYpq8lEpp7bYGzby1r5JHNrQ3PB1xOx09AahuSi6abJgffISV
         DsrRmEKCbcZPLyU31Z4rPeqkEvW5t1bmtY+NUCR/WD1M0u8lY9jqRTLIJk/xSJp0wLF+
         DpJoZUvVYuKg86QxwAAJVL8AWdzD00b70ChTt7OAyqPJferItXGb2nz7T7ItebVjt9N3
         MVzQ==
X-Gm-Message-State: AOAM532lqDlBq67V9LanGe0G7y/0dK+VEaNLGhNrT2Q25wu7qPl2SIkO
        8dQqM3jx4w2wHVyvvBiEb11UZA==
X-Google-Smtp-Source: ABdhPJxEfMhetHrX2yHPjWktWJTBwLeecfxINiXmJgXKm53r1A35ap/9XVsZci1/VoVeSJlSm/ss+g==
X-Received: by 2002:a1c:9dd4:: with SMTP id g203mr21201962wme.114.1640771337080;
        Wed, 29 Dec 2021 01:48:57 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id 11sm25917589wrz.63.2021.12.29.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 01:48:56 -0800 (PST)
Date:   Wed, 29 Dec 2021 09:48:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <YcwvBj/OeeiPGB8T@google.com>
References: <20211227170151.73116-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227170151.73116-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021, David Heidelberg wrote:

> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v2:
>  - add #address and #size-cells
>  - add reg and remove spmi include from example
> v3:
>  - fix doc reference error (make refcheckdocs)
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |   2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
