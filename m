Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D054C9820
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiCAWFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiCAWFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:05:42 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2698F76
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:05:00 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2d646fffcc2so160614417b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 14:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UcPAPgfcldc73jEP+C7Dej+leQMSuSLsqYm57vv73+s=;
        b=nRakB6HmSQvAY0Kx8G5e0XiHu+lZH+cNOSVvManb39OQg5KXxnMddGx3eaTlkqCwZ1
         tD3b2Xov2F7FLOGsOzjBxOVPu9aKqb2AqpjUU1eWbTbx00Ju3UR40XNvN0l3LMy4bkt9
         Rui06CAZMrodVpaNMV5lUTT+sDBGnsNvtd0hVGWHCjSw8DlzZ7frrYemADTorf6gcuYD
         kHhnCqVDMa2qFBaQLMP27xmcmelDgZEstkQIDIVpK1HV60D9tRmgAUcp+g6b9yplwuZ+
         Spq9ZALSr6S9zZA2jhs1GuzgkujBQTV2BcBMIp2DZVmie1F4BWb+HD0OKh8S+TaUi8zF
         espg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UcPAPgfcldc73jEP+C7Dej+leQMSuSLsqYm57vv73+s=;
        b=O1qKdWjq57/lonqbDx1J9nIfeWodHlZwqOo0ceHJpjRvtWaWK7+NNaREZtL7qriJlF
         HO/kAgAfPnJ0c0xnFWpuWf1e7AY8QnDYbey8tNnpuxmZYmzoXAl1Tx0qkgNjDIonTPQ8
         /upx8lee7/BRU2oFa5udUGyKZfU5UqN+f4rNLh9Gj++gRZcVVahV2p0ec+ygJ2USn+2+
         bq/PdkpMt5n9xOpJwEclDmnvEWScjApzcVb6fgG2HKj7DEDmxwSISQboEOmLEcPj+l9l
         IPQTYj/kkZVKsAGDgLBE93ULfqzyoDn+xcmW7bHm+qkyD5jBLHxvFPtWSEoozCYaD9WK
         NPsw==
X-Gm-Message-State: AOAM532ul+92tRuogA8BvUquq4wuzc8yCglm17u7Up6NjQam941Zo5Ck
        6w/qkJHmE8guxgKgmoAofyQ1q8VYBNk4BAeD87w5DA==
X-Google-Smtp-Source: ABdhPJz0z5NUDx5yT9o5PaqMCK36QA8R6U5yziPTGeHEgqZnWomadFex96iDbgDg/IFQkrR5Udu+iKW6bIM/vAp44rg=
X-Received: by 2002:a81:d15:0:b0:2db:d348:2fda with SMTP id
 21-20020a810d15000000b002dbd3482fdamr6926473ywn.151.1646172299759; Tue, 01
 Mar 2022 14:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20220215163926.894-1-paweldembicki@gmail.com> <CACRpkda=ky29PiTjWimnNihLDHSTfYWk68qg5GcLqZTD76ba=g@mail.gmail.com>
 <CAJN1KkygDrGPzJj4nobS-ZFSRqP+g9LQ49tbcLA8V7KvPhfYOQ@mail.gmail.com>
In-Reply-To: <CAJN1KkygDrGPzJj4nobS-ZFSRqP+g9LQ49tbcLA8V7KvPhfYOQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Mar 2022 23:04:48 +0100
Message-ID: <CACRpkdaks_R11d6+LS7ER6KgS2uupO3xLunH1CxfoMiJtc2qaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
To:     =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, Mar 1, 2022 at 9:32 PM Pawe=C5=82 Dembicki <paweldembicki@gmail.com=
> wrote:

> It has a fan controlled by the lm63: PWM controller.

Aha it is one of those combo things, sorry for my ignorance.

>  But the fan blows
> only on disks, board temperature won't change even when PWM =3D 100%.
> It should be controlled by hdd temperature.

We have a way to even monitor the temperature of individual hard disks
these days and I create a thermal zone and use it here to control a fan
in this DTS:
arch/arm/boot/dts/gemini-dlink-dir-685.dts

Yours,
Linus Walleij
