Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2515587C03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiHBMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiHBMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:10:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56E2A246;
        Tue,  2 Aug 2022 05:10:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so12187805pgb.4;
        Tue, 02 Aug 2022 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tZd4njYAUvqcBl8Cg23Z003UTROce5YRjVytjkuVuJQ=;
        b=ZMlCgPyowTPmfRKTIFirpjCR+BYX+KSTxBJq5E7OFZ0rR7Ju6y/ZRoRFuPEROa3wTT
         xZX9IqQ4y6D9O/c5G0q4qT+G9ExKuFWGntGwPronsW/1ePmnZCebwKpr0DZSp/yXPz79
         vLfXAY39Zy+f38K/IjhgmB1WDZ7EN/cioAiHyCLhPREQRU4jGeMnkbsFGG5T9pVk/vYh
         pmTpQjT/l6OvQPeamSSTvF33DXVMrniShfbp5GVOBNfyPbtriA7OCjWYRXydvCl+MTS9
         d5iQ0J+I7CPDXqDhDqRxdHERWlgmtzv7OyTb+Gu7MvZp+eIiuDmBo0pSOifvfw28yija
         g1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tZd4njYAUvqcBl8Cg23Z003UTROce5YRjVytjkuVuJQ=;
        b=WYhI+nzxOCONWrOVlbiT4yW5Gihxhi+BwYEAujwwpqCEaoz4ks+qrER/iLOkE+Nm8R
         Ltk2x9lkRtRSAjEuuZzlRxa8XIN5O6WodNghCxm2z4Z0TODu2d8pxo5PGk+EolvBIWG9
         tXy1DKdf2g3wHk4AD6eLoIlc9+nME2f9ZH9c9tbQOx6559E34pCrXkb9PWXRTd/4IBfO
         ZLqHCW65FEd9p9k7vTPQkZ/o4zG+M9ze1yg1tn4ii7dq2atsmbY6ueY38raGBN5xUfmS
         XTLRLFjnLXeBDTRijp/Lcx/UAMjsRydt6i+CFBa4Hy52V3rODbptagxWdCcvzd/jXi6l
         HTUg==
X-Gm-Message-State: ACgBeo29CB3mNf+b4vA60aCYMcUI/pSnXoCrKCPsmBTVV596Bu5/LSwD
        FrRtXOW+U6118xdDbPUk5SgIF/PNYyz6VmLWDs0bBGtOin0=
X-Google-Smtp-Source: AA6agR6wLj674jkVZLo3n0UXFwPSekdGWVi7lh11ggnjJig/ryQurshV4LdPkF+RM421mlCXy3G9ZU0SPRHRmtOS8wc=
X-Received: by 2002:aa7:8f13:0:b0:52d:fe17:ce11 with SMTP id
 x19-20020aa78f13000000b0052dfe17ce11mr700675pfr.26.1659442254528; Tue, 02 Aug
 2022 05:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
 <20220802070518.855951-2-nagasuresh.relli@microchip.com> <3406e537-cc97-42c5-2342-cee18e8054fc@linaro.org>
In-Reply-To: <3406e537-cc97-42c5-2342-cee18e8054fc@linaro.org>
From:   naga sureshkumar <nagasuresh12@gmail.com>
Date:   Tue, 2 Aug 2022 17:40:43 +0530
Message-ID: <CAH_iE_3s9=-Lk7bk993==jJz0m8pp+GEzUZvDoH4MR_SSSCr-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: dt-binding: add Microchip CoreQSPI compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review.

On Tue, Aug 2, 2022 at 3:55 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/08/2022 09:05, Naga Sureshkumar Relli wrote:
> > Add compatible string for Microchip CoreQSPI controller.
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> > ---
> >  .../devicetree/bindings/spi/microchip,mpfs-spi.yaml  | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> > index 7326c0a28d16..8d252eb8c460 100644
> > --- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> > @@ -14,9 +14,15 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - microchip,mpfs-spi
> > -      - microchip,mpfs-qspi
> > +    oneOf:
> > +      - description: Microchip's Polarfire SoC QSPI controller.
> > +        items:
> > +          - const: microchip,mpfs-qspi
> > +          - const: microchip,coreqspi-rtl-v2
>
> This is a bit confusing and it is no described in commit msg. You change
>  compatibles for existing binding. This must be a separate commit with
> its own explanation/reasoning.
Ok I will split it and add information in the commit msg.

Thanks,
Naga Sureshkumar Relli.
>
>
> Best regards,
> Krzysztof
