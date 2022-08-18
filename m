Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E959C5985EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245326AbiHROdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbiHROcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:32:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65996BA177
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:32:44 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3246910dac3so45463027b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Q4PdP6WMWUVs/TeYlDNhMKNUMGDED/B13OgREMxFMgY=;
        b=xHsVBUejsifubir7I9ujOu5L7D7Gctd4kp0EcAGnt2NOCDvJl/VTImRQGl89bjg/6T
         7aBot6xRY8k6Je60qj9TxBYr45y8cnIiPAqc4smkamnZwMkjokv6yopWH2J4eOaRrVL3
         Ej/yjOFAP1cvBjrnTtfHB9IFdXgJ2awAhMraCpO7xUg8LCoXt2FK8JX859tnIwIBGDW8
         EVEKNrVWK4xfFzO2BfiCgzKwFm6SjXFwZnVuIXh9bUaeNrzl0N/pIcooPlZQdeehXxV4
         StUvn/bBotX061UWdKMESkYJ878gzg74y2BoHckho8kP/CAdmynJqnVpNZQvN4KuAHMH
         +Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Q4PdP6WMWUVs/TeYlDNhMKNUMGDED/B13OgREMxFMgY=;
        b=MYOyMXudrx7D/uhU3fxOhsuqMX+FtD1OxNoCjZaP4Rv5Y6jDpYlVtCvvqkeiRLmeEA
         /fEfraBoxF1t3as7PcBOptnQhtp2FlpKS2CYSz9lHVNplAU4E9Cd6cjLN+6AI2/6GKsd
         X08WZEdYFhBWXtelR+whUO5twaAYMUZL//VCjNjhQ2XIilyVxcaZx35ZJZwuNL2qwL2/
         9ZMFfUPIoQGOyQgkNLTlxhUKU71WXPtIuqP5xqzNSoS/Ql2oGU2/S3S2LcgDuaBSZowB
         sm+RiW9esY4Z9axCJHR0gdxOgT64KOTts7XPzqB9euIebF5+1YLoH5FwU7R2dDwk122d
         Ra1Q==
X-Gm-Message-State: ACgBeo0CddmDf8Wqs5ZpSzI9BpQM1PG3ExDRPZk29QOzxz4AT4+e54lu
        BI7QBY5ji8jUAEqA/SUGsrZIXQQyjr5ZagdIcRlNgQ==
X-Google-Smtp-Source: AA6agR4AEclnoudYoF6VfykDjXrvraA0qGjn/GeXAkkP873Ycrs+WwTOAD5oEu/HVCUK2JaGonXuFI815FumjWyTljI=
X-Received: by 2002:a25:2f8f:0:b0:68d:9cf4:1e4a with SMTP id
 v137-20020a252f8f000000b0068d9cf41e4amr3219470ybv.38.1660833163595; Thu, 18
 Aug 2022 07:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-3-bchihi@baylibre.com>
 <18164de9-ad28-939c-a802-69647fc65a37@linaro.org> <CAGuA+op3tFL6M=H2rzAB4DJn+7ve4W5vUuRc+zBrq7zQY2CX7w@mail.gmail.com>
 <3b4fd920-1f9e-de43-b436-85d73cf12f8c@linaro.org>
In-Reply-To: <3b4fd920-1f9e-de43-b436-85d73cf12f8c@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Thu, 18 Aug 2022 16:32:07 +0200
Message-ID: <CAGuA+oozeHkrRvO9iBYnPYrxq=1KcXcabji4Mjt_cAx-darWMg@mail.gmail.com>
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
 LVTS thermal controllers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 4:08 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/08/2022 17:04, Balsam CHIHI wrote:
> > Hi Krzysztof,
> >
> > Thank you for the reviews.
> > Would you please explain the meaning of "Rebase your patchset on
> > decent kernel tree. You seem to use something a bit old"?
> > It is rebased on top of linux-6.0.0-rc1.
> > Am I missing something?
>
> You Cc-ed me based on old maintainers entry, so either you did not use
> scripts/get_maintainer.pl or you used that tool on some old kernel If
> you used that tool on decent kernel, you would get different email
> address. That's why I asked.

Thank you for pointing this out.
And I will do the requested changes.

>
> Best regards,
> Krzysztof
