Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA225689B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiGFNl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiGFNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:41:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9B24BE4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:41:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b125so10997394qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHSKlvMGkv1jpA5A5SMLM9ENueVd+m4sc9yzrKgH5As=;
        b=tdJHZF+S3YNuq+J1C/YZfx7geIiJ8GM0cgdNBSb+HD3tkKT7XqFthGWedqgKvYJGKY
         2rrZqfDgts0l9pX3U9RLrndFnHEaovza8DmkvVgi8JnOfL9MQJmMQ4tjc5Qv4Vl4DIcW
         fcoj+4BtYzi2hHkqFu0W7Ufxw6txWu/jq/NZsyZfU3/fcZkU7w+9aiWkZ4QWZYLowddE
         vL8OhTWsWvbZSan+E7ldv/wxbG/bD5OV1NUru5KvSNDjmISrDBRoJ6ZKdFZMB2I3cOYH
         MDhObyIXZVpFQGm7wvjBfhC6ob7B6DZY4nloFIaXhM1Hecfu/dDWEZtvP/ps9RnrhdtP
         NX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHSKlvMGkv1jpA5A5SMLM9ENueVd+m4sc9yzrKgH5As=;
        b=VUwhSM7Dobmshig7bhOCYXsj0Py/+bOILzS0+8xRjItHy3I56JMtqPBbTS7G6wnDxr
         /AiR7WhKyHARAxd3NyS2BXi3Ibs2FZlFoX0p5/QfzG8iG7+Zi8rKv8l3I8dGh+xd8WvN
         h11VJemVOeK64jZI6L3zWku/0aHn2ka7dy7PQvtkNd9nbhUbFyv1CXjGbnzJ2Nl1JEO1
         0VjprYq2Ol4QXwdWtKqpaGvCi00LvpuJ0aWeJ7HaKM3LGvzehWdqrT0uTY0LaPD6ryo5
         xdDDrxYwbuuw5cRJgKfDDU4rTaYE8/RKrmQqpZhExsbV4Zr4DtC6lc6pMT03cD/1/KlU
         ORVg==
X-Gm-Message-State: AJIora94xTQ+Td3MeXIdPsFiTY6gvc/JCF9y986Htv5bsB3jA13lA7pu
        qqfxWhrATu84wNzK2meutpZUfeNr2+SVgordgEdngFBmR/o=
X-Google-Smtp-Source: AGRyM1tOjUM5+iQr5E5SnPFxhjWcK2SxQVuNTQqxyehUosjE+wLpxhrXdcOkgplr5ZDw0Hdz468XCEMKDlXBr5ugv/w=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr25162746qko.363.1657114880728; Wed, 06
 Jul 2022 06:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220705133917.8405-1-ansuelsmth@gmail.com> <20220705133917.8405-10-ansuelsmth@gmail.com>
 <a56f2941-b386-19f3-a6ad-b5a0738c8458@somainline.org>
In-Reply-To: <a56f2941-b386-19f3-a6ad-b5a0738c8458@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 16:41:09 +0300
Message-ID: <CAA8EJpohZMg5MVJiqxZ7axcr1Cf3AhJEE7c5nBOdTvmZQCrT1g@mail.gmail.com>
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 at 16:11, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
>
>
> On 5.07.2022 15:39, Christian Marangi wrote:
> > Add missing smem node for ipq8064.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> I can't find a downstream kernel for these router SoCs, but
> I wonder if the 8x64 family DTs couldn't be somewhat
> unified? It looks like they share quite some code..

Let's modernize them first, using the other one as an example. We can
merge them afterwards. And don't forget the foster child, msm8960.

>

-- 
With best wishes
Dmitry
