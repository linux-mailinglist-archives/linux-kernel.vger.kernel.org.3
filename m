Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729CD48BC32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiALBKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:10:23 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35391 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiALBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:10:21 -0500
Received: by mail-ot1-f41.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so846494otu.2;
        Tue, 11 Jan 2022 17:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pshnZ4W/Rw8Ukt+76ESIW3rEP5oYqXRjp7/sdOFgPk0=;
        b=mBo8kjmsjZQVVdMoAHAmzw0a0PBz7whabmWNnVLfyMEcCmKJ2ac7SBIzu0Hyjnq2PO
         lOgXlT3HYAorkWvdephMi/NBJvoLraBgdosTiFpZ99BhgOYz02LcMqfR7YS55Yvt2vd/
         jOOk/5A1CogcSnTMfokF55uu4DIyVu9TTOGCkJNDE+XwafCxyc/AeSuVehvuUegDUSPn
         dNteeoNDtE2vzUeHOnN1aRUBfhUGRxKOji+S0Xicr/Qk8A7Tw3hDid8UKNsDWuwrJ4gr
         kVfjO0DocOk11tYF2e+k2bKt/gmhRIiqGnwrfbL2OQffo4NdiABQ+rD3einWiM3rquSW
         Byqw==
X-Gm-Message-State: AOAM5314tlTwAh9JmUxfAyY9ehhIsoLYxWWJQXPVdcgp/9YqfLsA/A4P
        zDB13J2XfKMsuc3KZbh5rg==
X-Google-Smtp-Source: ABdhPJyXr+z1GwXS51f7Cra7y2I3fFRP75meDFTLR6GIFbmR/mSadbCM7ip9J0wSlPZ+yk3GjztV5w==
X-Received: by 2002:a9d:6393:: with SMTP id w19mr5084679otk.276.1641949820341;
        Tue, 11 Jan 2022 17:10:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u19sm92195oic.20.2022.01.11.17.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:10:19 -0800 (PST)
Received: (nullmailer pid 3841026 invoked by uid 1000);
        Wed, 12 Jan 2022 01:10:18 -0000
Date:   Tue, 11 Jan 2022 19:10:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: arm: qcom: Add msm8996 and apq8096
 compatibles
Message-ID: <Yd4qepQPqZpOzqsI@robh.at.kernel.org>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
 <20220104132618.391799-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104132618.391799-2-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 13:27:55 +0000, Yassine Oudjana wrote:
> Add compatibles for MSM8996 and APQ8096 and all supported devices
> that have them.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
