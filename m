Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA755A841
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiFYIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFYIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:51:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA9419A4;
        Sat, 25 Jun 2022 01:51:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c137so3512338qkg.5;
        Sat, 25 Jun 2022 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gr7rHwj4uZV2BrO1OagJPPNTulCd6lAi4kIBjcgZsYk=;
        b=RF3hzoPNG9vTghwo8Zhz+k+WmE8fn0+6kzxobSF7lZMuwexuhuRa4uU2HdfatbuaO3
         2X6IGckFsgx2jz4VSCheJLkCw9P1qKxdC/cHZAUSVJ+L2ENfSr0LMqSdRFXYW3Cb7Rq7
         7/KSMpCA4pNOoG+om3o1xSWkRXQKhx0MqNLR5K+907lHBFWDA5QkYOC4SooA7vlv3/hw
         tx0DDk3CLG7zxrA/zKdfcrMthH8tksK1ywdTBr/Vp/FaTlxDTz6/IY2qHGR3Idim7q4A
         ULUywPAFVUvF8zqlgYg6Amewifo6H6ugiwbYB3U/oWahF/yrU0nZdqekEDa/irM82vhz
         eL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gr7rHwj4uZV2BrO1OagJPPNTulCd6lAi4kIBjcgZsYk=;
        b=Q+4gf93dDVMOz0Mlgpy5P/b1WdtsQRl0mqoN79N5bn0rlnKP1nv/OP/7aoGaKHZjkH
         LuSnuyIbnWXX7utqyStNj/c9/PGVCYf/yn18Javb3uiB6DWw5wpYSfsAhn2Ln5kZ1SHe
         /9ukUZEXaaqo6A6N5uVAdBiTyRJ6UN4k+AojJ+lxN58YirLBcXkZtJxc0HkerwmV1bwn
         kyqqCOEB9wpZDDpH1YSOlu5r+LFn//TeBg5xgQdKNbGQsLWtAwMbPiG61/GdNlqqc0RY
         bR7yEX9r/g89WLvC2NOYs9L60JSaPVUMVCXOYH/eW51EZ70D/wWaCVH8hCEHtbAjXkmu
         9bbQ==
X-Gm-Message-State: AJIora9DqJ34dlYEVdx9tY17Bn0wXbZsD4VxSwcPHKtbm2kiafGVx0VK
        OAXNgzGDCX61W6631smyTDIR3BYb1UQK1pMIxMQ=
X-Google-Smtp-Source: AGRyM1vnMR2wmyHZ82Hm11vMWcd0aHa0cK911PF15+gzrd3hKdZXPTKZj8n6Rj+ksDElGT+sDKNwTHx7h462FXBGNoU=
X-Received: by 2002:a05:620a:2450:b0:6a6:d264:2b88 with SMTP id
 h16-20020a05620a245000b006a6d2642b88mr2100874qkn.25.1656147060016; Sat, 25
 Jun 2022 01:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220623182542.1116677-1-robimarko@gmail.com> <26cdc24c-e0e8-1059-f6ca-11c08615eeca@linaro.org>
In-Reply-To: <26cdc24c-e0e8-1059-f6ca-11c08615eeca@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 25 Jun 2022 10:50:49 +0200
Message-ID: <CAOX2RU7aEaBt_PYS2UA6BES+dJgx4n2QPHJ6yWYWZuTt2SLXoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 at 11:52, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/06/2022 20:25, Robert Marko wrote:
> > Convert bindings for Qualcomm SCM to dtschema.
> >
> > SoC compatibles that were used, but not documented were added.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> This was already submitted:
> https://lore.kernel.org/all/20211218194038.26913-1-david@ixit.cz/

Hi Krzysztof,
I was not aware there was already a version sent, just used linux-next
as the base
and it wasn't there so I assumed, will search through the archives next time.

Anyway, that attempt looks abandoned.

Regards,
Robert
>
> David,
> Do you intend to work on the bindings you submitted before? There are
> several pending on your side (things to be fixed), so I am not sure if
> work is abandoned or just waiting.
>
> Best regards,
> Krzysztof
