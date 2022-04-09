Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE894FA187
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiDICG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiDICG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:06:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE61CFCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:04:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r3so2349362edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cUq6wKL2eg4YK3c6xmRvhrYxfFrlkl8iW8PAzAV5Zc=;
        b=2ks+z6QqN7kNNK8lKkDTCE7RM5AkUgvnu2j6q6InkjwMR3sUtFR18cLs/tjNaVTctg
         bfX/BfmbpkCnB16dEWAvDaNgsQwaMECrwCqi00r7zJCEPrG6lDNgbx6NW9YtPMZinUwt
         5Vk8+CHnJvsPgDEFVToLY6AXbI7ona/+wEKeDa5less2toAKp9tjzfi+Bd05m+/H+r3g
         aVaoVhS5jzsLJgDiUNkWATqF0mYK85vfpUUtRiL3BTuftGAliYytt1GUXmrMdh2ARE+H
         2v5NoDc1EGPz+t07TabYy/tmdfqCJo5NmF9pY6WU94TV4nbH9gOPd65s8RstC4ugMpVy
         mEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cUq6wKL2eg4YK3c6xmRvhrYxfFrlkl8iW8PAzAV5Zc=;
        b=IPCY7+YMYooR5Ai0OOzETwd7PUlxa+KbKn+B75PTvTNdcx34Xdesey7ISRZSq6rE1M
         oyVYiliVM3b3YP2R1BqvNv4EQdd/mBeCgwj4aRtO8oR/p/UyXpYMplhsGY3E/aeytvDN
         V1Qyvn/MN6jPqIUIFfdXP+iwdQ9z3Zky9gRDAHe7hQfx0u+YcoOeoTmPyD1zV3Jg/lI8
         1JKSn2Z/kzailj3ucSezyNekXe87rtzE1WtgbcJrEQYFmbvcyQPgjwpNJjt22H/iJXT6
         vWoAGGEJAS6dnBH15YuN6iCw8QD+A4+auPdGTChAEwF4rIY4IxFHInGjCrtfZv2RBSEt
         jbvQ==
X-Gm-Message-State: AOAM532B8K0ASQDsM1ARTGqTzttgllIwnedbYb6uS+27jrPbSbPjIsNC
        SgEsWv+8mS3bESJ8Wh4g65KQSPfDCJ1ABUB9tYtBRA==
X-Google-Smtp-Source: ABdhPJw8VmMCU/F2QWOhnLWYUiSxqw1LGnzIiAnctMNwRiGRe1sb6g6TTMrBy4XimjkeJVJbwRyW8L37F65jQJ7PvyY=
X-Received: by 2002:a05:6402:1541:b0:41c:bfb9:d56b with SMTP id
 p1-20020a056402154100b0041cbfb9d56bmr22092637edx.344.1649469890042; Fri, 08
 Apr 2022 19:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-2-brad@pensando.io>
 <a2f89f06-f586-2bf3-fbfa-f0fd1b6ad057@linaro.org>
In-Reply-To: <a2f89f06-f586-2bf3-fbfa-f0fd1b6ad057@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Fri, 8 Apr 2022 19:04:39 -0700
Message-ID: <CAK9rFnw0vxh6hjGf4XCGrfuM4Qak5_BmMcYjxkcUwqFL-V6rmg@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 11:54 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> > diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
>
> It seems you ignored to Cc devicetree binding maintainers for all your
> devicetree bindings patches.
>
> Please rebase on a recent kernel tree and use scripts/get_maintainers.pl
> to get list of people to Cc. Your tree could not have my address, but
> why Rob is missing is a surprise...

Hi Krzysztof,

Thanks for pointing this out.  I used get_maintainers.pl on the
original patchset that has evolved.  I will redo the list for the next
submission.

Best,
Brad
