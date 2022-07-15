Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF2575F96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGOK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiGOK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:58:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03685F8C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:58:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m6so3411216qvq.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjXJYU8Ca6zEedr5pwyFGi7gqZxYyLWinYBmJNfXr0o=;
        b=yAw42Riqh9SF51Nq5en1JtNN5JqGWpNDiFFBWdqthtOO6QqwS7YFrGQbaAz2+Zb8Wp
         +SPhcKkvb7k6thRa8q1b4AwjO1cONFF7jzbaUB5ORBH157jtnvfhqu540iBT2uplwl9t
         wS7RqwZM+qu0t653Wtxhm103zENWmn7UfYY6u3Twwvv5rz9lTt26V4nBq2vajfDPK3A7
         72W5ulCD4P3D3as3Q/iI02PAWRe0sZVUsXxo34gx4i3XU0KpLMvE63gY1S2E6w0vHmYo
         Djsca5v/eNyBaYLkUcEMPmiitWoPjDNMwd7kRb3TRr2FUVgkMj9DMV1G5fVjBsUeWf7X
         LuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjXJYU8Ca6zEedr5pwyFGi7gqZxYyLWinYBmJNfXr0o=;
        b=fBiXtefackU/nhjFkEaGnLAO0Gy6pxwKJVoInSLjCZzzCriDgfgZB5UBlcyf4ADa15
         z/0BqG32O9ET1evSjgUMqgpjIJIz4Q+RCWy6g5EdiFXw0VQ0JJ7vP06VXNZSQ2rnr6f1
         qXF21MgPIfoC0jNFQXQ4zLzSHiGJeQb6SABSaTxqa6BibSXuitMVj0P9w3z+do7VbXzK
         RrGzYOUonkxaygWDDyybh202cQHT2VBqiwHIzapKbFdMgcXiBmV43wERrncq/s2LZKr+
         j8VYI73pLRvNvjGiiJVb4FaPfYcHjlDMEAU8jLHwotZwmJgBqRolmv3A5tk/wIuL1Ld8
         eM/Q==
X-Gm-Message-State: AJIora9CZsI20UYWmROpMVjKnJAOfjsxNsOl/qPpHBHxlSQHbEOEef9A
        UIeA8YiG7cFAmh4RU5SmpapWlclm0Ds+67Sot3Jbrw==
X-Google-Smtp-Source: AGRyM1tEIsAaCJg+HSR8qR8BS2VnxOA/YbkmYpyTrN1q01vkMCdJKkz8yJ46Jcn4M8eui61Owe5WqQlEXDnqA4fUe78=
X-Received: by 2002:ad4:5f8a:0:b0:473:2108:7fe0 with SMTP id
 jp10-20020ad45f8a000000b0047321087fe0mr11229869qvb.115.1657882688188; Fri, 15
 Jul 2022 03:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220714124333.27643-1-johan+linaro@kernel.org> <20220714124333.27643-29-johan+linaro@kernel.org>
In-Reply-To: <20220714124333.27643-29-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Jul 2022 13:57:57 +0300
Message-ID: <CAA8EJpoBhFyoUrUYM3+gYk4hvORvp_3hLYJCF82-LR3_YxLFsA@mail.gmail.com>
Subject: Re: [PATCH v3 28/30] phy: qcom-qmp-pcie-msm8996: drop pipe clock lane suffix
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 at 15:44, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The pipe clock is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the clock name.
>
> Update driver to support the new binding where the pipe clock name has
> been deprecated by instead requesting the clock by index.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

-- 
With best wishes
Dmitry
