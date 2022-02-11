Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136B24B2A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351479AbiBKQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:26:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351485AbiBKQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:25:58 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB93AD;
        Fri, 11 Feb 2022 08:25:55 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v67so10066191oie.9;
        Fri, 11 Feb 2022 08:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNHEpqIX2AMyOXJaqG7yEXFoVSICVPmb7B0ilFWlNec=;
        b=NITPRY5H7arMQsFaW9G4zKnHf8g3lskbRi216nO6LihTHSNIAj2/NLJof6xdAYorR8
         QxXSuVrZ3QDuO8fG5v9CFV+bSxwVgK9WCR1tv9jmiPsV0mdXYK+p/xhIVGC8p2kvQiyx
         x77k9fBYsn71f1Gw9WqIuXzU4XlEscgtnqE2tjrCVl+T/crmVxTiSqaZLSgUoUIimgdY
         iHFXSt8FG6f695ZUHA+qvmzBMPEWyUphx0yMbGGPT0fktUeTNs8QxtD68mvDeMpmSKNh
         IT0C1ThrqlgAwjLxkeemaPuxnH0icoCZgjLX+NxLcvsNY/iPiQsFXjSoutrPkNy+JgVK
         1/+g==
X-Gm-Message-State: AOAM533ULXE12O45eB0+C6lBWFmvyWe8aj142YVMdFrlFviw+3GPfgI7
        lNKgA39WlTtROwcjhx/fSQ==
X-Google-Smtp-Source: ABdhPJw8oaVkgx5Pu3uFJ78qknmKsHlv+NqPM1RqyBvjDOel/OiKPX344OCHUA71kPGl79Oq05bBpw==
X-Received: by 2002:aca:c056:: with SMTP id q83mr582840oif.294.1644596755317;
        Fri, 11 Feb 2022 08:25:55 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id x16sm9731092ooa.6.2022.02.11.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:25:54 -0800 (PST)
Received: (nullmailer pid 467504 invoked by uid 1000);
        Fri, 11 Feb 2022 16:25:52 -0000
Date:   Fri, 11 Feb 2022 10:25:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jeffrey Hugo <jhugo@codeaurora.org>, linux-clk@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add support for the MSM8226
 mmcc
Message-ID: <YgaOEHwe7DKI6i1N@robh.at.kernel.org>
References: <20220207185411.19118-1-bartosz.dudziak@snejp.pl>
 <20220207185411.19118-2-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207185411.19118-2-bartosz.dudziak@snejp.pl>
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

On Mon, 07 Feb 2022 19:54:10 +0100, Bartosz Dudziak wrote:
> Document the multimedia clock controller found on MSM8226.
> 
> Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> ---
>  Documentation/devicetree/bindings/clock/qcom,mmcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
