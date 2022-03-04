Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413224CE147
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiCDX7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiCDX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:59:03 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE1EF081;
        Fri,  4 Mar 2022 15:58:12 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so8640007otn.2;
        Fri, 04 Mar 2022 15:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7shUq9I7yQHeTKVfNDbhhFsZTM4LwR3N2qzKXb2oavk=;
        b=jVC/Ye4gJf3oxkuv+X7BWqpzAKUD2VRVuF3MgRdbhBTJu5S8N77kVHBTjmpyTSogE6
         Wk2iZ8GyYSOTeU22bWOQoRwAoLCII5avNbXiD8YFVJra9yOozkWbvSfkazSf8WUYUg77
         RjzApBpnm+1UO7nnAx7RWZeAgf1znrzBYYlTIQQRFY3ySi+fw5Q3XOuh93bVZJoSecMj
         8xyQtzHsSMPjVT8oLTPXyFbRrqaUYgaciwfNg9C//THC7GZ2tCaOb9MgeL3+884Fq1O7
         t/D0rxqzQdw4xf6LyxUYZDOtnmiT4hk+TOszJMMNe5Hz6xq4KfoCyhelK86J2UTAV6hw
         62vA==
X-Gm-Message-State: AOAM533NswjO45/EtAx2QaeSn1VnJu6458oghdQrplwMdaBYTpmdS8oT
        sM6YiTR0CARgKeM/TV4Z0w==
X-Google-Smtp-Source: ABdhPJyOOqMhAb+ZDmCDWzK00jEJxcGH/1VqZn9ZHYoe8kQbOMrKk0nAZxp56TsJX92XoIcF2xOspQ==
X-Received: by 2002:a05:6830:1393:b0:5af:8b50:2e15 with SMTP id d19-20020a056830139300b005af8b502e15mr509919otq.168.1646438292162;
        Fri, 04 Mar 2022 15:58:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l10-20020a9d708a000000b005af3e65ce95sm2835589otj.70.2022.03.04.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:58:11 -0800 (PST)
Received: (nullmailer pid 720286 invoked by uid 1000);
        Fri, 04 Mar 2022 23:58:10 -0000
Date:   Fri, 4 Mar 2022 17:58:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, shawn.guo@linaro.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: qcom,qmp: Describe
 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
Message-ID: <YiKnkg2gXnWFq/W9@robh.at.kernel.org>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
 <20220228123019.382037-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228123019.382037-3-bhupesh.sharma@linaro.org>
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

On Mon, 28 Feb 2022 18:00:13 +0530, Bhupesh Sharma wrote:
> Since a few boards based on QCoM qmp phy use the
> 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties to
> describe the ufs phy nodes, add them to the dt-bindings doc as well.
> 
> This fixes the following '$ make dtbs_check' warning(s):
> 
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
>    the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
