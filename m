Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F99451BB10
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbiEEI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350578AbiEEI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:57:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783B4A3FC
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:53:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so5152251wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z1qhAiuwx9mBUiHy9dya4P2O5hAWhg+B5SPDALjMxTU=;
        b=NTkOBAgfIX32vg97U0GI08e/VNhXx+m4QYZORH+D9wL1h/Sn5ucAeg/Td7D4/kbAOo
         PlX2j3fuUsh02xpdgYENkOVmDldfK9qcMXCKDoh/Id42KkekF4Ot5YI/MQiFGArULFkI
         ve/hzmUsuv3yA96J7mcXo4HGt9oYgeI+p7PTBbYB2vaI2zX9Ir2GMioX/0DTUUBzyfI/
         vmf0qwFC92iv6APGgb3KN+GOb8wXkixoACw2h6XNWB93c0pUyHOMjX/znWIkL0Eav7yv
         DuVsVX6P4XGbI4W7AWMAsmEoSDzmx9Jlxy9UlUncJ1r/Lp8pennAj3VShMmhlFb3WRPt
         P/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z1qhAiuwx9mBUiHy9dya4P2O5hAWhg+B5SPDALjMxTU=;
        b=arSRdK6n4W4FD05lf6CVTPAwSXq9X6ujrf5ou3ozsjQThkbK/LMn/AL2/sJgGZan26
         YHlqjYo3w/Y9Zh+LqxylBryFPWrO/9HFldWh3CHanIi8M38j4HyRMNueXytuQFf/C2Gf
         RU6FS/PvmRF0zRhvS0C+IGWmjsFEPDxViyB0NUz5hUn0to5FKuymZousgsya3kLw+88J
         WUmwBfmVkj9CgzohLX2CQE5p1EbZ+yd/B/rjttdPSV1aTpCmM1Q8Otacq8sBRkhjHHvr
         kJCRxSMbRqOJMr5e34iqB5/uyIW5zws+r7a5hAznoYmzQfyet4vJW+eUVau4JamiXPG+
         kFaQ==
X-Gm-Message-State: AOAM530vB0V54lBn553Z7mGruR6wCVadAkMsh0yHhzRVlwhxm7Lwn2ap
        zHuyK5/RqL2gYIhl5wZRMx2JLw==
X-Google-Smtp-Source: ABdhPJzTZY3HzX0A+7F+MbZQ3841/cD0zf07aVExNp72ZyvTt2yp7RKn4jA57m3JLR+PQtSrptj8QA==
X-Received: by 2002:a05:6000:2c4:b0:20c:6c76:14f4 with SMTP id o4-20020a05600002c400b0020c6c7614f4mr12408912wry.56.1651740833744;
        Thu, 05 May 2022 01:53:53 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b0020c5253d8ecsm702571wrq.56.2022.05.05.01.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:53:53 -0700 (PDT)
Message-ID: <2a05253a-496a-c59b-b607-e2af2e53542a@linaro.org>
Date:   Thu, 5 May 2022 10:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: add optional property
 reset-gpios
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@xilinx.com>, gregkh@linuxfoundation.org,
        balbi@kernel.org, radheys@xilinx.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sivadur@xilinx.com
References: <20220504075309.6244-1-piyush.mehta@xilinx.com>
 <20220504075309.6244-2-piyush.mehta@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504075309.6244-2-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 09:53, Piyush Mehta wrote:
> Added optional property support reset-gpios for the dwc3-Xilinx
> glue driver.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
