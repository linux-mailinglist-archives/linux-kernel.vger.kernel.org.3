Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1285866DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiHAJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHAJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:30:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584C6399
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:30:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id tl27so1391850ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ylmvQoTPw7ZE/EAiWRtIUS7ffPwmJZAEaFRCxWVFMDk=;
        b=GgBwYqbhvN/4pIvw8sZfhtcJ/qnLOwkP6T8h9r/MvMGJ8yxkAdHFqjkYZlDAHsj0Pz
         LbkUtBEoqQd2ifzhu0oDV5ll4ZH8f/9a2RqQQrxqhN1nQxL8uTqONEDed/NttZXheLLV
         fnZwn3OIkrCRYZViLHAjPe0K98haj3EyV4VRd58bsIU5BD1Gl+34WYMfAZYvVLp1zxHf
         arh1p93kt5nVm04KirCGk4dZDFLRm21EOm8G8DDKhbSulDdRErNADnG7LaAGUSWdJilU
         Ito3cBxk4yDnjo6JcuWJmt+4RNsddqwTo5uaEUlWtynAgiSQflTB5xR2zOyIkV+y7fLr
         CAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ylmvQoTPw7ZE/EAiWRtIUS7ffPwmJZAEaFRCxWVFMDk=;
        b=sudbCmZt59WX2zoXD6f7zhCJwN1WXa6GFZ/l2y+GePph3YIo791+IzE4ykkrPQru8H
         uSuHHy8HYI3HuC80VdAGiq47a/drd8FYQfte2lAEfT8fin52wHy2O432NQXuJEOZGgtV
         XaSB4+3H5hduXHmnuw2aKj9VD0nxiQAJJ09dcj6F4ZRcGUrszssMLq4sZeExcUMW+9J9
         dPxfnYrurhClcgNg7qn0HwnuBMwAn/7ZCRUSY9vpItFAWVMq2oZDkfq1/0QGs7JHoIjY
         jFJHZnyq3dJmMRQnynfR76qkY7FA9fHCsDbk0IrJ34Xnb3UCw4pC9LFOEaRhgEI017RF
         2gBg==
X-Gm-Message-State: ACgBeo0hS1B+B0sEqqBGsDa22uq8QNDujabssQ72bj8OsXp2O0M2gAmY
        gpyfjA03P0kmK7gxOMNwnb5HmqEu52/6avBDE+s=
X-Google-Smtp-Source: AA6agR6+f20IqqMDhbwuYCrh3wu8vGU+qMYjb0uqBNibdh/rlYa60teiEfx/iYSb6wJsLVc6Jn/UBJdzqDTIa6KIMl8=
X-Received: by 2002:a17:906:e8f:b0:730:9480:9728 with SMTP id
 p15-20020a1709060e8f00b0073094809728mr1026124ejf.99.1659346242906; Mon, 01
 Aug 2022 02:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
 <20220731201258.11262-2-andriy.shevchenko@linux.intel.com> <c7a0251b-403b-37b4-6b17-5e5e2b7c318a@wanadoo.fr>
In-Reply-To: <c7a0251b-403b-37b4-6b17-5e5e2b7c318a@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 11:30:06 +0200
Message-ID: <CAHp75VdHNEumBkkviD3sHPft-vMmVTDc2uXJVvbBDjpaHxKKiQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] mfd: intel_soc_pmic_crc: Merge Intel PMIC core
 to crc
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
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

On Sun, Jul 31, 2022 at 10:29 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 31/07/2022 =C3=A0 22:12, Andy Shevchenko a =C3=A9crit :

...

> >   drivers/mfd/Makefile              |   3 +-
> >   drivers/mfd/intel_soc_pmic_core.h |  25 -----
> >   drivers/mfd/intel_soc_pmic_crc.c  | 163 ++++++++++++++++++++++++++++-=
-
> >   3 files changed, 158 insertions(+), 33 deletions(-)
> >   delete mode 100644 drivers/mfd/intel_soc_pmic_core.h

> in v1, there was a:
>     drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
>     delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
>
> Is it expected not to have it in v2?

No, it's not. Good catch, thanks!

--=20
With Best Regards,
Andy Shevchenko
