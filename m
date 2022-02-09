Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3B4AE7CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbiBIDNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbiBIDNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:13:34 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A9C0613CC;
        Tue,  8 Feb 2022 19:13:33 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id g19-20020a9d6213000000b005ab7489371aso638029otj.6;
        Tue, 08 Feb 2022 19:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bhPYavz29pyl+ykJUTk2kuFVvwHnpLudfeWM07RV3CY=;
        b=6ETwU8WaGGDmbajZCFbvcuk4XDOoPx3TR/1UVmAUS/wkElWpGLqZg2s2Vh5GA0FryA
         oQP8rymykNU+FAOabwk6vzfnYpZeTch/lAWzlWeI+ER7F99Mi684XTUKSb0xkEe6T7UO
         cByvqv/1LQ5rn2LJAhzARmxqy1uG10sKx0albB8VpbqQUOXAblgnHfDL/pCjN5wwUW7u
         UsBMnxSj6Nfwus8b8MLZEXqtaeFARAnfBwMI5YxHWJ7C03hv9XS+EBukTzJq/Wd+tFEV
         Q4+kGdRKRNSPlELdx7fj1M3vXCTU1ce7OsxE1CeoHPYS4x3LHCZTd8+v92HtcQE58AER
         s6Uw==
X-Gm-Message-State: AOAM532FgtgIxin5hzLEwX/q728b7cRX8Z91vyZkY+OkPr9LHxQDpkkK
        OeE0OmONvDw8KvK4a5RBtA==
X-Google-Smtp-Source: ABdhPJzRQj0n07HNIyiYaj9jZlxThIk4+DLTmzsAvKXF03QmDAL4Omrrf0mgpRfVvroOQUoPAt4qag==
X-Received: by 2002:a9d:6b15:: with SMTP id g21mr148782otp.337.1644376412801;
        Tue, 08 Feb 2022 19:13:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n13sm6738710ooj.34.2022.02.08.19.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:13:32 -0800 (PST)
Received: (nullmailer pid 3557642 invoked by uid 1000);
        Wed, 09 Feb 2022 03:13:31 -0000
Date:   Tue, 8 Feb 2022 21:13:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: document HP TouchPad
Message-ID: <YgMxW46u6m5dhn0+@robh.at.kernel.org>
References: <cover.1643075547.git.benwolsieffer@gmail.com>
 <aa59002aeae45a95097300213fc34490aa8db250.1643075547.git.benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa59002aeae45a95097300213fc34490aa8db250.1643075547.git.benwolsieffer@gmail.com>
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

On Mon, 24 Jan 2022 21:07:04 -0500, Ben Wolsieffer wrote:
> Add binding documentation for the HP TouchPad.
> 
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
