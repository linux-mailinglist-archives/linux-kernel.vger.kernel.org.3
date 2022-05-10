Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB19521E38
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345732AbiEJP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbiEJP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:27:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDFEE86
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:17:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a10so1386739ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2B5Vkl7TFzY6huBpLT1bUz9mIIjjQyx9+L3zupaHP/E=;
        b=kUfXtfH9Zonopkyd79eaW/m77x8S8R7qo80V2tCzd9JOlsQ06sdS6sGJbzM+8yjoY9
         m+XmvO2xJeWlqHJCjJolAYENtfzZsaFEyw9wyzc8MkO4WDZFWa314wUPVIzlmiJZcjA8
         VQfnOVy24KVA3D8ezVnljqbKm7hf45os3aX2XsnlqxxgyVXhS8VR8x3BgIl/nQZJLwgg
         vgmojE5RPPTRhLfcnOtVuaoWLYWu1oWkbxVCczSja7blDxGU7Atw8m9rLXFuPyURmTzS
         0YcR8UNLAn6IeEZCHKZIato4Lg8ssgcXXg7k19XYrjBpJCes/KX4bqJTTHAgv6h0dS8s
         Qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2B5Vkl7TFzY6huBpLT1bUz9mIIjjQyx9+L3zupaHP/E=;
        b=s+vDTC5WpJ/Hw0iXP/cnN9PfuL4VwDZNeq7Ck6WazV92QtdA5I9IC8GrbjhMb3R6d0
         GE9nVErgJyyHPdhkZB4wXvdZXMaRtOthEDrUpCvtZALvBVTcXbgEHf/ztry+dA2vIGcR
         EEnID4wf4E8ItlcoIbSfbCQVnmWnkW5dSgvEXXhYzFouzgE0oV4Henup1jAeKXXF6GlH
         0B37xM8nI9rwWD3e9vSVsLAHg40ZVFHAm058+eZ9VTUoC+eTJKQfhk9qGX7vCE679Dge
         kO1kFte4KK5VMP/GPb48hKAORWE5pbjYcoXGmV6cRFHKPvS+vXAQoptZhHqZ3Ar6hQGt
         W4ww==
X-Gm-Message-State: AOAM5333SDWJwoa7FmgBldDOj5e0TGbzEGKOheIdNHQRbQ39XDTqQbqo
        934giW41HEvGVtGqE9IPOwUlojCZw8EHeECRTPilBQ==
X-Google-Smtp-Source: ABdhPJxNspW+ngbi0U/I2ZjEzZydwyZIbEbjDc4pUkE02twM2tokN7gph1uMIPpmqO4/YO1WsuVpjI+o2sl2PzHACAA=
X-Received: by 2002:a05:6638:3288:b0:32b:5f8e:19f1 with SMTP id
 f8-20020a056638328800b0032b5f8e19f1mr10407822jav.248.1652195845296; Tue, 10
 May 2022 08:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220322105857.1107016-1-robert.marko@sartura.hr> <b183f838-359c-752a-dd23-9bd1a160eee5@linaro.org>
In-Reply-To: <b183f838-359c-752a-dd23-9bd1a160eee5@linaro.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 10 May 2022 17:17:14 +0200
Message-ID: <CA+HBbNHJtHexMHUiZ8d-OStCP57nbDXhQtgL+hvjQkA2FFsXZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: uDPU: update partition table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 3:56 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/03/2022 11:58, Robert Marko wrote:
> > Partition currently called "uboot" does not only contain U-boot, but
> > rather it contains TF-A, U-boot and U-boot environment.
> >
> > So, to avoid accidentally deleting the U-boot environment which is
> > located at 0x180000 split the partition.
> >
> > "uboot" is not the correct name as you can't boot these boards with U-boot
> > only, TF-A must be present as well, so rename the "uboot" partition to
> > "firmware".
> >
> > While we are here, describe the NOR node as "spi-flash@0" instead of
> > "m25p80@0" which is the old SPI-NOR driver name.
>
> This patch was applied, but it was never tested with dtbs_check (nor
> rebased on my cleanups). spi-flash is still wrong.

Hi Krzysztof, sorry for that, I did run dtbs_check on it but there is
a whole forest of
warnings about schemas not being matched as most of the bindings are
still plaintext
and I missed this.

I did correct this to flash@0 in the eDPU series that was sent out today.
Regards,
Robert
>
> Best regards,
> Krzysztof



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
