Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384744E334C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiCUWva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiCUWvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:51:20 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715B3AE9F8;
        Mon, 21 Mar 2022 15:31:03 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id s207so17760675oie.11;
        Mon, 21 Mar 2022 15:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qpBy8/OYx70t80yV9nniAHD9sFfG+3EO5lhZ6lcjTZM=;
        b=T6eN2WCIAJYewai1GpzDKtUHOLkcPDA4NIdVjSWTiYnIxGPe4tg5ghNGeHobI/BVty
         uaVfqIJ47dkfYZMd1EA7A8re143qlE2U4BZ+J1Mc4ppo48/J8JwVy+1Em/DBXZoj9qQj
         IsKa5LwrKhg90Qg18tFCc6hrwPLE64ak3xN0ADQhj/wiliG5y25lB/0K5/O7x2cVh9A1
         L9S4Pdq6mEYz0YE6ZGTqgIIpFQSDC4qrIP+bcEfQy1aAP3XLod0V9BGtoqqYsGB9qfmA
         qCpjGjU4wvNbaWu921jd7ghMgMsqAO4Tq/e7y0mCmvFJ6+NnXQlMilVYZfUOgETS0dbW
         9oiQ==
X-Gm-Message-State: AOAM531OalwQTUrJKavfwcwyCpsbX68tmKa5igQrRy6JHVgVXQmffSOb
        iipwDxXAJh6EsPcqm+NX18+Q5fWGWw==
X-Google-Smtp-Source: ABdhPJx6TvCku6XWqq2RvsKNU9ONO8JkWRgLdjkvQQTVTOgGpV/EfV8t05/k3kfG37toxwZtiHYa/Q==
X-Received: by 2002:a05:6870:e40e:b0:dd:c65c:ab6 with SMTP id n14-20020a056870e40e00b000ddc65c0ab6mr455755oag.79.1647899482382;
        Mon, 21 Mar 2022 14:51:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm7703648ott.2.2022.03.21.14.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:51:21 -0700 (PDT)
Received: (nullmailer pid 601083 invoked by uid 1000);
        Mon, 21 Mar 2022 21:51:20 -0000
Date:   Mon, 21 Mar 2022 16:51:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 14/18] dt-bindings: clock: Convert qcom,krait-cc to
 yaml
Message-ID: <YjjzWAu8p7i2RANW@robh.at.kernel.org>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
 <20220321153855.12082-15-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321153855.12082-15-ansuelsmth@gmail.com>
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

On Mon, 21 Mar 2022 16:38:51 +0100, Ansuel Smith wrote:
> Convert qcom,krait-cc to yaml Documentation.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
>  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
