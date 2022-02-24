Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C74C355C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiBXTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiBXTKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:10:14 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADF20BCE5;
        Thu, 24 Feb 2022 11:09:44 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id z7so4317078oid.4;
        Thu, 24 Feb 2022 11:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dIjsUuI5ZAtCHc87tlKhrnHo/sCZxRliauco9CabeAA=;
        b=8Fwv8WZykDX2H1Dq1zKCUay74zEeqpKDVwBBSmDtWQ4ixiiUeATNrZDoyHpV4ZzsLo
         HvPv66dJ4InZjFzkfje1YAhLQL1WH0yKjGDcalTt/IWNtCk/P2WeTE1iws8tZNBq2RX9
         bru+zYRS0E8Z4vOubqRwJsbzbeGjsmMNFDdXR4JmfL4yVkC+Ai+2JFU8rXJFA7cVh5ZQ
         qlJvX9bVjvCu/ZhvtwwdzfwUD/C0ILNACZtsG6kdkVIIrFYNIwDTPDXQTZxEXscfPMGl
         Ck7dItuc2Q2M2DAoea8+u4xECQxrG1IgJ6LmETW+WGjJxRZdNMgo2NIi9Nn8m+RpOPS6
         lmNg==
X-Gm-Message-State: AOAM531d+reveIF4iOC+YINVWb4s8IHoqdq0EQOovQuE/DlMH0mO36jm
        SnyLz1HFn6ZRvLdO49QcAQ==
X-Google-Smtp-Source: ABdhPJwWlmoNBoaaLhBgfQlc3cPWoCSktOn51FJWv0XclJS+KXdvty3ZJqQEphJvnMtieSNJqQgkdw==
X-Received: by 2002:a05:6808:10c7:b0:2d4:f529:a4f7 with SMTP id s7-20020a05680810c700b002d4f529a4f7mr8341005ois.262.1645729784304;
        Thu, 24 Feb 2022 11:09:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m21-20020a056820051500b0031d0841b87esm68193ooj.34.2022.02.24.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:09:43 -0800 (PST)
Received: (nullmailer pid 3418706 invoked by uid 1000);
        Thu, 24 Feb 2022 19:09:42 -0000
Date:   Thu, 24 Feb 2022 13:09:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v5 03/15] dt-bindings: clock: document qcom,gcc-ipq8064
 binding
Message-ID: <YhfX9t2FFbGO/OYv@robh.at.kernel.org>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224164831.21475-4-ansuelsmth@gmail.com>
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

On Thu, 24 Feb 2022 17:48:19 +0100, Ansuel Smith wrote:
> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already documented,
> to get the calib nvmem cells and the base reg from gcc. Use
> qcom,gcc.yaml as a template and remove the compatible from
> generic qcom,gcc-other.yaml
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 76 +++++++++++++++++++
>  .../bindings/clock/qcom,gcc-other.yaml        |  3 -
>  2 files changed, 76 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
