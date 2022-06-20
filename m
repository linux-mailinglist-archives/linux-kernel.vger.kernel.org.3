Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37842551717
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbiFTLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiFTLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:15:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7841659F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n20so13616025ejz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PDUPEADjTysO+mW0NL3TVvFn5QhAfrPz/k4jnYFPPL4=;
        b=b/z7JDzP1ZHw1+DzWr/EyZeOFJkdVKikKEgc3wt2UpYOIFubbji8i8a8J0zNnRxe9i
         2QTDhaOF03EXnqMgmuh84GJimTuehwzuCjchSBPQcL1hIDe3fq6wEQ48duVWb575Zpc2
         5VEsKHFMA2eBa23zI3Gat3Q+uIRadXBwYwiVJob32wjSUKq7K3pPdSETRDRg/DTkkrWR
         vXN90/cIpc7QXa+o7GHKuCdru1CHouycAlGxQDQvtWm11Lthyl71DW2zlsIMZRzOykRP
         DL88UqKyc6q8iXDvOFmg7khjhwNcYp9bQvEy2RhwDDpOk3iIcJ9jicEE/lck2KyxeDLX
         oDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDUPEADjTysO+mW0NL3TVvFn5QhAfrPz/k4jnYFPPL4=;
        b=EfbZ8XLhdLgaakO++3vSYd4d5A1csjvTe/1DLLcgkewW9n9XO2BKKFRYPNNlCu4fpU
         rcI2LAoo7YRvRC3ZCtLaaS+u3L3mvHk7S353hsRmRkQS+xg2hZ/zj8dIUPw1KXmFnxSZ
         zfq6itIDZ14q4i7emsWGNI5VJgwPNVvoapicOH2mbZhqxQJ/tyke7MLLVuueC0nCMVaP
         C4lUsbohynfWgCv742OjGDwuInQH6obySNMAOuOwgU1NR+Rq0bsSLQ0QQNeY4zWDEMrQ
         4TDB9XouPodBF/uJlBZaW578/zrfp/jKaz9SU2fKtU6xacTirraZUB5Y18/371k15ska
         TWjQ==
X-Gm-Message-State: AJIora+cxqAiFFR1UCopwvO263gN6GiPNyK+smv7u7wa/czIgodJXWCH
        XFbl0WJTdEsymAAALuFrD9XO4EpZ8iyHOQ==
X-Google-Smtp-Source: AGRyM1v7ZEhn+sHHE30xE0qp6cQYFhsxB5lZl+gTtKPHBci6iRtfZiEpDw2heV4H54LXjhOZcxHIIg==
X-Received: by 2002:a17:907:7da8:b0:722:ca29:b58e with SMTP id oz40-20020a1709077da800b00722ca29b58emr2407642ejc.732.1655723685269;
        Mon, 20 Jun 2022 04:14:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b006fed9a0eb17sm5699969eje.187.2022.06.20.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:14:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: Re: (subset) [PATCH v3 34/40] ARM: dts: animeo: align gpio-key node names with dtschema
Date:   Mon, 20 Jun 2022 13:14:34 +0200
Message-Id: <165572367262.35195.3555641087941353753.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-34-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-34-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:53:27 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[34/40] ARM: dts: animeo: align gpio-key node names with dtschema
        https://git.kernel.org/krzk/linux/c/523b53bb750d91148222297c3857bbde7c7483a8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
