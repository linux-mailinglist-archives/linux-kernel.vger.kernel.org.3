Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83554E2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377528AbiFPOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiFPOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:06:19 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB693A190;
        Thu, 16 Jun 2022 07:06:18 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j39so1327471vsv.11;
        Thu, 16 Jun 2022 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JUULulfM9V3i4mc0Qk3Fyd0tY8etkNL7XV8IGF9DSrE=;
        b=kysGHKukDg4XMjD4OLhsvtuLWXFQ61YSTEXXgfqMZzMqlzrn0pv75Tam324szHtDEF
         rY62flO8fclLIYnk+a5XxNiU6vVwfKX5OPDwSN4qMiUq79Tf4gHezhS8SHfosCg50kp4
         Adklg4i5ngL8Jb2RXBXMycxQbaKRl4dyqB02+OWV+XaQhGxbsHdnueekaF0q9wOnJnru
         I8JUiJZ7Nj35wcVIgtHtUKkqJMsXPAs6oLJivCs+4pbAMVx3UR6zeMcFFPr/96eB0w8M
         eosYsUWMU8q3y0ob1cUiZLB7loTq/c6zIovkV4hIu1ARYfGg9wk/TmQdKG5FCj9xIhH+
         ptHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JUULulfM9V3i4mc0Qk3Fyd0tY8etkNL7XV8IGF9DSrE=;
        b=oNG+kxY5NEyM51vHcYj6xYjsyAbYRHmsBUBN90XXX2WtY9BazpKVozga+BYq27fFsB
         4VZIFjyhv30alNdEcA85rleAPnOzMA00zMHgrDFII8HkTvqfyp2OumYWb57xgxPjKMVA
         hfc0iOFIQwylJWPIQ9XyWcIudxq7sux17sPWTLNUE9ZXA0phbUBsTHFAN+l0TCQ9yzW9
         yhakVwSaF7gz8gsAP1HwaDBwkfGKyBUYDy4vq8yx3QsBpl1Dwo8w+Z9dmApeCp5tmeRH
         b5D1gYRekN1q4ipA6GPLbmZdfvE7ZZosXlmpl/K15FrThLCP8CGMxehF3udFu/FT/l3I
         ietw==
X-Gm-Message-State: AJIora8b4z+sngP9asg/THt9OU2OJfdSsoN1utova7ljbaI+OmF+J/bL
        Sft03BIDY3jmkUeowSb1pARR0q67f3uvVECiPIg=
X-Google-Smtp-Source: AGRyM1unyKfmVhWgwuxtF8J5/hxN+M9gIQ3jnyeEZM0vuiXBmPJl4kaVG08XPnZwDDjkKlVjJRiwJgm64kOa5/W+CTo=
X-Received: by 2002:a05:6102:10d0:b0:34b:8e3b:4e6d with SMTP id
 t16-20020a05610210d000b0034b8e3b4e6dmr2531370vsr.18.1655388377533; Thu, 16
 Jun 2022 07:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-2-romain.perier@gmail.com> <8293b455-1150-edb5-9005-fda4f2d2971b@conchuod.ie>
In-Reply-To: <8293b455-1150-edb5-9005-fda4f2d2971b@conchuod.ie>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 16 Jun 2022 16:06:06 +0200
Message-ID: <CABgxDoKnwn7QESkKKm4Q18oFbcmmfYn2ksVetofvNpnfR-XDTQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree
 bindings documentation
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Le mer. 15 juin 2022 =C3=A0 09:25, Conor Dooley <mail@conchuod.ie> a =C3=A9=
crit :
>
> On 15/06/2022 08:08, Romain Perier wrote:
> > This adds the documentation for the devicetree bindings of the Mstar
> > MSC313e RTC driver, it includes MSC313e SoCs and SSD20xd.
>
> I figure the RTC is a copy paste error?

Yes it is, whoops, I will fix it.

Thanks,
Romain
