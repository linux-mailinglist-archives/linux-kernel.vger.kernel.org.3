Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66D257D23F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiGURMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:12:38 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708886C0F;
        Thu, 21 Jul 2022 10:12:37 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id 125so1829744iou.6;
        Thu, 21 Jul 2022 10:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXW5mr/tm3w88vzFpDdrwOq+yoOKyhp6WYF1llgfXiU=;
        b=KM6UaB71/wUu3x4jl6qBtKxCH6u4tcivFfWWvEwupBoqwVIskOeQlAkslIOhsvNp/c
         xfVPH8mdaRK0IlEW5Z5uhEXWBaB47M17FXU4S/jEG3UbgET39rfEkwBmbI+KT5LXRcek
         UOKcbYAKt9dHtn8YdHsK3v7FtLLkoLaFOY4DTnlBLyiVish6mlBZ6Wen7SolnCHAE7hr
         cQ/EkrV55QdW408pfgiA+yXNexy0ddHH3cK2tcLglTp6xwSHPnCDLekr0bkRCW+nWKLY
         0Bt6mjW73oXJ82nJMQLIV0i2piPwkyl2AYbQNJ2SZZZoz0z9X1KYAQSprfTYHOtYoPgr
         Rzsw==
X-Gm-Message-State: AJIora9fVzCU8WhvQYIouympsSrhFCIc9tcsbabLJXdfOmPZmARWL62a
        /c151MaZEtkV7BRvWxlUUw==
X-Google-Smtp-Source: AGRyM1sKkq06wlrz9tYdzXzFQIDky9vf1ktv1R/s38hzIfF70Bb2Bf0HPO3kjqNaeCGXMgXdZiRTgA==
X-Received: by 2002:a05:6638:250c:b0:341:3fc3:a830 with SMTP id v12-20020a056638250c00b003413fc3a830mr20413533jat.195.1658423556742;
        Thu, 21 Jul 2022 10:12:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y27-20020a056638229b00b003416ac35529sm1012628jas.26.2022.07.21.10.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:12:36 -0700 (PDT)
Received: (nullmailer pid 1580571 invoked by uid 1000);
        Thu, 21 Jul 2022 17:12:33 -0000
Date:   Thu, 21 Jul 2022 11:12:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: leds: qcom-lpg: Add compatible for
 PM660L LPG block
Message-ID: <20220721171233.GA1580186-robh@kernel.org>
References: <20220719211848.1653920-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719211848.1653920-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 23:18:47 +0200, Marijn Suijten wrote:
> Document the availability of an LPG configuration for the PM660L PMIC in
> the Qualcomm Light Pulse Generator driver.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
