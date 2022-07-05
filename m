Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46356677B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiGEKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGEKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:10:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE0B13FA2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:10:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t19so19071599lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ol86STMqgAKp+0F1Lxowaa3JS8aP5AgYqpMap6ZZFtM=;
        b=zzu5W00IQ5hUD8rl4I7b8Vaa5O9BXFsj1UWT9yxwlP64l+XldCO7gk1cnHrtK7OsQN
         /KZrGkRVUFbjiV1GUyGTtDzl2K8j5rVIZtrH1CH1yMVxnzFe39Uk0Kxw+zy3fK6vkt3s
         uuYc9ZiYeUqK1NYudDbNA0bmwlny1aKFnTb+Ddy3EJ1Ht+CAzrpsZ9in+sub6hd8Cwys
         zpr777mvOpIFIL5N7/UsOOzBtqEEXl4y/RXmvGRs+Ne2foZn/pMLWzy4Ml6VzEtFgw3f
         zql/vH6hR7weGmzGR6nv4cspFgaQLk493vo0SmIfMbn7bzPpy+sCM1bDynZmqhIXsycT
         vmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ol86STMqgAKp+0F1Lxowaa3JS8aP5AgYqpMap6ZZFtM=;
        b=PKODhtRE4zYm7CwN+yn4ieuaK74U3Kw8J5Ee80IHypVsdlUC7Kik1w3O7X6tqpagP1
         TW2LTeqw8AgsVrI3HNuNcGod7eTBtF5ieGaOD9LCekPc6/QQTQADjkh4J7p5TGloI4+I
         LbcF832ys+8mQ12XKbJAHEx1Qgcs7P9rMBShTUQxCwUPof0aVWV0Qln/likD5MMcfut6
         z/KJWHWdkbkm6A99rtT4Wx1O+sk7QHQhl8LXI/iKG+/TWPqHqe3Mpq/E2RJej1d5aLDS
         wC21L0MLCknIxIm7DsAUglZ0t4g1cDlaaZHEOLr3EwC1SxjgTyCoQ7BPYM4LrJKilEYt
         e5qg==
X-Gm-Message-State: AJIora+j1rbqjgRGC8IkCrXLX21Q9Rb+XRF9RjCyd7sHTQ+DvH1alU1Z
        GTnccAts0dU3IL3fVseZLt5LmA==
X-Google-Smtp-Source: AGRyM1suh63veqOs9l5dpz5zDtMw1oH5sjt9T9R/ZkuzMhoMEQP61ZP6vHfmU/bcEB5jnEX6RmA6nQ==
X-Received: by 2002:a05:6512:2154:b0:484:b0b7:d319 with SMTP id s20-20020a056512215400b00484b0b7d319mr131270lfr.12.1657015853849;
        Tue, 05 Jul 2022 03:10:53 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id t26-20020a05651c205a00b0025583eb9becsm5271605ljo.69.2022.07.05.03.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:10:53 -0700 (PDT)
Message-ID: <bd294bfa-e7d8-0e4a-4108-705fc1ebcb77@linaro.org>
Date:   Tue, 5 Jul 2022 12:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate
 PIPE clock names
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-11-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 11:42, Johan Hovold wrote:
> Drop the unnecessary "lane" suffix from the PHY PIPE clock names and
> mark the old names as deprecated.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
