Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543FF57FDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiGYKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiGYKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:55:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6618E3A;
        Mon, 25 Jul 2022 03:55:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so14011409pjq.4;
        Mon, 25 Jul 2022 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jizxdn4AeaM9vGiU9lrvZv7w74oicIoCysUCYbSOl84=;
        b=kRkhrwK3DPW2t7fYXHm1e0ms1G76elOQhzsIn6/FQlpI88C1Kxp88jVAEDg6SkG089
         hB4feSsHEliEyiZDMhv9sCvTaKG1U6NjuOYJaYzcXn7ECDiyui3kpazIQ42jcGb96OrY
         9r9GkrVa9lqtOuuoS4coIfJF1iqGjp9dBfthZGIqHxQZYPTKnjkFRj15rwRqkzOnseOz
         w6BCpaBe/1vvPafvoczJAk0xvVTLFmpUUg4+XeEV7T18UKbnWRDgARjMXTmf1uqum50l
         eO36vwt1hrvXU/QwVMWPGJFK9i6dDHNpE8vuOeDV0jJY43SSP4SEffLyaHeDT6sMSdNO
         tM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jizxdn4AeaM9vGiU9lrvZv7w74oicIoCysUCYbSOl84=;
        b=YXFg52RUfr2oSoZN4R8oKL+EkaynABbt1QKjImYfJZ1oX7YFtcUg6vjCJO5m9bboQs
         V9ujW0419vRA5hVeNxa2GHrScW4mCSt3KntAgBolOxJQi1NLZ03CaP+Fjg3OhPAEplzg
         Y5ZyqDT0r1IqidmiiCeTpAjGwH95tXWvSPb1YXqyMT0imoqSTXWL/exa/z3mQR1yOJJN
         /J/yN6F4XUb6oP4I/qa2WWKDakbmMGF/RnPDKoC9a+mO6DbhYM2HbJcdnOmbRbbyjZDQ
         lpAIux6qFGIfLsfJkja+Zi/8BDXwgf24ReJjY5BPPHQJRtMLc6L6VIWBRhKsnwre5SVQ
         JATw==
X-Gm-Message-State: AJIora9YQhFVmLJ1itTPc1VGdoD8tUp4QqUP3mzd8HPOkDnl2uy/CqiT
        hHV3igRf/Q9aAoENta8//0eUhG/zQEc3cN4e2uk=
X-Google-Smtp-Source: AGRyM1sJEIM//oT8Ms9EiN859p9vVGAsLNN9o+I83rqP2ZI9QAkpUq7tYiNLOs9YwSKBPn1HocP+qZEWe4/SmofzD7w=
X-Received: by 2002:a17:902:d582:b0:16d:612c:2d6a with SMTP id
 k2-20020a170902d58200b0016d612c2d6amr8263669plh.168.1658746551759; Mon, 25
 Jul 2022 03:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220722215445.3548530-1-marcel@ziswiler.com>
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jul 2022 07:55:39 -0300
Message-ID: <CAOMZO5CY5hg=AFdFTFdd4fC0XgEmkmKUPWcA_vCdP6MUHFmbdw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] ARM: arm64: dts/clk: imx8mm: indentation
 whitespace cleanup
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <dev@lynxeye.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Marcel,

On Fri, Jul 22, 2022 at 6:55 PM Marcel Ziswiler <marcel@ziswiler.com> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
>
> While synchronising them imx device trees with U-Boot I stumbled over
> various checkpatch warnings. This series addresses those trivial
> indentation and/or whitespace cleanups.

Thanks for doing this cleanup:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
