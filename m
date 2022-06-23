Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1A557297
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiFWFep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFWFel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:34:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F582B1A6;
        Wed, 22 Jun 2022 22:34:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e5so10372895wma.0;
        Wed, 22 Jun 2022 22:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8cxDTttGuvM5WfX5frYexXa0T6hUzSm4PgtcOxFD6s=;
        b=nMxRlStSEh8OiHmbIP+I1FAfjgkYRbF158GwowQoYBAgp1Ry5ceVQzXvYyhPfQsW8w
         BmPMo13r28aDqxZZT+jWMnoG5WGNuauGXl/TvnXVkCr381COm6zJO2b4PijkUFBJrDow
         WN66EZCBeYlgzROXe2+KQjtXqKnUO892AETRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8cxDTttGuvM5WfX5frYexXa0T6hUzSm4PgtcOxFD6s=;
        b=cq0c/JVnS7HghK4R4mHrFX2uC+R+iKuzZtPxmNDgddZWNFGFIvEsPhnVpdsI0XaoA/
         C88rhOObxC9/bmTgwPvqBVmrOKR2scOOUoq1Bl4tl5aPMVty7BFZRp+u1MEhdv9xe8Gv
         QxWmlK9lSj4J+KIu9vaEgr2qxaHdLC9UBWB5CdPXdcrdbPobvBgKG8IzP74SUQ1LnzOb
         3VX+fNQJ/hoydkBf5VLcyUjFF1sE8xJ/zYHa+RrkNStSnf/Jg2DjNMseeMjqN8GaULQb
         cbY3MCobY2TdwBiDAmkydtAvd7KI4V1phHxxvLhPLNna8iMFKBnas+d4TkifiiV/SXN/
         +RXQ==
X-Gm-Message-State: AJIora9A2/cyify4QsdfHIQQu4je2VCpEdCC2f2gL3WvMS4ZmEy9+bev
        ewIfC8HGfpRq7th0CLAV5Kek9BFwrp3S2c6uHUc=
X-Google-Smtp-Source: AGRyM1tXegIUiy0sBBYZdYNPa6XJdexkZiJZp4a8S0xAChirQ3IDFRLYnIeC5JTovAQeot2wwJ3SQBXgnb4ABFJefv0=
X-Received: by 2002:a05:600c:1990:b0:39c:81f0:a882 with SMTP id
 t16-20020a05600c199000b0039c81f0a882mr1950976wmq.72.1655962478517; Wed, 22
 Jun 2022 22:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-7-krzysztof.kozlowski@linaro.org> <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
In-Reply-To: <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 23 Jun 2022 05:34:26 +0000
Message-ID: <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Steven Lee <steven_lee@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Wang <David_Wang6097@jabil.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 at 10:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On Sun, 29 May 2022 12:49:28 +0200, Krzysztof Kozlowski wrote:
> > "qualcomm" is not a documented compatible and instead "qcom" should be
> > used.
> >
> >
>
> Applied, thanks!

What tree did you apply this to? Did you get review from the maintainer?

This board is unmaintained and unused. I would prefer it removed
rather than meaningless fixes be applied.

>
> [7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
>       https://git.kernel.org/krzk/linux/c/6202c6063145cf9ec22b40aac219122dd702a10f
>
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
