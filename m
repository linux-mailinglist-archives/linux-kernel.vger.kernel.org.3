Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2355E228
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiF0Tuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbiF0Tun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:50:43 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D31BE98;
        Mon, 27 Jun 2022 12:50:43 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y18so10700991iof.2;
        Mon, 27 Jun 2022 12:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dtiCN8I266oCPG09ac417Y1pm08qNF7ctA3rQgmXy6w=;
        b=6IEmjU/AC55yI3QxFFSWUMbqoaic2FDmdJNthyKIjQmblaV2W0zMjOBTxUALT6fzlW
         21vZd5oqXo+23FWtLCA8vxSEycQS6S730OVNlZ97yc3FTXbeS+oGsY7m0nj5YVwUzmCl
         1y4tPtEYBAWaRuB/ciXE3XTmDvu0Ue9pESWMNkzbW42YU4vfPNqpsVk929mt5AlKkrv2
         o0RSEu0UD/u/P5H7YWPt77d1ZW+rG+9B2BRUinJGRQUHGFbLA5pp7xG21XdUlUTDDdsg
         5BWwOFGGHCFC2dzgj9ExPuJVl0SgjSZOmhjxYZbI6vf/e1j88lk/4c1HM43lRBKfE5z5
         3aEg==
X-Gm-Message-State: AJIora/v2VlZXjBUgQqGjWiYLElF4P1tpNEyxfxrx+doxXyN0a8EWame
        yJLuIDoxJdOLSFuiHGsHC7t9AvYh8w==
X-Google-Smtp-Source: AGRyM1u2Q2iT/ikNcIKiYYcSDU3g/Sy7U/L7yOI0luMVJbKj7N/sIoRnPSlGBdj3RBojY2yZVpm85w==
X-Received: by 2002:a05:6638:3727:b0:33c:98a9:9 with SMTP id k39-20020a056638372700b0033c98a90009mr4407071jav.84.1656359442513;
        Mon, 27 Jun 2022 12:50:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m28-20020a02a15c000000b00339e5e105a2sm5083795jah.117.2022.06.27.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:50:42 -0700 (PDT)
Received: (nullmailer pid 2841583 invoked by uid 1000);
        Mon, 27 Jun 2022 19:50:40 -0000
Date:   Mon, 27 Jun 2022 13:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board
 compatible in example
Message-ID: <20220627195040.GA2840123-robh@kernel.org>
References: <20220627143340.477120-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627143340.477120-1-krzysztof.kozlowski@linaro.org>
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

On Mon, Jun 27, 2022 at 04:33:40PM +0200, Krzysztof Kozlowski wrote:
> In the example, alone compatible "qcom,qcs404" is not correct.  Add
> proper board compatibles for QCS404 Evaluation Board.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Can be picked up independently, although the issue reported by Rob was
> caused by:
> https://lore.kernel.org/all/CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com/

Best to go in that tree unless it's going to take weeks...

> ---
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
