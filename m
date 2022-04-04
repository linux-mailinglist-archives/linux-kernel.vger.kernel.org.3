Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039C54F1FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbiDDXGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiDDXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:06:13 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137A31367;
        Mon,  4 Apr 2022 15:29:48 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id z8so11578519oix.3;
        Mon, 04 Apr 2022 15:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xaln98Z5ogcrbOoYIFhgQNjUgu9DlXMKe935blEOvEU=;
        b=1ZWdMvZqka7hLfymV4JsR/68X4UDxCI6MJZcUaigSu5pcGFwFrH0VJ8Qqz4DpSiXLT
         jlHfuYZ7ycnK3i63u1zRHB8eO0iE5AqLT9Bqf6EczMUt8R/MSAZwNcbW01olomHY7yYM
         CWcgkiArCZ5S9/dv3cUbEZkFPc9UqbbZcFiBpkbuIVfpAjnZadJH2jti0FTYVVOpFomo
         hQNCKwxYxgcEGEchXrEofMqiP5rTflrutzGn8EgJxWoKfty2EgP7KyNlCeSBl0AoDsj8
         4WDBD76i7dJ/g3CEEMKoxzM/7zzHAy315wVTpr/hX4N/bNcVwfNjiI5jdjqjlt38ZBe/
         02GA==
X-Gm-Message-State: AOAM530Qf6cx+GQtf8E672tWMoSymxuJsOjUfWgOv6m6HbvMr3aHaPy1
        ZGdWsQiw98McNzzA1DNkFA==
X-Google-Smtp-Source: ABdhPJwFCVYeAMkXPAGkC8KLfn2xCtr6/VEY1Hc12kGK/GermE55H0Wh99n9DVjIzSTJIpG0eAeE4g==
X-Received: by 2002:aca:1809:0:b0:2ef:3d97:2c27 with SMTP id h9-20020aca1809000000b002ef3d972c27mr198329oih.279.1649111387975;
        Mon, 04 Apr 2022 15:29:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hg14-20020a056870790e00b000e1c070a73asm4099387oab.55.2022.04.04.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:29:47 -0700 (PDT)
Received: (nullmailer pid 2116694 invoked by uid 1000);
        Mon, 04 Apr 2022 22:29:46 -0000
Date:   Mon, 4 Apr 2022 17:29:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: clock: qcom,rpmcc: add clocks property
Message-ID: <YktxWpHBamNnymwy@robh.at.kernel.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
 <20220401201035.189106-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201035.189106-11-krzysztof.kozlowski@linaro.org>
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

On Fri, 01 Apr 2022 22:10:35 +0200, Krzysztof Kozlowski wrote:
> The RPM clock controller receive input clock ("xo").  It is modelled on
> only one chip - MSM8953.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
