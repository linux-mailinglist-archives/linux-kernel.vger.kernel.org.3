Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5A528316
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiEPLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiEPLWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:22:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892293818B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:22:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ch13so27921884ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=z/sJ+M1XxtJXB9OHfNzwnEILWmK+EFv1aJKz+1MttWM=;
        b=ab8F5qnQhlZymUFMlry85o+kQxlSUkk0qQBmbXQYDXjm6tNk3f6wwBfgFJ1jkUG2BR
         9v/egoOeHoFAOvSkPi97wnKqMnwmRk/EudKcPqdzI7bZmacULRjBYlRU7D/SeUtVzHe6
         1jpYmWBlJ7TEO+YYOrI81j+TJhU+p4DzVB4hazDxVI0/RBdIoOAaRGjbUuuzJHB3229d
         6RdS/WrDZwulYt+3uULiQuISRpBwDmdlr4ZEtACXr9h6yhicZRKAh7wTL/PwyMUNmJ0R
         fTpjEagPe4gjas7QXRGL7og5z20u84pfcM9xWlubSEipIrfk3RGiCG2G6zzy9Sn0/fEj
         4m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=z/sJ+M1XxtJXB9OHfNzwnEILWmK+EFv1aJKz+1MttWM=;
        b=hC8/tWA5zGoIJI2etxgakjKpsUYTFwOT6CVdFcdYcbKb1VY70IOnZVwNn2CSJ/jQ0T
         VsG9bZtTSRuDC+kdEYttbOySkeqSZzKCPgYOKsBB42y6W9JlW8q/IBI2CbFZSW0zk+9M
         WAgGhNNPl/1nH8TNAE1h3qQ/0VaIpuysDj6su26UpjE3yyRM81Uw7UeqjYSQoCb4zoF6
         Supe2SopLZKxNwgptIqTr9Qtb4gCRVE+XQ4Xeqeydfi6gYaJepxGqS7vMraVBSS8Fe5p
         51xr9keEQ4u8JEoK3apmbDd86rLYx+ZIYjlP7h8VnU+OKN0CNm3LKGP2nN+yNoIGUmMH
         jIeg==
X-Gm-Message-State: AOAM530buuhuxPXOOgl9Ms6G6U4t/dDFq5hXcTaWlZevGF5jsyTcOQ6T
        TyaqgGBehdpiFa6Sd9TqZT48+w==
X-Google-Smtp-Source: ABdhPJzgJws20+k1w/bd9YDmKu6f8bJwp96JqZDsW4Rp66WDsfycPObkkkYE4zEcys2M4yADuMjhxg==
X-Received: by 2002:a17:906:dc8a:b0:6f9:13e9:4c87 with SMTP id cs10-20020a170906dc8a00b006f913e94c87mr14513978ejc.729.1652700167860;
        Mon, 16 May 2022 04:22:47 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id cn7-20020a0564020ca700b0042617ba6387sm5006533edb.17.2022.05.16.04.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 04:22:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 13:22:46 +0200
Message-Id: <CK15BB34PCJM.1PI9Z68ZM20K9@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Rob Herring" <robh@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: qcom,pdc: convert to YAML
X-Mailer: aerc 0.9.0
References: <20220103074348.6039-1-luca.weiss@fairphone.com>
 <bef4922d-4a32-f184-44a1-8f5430190938@linaro.org>
 <fef5f229-f247-d032-fc76-46ed7083dbf4@linaro.org>
 <CK10OTVFAP75.WCSVY40A7PXO@otso>
 <13d65ae2-f378-5353-16b9-5bf68883a701@linaro.org>
In-Reply-To: <13d65ae2-f378-5353-16b9-5bf68883a701@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon May 16, 2022 at 12:35 PM CEST, Krzysztof Kozlowski wrote:
> On 16/05/2022 09:45, Luca Weiss wrote:
> > Hi Krzysztof,
> >=20
> > On Mon May 9, 2022 at 10:40 AM CEST, Krzysztof Kozlowski wrote:
> >> On 09/05/2022 10:38, Krzysztof Kozlowski wrote:
> >>> On 03/01/2022 08:43, Luca Weiss wrote:
> >>>> Convert the PDC interrupt controller bindings to YAML.
> >>>>
> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>> ---
> >>>> Changes since v1:
> >>>> * Adjust description of second reg-name as suggested by Maulik Shah
> >>>>
> >>>> @Rob Herring: Hope it's ok to keep your R-b given the above changes
> >>>>
> >>>> This patch depends on the following patch, which fixed sm8250 & sm83=
50
> >>>> compatibles and adds sm6350.
> >>>> https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.we=
iss@fairphone.com/
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> Luca,
> >>> I think this needs resending as dependency was merged. Alternatively,
> >>> maybe Bjorn could pick it up through QCom SoC?
> >>
> >> Correction - it seems that Rob took the dependency in April, so this
> >> should go via Rob's tree as well.
> >>
> >> Luca, can you resend without Rob's Review tag and ask him to pick it u=
p?
> >>
> >=20
> > So... since torvalds/master my sm6350 patch is merged through Rob's
>
> If it was merged to torvalds/master, it's not a dependency anymore...

Yeah of course, but currently sm6350 and sm8150 patches are lined up to
be merged in the next merge window from different trees which just make
it difficult.

>
> > tree, but there was also a sm8150 patch applied through Linus Walleij's
> > tree. This means (as far as I understand) that neither can really
> > properly apply this (rebased) patch as one tree will have missed the
> > other commit.
>
> sm8150 patch is also a dependency?

I mean either this conversion patch includes sm8150 or it doesn't but
given it's applied to some tree and lined up for the next merge window
it should probably include it?

>
> >=20
> > Does it make sense to send a v3 rebased on linux-next now, or wait unti=
l
> > this has settled down in torvalds's tree?
>
> Conflicts can be resolved, you just need to choose one tree to based on.

If conflict resolution will be done when merging Linus' and Rob's tree
(e.g. add sm8150 to the yaml) then this v2 can be applied to Rob's tree
now.

Otherwise, I'll just wait until everything's merged into torvald's tree
so the issue disappears.

Regards
Luca

>
>
> Best regards,
> Krzysztof

