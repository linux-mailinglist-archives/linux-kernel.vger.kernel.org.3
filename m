Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EE59BE45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiHVLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiHVLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:11:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7679A1144B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:11:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb36so20388670ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OEroSL/F5loKrwxv3iK1vYMAkQUmUy4j2TLiaXHDnrU=;
        b=NYzO3zeux15mH53bA4W8Lmt95J/7acnjx58Vv9QUf4dQhkRC1u6gdBwdkl+giXe6U8
         hXYrhnGrnTdksCEVOI/2oNOb9ZDDA2nLsJR3j8M0UymYNCwGuc48CXJ4/XYbEqmC6AtU
         xA20+T6K4v3zDDp/XZXkhnSF6NiIugZMylI4R9vcQs7UMn0hnXk51rgEze+eVQ+nuSSN
         0QHs3lsLDzUsu72JU0jMFJ09F68nzj7F5utJXk402NqB5KuBZMPY383hfxKIhg7grDMK
         cjhnwMTKItM5jAPkM1LpAYQ0mCsrl1RmzundZqnv0utolwaG7sy9DwzDqGKTOmn/QbSI
         lMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OEroSL/F5loKrwxv3iK1vYMAkQUmUy4j2TLiaXHDnrU=;
        b=Dcpdxubr8HEk0xyNMO26hIPTgQO2jCA9jhhssPuXrEf8YHH4W9PLyn47jmuno2T3HL
         DdygP42w2vrQ9g4rd4BXIP3CKspKpOggRUqMK50+JI96YYSanVASBpTDDWJFlO7fVS3v
         GpsR3i2NLyGNFlHHJpjbewut6pQA36I0J0CwVaxFI9xBL1bkVHdDQlThfHb1qx2S3xA+
         2KlI9Lo1kjxQh9pV8z9Y9HE7AeHWWESCkMyhe5NWMCoK0Sth77gkJlqE49BJo6jW8M/m
         ikvQVhNWSeBo87P4lOBbSZE1l2fLOZHamhNt+gRTAV0F+4I8U2axDZ6CaS9QW5IbeGkI
         Tmlg==
X-Gm-Message-State: ACgBeo2ZSdBZui3p+uUYE6qNPYJsTEYF65J8wTMlBr87bIUzVOTMt/WK
        +4Q/6TA7nr7ZBr4Es1y6obE8vg4B1z4GMx8VrCZgEw==
X-Google-Smtp-Source: AA6agR7JaDwBOX8Gsy6aV2nQ6fQrHjocsPFww8INvgIfyuVL4tvn4G5kER/fuR+FhUDBdOrgjtS/FDLl67qHsuh6S1Y=
X-Received: by 2002:a17:906:478f:b0:73d:7919:b23 with SMTP id
 cw15-20020a170906478f00b0073d79190b23mr3684341ejc.690.1661166704094; Mon, 22
 Aug 2022 04:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220810160341.51995-1-robh@kernel.org>
In-Reply-To: <20220810160341.51995-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 13:11:32 +0200
Message-ID: <CACRpkdaiV53LUSAB4C0xJAZwmRL8vz5nsmPdZ5PtyiDoP-982g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Convert arm,versatile-sysreg to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
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

On Wed, Aug 10, 2022 at 6:03 PM Rob Herring <robh@kernel.org> wrote:

> This short series converts the arm,versatile-sysreg binding to DT schema.
> The binding is already in use in examples which unsurprisingly needs a
> fix with the schema added.

Excellent, thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I assume you will apply this to the binding tree or similar, else tell me
what to do!

Yours,
Linus Walleij
