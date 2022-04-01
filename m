Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7FA4EEE88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiDANy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344797AbiDANyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:54:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3C9280C0A;
        Fri,  1 Apr 2022 06:52:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x31so2692347pfh.9;
        Fri, 01 Apr 2022 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zWTc1GA+fDXQjVICuLK5pDFkGNHXuuKJ75eX3a0jFpk=;
        b=q8JS2irBMX1lLwCC7Oi3yAaY/hQ1zpcHByB5AgM41VPIU1DQuLACPYobevPxPc+uB7
         aK+87kQULmu9KeFyHKgU8+nfyCYrUt4KIi1zaOaV4vglIH6C1zStNGyA9nIgJn4yT6oI
         0+W5HFu6UJiY9qb9gY6Fvb7HqBHoOOk7wriStn6wwguau8DCr2JqRWFwu7F8WmuUxrGN
         cvMVRE1KSw0Ee0PkCKn21TjMCa7xLL2UWvU53N9u2VG41waHYHu/Mw90HbAuIOX2FDtC
         cCgr4pp6v6KvErodaM44Xuakm8aR1N7Ce7bOWBgZOJFmkDj85zODAPEdfh7lxPKLQXfT
         xMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWTc1GA+fDXQjVICuLK5pDFkGNHXuuKJ75eX3a0jFpk=;
        b=F8T8zJVRzX0NcD/MI/T5qe/AxGPzL1awDLv2G+AGjKHCAJXzysAfaP8zISycTSLAFd
         jrG5NG/R6XlMM2aq2dX+oIqH7LahwIIlCEeJaoWSffK6PgXeUSh1NcqCw/5FTm0zagKH
         RuoAxIlXgCy/2Xs8QwMM24JEPCj0X4NomPi76MWJKpTowyjt9M5wtiFf1DerWpGUep2I
         +2sApOiWXSX1bcDvPzWhxKdVW+IFsxvdjdlChZa7yTf2LjCz9svP515yzPqEM4uflzmj
         Cee3rnJUKyg0T5yfaNsUxtIggg4UDYDV1cfHcm5lbArhFFMG14CJrdlQ4xmGA2rXYq8M
         67eQ==
X-Gm-Message-State: AOAM530BD/OK+dycDzh++0mwbY0F4cQrKCaGSZm8ih+Da4K2aSujfl6Q
        /q6r64B4IRdHKImHmI1Ky1s=
X-Google-Smtp-Source: ABdhPJy3hN5vTr9dLoBt4zMf7HbBZijJUPijvLmh0eNC9FCvnJmNdb6cYKiFWxU0MIfOkZ0iGr2wSQ==
X-Received: by 2002:a63:ec43:0:b0:382:11ef:b94a with SMTP id r3-20020a63ec43000000b0038211efb94amr15399453pgj.409.1648821151426;
        Fri, 01 Apr 2022 06:52:31 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b00398d8b19bbfsm2567167pge.23.2022.04.01.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 06:52:31 -0700 (PDT)
Date:   Fri, 1 Apr 2022 19:22:24 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Message-ID: <20220401135224.GA40286@9a2d8922b8f1>
References: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
 <20220331175817.GA91341@9a2d8922b8f1>
 <ddc12aab-3cff-16a1-9ec9-a246240f9521@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc12aab-3cff-16a1-9ec9-a246240f9521@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:40:08PM +0200, Krzysztof Kozlowski wrote:
> On 31/03/2022 19:58, Kuldeep Singh wrote:
> > On Thu, Mar 31, 2022 at 06:02:47PM +0200, Krzysztof Kozlowski wrote:
> >> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> >> Peripheral Interface (SPI) bindings to DT Schema.
> >>
> >> The original bindings in TXT were not complete, so add during conversion
> >> properties already used in DTS and/or in the driver: reg-names, dmas,
> >> interconnects, operating points and power-domains.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[...]

> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  reg-names:
> >> +    const: se
> > 
> > Why reg-names is required?
> > Reg contain max 1 value, we can skip reg-names like other users.
> > 
> > Also, "se" is used as clock name and using it again for reg-names?
> > I think this is wrong and reg-names shouldn't be documented.
> 
> reg-names are not required. If you ask why they are documented? As I
> wrote in commit msg - bindings were not fully updated to DTSes being used.

Hi Krzysztof,

Power-domains, operating-points etc. makes sense, but reg-names?

With quick search, sm8150.dtsi is the only user of reg-names. Moreover,
there is no reference in driver to incorporate it.
Driver(drivers/spi/spi-geni-qcom.c) looks for "se" as clock name and not
as reg-name. If there's one, kindly help in pointing out.

It seems you are adding reg-names because some DT is using it and no
other reason. And with no reference even in driver, that's surely not a
way to go ahead as you have been advising the same in past.

-Kuldeep
