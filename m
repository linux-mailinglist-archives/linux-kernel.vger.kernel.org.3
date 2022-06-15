Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC51654CF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356695AbiFORPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345763AbiFORPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:15:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132035DCD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:15:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so12032151pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nPsbkcbBeqbASqCJC2zl/rCrhRNAADIrDvak/nQhe9I=;
        b=zuUSSOBt4Ggjo0c6W+e3LgU4K8RLCr5F6HVZo7DVgpVZYW7riUD3FxWdyShRtnpMAd
         gD+qtluAXQsN8laYT3xeuEGuv0DrHBfYrgnttvxnqepG3/xslpnx+osllE93T4ST88+O
         dIe7oLe58IH8oAe+ScDXmlcmYTfJ9RDysO8JM7xTGO60AeiL7d/EEKC6DfZrssuCns49
         mItlwhRGLv2lcbNJNAVRzp+SeGobY19ZlGiy7IT/Ey3N4z2nBpIGc7xwYJBLLEnr4DyG
         FGroZZaSzoHw6OS3i0d2hE3+1Y6EdBwec+ShpWaU5IDziPGTWyEAk97HswqN9AILr/8u
         xaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nPsbkcbBeqbASqCJC2zl/rCrhRNAADIrDvak/nQhe9I=;
        b=V4SIjJkolW66FP8AM4OChYa2xhTxMSzum3t+oosuqiAkZYaQlz4PvY+PN1/eVFLTTs
         wn+vScyPVcGZntwFpLo4zLRHqR+C90IqrYFDJbeG9OD05HV9asHW8z4e3WhZqa6RrG8o
         8O3ebceC9IKlMNJlGTDY4D6hZSYj+hSmJo6uQkFom7maa1/8eXskang5AvY1FmtpGBst
         Zq9A/DvgI3A7lbgVHxLN26yKLM+kbiL+QItdMriDmtfrH2CbW8Meq5klaDCALe2IvMKs
         BqBk/Ey70YWBibPPt//tr7v+B74ABUZrusNqZLQVxEaVhGMc1kNHIux+DpT9+0CeVVU7
         ifBg==
X-Gm-Message-State: AJIora/ACy091ST8DfI35PRN0PWVTZS5QV3jQUwpVHDFCfcRIbPcHF+y
        CiQ7V88bXE8R8gxYaktBH0OB8Q==
X-Google-Smtp-Source: AGRyM1tYcSNkOShX6GUjY540L3XsgD4qhnoZ7s0AKq1KR4hZIS/RVxyoI7gWFkGA1LbJjPUi1Gog6w==
X-Received: by 2002:a63:e517:0:b0:3fe:4273:1063 with SMTP id r23-20020a63e517000000b003fe42731063mr672021pgh.371.1655313317162;
        Wed, 15 Jun 2022 10:15:17 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id h30-20020aa79f5e000000b00519cfca8e30sm10153151pfr.209.2022.06.15.10.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:15:16 -0700 (PDT)
Message-ID: <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
Date:   Wed, 15 Jun 2022 10:15:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Content-Language: en-US
To:     Max Krummenacher <max.oss.09@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <20220613191549.GA4092455-robh@kernel.org>
 <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
 <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 09:10, Max Krummenacher wrote:
> Hi
> 
> On Tue, Jun 14, 2022 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Rob,
>>
>> On Mon, Jun 13, 2022 at 9:15 PM Rob Herring <robh@kernel.org> wrote:
>>> On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
>>>> From: Max Krummenacher <max.krummenacher@toradex.com>
>>>>
>>>> its power enable by using a regulator.
>>>>
>>>> The currently implemented PM domain providers are all specific to
>>>> a particular system on chip.
>>>
>>> Yes, power domains tend to be specific to an SoC... 'power-domains' is
>>> supposed to be power islands in a chip. Linux 'PM domains' can be
>>> anything...
> 
> I don't see why such power islands should be restricted to a SoC. You can
> build the exact same idea on a PCB or even more modular designs.

In the SoC these power islands are more-or-less defined. These are real
regions gated by some control knob.

Calling few devices on a board "power domain" does not make it a power
domain. There is no grouping, there is no control knob.

Aren't you now re-implementing regulator supplies? How is this different
than existing supplies?

Best regards,
Krzysztof
