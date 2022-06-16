Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79A754E308
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377340AbiFPOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377556AbiFPOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:08:27 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676232A719;
        Thu, 16 Jun 2022 07:08:26 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id r4so1332707vsf.10;
        Thu, 16 Jun 2022 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrYcdQgMMj0tJd0GCypW33PRE4/W3iPmmyMq8bz+7DE=;
        b=kKK3GAH4z4U3YumVZNn79Ch1G44q7SVw7+oi81SquZQyrhVztXfwIT6XYtr4LKGFJB
         xzr1GE27vDB5oF16k5TaEQwtMTsruEn6OvaGk1I4g7+43k+5ScAx1Efpg+TzfZQ1PuX3
         YaV5YRA3rxg1mycPj9Zwu/tYhfS4/Fu8q92pcplEu4oPBWi6A+6Fyq++c2m5AsDC1kuV
         Aug65pumjqtJF5j8ZpNJ638hWnbZ5Kr3v9vqYy5TGrNHLuUczGZtTzJ51+T0uVbnIvfi
         +ghIwqNvRvOHu/PprpB6nf58C+hvF+rAP6PLtNkTySIiHsKKoCvheZOerguH7HtLUpe1
         gPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrYcdQgMMj0tJd0GCypW33PRE4/W3iPmmyMq8bz+7DE=;
        b=sWMgZStGK7OZ4T88m5+/FfFvD2gYQO1SDZYGa4Z8ebgA0pSqUCYU4EWKfkI01dD06i
         5kUCWyY5aT6/S4kUh2Qqd/Sp5qb0bPF7aYMtI5MQpSpoT9kPYWT7/mM4ETTGxUjkqNNT
         qCaXF7e0UXwFkfXsNH5cv+EVBcw/EILHlrC5hpJb2ePomR/Tx8G9Wyo8igft572gfFNj
         1fCilw3tUrEWj0x07iM2rc0FXG9g95p3/u73BhIhuOusNwkGM8wQIWQYnVGAGayEPUWR
         eLf6fb//SwS5U3M6MNs718f5Cupg0Hw+lZ523ejuHGI9c5inHJj1bPY88PFSSWqXqCjn
         MNLA==
X-Gm-Message-State: AJIora/6Ac54kvEk5iUqkCQw8kvGDBb1HcPJPTIs0afCh7PyEhzEVZI6
        m8H1avzkj8XFsb/rJyNC1jG2pSkqBMf2KPgmIQo=
X-Google-Smtp-Source: AGRyM1sAkqNmpZ7DjWNnBWpUFGZXOCr/kKVwhJU4zW7sv3K86XpIJYzfhVP3KnpFJK+qNs2H7HVkZ1A9NcAKvqFEbK8=
X-Received: by 2002:a67:2246:0:b0:34a:46d:4f48 with SMTP id
 i67-20020a672246000000b0034a046d4f48mr2407019vsi.4.1655388505555; Thu, 16 Jun
 2022 07:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-2-romain.perier@gmail.com> <1655298962.395709.662448.nullmailer@robh.at.kernel.org>
In-Reply-To: <1655298962.395709.662448.nullmailer@robh.at.kernel.org>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 16 Jun 2022 16:08:14 +0200
Message-ID: <CABgxDoLCJTn8Ohvb0TQQ_MsgCNoV5e9R1-7JUe137uTRtFY71w@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree
 bindings documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Palmer <daniel@0x0f.com>
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

Hi,

Le mer. 15 juin 2022 =C3=A0 15:16, Rob Herring <robh@kernel.org> a =C3=A9cr=
it :
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>


Mhhh, not sure to have yamllint, I will check it and fix it.

Regards,
Romain
