Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFC54261D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiFHFiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiFHFhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:37:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2A32FCB7D;
        Tue,  7 Jun 2022 20:04:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so31131181lfg.7;
        Tue, 07 Jun 2022 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L5ZYH+LWYqiBk7fpM83vhj5wGF3Gz0mcvdvBDz/uj1g=;
        b=agHYHkRrWMlWqfuqVBfv9Fr3XsxQRGh0512tN0VYh1PyZKyyqFbYoDjhWT5bnTHP7W
         hukeiEb++As8nxUOjdGYAtY8wSq9vbjpZJ9MKGC5jRaYg5OpnM+AR+djx8CzDWLalWJn
         jLsSw5eejh24vmroszLeuAjg4psdO7vKl29AYFtuvWs7okT0v+g96RRFQCAtd4hMr1yd
         gFfTeikgaLo6Uh92GaNnonjTS/Ja4d03KO9aENnoyDbA/HpnZ6BXW6V2KyEBsxCIZWjs
         aiJ6qzk2JRTNHfFCPnMJWKXLnsw7pvnKJxqJqtKWYbnx5VAiRqQ0ikAN6bxQluxLPLiG
         c7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L5ZYH+LWYqiBk7fpM83vhj5wGF3Gz0mcvdvBDz/uj1g=;
        b=iwRMgWT8hGsaMEZGer8bxODtAVO5qsD5ByJooMmWV4/yIyXNyJaByKjfMyleet4RXb
         ufbhXK6t5q5xTpXK+J5lv33AftJteMPCFHwxAAqSfhvhfgDO4Fx84j+LYTY+YVM2TcSO
         uUji1HrrCfLwW3TbnTxUAzbxl7LB3xqMgMvKz0k5dBvdnJmXxLDPl26vbtRjvokOBPfM
         fnkLHKBXl+k3Yuoj65vYvPYCc3PToJG3KLE8+znRoWAK5+5u41+Z09KCfFrLeVHzSDY0
         REI258dDH+Jd1Mlo9QcRLrvtFgBW94ZVXXPJ+kQaVIa6Wbpiy3/h2AIzxFgBDG4G3QY5
         CqsA==
X-Gm-Message-State: AOAM530CdmW/C5zVVIikU1CLq4vrYFeCTvmS6lmrGOB43wowSzu3jkwq
        ZyaLCSbvUmOSyLIKrdivh5t4lAEZcmeIUr0pqLY=
X-Google-Smtp-Source: ABdhPJw8f6cAe3SFbdQWcdhfsF9EaEbYDlnQeQAtC3B9hkem5sTjhnQljn3lzT0a0+nOO+yUTds/upCJko0NOJQO6LQ=
X-Received: by 2002:a05:6512:2251:b0:478:fc67:b09f with SMTP id
 i17-20020a056512225100b00478fc67b09fmr19913197lfu.196.1654657461572; Tue, 07
 Jun 2022 20:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-2-git-send-email-u0084500@gmail.com> <Yp+gtJju1H+j88lE@sirena.org.uk>
In-Reply-To: <Yp+gtJju1H+j88lE@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 8 Jun 2022 11:04:10 +0800
Message-ID: <CADiBU39yXrB+yQeXHv0ToceCeG+w_TT2JkzP83rzkf+j-53Zfg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
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

Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Jun 07, 2022 at 01:52:38PM +0800, cy_huang wrote:
>
> > +  richtek,enable-undervolt-hiccup:
> > +    type: boolean
> > +    description: |
> > +      If used, under voltage protection trigger hiccup behavior, else =
latchup as
> > +      default
> > +
> > +  richtek,enable-overvolt-hiccup:
> > +    type: boolean
> > +    description:
> > +      Like as 'enable-uv-hiccup', it configures over voltage protectio=
n to
> > +      hiccup, else latchup as default
>
> Why would we not want to have these enabled?  Unless there's some cost
> to having them on it seems safer and more helpful to look for problems
> with regulation all the time, it might help debug a system.
The default latch mode would be safer during power rails boot up.
If during power rails boot up, any oc/ov protection triggered, latch
mode will keep power rails off.
Only toggle the external pin to re-enable can trigger next power up.
Like as your said, hiccup can help the debug for this kind of HW issue.
So after all power rails and system booted up to make the user choose
the hiccup option.
That's why the property here to enable hiccup mode.
