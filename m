Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A459817D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiHRKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbiHRKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:30:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09237EFFE;
        Thu, 18 Aug 2022 03:30:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o22so1298274edc.10;
        Thu, 18 Aug 2022 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9vZKSAmG8I4EgDVUcYaHeGxa/jI1j+UCbOHpxXjMwqc=;
        b=eCt769iz680T564gsrZwVhkuutB9GSfw3qDqOUTK1YlumPDVNF5fwumLp1OFQt90Ru
         eXWjF4hQagG1RnxctP8B53aKdP58tJXD8M3LSZr2Z4V+zkUnXSurv2BPUSlU4AMHD4xi
         lE9xObpZ9iwbov6Qd8PcHu56/Ze5M9X/VvUePgpkV8kapSEPtb4L+6fCxDcYcjn55FgP
         aU45C3njQJDLRzwhRu3Fc5KCAD6JK75tQrPkoJ78jobMg3Ugh847WU38NqIbacYyLd6h
         jYeSLMgnKYGP2wuBfCqEwtgko0HIpxrXtJJHxSEfxhDQMM6S/aG00nUNZGOTh+ew3mZq
         Ml0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9vZKSAmG8I4EgDVUcYaHeGxa/jI1j+UCbOHpxXjMwqc=;
        b=vvki00Ez9kJzfh4AH6GTuR4q0/7w3zCosi8/XzT8GPPCizgWvTea1TwoybGpM4QqvY
         sJg9+bDmZgvj3Yh5a+S7NHWZettKZCxVS9TVYAlrAPciZlSYr+2khotFfKnOn+wdbe+7
         OB3aeo8Z36PHNzxQFqu6f55wOhDLJyjmDLg2mhll7l8zzliKPshSkMnI7fDlVdwdIccB
         ikZheqY7XVMuolPogS/3+bIwdHah+8me+bpKt7n4a8xTmbeswam85ZTXskrCBKlhIpnu
         oazBJ2ypOO+ZYvZyr3WAiLKxlt8aYBdSN9dzkAAqyjnjMHFfds7jryA/nE+Jm176gy8N
         E6+Q==
X-Gm-Message-State: ACgBeo1i6G8Xl4Eo1VIlupCmkxc2iMv8f5dZAgeVJs13lbCyPfxnaKTQ
        2QpHGPVk347H6za50HUvSBLXB4a5B2j8ns9hXdls2oQE
X-Google-Smtp-Source: AA6agR5sF3SG3SknPo6+Xa7a9bQt2OyzxDtrsi4BxnhNiMk7JbjzFgQX7RMQSQY8ftDc6akBUs+7MZnNg748Z6IMaTA=
X-Received: by 2002:a05:6402:438d:b0:43d:b383:660f with SMTP id
 o13-20020a056402438d00b0043db383660fmr1725007edc.283.1660818649081; Thu, 18
 Aug 2022 03:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
 <1660785696-9010-3-git-send-email-u0084500@gmail.com> <85193de5-244c-2cda-e442-656769b97b14@linaro.org>
 <CADiBU3_RUTiG0T5vEKe0qHmHHQDXyMQL2BxFA+YgL_u-VGUNkA@mail.gmail.com> <a6f3d97e-547a-9797-1469-bbe5d80a3bb8@linaro.org>
In-Reply-To: <a6f3d97e-547a-9797-1469-bbe5d80a3bb8@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 18 Aug 2022 18:30:38 +0800
Message-ID: <CADiBU3_3MgowozeR13iG5ZksdbodLufc06tsEuKugipxBCYjLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: rt9471: Add Richtek RT9471 charger driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B48=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:18=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 18/08/2022 13:16, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=
=B9=B48=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:09=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >>
> >> On 18/08/2022 04:21, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add support for the RT9471 3A 1-Cell Li+ battery charger.
> >>>
> >>> The RT9471 is a highly-integrated 3A switch mode battery charger with
> >>> low impedance power path to better optimize the charging efficiency.
> >>>
> >>> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> >>> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>> Since v2:
> >>> - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_=
to_chip function.
> >>> - Specify the member name directly for the use of linear range.
> >>>
> >>> ---
> >>
> >> (...)
> >>
> >>> +
> >>> +static DEVICE_ATTR_RW(sysoff_enable);
> >>> +static DEVICE_ATTR_RW(charge_term_enable);
> >>> +static DEVICE_ATTR_RW(port_detect_enable);
> >>> +
> >>> +static struct attribute *rt9471_sysfs_entries[] =3D {
> >>> +     &dev_attr_sysoff_enable.attr,
> >>> +     &dev_attr_charge_term_enable.attr,
> >>> +     &dev_attr_port_detect_enable.attr,
> >>> +     NULL
> >>
> >> You need to document the sysfs ABI in Documentation.
> > Can it be define in 'sysfs-class-power' or a dedicated file called
> > 'sysfs-class-power-rt9471'?
> > Not sure which one is better.
>
> I don't know what is Sebastian's preference. You can wait for his input
> or do similarly as last patches reviewed/picked up by him.
M... OK.
Whatever the preference is, at least, I can prepare the ABI contents first.
>
> Best regards,
> Krzysztof
