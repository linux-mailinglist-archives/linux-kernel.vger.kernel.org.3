Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6454BE47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbiFNXZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFNXZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:25:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9D43391
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:25:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso427355pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MnYR7D2vdovc6+NVQYg3gjYLjJ9NoRgOMxo6l8h+HL0=;
        b=IWLX3pfxNbdU83TkMCUCyRx1Ik9Cz/jqvY+RVqZ0MaCS4Um2NWkjpZeBXF+VBE8ALW
         qsHYyV8cL+vgetZb/XxGvgQSzkNwlfT1zrh9olzKbkz0woA2iBlNAVrPegGhIxL+OSlk
         fVfNd5SNg13zbgEZXOgZcaUK50Hqvx4WjNuPdIpZz8ZeOQAel1rwwLNs1VhRUjFlSEHK
         F9sIIX+3Umm5VoE8AvDq6lgAP5agggaDsgtEebbNhnXFQGaI+IVWBCFiDmCLYGy/Ej06
         v2oPOGEreTYpYdc1I0pbRG6JGm8kZjfVb7FRqq+FgvSwozOpgLdzV3lXeh2fv1RqRMVk
         9l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MnYR7D2vdovc6+NVQYg3gjYLjJ9NoRgOMxo6l8h+HL0=;
        b=B/EvLgk2tVWpXe6SsujptfNdoGCGLn89j0ZS+SkhoaBhc2UWTQG/iCwCTer/sHe7yr
         4RP+hIOTR69Xy9DavNrSsl1/H3mDINbFaVyCr1A89ieXaeLbT+DTmBAVtEk4nI7j/9kg
         RwVplnb2Hun3/PKPNwgCSMUPlsXjAJULPg5JUDJR5zMwxT80BxEvNyJDgEN3WJ7X4Nbj
         TlWaEJ3srxYk3jrPUaV1yEHcRvenvoJrprsED0NMjVU8g6iuKyxqneltSMBTFOmAahZT
         Lp+2ZmGxow+qx3esQ/9gFdnF0HaVtFBnjV6gTvM13ywFo64P/aHSdX4F7xzdnbYjy4E0
         9e8A==
X-Gm-Message-State: AJIora+u6p0xmhCfL9pqbl1AonXqG2MPgG+7Nf4ESsHeJsxrTZ3KNXKt
        KX5ZBUrfg4QAMCbJwpotVsyyNg==
X-Google-Smtp-Source: AGRyM1tw1m3IOauEJxCAVfmvuOelTn2/boEYepm2/G9bAdEnTYyraKXuIAUW9yVyjUanxxxKyR2F3Q==
X-Received: by 2002:a17:902:e791:b0:166:3985:2f78 with SMTP id cp17-20020a170902e79100b0016639852f78mr6300133plb.158.1655249117001;
        Tue, 14 Jun 2022 16:25:17 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id w124-20020a628282000000b0051c394eea03sm8179164pfd.212.2022.06.14.16.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:25:16 -0700 (PDT)
Message-ID: <5eec5292-ea45-fe44-75ce-968742c2ee96@linaro.org>
Date:   Tue, 14 Jun 2022 16:25:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: altera: document Stratix 10 SWVP compatibles
Content-Language: en-US
To:     wen.ping.teh@intel.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220609025647.400998-1-wen.ping.teh@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609025647.400998-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 19:56, wen.ping.teh@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add compatible strings for Stratix 10 Software Virtual Platform
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>

This must come together with the patch adding DTS.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
