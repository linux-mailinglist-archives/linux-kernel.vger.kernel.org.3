Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F75259A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376470AbiEMCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiEMCPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:15:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497322016E2;
        Thu, 12 May 2022 19:15:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v11so6171368qkf.1;
        Thu, 12 May 2022 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ABvjeYMUgeKiiz0vGblNmeh1O4Ojq+8TMF+cDOW591M=;
        b=hQ/Q1gy0b2X8nW5tb5YpMdScAixDo6Xd3Dk+p6mUSw2AEsq4US2fkEzgdxsYVgXt/L
         rTULcO5Uj/e7A1nBTXpEjROkZFjqC7xWVYj5PaFHf5ZPLHJUCyG4B2tsF1iu3WPPCDUA
         GPHvCSGlAI3eEH8qpM/mZd5XbztGm7ry786Z2QCb7OGX2cJ3ZHPyhjUlTAxEI/HNINEM
         DioCRWSKu+cFmmXiw2J2lXwkhATRAnpx7V6XF4s8Y6c91rWc7//kNFK8T8ToNNh0pbJH
         Xck91GZOSZ0sDTLIQTvOx7fHL6jUlaY2ocJDXzEw746p9JHLxOqlJ4mHeem80308W36x
         9lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ABvjeYMUgeKiiz0vGblNmeh1O4Ojq+8TMF+cDOW591M=;
        b=PVGPMFDYmUriFZMIF4t3h1AOtx7VlY1XfSh+d6m7KL2sDPTZN8ZXDWdUNUL2uEV9MM
         qhRmZlVYzlCdExvQe078ouBQU6wjRJETx5NMJMCcBiTHvbKjZnnB2IIgm1q59fBXQDy0
         gCTvDKCumrWKrlQ45aZLu7GSVncJ/utIoiurVs239aHjwlPQmEdb5/L2HMs4DwviN5Si
         wk72baN0BDW1W+MK2cvhM3L/Wo5R+ckTlWrXpbMsCbJRSyniGzGf0r4B446JXGrh9ROo
         YidXTC6d0D3YUouJVF5ZL8lm5fpT/SdUpq+zXoIUW2HeXYjjEvA7ADTSNlOhiT6XtTLU
         7nuQ==
X-Gm-Message-State: AOAM532Y6SFWlMGw7OB+3fi/Habaoo2l5CyIzmQlzxqkHS4CRX7vBD0x
        z6neRw9wEYiICeAWzdMFaDB1sV6wjtq2Xy2CNfEvISl4z0k=
X-Google-Smtp-Source: ABdhPJxKA/bNaK/LNalC4UHx8MqV68htFhXt1WDC9gdNSs6FKa/Rh5mTTMK9V4mzYiP4DlFghHkZGnkRPbyfHMd9Da4=
X-Received: by 2002:a05:620a:25d:b0:6a0:dbf3:54d5 with SMTP id
 q29-20020a05620a025d00b006a0dbf354d5mr2196666qkn.74.1652408110338; Thu, 12
 May 2022 19:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220428125610.66647-1-gengcixi@gmail.com> <CADBw62r8eGRNcXH1cAZvYQdKCgBjxUVnxhLsa=Oyzs-uwavRTA@mail.gmail.com>
 <CAJejCsY+DX0JywDS_dk=1P-fvyjUc4i1e67uM_WW64E3YVvzQg@mail.gmail.com>
In-Reply-To: <CAJejCsY+DX0JywDS_dk=1P-fvyjUc4i1e67uM_WW64E3YVvzQg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 13 May 2022 10:15:38 +0800
Message-ID: <CADBw62rMXU+XDyANaRgjEeBmUMe2nU69S5qU2nuxDben387gpQ@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: Add enable the primary charger interface
To:     =?UTF-8?B?6ZmI5rC45b+X?= <chenyongzhi811@gmail.com>
Cc:     Cixi Geng <gengcixi@gmail.com>, Sebastian Reichel <sre@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi,

On Thu, May 12, 2022 at 11:22 AM =E9=99=88=E6=B0=B8=E5=BF=97 <chenyongzhi81=
1@gmail.com> wrote:
>
> Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=8C 12:53=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Apr 28, 2022 at 8:56 PM Cixi Geng <gengcixi@gmail.com> wrote:
> > >
> > > From: Chen Yongzhi <Yongzhi.Chen@unisoc.com>
> > >
> > > In the case of charging multiple charging ICs,the primary
> > > charging IC often needs to be turned off in the fast
> > > charging stage, and only using the charger pump to charge,
> > > need to add a new power_supply_property attribute.
> >
> > I'm still confused why introducing a new
> > POWER_SUPPLY_PROP_CHARGE_ENABLED property to control the charging, but
> > you already controlled the charging by POWER_SUPPLY_PROP_STATUS?
> >
> Our purpose is to achieve two different stop charging states:
> POWER_SUPPLY_PROP_STATUS: The software status stops charging, and the
> hardware also stops charging=EF=BC=9B
> POWER_SUPPLY_PROP_CHARGE_ENABLED: The hardware is stopped charging,
> the software is still charging=EF=BC=9B

Please separate it into two patches, one patch adds charging control
with POWER_SUPPLY_PROP_STATUS attribute, and describe the use case in
detail.

The second patch introduces the new POWER_SUPPLY_PROP_CHARGE_ENABLED
attribute with explicit description why you want a new attribute.
Cause I'm still confused about what you want, and your commit message
is useless. If the hardware stopped charging, why does the software
still need to charge?

>   Our  don't want to change the charge_status switch due to the
> switching of charging and discharging of the charging IC in the
> charging scenario of multiple charging ICs, and let the upper layer
> perceive this switching
> > >

snip.

--=20
Baolin Wang
