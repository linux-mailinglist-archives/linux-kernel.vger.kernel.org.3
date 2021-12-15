Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C347633E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhLOU1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:27:09 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35348 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhLOU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:27:07 -0500
Received: by mail-ot1-f48.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso26353011otr.2;
        Wed, 15 Dec 2021 12:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oAT5L9lr/sIdbQvVLvV/av++qpPuvoaujTYIgNY/W80=;
        b=FzyTkduQsfF75eAg94nme4VgsUHCNMUf+GvbNc2w/4ahm8roL4tzlB5BPXEyDJuCyo
         EGIqjKblh14q1ZGM6Sy7tfUTBLw9JZKhvj0xXX3UMOJTLQrk6vxJorROW8EU4o/vpv2X
         KRkY3JWuIRkFhn3nMeWJT/MU2bBvNmTecAno4GUDEYO7pkzczCGkQc9RiLpIPUldhJhv
         E60vuMGjJEv05wze5lu7gEPc4aOFQS0DYpiL44KvNhaJdgU9fbry+gZKNKmvF8VkMqI5
         IZdlhE2yW4vG8OfSRzILTEOsictJkphgd1y5m7kfvUc3m1aAUkA/FpMay5UwVIIIwSSX
         WmFQ==
X-Gm-Message-State: AOAM533oBN5rZMD+NTzKNJqkQjWNXnpE/vKLvoj8lPCrpYPOM1kNljp1
        zbb3JqzxhmLjUSfQDVMzuA==
X-Google-Smtp-Source: ABdhPJywH7hM49x3LKoD410sXOeIWqsZT6ujprrj2uc8SJZHUBQ2hvDAoTzF6a95wmqB/acytJxlJw==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr10382079otq.8.1639600026954;
        Wed, 15 Dec 2021 12:27:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h14sm647091ots.22.2021.12.15.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:27:06 -0800 (PST)
Received: (nullmailer pid 1781143 invoked by uid 1000);
        Wed, 15 Dec 2021 20:27:05 -0000
Date:   Wed, 15 Dec 2021 14:27:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: improve QCOM compatible parsing
 for modern chips
Message-ID: <YbpPmZyxl0thopnE@robh.at.kernel.org>
References: <20211213203710.122708-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213203710.122708-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 21:37:10 +0100, David Heidelberg wrote:
> Parse compatible as expected for modern QCOMs.
> 
> Fixes warnings as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: ['qcom,apss-wdt-sdm845', 'qcom,kpss-wdt'] is too long
>         From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: Additional items are not allowed ('qcom,kpss-wdt' was unexpected)
>         From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/watchdog/qcom-wdt.yaml           | 33 +++++++++++--------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
