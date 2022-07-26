Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74EA580A45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiGZEPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiGZEPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:15:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6BA240AA;
        Mon, 25 Jul 2022 21:15:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id j195so4093224ybj.11;
        Mon, 25 Jul 2022 21:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lL85hlJEWNpWq8aoVq7T9RPrHigl/wy3kQyoeNe4Sas=;
        b=hCdS8QSsYIw6gGaV0XS9IAV/+XD+Kk0QE5hzusxmOf5d2dTDTQQcL3NhqMYKbFY0Tn
         ALB21R/6DazMYeCAAzfSZS7P0Z41gJsw+nZjWX6PlQXwXANm3LVAqrB5PFsMuqAHqXem
         Mqmm3Ih1NTwtWzQhnAzSzRXXrf5yfCoFcjkmFFPLCmRVp2siIg3AfNjuCMTK2YESptid
         eeP9tz5wTm7qe3sotMpBO4iTSI2DKFf7D3YatBVRT/PbkAZVFycO+siEvHp7i27pNctb
         TonIMjdDnr0jjVWHRnLmYyT6Iqx8oAClUtlkGASQ6CkTyN1ePQ9WOQPU8smSEzTDkemD
         7GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lL85hlJEWNpWq8aoVq7T9RPrHigl/wy3kQyoeNe4Sas=;
        b=PC6hw7zeLjOXjofpJO1WG7vc5dzxEG2re2M9lU+dBoq7396PI+/H0o18wCV6FXP3HL
         DVWLfwjhxo6IEwiWKCpIpEPlKmux4/qzcM4DZhZCNbMd7X6p1kvG3YPC3yJskwL6q4mR
         bnZe0hw9n0J+Xi3G9eMJsaUYwL6S1ZKD9cX+Q6y8lNrxlQKZnLMfAoWykBI5j3AX9D2S
         9z2iIrahKCgnt+rZdzI/GVljdaBVN7YBa+n7iN2NH4LCEJgPaqB+wIKMkiopEFMVCIym
         DJeu1Nz5F5UxTziRTH1aPfl7zngy8kqLsJxYAKxVhaM/Amqw9AgFMiycnhTrO/p03qGt
         lKJA==
X-Gm-Message-State: AJIora+Ml0B1VxZDIMEoOtToMqvbHpdtILIeE9WZF99630HmB0dl3Up+
        GiwbnPIJXues3K50dfQsbBjTROsPpFGg5HH8f1w=
X-Google-Smtp-Source: AGRyM1uSqvDW6wRuMm0lak5Iwbp5WAlFUJEhBzOij+tqweUKRMo5toAZUB++pRBDQrYJNbxll8cTRP6sKMvIiCj1/Dk=
X-Received: by 2002:a05:6902:10c2:b0:671:73dd:e67e with SMTP id
 w2-20020a05690210c200b0067173dde67emr484158ybu.16.1658808945685; Mon, 25 Jul
 2022 21:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
 <CAHp75VfgiK87VwWu2bTJ_mR0=g0sa0LPJ+H16OGcUdARmzFRSA@mail.gmail.com>
In-Reply-To: <CAHp75VfgiK87VwWu2bTJ_mR0=g0sa0LPJ+H16OGcUdARmzFRSA@mail.gmail.com>
From:   szuni chen <szunichen@gmail.com>
Date:   Tue, 26 Jul 2022 12:15:34 +0800
Message-ID: <CA+hk2fYpDRw+DRRU3m=EDOP6UEQNpJLyNBHe8Zi0qOfUObTb4Q@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

>
> > +#define MT6370_ITORCH_MIN_UA           25000
> > +#define MT6370_ITORCH_STEP_UA          12500
> > +#define MT6370_ITORCH_MAX_UA           400000
> > +#define MT6370_ITORCH_DOUBLE_MAX_UA    800000
> > +#define MT6370_ISTRB_MIN_UA            50000
> > +#define MT6370_ISTRB_STEP_UA           12500
> > +#define MT6370_ISTRB_MAX_UA            1500000
> > +#define MT6370_ISTRB_DOUBLE_MAX_UA     3000000
>
> Perhaps _uA would be better and consistent across your series
> regarding current units.
>

Yes, _uA will be more consistent, but in general, using upper case in
the define macro is a convention, doesn't it?

>
> > +       /*
> > +        * For the flash to turn on/off, need to wait for HW ramping up/down time
>
> we need
>
> > +        * 5ms/500us to prevent the unexpected problem.
> > +        */
> > +       if (!prev && curr)
> > +               usleep_range(5000, 6000);
> > +       else if (prev && !curr)
> > +               udelay(500);
>
> This still remains unanswered, why in the first place we allow
> switching, and a busy loop in the other place?

If I refine the description to
"For the flash to turn on/off, need to wait for 5ms/500us analog settling time.
If any flash led is already used, then the analog is settled done, we
don't need to wait again."
is it answer the question?


Best regards,
Alice
