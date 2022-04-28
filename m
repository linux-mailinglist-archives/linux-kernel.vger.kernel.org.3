Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A186A512FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiD1JsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347651AbiD1JeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:34:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1417FF70;
        Thu, 28 Apr 2022 02:30:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e189so4722665oia.8;
        Thu, 28 Apr 2022 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nngAnZlymkzX4sUAsT0146zEMaA0AO4c4fvL3wIWwWk=;
        b=l18ijNANJ5b5fye/QNxz87z7+j8z02w6R0swX/JLw63krCb6g192GEyjHjzQP5aj5N
         Oa7DRdFJTdgQbLmCBFuvVrJFSZZCa7u2cofzzcnvLPI61NzdxgLO4fNj9EEFzE61wyUQ
         mam1iVGXHTeLeNvTESRsLv1awkl9hwK0Yu75xPx/hPIc21cKILj4Dqif7rntW15dNRgM
         PSyyh4uu+e/czfoBlGa26euNzMwWhk9eRd+G+bd56WOPNdgv9VmPtDcQw6SHIEQqXUoP
         z/HArI89LLF3VoUNX4cm9BKXp7vKYNCsN+7V/IEXzt52nWFAlin61yEZXfhUw/uPoXAY
         vqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nngAnZlymkzX4sUAsT0146zEMaA0AO4c4fvL3wIWwWk=;
        b=P0BstbZ2lKHZA8ahZk+TV1hKq3zcLrs8qF6v3iu/YHA6+NDLUqkT9jRPGNsTYwd1Tw
         a7T/eOR5uFjn1QQwXWvAgzVWH7bWvi32haQvsNk4uV9m1QWo++Cdpxwzwe00/PzAmOOQ
         oOPonXtOq62j9NgiZ5tT2MtcIqEDEreet9J3ZNN5GmFmTObzCW7HOVC0JvhD5hVRWwxe
         0m/VLTZKU+o0Wk4lGgnuyWEjV7mrYtOR5dB7H1a6wdrGrKcEAKUVA7b/skSRZ1KbTFGV
         TtGYlDM52hKxHZd2WMtK9m+x3jwFiJNW8e4VYcUjqrprvKUlgyU48hgbUkGhmx0HR0Cr
         oISg==
X-Gm-Message-State: AOAM532n4bFSz6cGQqrg+I1YS9SezAkDzqkg7NA3QjSPna3ULzfTI+lf
        2tpqCwaDZnLb32flglZ+C6LQWSgTLKT+b3KRpV/qvTDbLO8=
X-Google-Smtp-Source: ABdhPJxBPaN24K5DEsdqrFfIEtSaWdXHM9IEjTWzdDQ+b3wWrScNMI+uGO0dfJS0cpYEZLaEWLJNqGcvxnc4xNMAtpc=
X-Received: by 2002:a05:6808:1246:b0:2c9:efa5:7209 with SMTP id
 o6-20020a056808124600b002c9efa57209mr20058605oiv.62.1651138249908; Thu, 28
 Apr 2022 02:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
 <20220427080330.40136-3-gene.chen.richtek@gmail.com> <YmmQpg/Hh6qTNhj2@robh.at.kernel.org>
In-Reply-To: <YmmQpg/Hh6qTNhj2@robh.at.kernel.org>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 28 Apr 2022 17:30:38 +0800
Message-ID: <CAE+NS34SawC_pdTm=eDmp6zq1zLZgEaA+_s_xZOc4LuFHDV1iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mfd: Add bindings for the Mediatek MT6360
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B44=E6=9C=8828=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Apr 27, 2022 at 04:03:30PM +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add bindings for the Mediatek MT6360
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  .../devicetree/bindings/mfd/mt6360.yaml       | 258 ++++++++++++++++++
> >  1 file changed, 258 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml
>
> As I mentioned, I applied your previous version. Please send a patch on
> top of it adding the child nodes.
>
> Rob

Hi Rob,

    I try to sync latest code and can't find the mt6360 led fixed patch.
    Could you please tell me how to get and apply previous version?
    And should I add a tags in commit message to tell which previous
commit I based on?
