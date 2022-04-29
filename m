Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C3514FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359559AbiD2PnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiD2PnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:43:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE90D64EF;
        Fri, 29 Apr 2022 08:39:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so16140028eja.11;
        Fri, 29 Apr 2022 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mmy7RuPMU9hCC/2o2BzJ3rLqYOzAAc3YMuV1L840fY=;
        b=i+LxBL7iEddxNdeB47NwwEeblzTlvP/xkHb3kztkrbhOeQ7NYmE/BOaMX+pYeWC7JI
         kFidWrhpdqBmR9M6OS4sqssUmN/EbofEIc4u52ErRJ6IXhoThxZEeJFvidJHzLmwcdbt
         C1/EeVsuvYQcRmF7YseuoTBlBSuoot2dihCCfusuEeI+NYnnSwlwRTOyc/nHIqN++YSK
         t9R3JZgsO2jsPVvTj8BB/SJ/uk5tev642NtoR4Jh+Khofyyb5owT4ks4a0VgWzyEIHBk
         dmhObRVcJUH40ze/gihxdQExwcLfzKYZV1NWEv4Qaum0x/BvdYh6AxlqL8JKaWbE7aSn
         lxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mmy7RuPMU9hCC/2o2BzJ3rLqYOzAAc3YMuV1L840fY=;
        b=rzHg3kJ0phbzwerEiWFKl8aYKAFOyOTSL/Zda6J1hnLVlIDyRiArif3IQfBenHnlsS
         +eELN8ZAqwaAWn1OeuDEfXdKP20aQN4FKbqcMpnIL4Aer2PbuX9CE77nJLZ2qK1sZDT8
         yrBlPJJGdlpI0kH5zAHxMdIaF3+yYNb9Zn+3hTSxG3NWf/pajdhMJyN5sK7YynPO/6Aj
         +5aTK91TYvuyiUvA2MI9hyeI2NqqKwRnYYPQOa7qWrIqHXImya8WJZUfhQn8IZRTj36w
         ndjs2NYwwUi5uUGvckpMIUv/smSc/NlxkNezpAPQYdMJQoQF+RE2L3DRUFft5+bENbD2
         TR2A==
X-Gm-Message-State: AOAM530vmmoEua3Zfn0tOo3oN7/VgqbxtGVv8tbWrkTy8DwADleat7WL
        TDve+uu2ldc84fO3ZVlMgzYkwYl5k08Zc/iW8/M=
X-Google-Smtp-Source: ABdhPJysTx09E3S+k4vxcIhSGn2Xk6ivf6iVrOPm3PvZJQqFGajE+UPPkdSWH+q+J6XFLOdHkBSSQL/MinWpkeTpo/k=
X-Received: by 2002:a17:907:c18:b0:6f3:9c23:20fd with SMTP id
 ga24-20020a1709070c1800b006f39c2320fdmr23390448ejc.740.1651246782030; Fri, 29
 Apr 2022 08:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220429114330.59026-1-robimarko@gmail.com> <20220429114330.59026-5-robimarko@gmail.com>
In-Reply-To: <20220429114330.59026-5-robimarko@gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 29 Apr 2022 10:39:29 -0500
Message-ID: <CABb+yY3dPwT4ASdxHqRidRBEq19YHsp8RfAgO0tr_rZ+Dde2hA@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: mailbox: set correct #clock-cells
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 6:43 AM Robert Marko <robimarko@gmail.com> wrote:
>
> IPQ6018 and IPQ8074 require #clock-cells to be set to 1 as their APSS
> clock driver provides multiple clock outputs.
>
> So allow setting 1 as #clock-cells and check that its set to 1 for IPQ6018
> and IPQ8074, check others for 0 as its currently.
>
Please include qcom specific marker in the subject line.

thanks.
