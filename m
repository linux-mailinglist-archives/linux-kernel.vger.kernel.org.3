Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568034B1A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbiBKAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:06:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiBKAGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:06:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64954270A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:06:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so20410160ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6V1dY7qH4XL0CAYuK2Vnpgq4jGgOMChN5apsqSbEVz4=;
        b=I4KkwcTzPrUS5XBCJI5mclWxp/zgGo5+AgOEvrnHlHoZoB9A1klt91o4yKWAgYkr92
         NScV0bFUW+pJxPlfWIgg+G6HQnWRbd1MMGot90IFSMfkJzq2qZZyJGk4Zl876Cu60n4F
         D/n/731FNUlaCnhgn6fjzIILLjhiyldwlz9Sl3/P9rcNYmABUjdR6mz2OIcoEryA4Hop
         3IxObDYSSEez3eHVT0QhkMY0vjTrGGPnlkoRIk/rJoQw7A8hkIr0oxoK5PmtkdgRZ+8S
         p/7ThnZyIEVN3rzhj6HoORXIWDc7k7Oc5RnCUHvqGrxujkXTP3leAkGk/GY+ABX4VFth
         OD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6V1dY7qH4XL0CAYuK2Vnpgq4jGgOMChN5apsqSbEVz4=;
        b=d7YuJh833Wq7OKBlttm1PZE084HfbGcPhyEL5EGMBHjmQ1+dlctw4KnYrz/PoviodG
         D8P5dUEB/VvTuCaTy6wgdXomSSDmTLKXP8NjlF6bFUOm9sTngtYdqEcRpp57h+z/dTm8
         PRUlsRkLD126pWJQ7bBo3r+V5npZe4uEwd+uJrSkTO0VV+QeDbLAW6pHx4946ukSn1R4
         Z1Kzzv9m1BtofzAIaj0BtftWG5nZi9HzbE93FsvlxZ4PA55jPwW1qOPVC7AqhNR7mHVR
         0DAalTPIXSmGw/XiUXphujCjC1ZgrzJD44wqDcgG8TUXKLXmEps8MmmvxcTtus2aT8a1
         ogIg==
X-Gm-Message-State: AOAM530EpXz8sIIpEZbWuQPxMgqCxgVzgHQ2RGXOYDMZTqx8SfuzXIKg
        qNe9yHytrqvyXFYlwFYBmwS7U520rIpSmDFOf2nPEw==
X-Google-Smtp-Source: ABdhPJz+jjvVDAMnJAeqVCkF3QOXGnhLDGmaiuRR3lJzsVoxuZ87a7x5HWn4GRjaO1r1yECcDxpqMOwKzaMCxaaBxLU=
X-Received: by 2002:a0d:f903:: with SMTP id j3mr9686393ywf.118.1644537981686;
 Thu, 10 Feb 2022 16:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20220112194118.178026-1-luca@z3ntu.xyz> <20220112194118.178026-9-luca@z3ntu.xyz>
In-Reply-To: <20220112194118.178026-9-luca@z3ntu.xyz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:06:10 +0100
Message-ID: <CACRpkdZCdEGdAPXfNsFxN+mH=J8-23Hdq+EXp=uuihwiqjbufw@mail.gmail.com>
Subject: Re: [PATCH 08/15] dt-bindings: pinctrl: qcom: msm8953: allow gpio-reserved-ranges
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jan 12, 2022 at 8:42 PM Luca Weiss <luca@z3ntu.xyz> wrote:

> Allow the gpio-reserved-ranges property to be used in dts.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij
