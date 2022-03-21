Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2234E3252
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiCUV1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiCUV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E73476DC;
        Mon, 21 Mar 2022 14:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728526123B;
        Mon, 21 Mar 2022 21:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE72C340EE;
        Mon, 21 Mar 2022 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647897909;
        bh=AKwmwLhwJETomCoi21Fza1mV0uLKeQfDm9gRO+vTHvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MPxIKdPtpK4j7VKUCmDV+2tDsGY9qCuYZpT+uubn/K/7ZK4NFb15xCb7hlq9Udn/H
         MyPl1Bk+q6LddZD/d1AuanZomshNMckC1t6J89dbe9aPrfrj2jV4VFMJ3LFFxatinG
         8nGAUkv7JdOv+NClrOsXYg45DTg1HkU6jx8Tah4NtiEPqFXEyrdreKugKQTkRyWKrc
         kbzZnCeF2Un5lZJqo4jqCFdILkwrWDyU06wV1wmVZsTgJcdUOiSAOHWV7SefJETDcd
         d0N8EVw6gxjuXcIzFplBRj+SKCagjPJi8dToTNjOutjni0pgTncZZ2AW7rlyvnpKQx
         iX6oJ6aiNI/GQ==
Received: by mail-ej1-f53.google.com with SMTP id a8so32466468ejc.8;
        Mon, 21 Mar 2022 14:25:09 -0700 (PDT)
X-Gm-Message-State: AOAM530UiAgnZOXXy/T2Qgqek3nLWgM81QfN7gURhHXNic1iW4KlyRmM
        mZkSd3BqKY2JkMoOqSZuzLMkbWejpS7r2+fJFQ==
X-Google-Smtp-Source: ABdhPJzcUrtfN5C6Cp1DYIuKWWPjCKj++GrqTdBuxiMIr8dvQj2FvXNQlVmjtpr5ucAsK90IFEeDROYXBp42Lkqhk70=
X-Received: by 2002:a17:906:5418:b0:6df:a07f:764b with SMTP id
 q24-20020a170906541800b006dfa07f764bmr19268057ejo.27.1647897908076; Mon, 21
 Mar 2022 14:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com> <1647237097-29172-3-git-send-email-hammerh0314@gmail.com>
In-Reply-To: <1647237097-29172-3-git-send-email-hammerh0314@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Mar 2022 16:24:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzbWejb0=XY+xi17n3P1QHWgHYhY1vM3cBBHOqRQ+4xA@mail.gmail.com>
Message-ID: <CAL_JsqJzbWejb0=XY+xi17n3P1QHWgHYhY1vM3cBBHOqRQ+4xA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 12:51 AM Hammer Hsieh <hammerh0314@gmail.com> wrote:
>
> Add Sunplus SoC SP7021 PWM Driver
>
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>

Your message is corrupted because charset is set to 'y' which is not valid:

Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

This is due to git-send-email asking you what encoding to use and you
entered 'y' instead of <enter> to accept the default of UTF-8.

Rob
