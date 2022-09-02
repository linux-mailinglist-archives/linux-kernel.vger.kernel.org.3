Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98E85AB156
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiIBNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiIBNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:22:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5539474E2;
        Fri,  2 Sep 2022 06:00:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x5so1339216qtv.9;
        Fri, 02 Sep 2022 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GaKGM+dpPVOcKQB0I709BWsCafKACGVR73YUNmM0p9M=;
        b=MzOF0SUMu+LWHqJesHluUKrd/Yms+3BJ4yiX8IZ4kldKwlXIPY6KoRbCzBQ0E9owFd
         FOSw0LJFW7lY6uNW/5x4vetN/h3aNtuJDktsTt3UxTRjcBEIBqnLW+Hkq5QV7OJWSV4K
         0ON6XAsbrJLtCVL/5ZilEYsRB7NT3LyKzCjY1RGXUS9kzZmlwR0ZgGBXWCDeyojdnOVs
         1KUiQMtmLsMbWJ9IE3sCwx6L5p0vlRMSAKSg/Ev1evlOODPx6m+94MdrNxZ8u0qblaQN
         I/lErX1UA2O/VGKoZLA3AYLgVIFYbMTFI72OWZSTAgWWoJGo07vEfaKmwoGTGCDAGXD0
         7oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GaKGM+dpPVOcKQB0I709BWsCafKACGVR73YUNmM0p9M=;
        b=z9ld2/Sfz/fn+kvw07RxRqpVlGGTHfpK/s1XNAA3oYybZ5TRflFnMCh43qwa5biHwV
         QL/6poAGbe9ASOWCKilSFFSnVXiLLmactlI9bM/7CNWNthVNLTKDcvBtK2kcxKcAwueL
         4VZd9uEDA/yuHDaWm6O8QM9Sy+b8ZbRBjHnW8psyhAXdx+89E1qbC7KT1iroedPp83wR
         sEXMgMMT7frJTunMh78X2aJPOjeQBfKm+TEN28H3OPrry8TyJnIGGmyuhDZOxfmH8fQu
         J9kLg1t3dFYgpvzvEn0WyHGfEpG1PPjK2vBFWUrVGFj+nMS/wmiGNdsbCca6I9UuGlvS
         IL2w==
X-Gm-Message-State: ACgBeo1hC13jLychm0VHIhMolreLNXNewH2CZIq595+C4KbTRhReI1Za
        rN1BbK943HSh9X6dUegKjcbrRxWyL0k=
X-Google-Smtp-Source: AA6agR6ukfEivBRMBVS78MYzMPw2RtR4O1lu1dnKDXXluEBnn1qLr4Sdq/b8RyCi0wQaMU5oUvbymw==
X-Received: by 2002:ac8:5995:0:b0:343:77a0:7c39 with SMTP id e21-20020ac85995000000b0034377a07c39mr28186140qte.663.1662123450255;
        Fri, 02 Sep 2022 05:57:30 -0700 (PDT)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id eb2-20020a05620a480200b006b629f86244sm1209868qkb.50.2022.09.02.05.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 05:57:28 -0700 (PDT)
Message-ID: <bb4804c0-04d2-6e0c-b9db-1243828ca515@gmail.com>
Date:   Fri, 2 Sep 2022 08:56:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v6 00/10] Add support for i.MXRT1170-evk
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
 <CACRpkdb25ikL4F499NDCrv1kf2FGvJxqDW2wk9GNQCqrbX9kKQ@mail.gmail.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <CACRpkdb25ikL4F499NDCrv1kf2FGvJxqDW2wk9GNQCqrbX9kKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/22 04:06, Linus Walleij wrote:
> On Thu, Sep 1, 2022 at 8:33 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
> 
>> This patch contains:
>> - Update to imxrt_defconfig
>> - Devicetree
>> - Clock driver
>> - Pinctrl driver
> 
> No it does not, I already merged that.
> 
> I think you should probably split up your series per-subsystem so the
> clock bindings and changes can be merged separately etc.
> 
> Then the DTS files can be added to the ARM SoC tree as a final step.
> 
> When you send everything in one bundle like this subsystem maintainers
> don't know if they can merge e.g. just the clock patches separately
> and be done with their part (like what I did with pinctrl).
Do you think its possible to add Docs for Device tree compatibles that 
aren't added yet?

Thanks,
Jesse Taube
> 
> Yours.
> Linus Walleij
