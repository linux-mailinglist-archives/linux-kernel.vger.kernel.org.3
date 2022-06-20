Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3725C5523EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiFTSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiFTSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:34:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A01EC6C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:34:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n20so15998443ejz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VdhSiamvlItOfaluqmA3TGcLsrz2Y0okHdkE6Q6elBQ=;
        b=KH0btaCmNirixRVWSNGx8yXRL6TZJQalbk0W+n+WL5+UE18QpxFy4mDhFCNKTimN3t
         r26MUghoGvhyCqYsObS5ql/4lMN3GCvegh2Gr3PODxzbN46L/5hK4pN+9WiGqeG8ZpFJ
         nAhQy9WC9mBzy69LTk3plSyqj0LhKgs7WHBYzyo8Xd9IEgFMce2v0j9p1Tdu0Cr0YPFq
         XfCeWVYi/vpBeb0PhNw8ZD86VxaBS69U9KI6Z8HI7xh4JIa6F9Q0Kdtqn6nHoOxhTp15
         bn77nDBZboCNyldHWo3Gq2oAROp4+9hurtL/ZVsEMinMOSjaI77R4Tw+D8PjFXqVvP8l
         qHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VdhSiamvlItOfaluqmA3TGcLsrz2Y0okHdkE6Q6elBQ=;
        b=3JvMhIkiN4LbP8Nt7Q+7sZda/V7GVawShcCO2GkEa/jy7vXZN1mViphicsxPyWjRNM
         JWHgHmShkQ3R55P4VEszD9JSMRnX3SLhOmpF2ylyFXDnCNorSFZQvo2zwSxyR2O+ZByQ
         l1xj48lm5osR07YS9WBzEaVbLg//34WAqOrqVPu8acmXsn06Pb71gG8DuSfMAuXIINfl
         1SHzgc9ATIX6XbJFySdftnoEzPoWQUVzrSeRKKEJ2d1ElIIoKbUHeWcRQ2RsQuttxViR
         0H2TFyJ+ZvsinhCylqA26MqrAYrpmrD04tQTwnFwOsez5JCRP2oQGhOicNUT9A4RdzhE
         gt9Q==
X-Gm-Message-State: AJIora+ILkQt12iar2ZyC/KJp+n/9Hf8p53Xeo2MaURU45QH+O9GMGD9
        d2i5Zrlfa506DS17B4I8GY4fzw==
X-Google-Smtp-Source: AGRyM1vJv8optT/McfbmWzU7V8gh+UXyiMiOErF6085ks8k/0CDXPxsDJj+QGxW35+wFkyjRGTuz0A==
X-Received: by 2002:a17:907:1b0c:b0:6fe:25bf:b3e5 with SMTP id mp12-20020a1709071b0c00b006fe25bfb3e5mr21995640ejc.689.1655750059488;
        Mon, 20 Jun 2022 11:34:19 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kx24-20020a170907775800b0071a1cf76928sm6352945ejc.51.2022.06.20.11.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:34:18 -0700 (PDT)
Message-ID: <8095f934-34c3-17d9-9e4b-6f244f205dac@linaro.org>
Date:   Mon, 20 Jun 2022 20:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 00/12] dt-bindings: remoteproc: qcom: cleanups and
 improvements
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
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

On 17/05/2022 09:01, Krzysztof Kozlowski wrote:
> Hi,
> 
> Patches are mostly independent, so they can go via:
> 1. Qualcomm SoC (dt-bindings/soc: + arm64)
> 2. remoteproc (dt-bindings).
> 
> Changes since v1
> ================
> 1. Add review tags
> 2. Patch 8: Remove ref from label (Rob)
> 

Hey folks!

It has been a month since this patchset was sent.

The bindings part have Rob's ack. Maybe the remote-proc should go via DT
tree? Even if that happens, still the DTS wait for the same amount of
time... so not sure what to do here. Shall I pick it up as well?

Best regards,
Krzysztof
