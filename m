Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF675665DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiGEJKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiGEJKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:10:17 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B62110C;
        Tue,  5 Jul 2022 02:10:17 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c8340a6f7so61355797b3.4;
        Tue, 05 Jul 2022 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mesOAujj2498Fnr2MFK4DNJdDYotGaaeMetlFLeRO90=;
        b=G7OGP3CjxPW0T+UcuzLZHXS9z+TL0mC/woogXiktwcXuprc6Trm2XFvLdLmybFzSoM
         QX/seWS1bQGCNkhA5rMZ1Pvw5P/SRxaWrv7K9IeCIfzKehMcO9qL5QLG9kuC0aIJHF9C
         ZTdBmGlfp0vA5o2RFJPpFBZAAFJspOL41a5D0Py/33udKj6z/SL2uxw9rkgulC0hTu3G
         8s0idJSXRhg3a64eITRCAiQx47VdhohibaIJWXqcICO6xr/chBwx376Udfsw6wAqcnaH
         oumWRBpiajkQh+t7OQWLKykGvMzkQG81K0rop6qa9GpJUrVxxteIta9xFoU9a02scA8i
         F0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mesOAujj2498Fnr2MFK4DNJdDYotGaaeMetlFLeRO90=;
        b=D4A/Tuzc6POrtrX2p4Nnq/CFUWAcYBJti1ATR4XZsb4MDxWDwRy/DgdSAV+r73/fxc
         AkIKDARCBBGWigrp4Z7nUbif7oIqwnlNdXpr1ixuOuu2fVCrxzAGesI4kPDKRJPPuOv7
         GpWZisIVpe/kmu29YcZwK2QWJqB3UBne13aS0NfFFhiz9qUChbxjG9B4mCyKsWMwl6TH
         l1Kg9dNdq2oo5++7cAk2f1UQE4UBwipxEEEGBlTmv/+D9bYwvAmimApV5shU0A67+fd+
         6a2ZbiH5S5dk+VYyH2qamNJBwsuoWzINKHMxdMimBZbmM0tLa5I3JOA9/1M1HCJfE0uL
         BOvQ==
X-Gm-Message-State: AJIora8iJPryWW53VIdcSeUi3f9XC5yluKzUadBgWdtT3M3Lq00cfRDB
        OT5vEszLRgsc/b6Vqy3cjaNQlugmyEklC+tnXHQ=
X-Google-Smtp-Source: AGRyM1s+KW3MpigW6Lyt5Q7XI8EubTFH6ELEP+imQ1gswdUvcMDAHle2LIDn14+68VBEB8xGP5zZuy8GI/JcxP/qmQQ=
X-Received: by 2002:a81:13cc:0:b0:31c:ad64:352c with SMTP id
 195-20020a8113cc000000b0031cad64352cmr7300823ywt.185.1657012216217; Tue, 05
 Jul 2022 02:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <1656922179-21829-1-git-send-email-u0084500@gmail.com>
 <1656922179-21829-3-git-send-email-u0084500@gmail.com> <CAHp75VeNDnq+jszSZeU=Gx9cYzbrEo880QaBUOzSkoHDu5qKZw@mail.gmail.com>
 <CADiBU3-mJeVyFT=RaXYbg+rX96nV6viC-zuL=ch1zeiOeUtPnA@mail.gmail.com> <CAHp75Vc-e+s94e=frhuEOJh0qYKME4kyJypHauqkgMZ7Umpfsg@mail.gmail.com>
In-Reply-To: <CAHp75Vc-e+s94e=frhuEOJh0qYKME4kyJypHauqkgMZ7Umpfsg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 11:09:39 +0200
Message-ID: <CAHp75VejXqbDJJAQTPHWzPyMZKEqggu387reXyUTiV1mASv9_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add rtq6056 support
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Tue, Jul 5, 2022 at 11:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 5, 2022 at 4:17 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:18=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > On Mon, Jul 4, 2022 at 10:11 AM cy_huang <u0084500@gmail.com> wrote:
>
> First of all, please remove the noise in the replies and leave only
> the necessary context. Respect other mail readers / commenters. (In
> case you wonder why I didn't follow this rule when given my tag, this
> is done in a way that I cited full code to show explicitly on what I
> have given the tag).
>
> ...
>
> > > With a fixed kernel version (it may not be a stable version, we are
> > > now at v5.19 cycle, and it can't be either this cycle),
> > Do I need to submit  v4 with the latest kernel?
> > Any misunderstanding?

And a missed reply here.

It depends on the maintainer. I hope Jonathan can update the version
for you when applying.

> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
