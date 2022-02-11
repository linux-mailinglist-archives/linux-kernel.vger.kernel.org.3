Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C894B2B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351868AbiBKRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:01:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBKRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:01:39 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A32E8;
        Fri, 11 Feb 2022 09:01:37 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id r14so9575663qtt.5;
        Fri, 11 Feb 2022 09:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lTU4HbSouJ9dqPWmjI3l0Ew8QHUuA5sWoJVXgwwCRvA=;
        b=L3twywx6ugG2B51ITAFt91RQmpstfYG/txmJWlwKOyoDayIx+bGD9md+IJUa0yHVfn
         /6O6WYopj6CvQCNMMioZ3LRsnNkpXwM+70gw7lDEGoeQWbuNpWkIyRam74ZN28Lz0VJ0
         vhN8iqosVzAmZ9cth0sHbO6rq21DzFIMZWBvF4ENiSxAi6g6v7teSdM8aV6eiarzbYDs
         dP94K0Rqa69iAccLNSNoq4og+/x91KRSZc7BIpDdr7DssxS8fZmzMfDLErJRbcCb/mo7
         +kFqQXvbw0k2ApptnS5xQo3mNTPZYcIvCAojH6Zf545CZxmc1cICb8Gi6B/XfB97r8Di
         Kh0g==
X-Gm-Message-State: AOAM533JWb2lcJNdgwhoo4efOKBMxsGuAI3Y2fpdj11sPhY9y373i/xy
        XloYorCbJEf51kZOfyipUg==
X-Google-Smtp-Source: ABdhPJxar8bPh0jFhQ/T6PgRv8vQRRu79k9YmCed0Oo2PzGqPTvP1dPyOPbElhyV0I3YJZDBuvwn0A==
X-Received: by 2002:a05:622a:411:: with SMTP id n17mr1774065qtx.466.1644598896394;
        Fri, 11 Feb 2022 09:01:36 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id j11sm13087720qtj.74.2022.02.11.09.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:01:35 -0800 (PST)
Received: (nullmailer pid 521591 invoked by uid 1000);
        Fri, 11 Feb 2022 17:01:33 -0000
Date:   Fri, 11 Feb 2022 11:01:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, tglx@linutronix.de,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alexandre.torgue@foss.st.com,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: timer: armv7m-systick: convert to dtschema
Message-ID: <YgaWbb11EEKSVEZZ@robh.at.kernel.org>
References: <1644414747-22159-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644414747-22159-1-git-send-email-fabrice.gasnier@foss.st.com>
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

On Wed, 09 Feb 2022 14:52:27 +0100, Fabrice Gasnier wrote:
> Convert the ARMv7-M system timer bindings to DT schema format.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
>  .../bindings/timer/arm,armv7m-systick.txt          | 26 -----------
>  .../bindings/timer/arm,armv7m-systick.yaml         | 54 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/arm,armv7m-systick.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/arm,armv7m-systick.yaml
> 

Applied, thanks!
