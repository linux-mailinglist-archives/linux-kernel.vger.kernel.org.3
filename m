Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD264E692A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352890AbiCXTQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352823AbiCXTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:16:44 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE48B6D24
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:15:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o5so10198988ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z0LeIn5cVeaYNuaJmEd4BGZ3EQ0592UmRlXh68ATPqU=;
        b=rgReT6OdFEsgGhaCRPpaJAOxQ6k+YnrdAp94eYBCESWg/9udF4117hEuJlxSJPOC3n
         vN5LWCw2vn6aYdBkD6+NczFFu1EH+tpfc1VIZnqq7r8Er81CQcQEKZDO/pUYZV+qFaaV
         TY4nHOcLifwed6u6PhfLO2dV4lW7CUX3RTW5DNRCY95siXGUUqLzLnpxS+Sr1LEhLlPC
         Tf7Nzx/aZikfnSscPzmqdA/ATlpTur9R3tnaKf2P67Zg3CQ7YwVbccbdJeFGgsVQq7Ni
         p0faoI9Ud6zQVy0UztMQzsFFc1RrVzsxx7JXChrdZtkJIV2n1zEsGmgHN4FADvMVWoKc
         Qigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z0LeIn5cVeaYNuaJmEd4BGZ3EQ0592UmRlXh68ATPqU=;
        b=immPdEg5HZgZoRiR91ouENgtxm7MP39F8G0Efq27p3lGwFmJd1twnDDpK+j9lXD1z6
         xDdOvWcgq7oA0G4G/x7HXcwoZNb7L2/6VVfvySBYjCDEYcEVVAU3PvV/vlc2eL5Sl/zM
         CrHmErC8Wks44Z0mYJKDqOiP5gOVWjU+AYlDzUq47n50VsF0Oux0UIIkKqvrbi2r7GrY
         jmVGUUS4lXgdT7hKqd5uLvaiI+gIKwfSeXcmqlD0TNCVDDaX9bSseN8Nk74tqx1J/xQz
         wXWWIZiNc25UH2dNtIBafy5qBk3v+c2UoZyhQh1oOrVnRjXz50DKCgjbp3rSqqsSpZPI
         jEEQ==
X-Gm-Message-State: AOAM5320zQr4fpVBsvKRVXw+wQ3Dy2PqxfA8bfnV2VJ3AHUfxVgW7gZL
        jFrJSl55kPpcPN9gRQV4Ot+LHbkcM7S7KaqmEZZaLw==
X-Google-Smtp-Source: ABdhPJz8H7eFv8w9/IGF1if3KqlcAAovm/FyVXAWyxcW0GbUNS5f/71mzOOXdpyo5cA271dh+/Kp0QW7hLfVJCLDuus=
X-Received: by 2002:a25:d088:0:b0:633:b902:2d29 with SMTP id
 h130-20020a25d088000000b00633b9022d29mr6003839ybg.626.1648149310377; Thu, 24
 Mar 2022 12:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220310140542.7483-1-arinc.unal@arinc9.com>
In-Reply-To: <20220310140542.7483-1-arinc.unal@arinc9.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Mar 2022 20:14:58 +0100
Message-ID: <CACRpkda1dpxzUuExEHeJn4i=Vcfiunj4Fmup+0y5un8peBUPCw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: rt2880: add missing pin groups and functions
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, erkin.bozoglu@xeront.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 3:06 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> Add the missing pin groups:
> jtag, wdt
>
> Add the missing functions:
> i2s, jtag, pcie refclk, pcie rst, pcm, spdif2, spdif3, wdt refclk, wdt rs=
t
>
> Sort pin groups and functions in alphabetical order. Fix a typo.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Patch applied.

Yours,
Linus Walleij
