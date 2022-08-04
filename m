Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B6589ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiHDPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiHDPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:40:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80664F17;
        Thu,  4 Aug 2022 08:40:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s9so259650ljs.6;
        Thu, 04 Aug 2022 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=1leJD2jYdoCH2YF7serqPkhW+3ZM8UEl9gxlKtZpBek=;
        b=laH6fB3jX1QrWTXtnY0qRiG3yiIKuZ4sSkr3yP8rxh1K2TGiHIorSIQj6pXgAPPmeB
         xjuQPlvW66l4ncnGmdARxcrcDDCuJip7fBWe/TENNYsO6wB8viV1yd7NePXWO7qdTqYx
         8MfNKUYe0peXYXpxBRzDrWsNShuAsTnMWECNSf1keJI2JPSIsOflFQGQKG9g3i7souQ4
         vlEEDBcYzkLA3n4eGouBn/EOQRxK7qHWWNwZIozIXzHZExLeIMgz7zNd/S4ay+07kWlX
         Jm52skrNW+E54wGgzw53RO8RayH5aAClCL5hZm0q1mY5SUz9ja90B+8TdmhYjukln66M
         ZsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1leJD2jYdoCH2YF7serqPkhW+3ZM8UEl9gxlKtZpBek=;
        b=yXYMGHeQzhXGY0SoI9eHRsdppCvPmnWib8jPRaQYymlhrRxryr+1oWOVxtl6YVCDvd
         dKgHHgvmyqEjKyXLfK15IcXC1k9kxCYB/SuJy4rbbxb2bFRrXxM/44g4JGOpqnfLNVE6
         oKMGcIKV5Diq/nOnbXlROSlDP1THoej7EE4kaaEwnYkLHzRtP4gD04nRQBlWx5o2OHp1
         INFBUwFFHqRnrVPMWIeXuwTlhiwlEgulnoVBTlhDb1lgN77aqhcn4r+sKI35awBPLuaY
         /RLBDhSH6PUSitRnXGw0jr7DV2+6NXRbdfb78SYMFx7aixEw+XXb7m2AI0199qeYHKq1
         n7aw==
X-Gm-Message-State: ACgBeo0Y1GZpjOj6zjj79gcXCrxhLqO72Vbj8RJOIILKPw8hg0lOjlnt
        eNM5I9PxjLOYjzSNpESd2Fz8yuB87SO3j/OfHs0=
X-Google-Smtp-Source: AA6agR5RGzkugERz/4oeLaBfhq3ArqArrOJPuit3/LvK760dfD+laKr6a9iKinniQ0NQiCL5MKgOdQhbs91FsvnJysg=
X-Received: by 2002:a05:651c:2d0:b0:25e:6c94:59d5 with SMTP id
 f16-20020a05651c02d000b0025e6c9459d5mr810993ljo.488.1659627653867; Thu, 04
 Aug 2022 08:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220804145516.217482-1-tmaimon77@gmail.com> <6fef92f3-6932-5c20-57fe-9eb40d676013@molgen.mpg.de>
In-Reply-To: <6fef92f3-6932-5c20-57fe-9eb40d676013@molgen.mpg.de>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 4 Aug 2022 18:40:42 +0300
Message-ID: <CAP6Zq1hvDdDO3yA=rFAvKMg20EM6OuoiVnxOBMbrpB9oHaMbfw@mail.gmail.com>
Subject: Re: [PATCH v1] dt-binding: ipmi: add fallback to npcm845 compatible
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>, minyard@acm.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, 4 Aug 2022 at 18:01, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tomer,
>
>
> Am 04.08.22 um 16:55 schrieb Tomer Maimon:
> > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatib=
le
> > string.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >   Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt=
 b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > index cbc10a68ddef..4fda76e63396 100644
> > --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their h=
ost.
> >   Required properties:
> >   - compatible : should be one of
> >       "nuvoton,npcm750-kcs-bmc"
> > -    "nuvoton,npcm845-kcs-bmc"
> > +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
>
> Isn=E2=80=99t the added string exactly the same as the one below the comp=
atible
> line?
it is not the same, it describes a fallback to NPCM7XX KCS Since
NPCM8XX KCS and NPCM7XX KCS modules are similar.
>
> >   - interrupts : interrupt generated by the controller
> >   - kcs_chan : The KCS channel number in the controller
>
>
> Kind regards,
>
> Paul

Best regards,

Tomer
