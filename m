Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537155665D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiGEJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGEJJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:09:24 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836B0397;
        Tue,  5 Jul 2022 02:09:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i7so20692906ybe.11;
        Tue, 05 Jul 2022 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ABUmJ7PqPeNvM2oyLJ0kEH6G6ytJGVshdh6kGqpszf0=;
        b=kN2ViZnnHHncMhTTe/DRwvaVuW7kNHTMxkkpaAUoDoKdZLrBdWARj8eAY6YNkrDxJO
         yVu+F4AEDiDGRWT4NzAjeKcYVfYZKsZ5rvZdmjkc2a3eU+CsrTlXi6mkWkriCGjA8OWt
         dttFDP43A0O7DnyzeDtSCERb8igUi8NVo0aeWh+W0VOSAH+SAMJY2x7ehDHJZqShRdlX
         URz24PBf6ij3TinRLj2Q6NWSq4q5uD1HcS3vIeIogcaOe08XOLoGjvXHLffYQQhgmyVK
         lyrl1e/nvUOHxdyzyjd2yg1b/qZ7suz+3ZhR0YntVpEHpVNknwRNzf1pvwKIsV30UbIU
         9MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ABUmJ7PqPeNvM2oyLJ0kEH6G6ytJGVshdh6kGqpszf0=;
        b=KdZkU8beGd44NlUK0dy7Sp0aiAFld8+PhRjWzrVbyRAwi39vmbTsya5uLwx+7q6yah
         oJuOAyM+3tnzhaHQafyIPHZcWn4hYye9po40kveEgtz1IpPm3RcTtOQxqRIU7kfC6+pO
         wp0mFPMm0pxbNEhsKYAbaOl6O7n4FrtX50P+CPkj8eMVlJN41f8T4m9P96RJqLBVsaQn
         Nj39oJVQS6NgNCXoh9U/0ugK4rgRgRRDVYlCnh88JnA3cAHCyeVFwS2EuNvG47S/5Bsc
         0PZ8Ofn25OyNUmPklQeD0ooSxdowIugCWNMXDKD4/GNo6yWtANxOdm4V7jZVUGqec/rl
         NuMQ==
X-Gm-Message-State: AJIora9uHDNukDtspwiq2j+Z6JENWx5ytUMw8kr2ANxZG9DbsXkkwrjX
        15BKdvzRIVvpD2Ubfs+UaTuSaZPmSZfZLSza+GA=
X-Google-Smtp-Source: AGRyM1uoZlG70VN54FIzLhHwlqJvuDz8beikCFYCKCGhB4L+Vr4WMLb1mzDJ/xhMXwGyDqAdydyjc3r0yP1NHC91vzI=
X-Received: by 2002:a05:6902:154c:b0:66e:8254:146e with SMTP id
 r12-20020a056902154c00b0066e8254146emr533231ybu.570.1657012162751; Tue, 05
 Jul 2022 02:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <1656922179-21829-1-git-send-email-u0084500@gmail.com>
 <1656922179-21829-3-git-send-email-u0084500@gmail.com> <CAHp75VeNDnq+jszSZeU=Gx9cYzbrEo880QaBUOzSkoHDu5qKZw@mail.gmail.com>
 <CADiBU3-mJeVyFT=RaXYbg+rX96nV6viC-zuL=ch1zeiOeUtPnA@mail.gmail.com>
In-Reply-To: <CADiBU3-mJeVyFT=RaXYbg+rX96nV6viC-zuL=ch1zeiOeUtPnA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 11:08:45 +0200
Message-ID: <CAHp75Vc-e+s94e=frhuEOJh0qYKME4kyJypHauqkgMZ7Umpfsg@mail.gmail.com>
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

On Tue, Jul 5, 2022 at 4:17 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:18=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Mon, Jul 4, 2022 at 10:11 AM cy_huang <u0084500@gmail.com> wrote:

First of all, please remove the noise in the replies and leave only
the necessary context. Respect other mail readers / commenters. (In
case you wonder why I didn't follow this rule when given my tag, this
is done in a way that I cited full code to show explicitly on what I
have given the tag).

...

> > With a fixed kernel version (it may not be a stable version, we are
> > now at v5.19 cycle, and it can't be either this cycle),
> Do I need to submit  v4 with the latest kernel?
> Any misunderstanding?

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
