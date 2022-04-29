Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4651509E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378984AbiD2QV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbiD2QVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:21:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C78D8910;
        Fri, 29 Apr 2022 09:18:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a1so9652584edt.3;
        Fri, 29 Apr 2022 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZwaQkTc1o5LY9cje9VksJcXa1qMsHgX+3VUimrZtFs=;
        b=CVkpIV1keUv2SqhspbVhT0w+Fp5rhj5Vzjp3VnkKyDosT1kJ15MpPt9M3SqqefIMB4
         wFWRpUYGGkeG9BWyeAKoDWAc//rjytdabyuGLP8K1q5vFn87cZavTt8wUrIddaSuTp3A
         yGzrN7kySTSwdc9spRRab0ZbWfK3xXDh4z9Wk7jKicLYUNhqNprtJVAwCbg/yPaWOhIu
         PlkP2e++6IHDa2Yyy73SbOZp6sf5c+sYIJmEeAhGDjALSmoN82e0OOrmCaAHpWU6J+fU
         osLNGwVBkv4WDXguSbOjG0hjmDCDCQMnLsnoEVFI6zyGhNeyRigXc0OyKQkL9Di8xREh
         Mliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZwaQkTc1o5LY9cje9VksJcXa1qMsHgX+3VUimrZtFs=;
        b=0ALdUJXhmRHMfd9VNtTenCNXn6lrjmZAAQ1xGnpj6/sgInfq/ki+95HE4Pqc4hE19j
         KVtuNLAq/1YyFlbZKW/W7ci0SEwPkFj/iiigDyD7J3y7A+JwWSLl7pFAbvJhe0fQClD/
         LqPMh/KVoLxgdzGvcPf7jat57ArviqUg64+Wm+ty7KVsJW6z97oFcKRPPre+B3AmFV07
         gqluupKRtvc4SpcGyqJX16jTnKqQR8qZiClWey1H748pwVNI/4HC6uCrq8ZBXOScGDYZ
         W9ZGcm729ihnqCVwwuVlfADdbNQ1o9T0YV3iiCEhI2xg9gYRmngDfJCHf98n5L1Njlka
         k5Rg==
X-Gm-Message-State: AOAM531eVEYLAXM95dqs4cdOoAUkza2bzF+ENSjnJZf8Y28fEZFFTuBq
        MHAJlfHTnD3PmiPcwgGA4Saty0cKw3DoEzG8Kp8=
X-Google-Smtp-Source: ABdhPJy+lgRjhfWE18W/C8VWJhYXLELXMhk5hSCHuA9iWBGstwOKMooNwOTtrtgmT8Hx7Z0akKQrLcsbNUXxkGVvVvY=
X-Received: by 2002:a05:6402:35c9:b0:426:4545:ad87 with SMTP id
 z9-20020a05640235c900b004264545ad87mr2617416edc.77.1651249114584; Fri, 29 Apr
 2022 09:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220429161347.7947-1-tharvey@gateworks.com>
In-Reply-To: <20220429161347.7947-1-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 29 Apr 2022 13:18:24 -0300
Message-ID: <CAOMZO5Do-Vy_s4m99uUTnL1sdJUhghjzZJKp4V-SG4rAK=kTzg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-venice-gw7902: fix pcie bindings
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
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

Hi Tim,

On Fri, Apr 29, 2022 at 1:13 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> Update the pcie bindings to the correct dt bindings:
>  pcie_phy:
>   - use pcie0_refclk
>   - add required clock-names
>  pcie:
>   - remove pcie_phy clock as it comes from phy driver
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

It seems you missed the Fixes tag.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
