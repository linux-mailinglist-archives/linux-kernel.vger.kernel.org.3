Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F05817EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiGZQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiGZQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:51:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A377D63C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:51:41 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b11so6492821qvo.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWMoKp9O5cCiRpNuzRIWvI2y6hcDEynzvi/D30qooR0=;
        b=HMaz/pzZvwOUMpkU+vB+/CnvI0SflgzV9nihYoRVV5heuSGNVpKF+tsrlwVtfCPQaX
         PzMJHE4FfjsBp+6ZnS79PYmW7UuuL+wD3IP3ELl+xhYKThjpR358BBZhqGHHeoh+wM7p
         lsJ7ZQki6uCaALbV3KMIcAZTvJEbgq5vBDxS+ZGRabCA9XfLSxfeAXkaeQvOxoeSBb1R
         5rBTLz3pvA+ULThEsCyLVsfuCIOk3BOs9IDumjqw9Zp+XIJOisLH15TPQmdw8FCCJmgm
         MeyRH4Bwl+W+X+AiGGBLYLmK0y0ss+8559l7FctE45jVtTaVWLJYc9WTQgiBmK3X2BZF
         rFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWMoKp9O5cCiRpNuzRIWvI2y6hcDEynzvi/D30qooR0=;
        b=uo2SV3/gV3tlTz+7KkV6p7FSfI2YUJfJDe+YzfNDkqOhB9fDRfhGh9T5tFM+4hxfVU
         A5sTTO+jT5MA0cCjQoJ1ZyRfuBhYiHObtdKEnQkSnYEHG59lTy0UHD5ss+LPfeqruo0s
         pIlbKxE/L3+T6sM8YsT1V+I727zm2W+HT5TJGdwvnr7JEwKI0yS1Q7xnHYPf0aKtxCZy
         RXoE0KIHQZbFtwJqsJXbaTItb22nmqBslWQIavIRVB8yK2QxpKcbrxe0gqZMSu+UvM/m
         fPIfg2wjYOggkmp1rSf83eVAqipcjESu5W8RDKMVimECRvUHYfwOgCpb1bXz46OvyYVZ
         sCjQ==
X-Gm-Message-State: AJIora/Yj5Qv6hm4TUfZXOsRHMGvQRZJH4tEP3gx+HyI+BAFEsHQ9dwC
        TDaWVt9dXwmk9eJd2Pe194ATlKfVicyzjt0k6g/e6A==
X-Google-Smtp-Source: AGRyM1tqjdzZwmfAw2V3/D08e13F0gcRZUYKZyYGFurY02FXQRrZzbTjfN0zFvFiDtrxPDEhB08WpZAe5IzvqkoOJAA=
X-Received: by 2002:a05:6214:2a84:b0:473:2958:2b02 with SMTP id
 jr4-20020a0562142a8400b0047329582b02mr15856621qvb.122.1658854300801; Tue, 26
 Jul 2022 09:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org> <20220726150609.140472-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726150609.140472-6-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Jul 2022 19:51:29 +0300
Message-ID: <CAA8EJprjWz+VhsNVze7=MDqbZR4O3nsrsJQbZj-==TH2RMa29g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] ARM: qcom_defconfig: order items with savedefconfig
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 18:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Run savedefconfig and order the entries, without removing or adding
> anything.  This reduces conflicts, as new entries should not be added to
> the end, and makes it easier to spot differences against actual config.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm/configs/qcom_defconfig | 56 ++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 28 deletions(-)



-- 
With best wishes
Dmitry
