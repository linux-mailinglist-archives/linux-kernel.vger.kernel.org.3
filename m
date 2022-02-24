Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45154C34F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiBXSoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBXSoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:44:06 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F704223211;
        Thu, 24 Feb 2022 10:43:36 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id l25so4103119oic.13;
        Thu, 24 Feb 2022 10:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rDAV/WWC011qVv0D0YjIr6Ze1/ltKncfCfMwzEnMjjQ=;
        b=o8+zIulVbhgAZbFoTuYA4+uz+LExCbxhjmPDq3Omw15z7+w/aqEUCHK9d0z9xJkHXh
         mKHcsMJ7mej35QfkeczYztLX0kO9yZ+h1937eGKxEWZ971MbVpQkKsr3QWomuWPwlX1t
         dCJTaEe2F6Gp2Osk/42gzv+xEiCi5ZgL1cM70nIr2uruBVITXS6u9pSFDax1Y8s3Y0u8
         QaSsis8leehdU+kXf3c7S1NbYhSaU1uRFdv/rsWX8lxCJd3W+9subBTQ+wXJqnMuXkwA
         fbqBR06H3RIcvEUt2e2RvsHjNcgKbYVnYnLKifjqjKpDK21jNiuW8rKqW3Xvzc9YCyft
         vT/Q==
X-Gm-Message-State: AOAM530VzZDLAb9U6F3xMMMVJ3r5MxlsbrzUeuIHkbjPL5PKShlUqGdm
        2cfeDs72SlHMEs8zjytYIg==
X-Google-Smtp-Source: ABdhPJyzToIn+k8zZMPupkt5bsE/2FY1U+G91saHHxKA8Ux7j9WTKJiq5dYRPnNsAu8lEQhspejNdg==
X-Received: by 2002:a05:6808:1448:b0:2d7:dc0:c271 with SMTP id x8-20020a056808144800b002d70dc0c271mr5178534oiv.127.1645728215536;
        Thu, 24 Feb 2022 10:43:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000ccfbea4f23sm236718oae.33.2022.02.24.10.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 10:43:34 -0800 (PST)
Received: (nullmailer pid 3382450 invoked by uid 1000);
        Thu, 24 Feb 2022 18:43:33 -0000
Date:   Thu, 24 Feb 2022 12:43:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 01/15] dt-bindings: clock: split qcom,gcc.yaml to
 common and specific schema
Message-ID: <YhfR1fx+A0ZOrn5g@robh.at.kernel.org>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224164831.21475-2-ansuelsmth@gmail.com>
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

On Thu, 24 Feb 2022 17:48:17 +0100, Ansuel Smith wrote:
> Split qcom,gcc.yaml to common and specific schema to use it as a
> template for schema that needs to use the gcc bindings and require
> to add additional bindings.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
>  .../devicetree/bindings/clock/qcom,gcc.yaml   | 59 +-------------
>  2 files changed, 80 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
