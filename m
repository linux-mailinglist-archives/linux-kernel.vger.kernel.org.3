Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5065957A713
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiGSTSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiGSTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:18:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185712ABD;
        Tue, 19 Jul 2022 12:18:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz17so29015386ejc.9;
        Tue, 19 Jul 2022 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xqxh4Olbzf8gcHkRUg+aEa9829Q5AonJVqC/i9t2rQw=;
        b=bgSAqdILFPi4PfkKnFOG7lPQs8M+V0k2dhLHL7VXvzunlKh8JOfM9ZPTfBkD3HdjJP
         sAuVsHfd0dbRsNMl9I0BDcyIdqmq7HSCwdZlQs7U5aLBpDn9/hQZ5RvvchSKOE+8d0mA
         DLuJlZjxrcZvhXstn0sZSaq7M7MdSZmceBD3d9nf08uPlNepbygRLI0yPs2h1yxbD/k/
         /uN210O8pwBxArWSuiI3CfB6Dk+TJ4dFqVrtj9Uhcw/xRLsGV3EXxRgpP6wGvHOkawco
         YY5j7hEUgOfoaxiyhNgsckJyV72Q3i/UEEwMlkNrfFQl4NzoqNz6SW93KdcR4enKPg0P
         0tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xqxh4Olbzf8gcHkRUg+aEa9829Q5AonJVqC/i9t2rQw=;
        b=YLMivuptHdxIpn+/kJcpufJfamePoF7HbRysOg5HrAB7ASpMJ+DfdlybYsPa9+vw47
         ci5KLHgakX/w3mU54Il1jWgq4Yzz/OZ0kH3GtgPU/U/GOQqZJIlKECVHG9z8Rl2OpM12
         v7ClcE5bQr2R0Ymqti35Ejg/TuzEja7II3SoyYrrkwLTw8sjUGR6e8zLErOoMmBVQ3OT
         msOSkfXcUmtScr5QV6Gp0IJwxr3fN2fPEEvBqmISW5LD2uL2E8/CR2A1sGMLVNeDkwYm
         tohR5P0N0hMN0kKTl2yeKG1XlVwwx9MscknNMs8FQeK780K+rq7awq1DNagD6gkl78tG
         3duA==
X-Gm-Message-State: AJIora9llImInI3JxnCv3PuH6krTI9DpHH1H0mmsbEeND6w8ApSTiSwJ
        +9/KpKOxO4OOlOVdyNpwsNFZbzjtbAM9uByatcE=
X-Google-Smtp-Source: AGRyM1vyCCHUwPB/NQH9l/gyKkdjLrwOuphUl+PollGTiEOLSNU594kNYPkucqK4ubOHDUExEk9cMizBb+s/Gj/Br6k=
X-Received: by 2002:a17:907:2724:b0:72b:496c:568a with SMTP id
 d4-20020a170907272400b0072b496c568amr33098724ejl.305.1658258289873; Tue, 19
 Jul 2022 12:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220717181000.1186373-1-aford173@gmail.com> <20220717181000.1186373-2-aford173@gmail.com>
 <d346f18a-d82c-4408-98d7-f5295f51907a@pengutronix.de>
In-Reply-To: <d346f18a-d82c-4408-98d7-f5295f51907a@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 19 Jul 2022 14:17:58 -0500
Message-ID: <CAHCN7xLbDWC2yZmNvOUc=AK7z8V1sGjNdQAXQLPa8SgTWYU3hQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: imx8mn-beacon: Enable Digitial Microphone
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:57 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Adam,
>
> On 17.07.22 20:09, Adam Ford wrote:
> > +
> > +     sound-micfil {
> > +             compatible = "fsl,imx-audio-card";
> > +             model = "imx-audio-micfil";
> > +             pri-dai-link {
> > +                     link-name = "micfil hifi";
> > +                     format = "i2s";
>
> Given that MICFIL and mic speak PDM with each other,
> is i2s the correct format here?

I was basing this off some references from some NXP stuff in their
downstream kernel.  I know the audio I record with the PDM microphone
worked and sounded like I expected when I tested it.

adam

>
> Cheers,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
