Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352B251F550
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiEIH34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEIH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:27:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF26BF62
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:23:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so15154261edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=yh41zgnvY6/e7rd+RKrkrzj1vifp0kaAvEwbnIHLMjc=;
        b=KQpoKsPG1Cr0vVlAeQP5epvMisubeLvtfvlzwlp4LwBIZaVem9j9Kql6ZY/EEqpZ0t
         LnCZEj1f16BmSYYxf1ReN4Mnpc6gz574IbAeL3dXsn1t82ItSLnF+I2k+WnCUSViWPWG
         P8Nh6RA3X1JxWOm+0jw9AJ2umv57ewK6fJqkDRu4ZdOqupbVuibC/sRJzo9vBYxvIKOj
         icodQpuyWNKpkIR5GocQDmBzCFU/d5QEImd62IVRnN36cwyYYM51PnGBsHeDbeayXqwB
         MFsH03Yp0XTNuyXTU124IKF58ev/tHGoIJWXanTcTXE9Tb85jJrSzF4rq/3TghOyafz1
         5Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yh41zgnvY6/e7rd+RKrkrzj1vifp0kaAvEwbnIHLMjc=;
        b=P80ZeZ+puymgeMmcsxywYObAKJpg6g73W4IiHDssr4VYu2p59L1+mhuZdO1AC4Wz7p
         ZdRJxKbbH8jykLMgv42RQNVKtpo8mULEOG4BqnKE7/llxTJPYoaW7I7WI0ODNLlvaPed
         l8WVsiB58u6hNxm8g2KLMGA5sfHrJCyURSJ2RPzXlGYtMlM6yfLoYA8x6lKS6jzIWShK
         uClPAf1arPRP/JThJXnS9S6H4BL/3kSFgYt9oVIKmm4TSj922uaH5TeFwTIRro4rrg9q
         z/VShBSfPdhmewcWv/paS0z1DXQ8CXTQ5DbhQjtcEJfe0raegcmEQiitOCwvNYnmhCuf
         QihQ==
X-Gm-Message-State: AOAM530iDat6t7lR8C/p5vuIrtSi0VBHogEfDUTSt/i2XsUT2g4vuZ9c
        gETm8adNCspgOTyS6Upqjw1eUg==
X-Google-Smtp-Source: ABdhPJzq1dmrlLw9p3X4mAViSn0SPqXS55XG6DN2M8/VazgVx59OnsR6l5xHrOKvSk26BivZqTjLHg==
X-Received: by 2002:a05:6402:2291:b0:425:deb5:73be with SMTP id cw17-20020a056402229100b00425deb573bemr15667701edb.392.1652080988098;
        Mon, 09 May 2022 00:23:08 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jx21-20020a170907761500b006f3ef214e29sm4842379ejc.143.2022.05.09.00.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:23:07 -0700 (PDT)
Message-ID: <eee2d4f6-703d-d3bb-3949-493f9d65f676@linaro.org>
Date:   Mon, 9 May 2022 09:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/3] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
 <20220508142624.491045-4-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220508142624.491045-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2022 16:26, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a device tree for the n6000 instantiation of Agilex
> Hard Processor System (HPS).
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
