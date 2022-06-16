Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB054E20C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377052AbiFPNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376839AbiFPNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:34:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A25205DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:34:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t32so2182255ybt.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4oRD4fpeOcIe9J3CDXeLQW7t2RI1ucb4W5YyAxRXTc=;
        b=i+aNtOa0+P+UbHlJ+UN0VZmv+j16VlraJF77uRCdHFS9DDTc2ta8XYvSfxc1rbXh52
         C9Hwy4bHsghReeEsAOr5frAUR0h/6yvnL98uuM/BV5p6LF6ip1BxtdTvaIJRzEoCoJy7
         HA80uJ9DSen54oYDsfLIsIyXI8ieNXW53l/JP7kirV0mPi57XiWfohaX1D1/TOvEvTg/
         mTMITFgeJolEY5F43ftAl1AFapXqkYT57sFcHPxuWR/BDsZNk/fViXrCbaIOdIWGRapw
         Ef4Vs2gqSuHK2KLCX2E/zi9ktMQtWwZS2eAYxgKkkO8lJ6Wtt4oRt1hPRH4iksDjaemh
         +Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4oRD4fpeOcIe9J3CDXeLQW7t2RI1ucb4W5YyAxRXTc=;
        b=hYQ5fY9fnAxRRvm/n0ps9t46yb+BF6YOzpJqRQofr/eyV4i4RDUsHt5ahvwPREClN9
         AH8W6jkv2gghc5vbppfH80e6T0xZIWioStSV6TfcOiV0v6d9U12WlEDckCSxL60nDeEi
         +gJEvHKTSyam0w45fvRmlJpC7/uiv61j1mKXNEdVrQU/cqLJwfoSaUcl0F5u3hQkZ/67
         0idxTZnBgplCiwVHlZOe1CLMUhZ7Uh5icBGo60NOe5P8RRrrqAaOW+ei8LUdKDBbghkf
         fOkDN24ttMjABR86JUaoa/UUrAFfYLO/ylRkzdYeLosc62WNWaEIWQwlPkt5idNDpOvb
         AAlw==
X-Gm-Message-State: AJIora/5XVB2729SmOV+RIzb0xF8QgCNTKK0k9QVeBCyPjnkJY4PKo/n
        qtBkxBLPY7zGIEvLz9qwUrWMe3oNjnAzjdDszjW+3g==
X-Google-Smtp-Source: AGRyM1tOESzLLHsKWOfNIxiAJfDhdbEqfPn3s2ZPVjXgSzXCZ24IEI92hnqOwbzdBIKkU7b9sRdugwSZhPXLa08JRCI=
X-Received: by 2002:a25:3417:0:b0:664:aab3:7c44 with SMTP id
 b23-20020a253417000000b00664aab37c44mr5233002yba.533.1655386495611; Thu, 16
 Jun 2022 06:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220610203746.2191518-1-robh@kernel.org>
In-Reply-To: <20220610203746.2191518-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jun 2022 15:34:44 +0200
Message-ID: <CACRpkdaayHZaeC4X1+d_jC0nCvAtw=w2t2m1txj4OtV_LqcnoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd/partitions: Convert arm-firmware-suite
 to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
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

On Fri, Jun 10, 2022 at 10:38 PM Rob Herring <robh@kernel.org> wrote:

> Convert the arm,arm-firmware-suite partition binding to DT schema
> format. Simple conversion as there's only a compatible property.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

I see your own robot bit you about the unit name but with
that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
