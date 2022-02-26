Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412014C5600
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiBZM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiBZM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:59:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7926101F;
        Sat, 26 Feb 2022 04:58:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so15885624eje.10;
        Sat, 26 Feb 2022 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlsFotNs7NusnH+YkNEeGH7B3RozVLtGsx06+XCxfNE=;
        b=Fx/ueQBHZCn6hfYxQmFnnN9jkh4jshVW08w+yT0FHAe0wI3vD2U1K1jNBOY93R29MK
         jJ6w1Mp9xveTtwFio0Oj0GSm6KOu+r2JiSz86H5DM1pv/WbvXJdbSlWc10mt/gNURydw
         N1Rj8v3i6z/n6ra2qeWS82ud792pVEgRPn5IFFYEp9mwX/zCea9d5IR/QT1Z1vHqliXI
         39AzuY/dOD5iOZEitbmULrJo0et68GYwMIOCh22Tj+n7vSyvFjDj4rX85tlEmwpQirnI
         vhWDY1yQKKjFJwoxZ8D8/vEf/l2wWP4tjhi1qWoOJFdcA98IlgY8gMXJGqCu3i66Cs2p
         fGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlsFotNs7NusnH+YkNEeGH7B3RozVLtGsx06+XCxfNE=;
        b=bFZTrKKnLy4dip+uZ3vWzlyKXr346KlIDhpV69/QANzD08pQz3B8jfi1bFGuf05CAy
         zzfpiT+XyOCvTMuOTjbAnUq3446x5huM1hIM0mF3azSVmLWTyNgFo8ZNZelYpdeY6YPe
         U23m0V0pOFNdLNH+ndxhHaIC7jyAriSlqyB3CzdTfINP5hNt8NTD9ypAJKma7v3gfWmm
         yz6hHaBEWExRDm3dTGVTyZNIroWf1Ft6degNds4xzsurcsoRyS0L/VSKPVleqM+KeaCm
         aekHw3R2dxr/mYGB32eeA/J4IKIN5nV8e+FepJGcb4KFsBP3MNCHVueHrylOkxIU+DJs
         WDzA==
X-Gm-Message-State: AOAM53135Q0b+hnsfgqg3zuEdl/IVv5Ve32DPJbjiU5Q/DngEHrkInvI
        dL4xbMAxDbcRfs51QTYznyE93/9nrcZCpuLGVgg=
X-Google-Smtp-Source: ABdhPJxFYmNs2ovhTw6Xe1UMX5q+vmvjpLAfFISeO+5OSUn5VZrj0q6bnmsa8kbDBGWT+A+GlBBEdqm8PQJMpE+SYGg=
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id
 i6-20020a170906264600b006d5d889c92bmr9732240ejc.696.1645880338546; Sat, 26
 Feb 2022 04:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20220224103030.2040048-1-michael@walle.cc>
In-Reply-To: <20220224103030.2040048-1-michael@walle.cc>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 26 Feb 2022 09:58:47 -0300
Message-ID: <CAOMZO5A2WeSB4GWZTqxT4mHjvVs2jgjUnZM-K2cPy3SBic-L2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC outputs
To:     Michael Walle <michael@walle.cc>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Feb 24, 2022 at 7:30 AM Michael Walle <michael@walle.cc> wrote:
>
> Use the power signal names as given in the schematics of the reference
> board.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v1:
>  - swap buck1 and buck2

Reviewed-by: Fabio Estevam <festevam@gmail.com>
