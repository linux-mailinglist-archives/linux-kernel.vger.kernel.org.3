Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA356C937
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGILes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGILer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:34:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9205926B;
        Sat,  9 Jul 2022 04:34:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31c9b70c382so9719187b3.6;
        Sat, 09 Jul 2022 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FRulKm6e54Rx05VJEtDgH/oUpouEIMBNeaS4CcWT2II=;
        b=nBFOhEEZPgyq0RdwW85lPI1KwlgUZA1lwSMnWWi+7C7URoY4TdWslvx1AV1+pJ7lzY
         hs7iAVgE0Y/bPVne4/68sAPFoW0jfxQmneBSmJwAM6vDINN3C+SdCjF4qnXSRizpUvEB
         tEV4vRHFlelzBLB4/Wz3xfaULngQhiUqqCbx2ZDd25O5jwIQWNRYsc9dHyocrPlQ7RcE
         /bxPXywb+NV92QZOEWEhqHDS/yOgBQKBPg1CGFGFOpwMa34DVp+DchMeMRhk1NQB+nL4
         MdWKCYrhdJZ+bk9dW6oTPyvmEUQ66aV757pRSSnDMK+Txzeq15/9T2xvj2yFauqIhFTt
         +dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FRulKm6e54Rx05VJEtDgH/oUpouEIMBNeaS4CcWT2II=;
        b=tad4z8dnAp//dHCOLcEuoCov1zEdBy3LjAuFvVY7nsbMzMxToypnHpOP8mWC5NE+Pd
         Cbl5oTFk30kaPH18fdtrPl5IOk0qinjzOqLiIlE0Ux1HNWfafTU7dnie1jpDorqnaDFc
         hBwKoRvannfzkOnJvNcQ0KKCAA0H5LTww+ywL4gmt0jvVcFkXrk0gfdp328/YsxUmy3p
         QRiIBMPmFx0wRMgZ1WKzqmQBsgKzcUnk5XN3lpJtkkmh/z00WKYxsghXOXeLLI6ELOXs
         u/JQzW7haH6EEHoXa3JntpfMr8frSHtkVmyoQdqB7MNJ0zrCmytfTIM5Tdw4jwGQxcsA
         jMbQ==
X-Gm-Message-State: AJIora+ZkTOlZTU3bOgKoIt6HOHBiq2X/vjRR2IACxS+MaFwCaQmT9yg
        s78L9mHqaZIzFY8n+jmebstPR89OlBhEji9jmOc=
X-Google-Smtp-Source: AGRyM1uxf+7SgOhERQ+advuS8sg9tR4FzU+AlnliUTWqy2CD+XS9ScLPhWwwDRtP5W5sokxz1w2io/azNxJiVxadUx4=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr9266059ywf.486.1657366485519; Sat, 09
 Jul 2022 04:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
 <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
 <9826f272-ed7d-1daa-c852-6f353258bb2b@redhat.com> <CAHp75VfVoTcZD7vXxXckxu-crsXr7m4bx8F9D9cs2TtBbyeYqQ@mail.gmail.com>
 <154a12ef-29a7-8189-1a5d-648dc92cffd3@redhat.com>
In-Reply-To: <154a12ef-29a7-8189-1a5d-648dc92cffd3@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 Jul 2022 13:34:08 +0200
Message-ID: <CAHp75Vcfr9mjgWPRwg8i5OatEyLCDR-vMazarSAtJXd_-Fee-w@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] platform/x86: serial-multi-instantiate: Improve autodetection
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 1:00 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/9/22 11:52, Andy Shevchenko wrote:
> > On Saturday, July 9, 2022, Hans de Goede <hdegoede@redhat.com <mailto:h=
degoede@redhat.com>> wrote:
> >     On 7/9/22 02:06, Andy Shevchenko wrote:

...

> >     So nack for this
> >
> > This effectively means nack to the series.

> > But it=E2=80=99s easy to fix. I can add check for ret =3D=3D 0.

So, are you okay with fixing it this way? See below how.

> I don't see how this is a nack for the series, just drop 1/7 + 2/7
> and rebase the rest. Yes there will be conflicts to resolve in
> the rebase, but the rest of the cleanups can still go upstream
> after the rebase.

Because patch 3 makes a little sense on its own if we drop the patch
2. The rest is the simple cleanups which I do not consider as a core
of this series.

> >     >       case SMI_AUTO_DETECT:
> >     > -             if (i2c_acpi_client_count(adev) > 0)
> >     > -                     return smi_i2c_probe(pdev, adev, smi, node-=
>instances);
> >     > -             else
> >     > -                     return smi_spi_probe(pdev, adev, smi, node-=
>instances);
> >     > +             ret =3D smi_i2c_probe(pdev, adev, smi, node->instan=
ces);
> >     > +             if (ret && ret !=3D -ENOENT)
> >     > +                     return ret;

/*
 * ...comment about why we do the following check...
 */
 if (ret =3D=3D 0)
  return ret;

> >     > +             ret =3D smi_spi_probe(pdev, adev, smi, node->instan=
ces);
> >     > +             if (ret && ret !=3D -ENOENT)
> >     > +                     return ret;
> >     > +             if (ret)
> >     > +                     return dev_err_probe(dev, ret, "Error No re=
sources found\n");
> >     > +             break;

if (ret =3D=3D -ENOENT)
  return dev_err_probe(...);
return ret;

--=20
With Best Regards,
Andy Shevchenko
