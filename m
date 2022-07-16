Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6438B576B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 03:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiGPB7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGPB7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 21:59:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8E474E1;
        Fri, 15 Jul 2022 18:59:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 72so5919367pge.0;
        Fri, 15 Jul 2022 18:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tCv2d0jz7aYxXtvOKKLsPUo98p8UBRB5mwniLXluyp4=;
        b=qeMVe6ak4TXh288JdIVjZYsH/7dCKTDxWI6KAS6pAAAO5imaSHwMUcL9DHVrxyyU6l
         ZUxzdWJF47CtMW2AIdV/18KOD46vZAnJoinwziSjeLfg7c3LCxdKCCrNAhdzqwBfwmK+
         RqdXRx47FSOpbeZloyQE//IzAg/Swu+EwLDdS0jptsFB5Upx875a532MJYr2fT2iiHmb
         xY9OVvmanm54CCh9c29+dGAiYm98ydqRsh71kzuRXGvACLxLhra/xkC02T1jDDsABBbq
         qPRkT/+EywgCB1aVX5UyS9ZFMH+dQ+DtEJ/uP6Ys5rK6tmHkw7eIGTQ0GtIRL+kNIyWe
         ekrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tCv2d0jz7aYxXtvOKKLsPUo98p8UBRB5mwniLXluyp4=;
        b=bIlR4HzfagV36ghjtohsrm1bu0Rdeed41ptWnCeqeq1+oW8675gg7X7mEZXgpppijJ
         YWofRF0Dj32bqoWmvh0KhoO8x3vwt0ttGu9O0qavmPkp+zGb0cpanVjKlqXjSiHjnz22
         OirIhROgmM9U05jzLLobEOQTzNYE03Kcd+C9GLmy1VDUvH/T3RszWlPW86HN42WvBdU9
         wzEjeLZGy+aRxd2rO92GoPFMLB9qeJlRMoTH7H6FlJjAJDSKONveV/qDntqzynPLcJNB
         1LX1XTrb3UPBYOuFV0l0LvOgTkdnGsi58pPvgNpd2etccwjgZ12h2mWNPTGZYwD0fzcC
         e+/Q==
X-Gm-Message-State: AJIora8vsj/bGXlhlCVAe7uGWhCEszjGd19wi8vgrpkkhX+0+NjCqHRM
        cKXfXMEEZX2RSKXp4rUqwKkzgLGFMNg=
X-Google-Smtp-Source: AGRyM1s+NuVmm68uI+GX5krCVPdfDhjpnZUKMVrE+QW2HvW5pJGCRGNQG4OC7/rTUY+Y9uKPIYdf6A==
X-Received: by 2002:a63:1824:0:b0:408:a22b:df0c with SMTP id y36-20020a631824000000b00408a22bdf0cmr15113286pgl.119.1657936754785;
        Fri, 15 Jul 2022 18:59:14 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902779100b0015e8d4eb27esm4205420pll.200.2022.07.15.18.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 18:59:14 -0700 (PDT)
Message-ID: <043cec12-b719-e9e6-d234-fe6ca75ca894@gmail.com>
Date:   Fri, 15 Jul 2022 18:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: build failure of next-20220715 due to "No rule to make target"
Content-Language: en-US
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <YtH53r9UcYwquxcx@debian>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YtH53r9UcYwquxcx@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2022 4:35 PM, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> Not sure if it has been reported, builds of arm and arm64 allmodconfig
> have failed to build next-20220715 with the error:
> 
> make[3]: *** No rule to make target 'drivers/pinctrl/sunxi/pinctrl-sun20i-d1.o', needed by 'drivers/pinctrl/sunxi/built-in.a'.  Stop.

Caused by f6e42a0fce98b85380df8cdfb081d75c48e4fee1 ("pinctrl: sunxi: Add 
driver for Allwinner D1/D1s") adding CONFIG_PINCTRL_SUN20I_D1 a build 
rule in drivers/pinctrl/sunxi/Makefile to build pinctrl-sun20i-d1.o but 
... there was no drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c file added to 
the commit, missing git add presumably?
-- 
Florian
