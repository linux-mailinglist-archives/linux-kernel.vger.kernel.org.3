Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B06518B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiECRvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbiECRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:51:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53D275DE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:48:04 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e12so32303148ybc.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=947aJh+pEr7uhg5BlGb1rh+bcGKYp8loqMrGOoU6w+4=;
        b=pOThmmz3gT39SJAqdfBILVMTCusmdZvvKsw9+CzaPlDdFRIo2Ft4figC5DBltX3RrB
         yPKSy8haYbn6qrNUA6/llov9aUz7WTayVoZIfgJePmVMqOjK+O3cW/GojkgJf6zydMeQ
         0o9kzWF9HFgze8tfygDe9vcXWhTYS6VNJaTVEkhB6y4Cg6FnBDc45OZZ49vSXdLn2u32
         rSm28eYdGBykW9luNRSiqDg2m1v/i8dF5/sXuuMqaz8fjzfpSxvdWs9AUGDteyOxZriE
         3/mEoJlldELZj9fS79bosJyDogCKhFE7cmFvZehjRVgiISUlUZoSyMuKX+GCz61UxAdA
         HW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=947aJh+pEr7uhg5BlGb1rh+bcGKYp8loqMrGOoU6w+4=;
        b=CShs2CoxOG5f/f98L4S/H/IFsWrqnmC9x0yIKott5/KYOdTBq9NJXDB/m231rj4h9G
         5iAudX4dcHfvQ6ke62UB7FVXpXSrlpySatGVnand/Gj56AB6QOfPbraqy2s9CjKm3YVL
         GRXPlu0wx2f4H17Tc5JfyUCgHcFeFSSQDeo6xpg+bN8nFqH3ZP+VY+mgvR4WAIOJdMI4
         eMPYKAjaeXBmEhObeTp1/EiwatJBM4QBfQCYPV6nStoc4wTFCLVNQVtLMZuHNOLOYTSg
         NzSt806auSeZqrT5y+ZaZj/I/tW1wDYbTDaGg8IOzY0YQHK//BSIq8U/CDWg96VASVIu
         kVeg==
X-Gm-Message-State: AOAM533VCsG7UmhhQAJFp0ZZttxBgvqtdfaG0nYz0EVugImi0J3vxRrC
        wyVHr53R/Y7eNHaKCTVmmNsdkoiY1XKaeKAtQG4PRg==
X-Google-Smtp-Source: ABdhPJzm0YF1sjSAAUj4xHDlO7MHxP4AMo9zj4md3lb8ZyaxQHD1hXlwpadeStLd+hwdUUADfHcnsqYtnekDKXX7NY4=
X-Received: by 2002:a25:cfd7:0:b0:648:4e70:a98 with SMTP id
 f206-20020a25cfd7000000b006484e700a98mr15208721ybg.368.1651600083819; Tue, 03
 May 2022 10:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-7-robert.foss@linaro.org> <YnFlzOxrjrfBaaSs@builder.lan>
In-Reply-To: <YnFlzOxrjrfBaaSs@builder.lan>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 3 May 2022 19:47:53 +0200
Message-ID: <CAG3jFytoV=nAzp8YQmHO6ypEYFy02i1nxAxfodaDuFRzX0UnGA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] dt-bindings: clock: Add Qcom SM8350 DISPCC bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 at 19:26, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:
>
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > Add sm8350 DISPCC bindings, which are simply a symlink to the sm8250
> > bindings. Update the documentation with the new compatible.
> >
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> This is missing your S-o-b as well.

Ack
