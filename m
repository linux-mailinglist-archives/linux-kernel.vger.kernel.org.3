Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24164CACAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiCBR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiCBR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:58:35 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F5A47051;
        Wed,  2 Mar 2022 09:57:52 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id y7so2435090oih.5;
        Wed, 02 Mar 2022 09:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05AcTChGbiFBLynp9DvAtwr3COK0/aCXGa8Tju5HppM=;
        b=viyJ61Eg09xqW09uyuNOZwPQ1gKtSohTcX0wSDOZHDdzLsZdWjDQDuj4Je73tL2ahg
         yy6KqmxxSPpFwLWnigD+7Jjvoitg1oFhZ/k/9YhSAwx9XtcEIAt9kErbdPbUYJ5IPkIn
         7GEOUZjES79e7SMMY6XyTqHKgwLd9rv556MlLBZuEIQaIgdqpdnaZJxnFzoYhzW/IFvF
         7PH20a9orVhs+QGVsSXRoNJqq1OuuZtODhM3pRN4YTrHlZjpZDr0VPW+1gj7cUF4XiUo
         JiI/sUIPjVSCzeAOvxhEUU9x5IM8fh0NDtNFPWNQL3/QyEfCneICfTUgzDGjcd/hQLnZ
         Euiw==
X-Gm-Message-State: AOAM532zXmetAGcvYF+qJgqpjAXmGGyIevhdi5ff35S00YpFjYAjh/nF
        /g8DV1C3So6NzwtAbxq6jw==
X-Google-Smtp-Source: ABdhPJyHQTcjbRnh4UmtMno3JHe5lPOWGksstwll6PVTU6ix1I/HOLvFSH67y9+7H4D7TY87X4+AQw==
X-Received: by 2002:a05:6808:657:b0:2d7:5604:6472 with SMTP id z23-20020a056808065700b002d756046472mr940862oih.39.1646243871318;
        Wed, 02 Mar 2022 09:57:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x10-20020a056820104a00b0031d11ee4175sm7778723oot.37.2022.03.02.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:57:50 -0800 (PST)
Received: (nullmailer pid 3964330 invoked by uid 1000);
        Wed, 02 Mar 2022 17:57:49 -0000
Date:   Wed, 2 Mar 2022 11:57:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v3, 1/6] dt-bindings: pwm: Convert pwm-mtk-disp.txt to
 mediatek, pwm-disp.yaml format
Message-ID: <Yh+wHbOfYZukhcix@robh.at.kernel.org>
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
 <1646199106-26879-2-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646199106-26879-2-git-send-email-xinlei.lee@mediatek.com>
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

On Wed, Mar 02, 2022 at 01:31:41PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  .../bindings/pwm/mediatek,pwm-disp.yaml       | 65 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 -------------
>  2 files changed, 65 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

Reviewed-by: Rob Herring <robh@kernel.org>
