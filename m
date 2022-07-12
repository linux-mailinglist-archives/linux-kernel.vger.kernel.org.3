Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1595714D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiGLIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiGLIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:39:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9380507
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:39:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e69so12800054ybh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwAwI6J0LVXbBRyICwheygsAIzKjS1y09V3wEsL9VGY=;
        b=qJJY4LpTyW+n1zxGWTlKj49Onkt10Bvsx5WQ5rxR/co8RKeFA2L4JwpU5fNvCmqC4z
         4mRSDO27d+D22MYXRKJ9IgnxDSKIEbOaFaANiFtdb4SooM34P/t3LZRS5IP419lPTzBq
         7jsxbk4OKgzUR7beO2sLCYNv8u3GM2PGAVnB1309CjNs9iGzlLRwu/E6sYSJjaeKqPs4
         HzMRnGZak4aGcDAG1gSkiwNQlPxLApY4qvI3nBI8UMCvE78dlNywcYaYSoCYXSltgQhd
         gLAZCO7ohzu5yQflctZaGzHd3NOSX9sfq5R6DtvzsF83CPtkzruO2fdikFzuP7+/W88j
         hpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwAwI6J0LVXbBRyICwheygsAIzKjS1y09V3wEsL9VGY=;
        b=6/NQvvKCk6MrC/sRuZ5HTXbkJR6KK8noDBrKQqxC630406KPmOkxpLDvIkIuREWPdb
         uHiiwKHUHf7vxANVcXwyS6D3AbmCMxrgYYPj4KfOxm31/x/gzmElO3IrzEhMzpbD9uRT
         zHn+JstV9AsKItmNJ0H7DpLkudBwXz0YsSFtZ9lZjsWbYchdnRmgoatGe2JrKUl/LqZi
         Fk2CpWn5Q2ZuOLz8oejbuN5uo5vOoi+VFJAVsTOnQcRZqNOFacHckXlvV+DZkmPPHo9w
         DFy0cOY2s/ZfrJ2i3PxLapmGUKW86U+JjH1uT7am96XJhhOesfRY2eltGpLX3htAQDGH
         JzSQ==
X-Gm-Message-State: AJIora+V9fkuEeLyuoFOme9nu5+PmNPKkFbITz7mbTvd6RJpAsXreg10
        yBmUff3sufEXfoY8/IYo8XHOUA0ONtvmgSz+ytnJwA==
X-Google-Smtp-Source: AGRyM1v1Oxa2Ei7Zc9A6vXkFvArZM8yXqdVl4lpmO0YzWay4WnBwmf6aRkFO4ZkQqiKVseOQXQDCn8ZveRR7m0/vNUQ=
X-Received: by 2002:a05:6902:150a:b0:66f:8a6:be47 with SMTP id
 q10-20020a056902150a00b0066f08a6be47mr13784846ybu.291.1657615156399; Tue, 12
 Jul 2022 01:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220711203408.2949888-1-robimarko@gmail.com> <20220711203408.2949888-3-robimarko@gmail.com>
In-Reply-To: <20220711203408.2949888-3-robimarko@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jul 2022 10:39:05 +0200
Message-ID: <CACRpkdbLKXrVu9q3m1BRfRMT5q4gtrtuSNw0PmTsZBraeytVFw@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] dt-bindings: pinctrl: qcom,pmic-gpio: add PMP8074
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 10:34 PM Robert Marko <robimarko@gmail.com> wrote:

> Document the compatible for PMP8074 which has 12 GPIO-s with holes at
> GPIO1 and GPIO12.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
