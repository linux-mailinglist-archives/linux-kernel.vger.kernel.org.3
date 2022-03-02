Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AEF4C9A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiCBBYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiCBBYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:24:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E18A0BD2;
        Tue,  1 Mar 2022 17:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC7D615B1;
        Wed,  2 Mar 2022 01:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BB1C340F2;
        Wed,  2 Mar 2022 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646184221;
        bh=Vtqu1FA/EhQKB93E0dl9sZqlSi2nQ9HzS2eyUSMeVY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SzoEOrK53H/BfOlK2g8/uyKwG+q9qThAM0B0gia6QKlwq09DXU/4xtwihNycbW+m5
         +ta93OYQjYF1coMTw1QqdVgsE24RaBs1LTFxia/BfmyaPH1kzRoK/s1pSV6aFwlmiv
         qFaTUXIAQvDPnGAwZHJeIux8MYccXlkHEW8Bo6OeSDwcYjnTwvusB43VuEVCM2e6Ae
         AMvDY8j6VgMX6HFf7vzF3bY3wWVJodLrH7Gkha85Lk6mxDO7XekoWRS9l3exH6Wxtb
         rGsvsdMejUyQFAvfhQovGAfJpMwijhgeZlw1GnkzPh8Opt3a2t9FRen57mYGsp+eZ6
         mKk3eEDwUkksA==
Received: by mail-ej1-f41.google.com with SMTP id a8so508654ejc.8;
        Tue, 01 Mar 2022 17:23:41 -0800 (PST)
X-Gm-Message-State: AOAM531E7lku42eujFK+KZm2y523hE8BL2ViaNys8ea9k01pMlpDXLSL
        uZHhGgxgUXexRHTzB6FC7hJOhOnej82MCt+XXA==
X-Google-Smtp-Source: ABdhPJzKXysjbT/JZ87L5ioTa8UahfSQdl4Uaa+Gu5k31tVfXz8giRi9IO5hcfUZAQhZ676L4/DBC8+KyLY8J6CFn6k=
X-Received: by 2002:a17:906:a40f:b0:6c9:e255:7926 with SMTP id
 l15-20020a170906a40f00b006c9e2557926mr20377612ejz.27.1646184219514; Tue, 01
 Mar 2022 17:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20220301210531.1855709-1-robh@kernel.org> <20220301222440.pn3uxnoata4jaq4z@SoMainline.org>
In-Reply-To: <20220301222440.pn3uxnoata4jaq4z@SoMainline.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Mar 2022 19:23:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK54f11oEHDLOuCbPBD9ix16sA43074mfQAcyvBpwXV+A@mail.gmail.com>
Message-ID: <CAL_JsqK54f11oEHDLOuCbPBD9ix16sA43074mfQAcyvBpwXV+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Drop bogus interrupt flags cell on MDSS nodes
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 4:24 PM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Rob,
>
> On 2022-03-01 15:05:31, Rob Herring wrote:
> > The MDSS interrupt provider is a single cell, so specifying interrupt flags
> > on the consumers is incorrect.
>
> There seem to be many more violators of `#interrupt-cells = <1>;`, at
> least on -next e6ada6df471f.  It seems those are not intentionally
> omitted in this patch?  Searching for `interrupt-parent = <&mdss>;`
> globally and evaluating `interrupts =` right next to it yields:
>
> - Two more hits in both sdm845.dtsi and sm8250.dtsi;
> - qcom-msm8974.dtsi;
> - msm8996.dtsi;
> - sdm630.dtsi;
> - sdm660.dtsi.
>
> And for the docs patch:
> - mdp5.txt;

Don't care, it's a .txt file.

> - And the recently added dpu-qcm2290.yaml, whose CI failure might have
>   exactly lead to this patch?
>
> Would you mind cleaning these up in a v2, or otherwise explain and
> forgive my ignorance for not seeing why these were not changed?

For the rest, just inadequate searching on my part. v2 coming soon.

Rob
