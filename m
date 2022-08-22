Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6059BE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiHVLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiHVLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:09:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E641A393
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:09:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ce26so4693650ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kz4lUJFQeluTJdkQDoeD1e50ln0ulghIHI6OqES8gKk=;
        b=i/UEwikqQugib7mXXYh1BRVhl0BDo7FLssixho48gXZzYRnlia9B01V0s5bMceXkoJ
         eOVUbhVR2tmEgCZhHfGd7Jc/u1q0JOw3K5G4G9mSU+k35+ZyDATep27G2XbMqQjQC5GX
         m30dLQ/D5J7TvfcB0GgrSKVFiJt5kjVboLGl9aHZroQo9g57empGvEcqmWUN/bkUUGAI
         6itN++O9xzE7pzNM3f4ZLOP0xNVpBPen8TfFEZoVj8MV8U/PMHmIJ/ZRkvcoUz/jNbd4
         VM7kmatmc4/qlanS04I8bNJm4rXe5Ja/9O2irdSRKnx55K3OqdyvfdjUxlGG1UZIvKGd
         ERiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kz4lUJFQeluTJdkQDoeD1e50ln0ulghIHI6OqES8gKk=;
        b=jIGMRt5n+TtcjCLhXl3UdtHaCaqtzqrvJ5kW8TEq+brmew+lJwQepW0KQj6PNtQl5Q
         yPk4ZnLYxBeDvLhLwMA88WH5K08T8fXU976Kjm/FzAD+Da+hRpyIivvA8A5s3Ozjj3SI
         44n+JmNNPoC/OIzupuDCdbTk4VlNIdSHQ7x0MEyLqqpXtcCQeVngDslZRS3vnpuSedNY
         DwgU5l0yN8nHaNyh+HpznM9jm5xiSvXnLfC3mo6/CZs2N2cas0UU774EGRXtx5SoW+VC
         jbFVHeQKvDGyw76dNKlk+uVepdltlujyJ77X5jOc+hbHnLL+gvxFbLN3GR+E6eZElDS+
         uTYA==
X-Gm-Message-State: ACgBeo0Jt27rlED2gelVpwrxZUKuxxt+lwExwIaWJiiVSdUFDtqi5sU4
        q4VPu/8PoaYdpG8daqe+Kh/5nUD7EwhsQ5P9jhOeRA==
X-Google-Smtp-Source: AA6agR4SJQb77HChPBxtTvM9Bte1KKm8Fo45SwdpWpY1Zsair1ydEkJJ3pCJgYtXmfdBO3jr3fmVklL0zmnURpynhpY=
X-Received: by 2002:a17:906:974f:b0:73d:716a:7d98 with SMTP id
 o15-20020a170906974f00b0073d716a7d98mr4698929ejy.208.1661166588704; Mon, 22
 Aug 2022 04:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220810111023.280908-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810111023.280908-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 13:09:37 +0200
Message-ID: <CACRpkdaonse-DXwrBBup99EOUchQWJ9LS3H-E1WVzgy450ZxgA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: integratorap: align SPI node name with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 10, 2022 at 1:10 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The node names should be generic and DT schema expects certain pattern:
>
>   ssp@300000: $nodename:0: 'ssp@300000' does not match '^spi(@.*|-[0-9a-f])*$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I already have a patch for this from Kuldeep, will send upstream ASAP, thanks
anyway!

Yours,
Linus Walleij
