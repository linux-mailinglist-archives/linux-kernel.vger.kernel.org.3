Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F044E7575
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359422AbiCYOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiCYOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:55:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7073946B30;
        Fri, 25 Mar 2022 07:53:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q5so10634821ljb.11;
        Fri, 25 Mar 2022 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ADFLjfv7XVau4zP4CGqDzPUx9VbDwkvOR0QB3JK4HU=;
        b=PtJ/+eayzEHRzFiQYLkjXeIdoKQOOOx4bj94hT39qEKQ+oLvq0XxrXbyEDEtkx49PZ
         ew0/DhdaJ0Ol+/wNgndn+c5P0EK99K4pDruL7yaZCv/vuoYfvE/8LJdR458EwdEi+xrt
         y94YzuWt/OPu8a5gSZNFFAsxUcLBCPaayFPBSKZKfraoiKOEYt2/MBIHIqlrSNSQTyqE
         I+tXc5MiUUZnujLJMfgN9cCXltIdNpZKbOorM5hKQ/Tu9/wy1T1oG2VraTfZLLGmH0xo
         2LoNEGXv+4eLPyiAvR3VHPl8OIDU7w2zNqUHY81gpxS0W7/uC8OHVVzpyeJfGido3/lj
         s+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ADFLjfv7XVau4zP4CGqDzPUx9VbDwkvOR0QB3JK4HU=;
        b=vj4lc11NWxTDy+uT+eJtj1My4DBUtJ52z/Cp4NduG2hNmJT9cpvdrWvC/KFHg34w9M
         ClafCmR7annXKytPkE5sbfU+7zmVZQhnwYlLZz3scIGdpY4wG4l0IN1dES4WJFqIB1s4
         0p++KzP+dCjyW0Vp+ZdiD6Sti63aJVAcePMWLlNjepV6iw/5N83U2nzV0ouI0fjXFbti
         eN+ez7Q3G8nHE9it+xwJuuyy8FbbQLhIBR8+4SW7ECDctapJdYFU3/qIdqhFGuusc6y1
         GjEchOetPTUs9tvnavc9S3jrCGx29scwPiDyxILGLt4dvgJ5zXfRvgOWMJOe5fUrdOEE
         15jQ==
X-Gm-Message-State: AOAM533LPv36udEfke9wsjXaoO37y2qq2hJdcR4P28gcxHM3AZ+hd6yo
        fnOiQ2iA78uyNMSr418VzS5ZyXdw/6ydGXVmsYFb6QtX
X-Google-Smtp-Source: ABdhPJxiGq3bkXn6xmzO0i+DA9waw+voncAWCpxQceiC96+qkgwkBOr2MQ0N14wWuVHGDef1uVlOXJ3d0rOkCf4PrNc=
X-Received: by 2002:a2e:a28d:0:b0:247:dce8:cecd with SMTP id
 k13-20020a2ea28d000000b00247dce8cecdmr8301841lja.415.1648220011459; Fri, 25
 Mar 2022 07:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-2-git-send-email-u0084500@gmail.com> <d9b883d2-8269-8419-3bcd-3761074bea96@kernel.org>
 <CADiBU3_06mCfBFXc5XAaeNd+G=Yf4MK5Ze429H8iUm=kpFMa5A@mail.gmail.com> <db3efe0f-b6ca-e183-8562-bcf5e6b02679@kernel.org>
In-Reply-To: <db3efe0f-b6ca-e183-8562-bcf5e6b02679@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Mar 2022 22:53:19 +0800
Message-ID: <CADiBU39DuH=mW42mvogRByGH+wz0YeGBcMyby34-XYAso=Ysew@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add binding for Richtek
 RT5759 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:46=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 25/03/2022 14:44, ChiYuan Huang wrote:
>
> (...)
>
> >>> +unevaluatedProperties: false
> >>> +
> >>> +examples:
> >>> +  # example 1 for RT5759
> >>> +  - |
> >>> +    i2c {
> >>> +      #address-cells =3D <1>;
> >>> +      #size-cells =3D <0>;
> >>> +
> >>> +      rt5759@62 {
> >>
> >> Generic node name, so pmic.
> >>
> > As my understanding, 'pmic' means there must be multiple channels of
> > buck or ldo.
> > But  rt5759 is only one channel buck converter.
>
> Then "regulator". rt5759 is not a generic name but specific.
>
OK, it's more generic node name for this kind of single channel buck.
> Best regards,
> Krzysztof
