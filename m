Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809774EDE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiCaQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCaQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:02:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE25F8E;
        Thu, 31 Mar 2022 09:00:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o10so338033ejd.1;
        Thu, 31 Mar 2022 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OidiiBXTJgEslTgJiyc8AUz+qsXDVRCmee/lmtxGN1g=;
        b=oj81PkHsUp1MlfSm+RVV9LY8pAkYi26MxT4Tohf6JylmVDOFjJUU6HdfPvVx4Kdukk
         MB9OGRocsXQ51aY7ks9PvkbxZ3WrlhhL7E1vV+4sb0t7CQ6Keqkg48wZCGFL6XpW4/lR
         6WSAXIz7tIgUICTMQ1pXmFhtCJC5yU+yngYwWlj5K6TM+xf248y7RS4JQfTLpZxsAD21
         utCEdMJso2372iPX9O/l2rWoElkgu69GqIDNXIvYsMSmX+f+iltF/ZN5AkAKYnrH1xEf
         oXi6YM1pSSHrtf58TWyu6UvQPwX7Pzv/oDFbPyiyVZwrT8oX10dWRWtsXjcoMoXdpVUI
         wsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OidiiBXTJgEslTgJiyc8AUz+qsXDVRCmee/lmtxGN1g=;
        b=XLz4H1UHI3pbjOqIU8FP57MwHDr1gHAddMHncVug/0ZmkGqX0triDj+PeGjgs3eCP5
         Q3u8ulqBY1T7S4bXo96n6o0N3sg9VnE/ugbhxMWj98N96hkB/J3hZ3iN+77UaTQFoogh
         GWb5uGs52e0bcakWlf6y5G7clfWGLSnkZIw4MN25K7a7Jl1RI4qSBYxoTXY3Qf5xpeTn
         TUCFtVxMoOgT4YNSGMznXx5OwpDnHIykHpwZiYTFAaxXvTyQJJBWZU15kxnyLoYSehfW
         aQOVzeLgBXSwPDJF2/yVnz09oXIaor5yd4y/vk83kBlFPO4qOyzqnIPUSX61yV5KFgEb
         40Rw==
X-Gm-Message-State: AOAM530OOJ+6+Mc8PfMz9AytNcKn7r0r+qcXShVK9wG61q7DCRLsqQlv
        G42Wf/3E4xU7k6IoygdqmVaaVCa0ECbAk0pSO0c=
X-Google-Smtp-Source: ABdhPJzDGtVdfItRP/6FSdFNtXDkcyURHCSfqFqb7gMr2MTjH7e93kOf9afmJlP/1d4GHgrjkmciczb2x3gKDHb1KrI=
X-Received: by 2002:a17:907:7704:b0:6cf:48ac:b4a8 with SMTP id
 kw4-20020a170907770400b006cf48acb4a8mr5566870ejc.305.1648742439886; Thu, 31
 Mar 2022 09:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220327123835.28329-1-aford173@gmail.com> <CAPDyKFrhiaJHqsB8tVp_SkJwTtfanS5eN8wucntUHLL589Snww@mail.gmail.com>
In-Reply-To: <CAPDyKFrhiaJHqsB8tVp_SkJwTtfanS5eN8wucntUHLL589Snww@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 31 Mar 2022 11:00:28 -0500
Message-ID: <CAHCN7xJPohAzceFuXVF1XkC2mBVA4VDqsqbKvdYPdK7FT=1PaA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <Kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 8:05 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sun, 27 Mar 2022 at 14:39, Adam Ford <aford173@gmail.com> wrote:
> >
> > The SDHC controller in the imx8mn and imx8mp have the same controller
> > as the imx8mm which is slightly different than that of the imx7d.
> > Using the fallback of the imx8mm enables the controllers to support
> > HS400-ES which is not available on the imx7d. After discussion with NXP,
> > it turns out that the imx8qm should fall back to the imx8qxp, because
> > those have some additional flags not present in the imx8mm.
> >
> > Suggested-by: haibo.chen@nxp.com
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> I didn't quite follow all the discussions on patch3 - and whether that
> may affect the binding. Anyway, I assume you will send a new version.
> If not, please tell and will pick this up.

 I am not sure exactly how the YAML should look, but I'm going to give
it a try.  I hope to have something this weekend.


adam
>
> Kind regards
> Uffe
>
>
> > ---
> > V2:  Added suggested-by note and imx8qxp updates.
> > ---
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml   | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index 7dbbcae9485c..1427e9b5a6ec 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -34,23 +34,25 @@ properties:
> >            - fsl,imx6ull-usdhc
> >            - fsl,imx7d-usdhc
> >            - fsl,imx7ulp-usdhc
> > +          - fsl,imx8mm-usdhc
> > +          - fsl,imx8qxp-usdhc
> >            - fsl,imxrt1050-usdhc
> >            - nxp,s32g2-usdhc
> >        - items:
> >            - enum:
> > -              - fsl,imx8mm-usdhc
> > -              - fsl,imx8mn-usdhc
> > -              - fsl,imx8mp-usdhc
> >                - fsl,imx8mq-usdhc
> > -              - fsl,imx8qm-usdhc
> > -              - fsl,imx8qxp-usdhc
> >            - const: fsl,imx7d-usdhc
> >        - items:
> >            - enum:
> > -              - fsl,imx93-usdhc
> > +              - fsl,imx8mn-usdhc
> > +              - fsl,imx8mp-usdhc
> >                - fsl,imx8ulp-usdhc
> > +              - fsl,imx93-usdhc
> >            - const: fsl,imx8mm-usdhc
> > -
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8qm-usdhc
> > +          - const: fsl,imx8qxp-usdhc
> >    reg:
> >      maxItems: 1
> >
> > --
> > 2.34.1
> >
