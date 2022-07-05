Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F4567289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiGEP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGEP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:26:18 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA718E1D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:26:16 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3137316bb69so112226817b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wk5Y25/dUa+IXHDUL10teFIgK8kNUBO1oeMMo3Ill7A=;
        b=GsAVWt2RcePWEhCXpNuMhOCPB/Hj0hjOSc8fcr//l2a2j40bz/A12CPiM8+rQ2cPjK
         FE5x28RU7A1yUurjYhLkASsz48TuNZEr964a++b3qUwT0Dd+P2X5uC26c9NdiCWrj+kn
         caXUKSdiChQxkH5FlcxBpqu4F6jMfJsOKcOg2iC/om/w2HLcyM7dJvZegTcorWJCHyAm
         qxBmfiiWhnPwTHDdJf6wDI2hTxM/+hfs+I7+rIFVjP896vjIND+LDdG1DCSBHGgiIARa
         qPBhKXlPitQ3IKIZ0WQ4v7vL89DzX8YO5/crQ8+8uQAfT9uynVOAtYYUSU/cS08mijcM
         uBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wk5Y25/dUa+IXHDUL10teFIgK8kNUBO1oeMMo3Ill7A=;
        b=PZ5u/UVejzNto5HsYC28Th/voWUYFZjN84DBPEDgd4Rw1y4Bjdel73mWQFUzNMzjb4
         eKeqEzYnFQ3MdnLPRnjDUfQHpQRQfU7Urs2n66VVfIclze5S4M3IkO4CAxEbIT3FDbft
         q839gzJ6LuLY/W1GimbiFpiuRx+mkzfjslF5spEenWgZ5RpvHaqBF9JJs9ROo3wvYKZ1
         QAA67iqUSOg1mzbTlcOWsKleHXf4OrEXXpGi/4/y3Q1nztwo4tvqp+7mRADek6Xk8zJh
         iClAXWlTCbXuTqTgUgktjpHvgNFSEXczvYFTUQLfV0hIUP05iPX5zXrm+KmFsx0rnstT
         HV4A==
X-Gm-Message-State: AJIora+e54QBEq4d2AdJOMalaG2F6QQ2sT5bZRRH/QNgWzLeYvHgz9XL
        zVQ+ty9mBtE38T1TlQBSN4XMXkXoiNYIM/Hk3+k=
X-Google-Smtp-Source: AGRyM1sbWvK8fkwIV+Pfzeg/eyU/uTFVrTo9rOPot9tVLZJPz+6AT+wWjBp66RmVgXIojzx5ysR5XQTYtqIqakTkrA4=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr15794516ywf.486.1657034775878; Tue, 05
 Jul 2022 08:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
 <91f156ba-5d93-63d6-5fa0-86614bc370d3@linux.intel.com> <YsMTHTcOWX4Q3W7f@smile.fi.intel.com>
 <21522ae3-96a3-ce07-6466-89cbf6c67a9f@linux.intel.com>
In-Reply-To: <21522ae3-96a3-ce07-6466-89cbf6c67a9f@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 17:25:39 +0200
Message-ID: <CAHp75VfcbeMt=OUamfyoheqxX1gcCoov+976ewPUerfH=wSxRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ASoC: SOF: Intel: bdw: remove duplicating driver
 data retrieval
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        sound-open-firmware@alsa-project.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
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

On Tue, Jul 5, 2022 at 3:19 PM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
> On 04/07/2022 19:19, Andy Shevchenko wrote:
> > On Mon, Jul 04, 2022 at 10:31:48AM +0300, P=C3=A9ter Ujfalusi wrote:
> >> On 03/07/2022 17:35, Andy Shevchenko wrote:

...

> >> +    return sof_acpi_probe(pdev, (const struct sof_dev_desc *)id->driv=
er_data);
> >>  }
> >
> >> We don't use the desc in sof_broadwell_probe(), so we can just pass th=
e id->driver_data
> >
> > I prefer not to cast inside the function parameters when it's not about=
 POD.
>
> Fair enough.
>
> How about assigning desc before it is used?

As answered in the other email, I'm fine to modify the change accordingly.

--=20
With Best Regards,
Andy Shevchenko
