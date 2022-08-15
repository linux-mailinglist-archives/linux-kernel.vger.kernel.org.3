Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C3592A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiHOHYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHOHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:24:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98813DC6;
        Mon, 15 Aug 2022 00:24:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3517352wms.5;
        Mon, 15 Aug 2022 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=bRJDHP4cs+l0S/Vq3FhjHYYjhVUbwWITH21+gCuf9PA=;
        b=f/2ctWt1p/RNUXYK4u/QPfb7Gx7QoaxUiQa5h8VxVIH3EmMVJKau0NoYRKSygSe+ii
         K5MnGfjrB+89bbKMrPPFl7HylHxqk+0mx+gtZ4CgehszgM7mTREoHCN6ybiHY1xQYX0l
         4ZuJd06xpd/7VA00gaLVu/BMt6do2WvdTqAB1p9dq7HWqB032eVJP9/k+Hk+DjuVZJfw
         pWwx7bZqDzsjDCjZDkUr23jD0KhoxUYKQ/W4BprtKeQKb8oCT3epiINmQd9LUMFRCCp1
         gT8RbK6y2urJMbSsZepm/yaxhQZQJRh0Rs7ns7/g9fN8oh4yHnG037qnPclt0ODKKyeH
         u3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=bRJDHP4cs+l0S/Vq3FhjHYYjhVUbwWITH21+gCuf9PA=;
        b=TuCASSdmzWs8V/ldub1BvpMBTV4eXXWNHrBjzFLY/+U9J6SlRlStXuxJFBOMahj1yi
         Dh1C+3XI1Wxj0I9ILaUucFoXXX+LFPtFZgIFPx40bBSP1oqZ+/MTV/wD7b3LkTJ297ia
         IJYBaK8LiLSibru8DdM4uIb+W5bjhYI0EuNRS9yXdzlARUQAmRs4329KklP3f18rXdJV
         dDm2Qw8gHQS1wbkXH0+ldQjB5sgdGqM2Es3Jy3tduLXTJS9xk7b+xLBL7tzOziOAOssN
         LF+eWMqWlOffg3S+Eyt0vzcRyCoYTAE/w/Ch7F/SqpbiMO/j7BJk7LIVXWH68sKG1oE1
         y7cg==
X-Gm-Message-State: ACgBeo3kkPKDiCsQ/xElh7/Ikn7kGa2gdFA2Lz9GkLao+HoDqNaCJBDH
        pL5hYDg9lY25InQxrVjkyNPlgIunLAQRwkXIeI7Xjt9UrTQ=
X-Google-Smtp-Source: AA6agR44YLYJCEVr+7nBXbCM5zYovOrwibJKbST6ANvVb+2+QQA5nD3me/yk+io8Z7P0DW7E2dBwCcy9O0fCDFa6vpQ=
X-Received: by 2002:a1c:3584:0:b0:3a5:fb0e:102e with SMTP id
 c126-20020a1c3584000000b003a5fb0e102emr1185726wma.105.1660548284030; Mon, 15
 Aug 2022 00:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-3-git-send-email-u0084500@gmail.com> <CANhJrGMnjSu3MMQ2PgvSWztNgG1r-PdyLBdsT3JVqZZSfqky-w@mail.gmail.com>
 <CADiBU39c4P-ZNwjrqm-VxSZOLiobEu--y=iH+Si7a+dwUdmeaA@mail.gmail.com>
In-Reply-To: <CADiBU39c4P-ZNwjrqm-VxSZOLiobEu--y=iH+Si7a+dwUdmeaA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 15 Aug 2022 10:24:32 +0300
Message-ID: <CANhJrGP_99rU6nGfKmEmvZP_QAW5eqgBuCFmjE4fRwu-Rk5j=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: rt9471: Add Richtek RT9471 charger driver
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ma 15. elok. 2022 klo 9.11 ChiYuan Huang (u0084500@gmail.com) kirjoitti:
>
> Matti Vaittinen <mazziesaccount@gmail.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=
=8815=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:53=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi ChiYuan,
> >
> > Thanks for the patch :)
> >
> > to 11. elok. 2022 klo 16.43 cy_huang (u0084500@gmail.com) kirjoitti:
> > >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add support for the RT9471 3A 1-Cell Li+ battery charger.
> > >
> > > The RT9471 is a highly-integrated 3A switch mode battery charger with
> > > low impedance power path to better optimize the charging efficiency.
> > >
> > > Co-developed-by: Alina Yu <alina_yu@richtek.com>
> > > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> >

> > While skimming through the rest of the patch... This may just be my
> > personal preference but wrapper functions with just one line are
> > rarely beneficial. In the worst case they just add more lines AND hide
> > the details of what actually is done without any clear benefits. Well,
> > this is just my view so please ignore this comment if wrappers like
> > this are a "subsystem standard"
> >
> I'm not sure what the 'subsystem standard' is.
> I declare it as 'inline' function and the  function name to tell the
> user what I'm doing.
> This may be silly. But from my aspect, it makes each property set/get
> more clear.

I guess this is Ok if the maintainer does not complain. And if he does
- then we at least know the "subsystem standard" ;)

Yours
  -- Matti
--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
