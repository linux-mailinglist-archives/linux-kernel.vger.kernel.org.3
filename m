Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184CB50C1EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiDVWEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiDVWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:04:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E341A96D;
        Fri, 22 Apr 2022 13:47:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so11811891edw.6;
        Fri, 22 Apr 2022 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqJyh8C27vk9uziAAsZ9Sko9+svvUdiSo3Q1oIPdtew=;
        b=L6gGTQ/6DfQIlosX6rFW28zXn4rmTt2yEc4fSS7LlDRCx3GrzyWACj2e3H/hSS4EVa
         Zzf6rxAQVnSZ/0HYb5wpTSch47y4/x1p0qvv4LVbGn3yYb8Uvnj0gS+QmEqeYBFLlSLF
         Jf6w0khn0nRUft/3CCa6tJ5X4TJO+iqtGz3YwiKu21TfYwZ608QOGpAnXRJp9BrzHgLd
         0d3h6JN3unzrTHDSqngln9ajQWduYt5+CpgudMb0/x2SoNx+PabIrYbX2ijhT0YVrHfm
         2m1HOtnbbQCkLNCPnDV296p+lPUM1q99Kb4IfHzWP4Sm/hIXPnEWBwMJAZNL6g2IJyJI
         iVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqJyh8C27vk9uziAAsZ9Sko9+svvUdiSo3Q1oIPdtew=;
        b=hxSG9UZMyCNtAhq3d8gc9aooEbvJc+U7Uqu5WhIw3IyvXal8L66gA+JLzgd0yk+OYF
         UeVxDPD7uaG61aKyC6+5QKCLCsyx1MrUQJSVuP+45C6BfWPBhqkGmDc/E58Or84PP5LE
         sQalUo09uxk5CfWBmroXsRihoawNnIvttoRcjHhl69gLxIiGLy1vr1ToqOuTZ4Q785ow
         UfKrixlEkTxIYakDwEPO/7SgMLmKGtsMxr16M0lSfP6VX2zSuncirh3pzb/fEfD1wO/3
         hgvBw9eh+G2ROFNJceGx4FRZza9a/ir6O6YJScioKKFU8v4fxzCLRZwbkH3MpoglxnsK
         j/QQ==
X-Gm-Message-State: AOAM533I3RiOKfYxNJAzCrAW79GjHvT0IYcoSq5P1cxs0gsePcuTriLt
        H/6bpXP64GDveymIMCNMMEhet3MhG845EJ/HbLFQhvMcCrY=
X-Google-Smtp-Source: ABdhPJzONtYAysnLGqYOw6ud3FIKqGeCWT3xH7YoCMRjE9o+FmNs9pOgTW2YtKCoHB+4692wuPWCMYQhFhyZoAhR4V4=
X-Received: by 2002:a05:6402:e:b0:423:d5ff:8fce with SMTP id
 d14-20020a056402000e00b00423d5ff8fcemr6251542edu.407.1650652652753; Fri, 22
 Apr 2022 11:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160058.9998-1-markuss.broks@gmail.com>
 <20220419160058.9998-2-markuss.broks@gmail.com> <Yl7pqgjza/ZfajyM@sirena.org.uk>
 <0599e7ac-bd06-8d56-b510-0f27f4cc6790@gmail.com> <Yl8Jm9XqR3YTrW9Y@sirena.org.uk>
In-Reply-To: <Yl8Jm9XqR3YTrW9Y@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Fri, 22 Apr 2022 21:37:20 +0300
Message-ID: <CANhJrGPXJYf4Bf3oBLGB2v3AwyvJbompjX34qOaKXsEhFda0zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree <devicetree@vger.kernel.org>
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

On Fri, Apr 22, 2022 at 9:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 19, 2022 at 08:45:07PM +0300, Markuss Broks wrote:
>
> > I took an example from the rohm,bd71847-pmic.yaml MFD binding, they have
> > regulators at a separate regulators { } node, with a separate dt-binding for
> > it. I'm not sure what should I do, I'd be more than happy to follow a better
> > example if you can show me it.
>
> Basically either just remove the compatible and have the MFD directly
> instantiate the device like sky81452 or put a separate node for each
> regualtor like wm831x does (but without any DT support).

Just a note that the BD71847 does not have own "compatible" for the
regulators. There's only "compatible" in the MFD node - and MFD just
kicks the regulator driver. Regulators get the handle to the node from
the parent device. I think it should serve as a valid example of what
Mark described as

> Basically either just remove the compatible and have the MFD directly
> instantiate the device


Best Regards
-- Matti Vaittinen
