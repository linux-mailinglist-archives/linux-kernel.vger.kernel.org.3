Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834EF53B173
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiFBBzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiFBBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:55:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76627F5FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:55:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i1so3307931plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=KOVDOxCVI4vVBCH6b+W62sk58si7BFfHeJ7dzn6m1vc=;
        b=s5yKFAmmriDWLb9h6EkYjcAfxSCrlFCB35p1b62Cj6EhSyMkO0a2ehkmVZTqrdGeQM
         vZBKwmCQN52iGZ1q0NcueIW2C3yI4Wv8/lw3qm/VWUwwvkcNslirtCRrNXGgtt9/cArz
         PzWx2JaMcKxDceYpg8ybaD+ZEqxXu50PQIkrSQLdvxYPjd2U2m+5U41nHzh7CoUCET1u
         r+BjZNF0TdnAsc8gJbJSfHA3SfdkR/2CCuGX48L88U4BaSzdghoJpkoxySrgG2ombI+3
         8OwzNEGaguj4dRBXfrgx0C8ReqAbMj/qzq04FUx9OirSe0NpdDFwxU1jB1R11orJiQVK
         aB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=KOVDOxCVI4vVBCH6b+W62sk58si7BFfHeJ7dzn6m1vc=;
        b=zzwtCFM0LT6qUZFBPVpQ084XWaDFJGaAw3dVFgiAsyF80CV7roiIuml2cris/z9Cb3
         P/l2e/ApBPJJpp/43MihCP1rwLJpiLo8diT0n5sJOWKQesPVRhFWqpsz+KhyZdmB4xBP
         fATywlpPmQDbtTR4OKBEkviIAvwQWloQs9L5TVNNyKTfiONYKJBdM0GbkoRykVeA2CXS
         xT1eghY4szN+KMIdmSrdX1PERQVL+ZMoJydsVjRx/7gsGjhUsKiS/D3CNTYfsVXkJvrQ
         3yfGMt/h6MAN9mB78BG/m228FHHnvcfmKtdm1W9HyJE+JsWssddvrOaaZSXf8nMJH2T8
         6CMA==
X-Gm-Message-State: AOAM533wCHNCMptArNg2An2IEPUvp0CQImDipfhJwJNcd8zfflopYMZa
        wg1sNOYQrlloEJxV1nUKQs2yNw==
X-Google-Smtp-Source: ABdhPJw9CKiAFJKDrfs2v3vrViEDs0+jyFmtV+AptTS5FG62SVVtIE8OyHHDCh8XJ7scvP8oNp3r1A==
X-Received: by 2002:a17:90a:6941:b0:1e2:f37a:f889 with SMTP id j1-20020a17090a694100b001e2f37af889mr21009905pjm.160.1654134940921;
        Wed, 01 Jun 2022 18:55:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709027b8100b0015e8d4eb1c1sm2182005pll.11.2022.06.01.18.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 18:55:40 -0700 (PDT)
Date:   Wed, 01 Jun 2022 18:55:40 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 18:55:30 PDT (-0700)
Subject:     Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock drivers
In-Reply-To: <d50f506c-92fd-39c2-d5d9-5eb9c60b1de6@microchip.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Daire.McNamara@microchip.com,
        Lewis.Hanly@microchip.com, Cyril.Jean@microchip.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor.Dooley@microchip.com, Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org
Message-ID: <mhng-5c57560e-a00b-4fd8-95ee-5e2fc0dcd34c@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 13:00:01 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 23/05/2022 20:52, Palmer Dabbelt wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> On Mon, 23 May 2022 04:42:53 PDT (-0700), Conor.Dooley@microchip.com wrote:
>>> On 05/05/2022 11:55, Conor Dooley wrote:
>>>> Hardware random, PCI and clock drivers for the PolarFire SoC have been
>>>> upstreamed but are not covered by the MAINTAINERS entry, so add them.
>>>> Daire is the author of the clock & PCI drivers, so add him as a
>>>> maintainer in place of Lewis.
>>>>
>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Hey Palmer,
>>> I know youre busy etc but just a reminder :)
>> 
>> Sorry, I didn't realize this was aimed at the RISC-V tree.  I'm fine
>> taking it, but it seems like these should have gone in along with the
>> drivers.
> 
> Yeah, sorry. In hindsight it should've but that ship has sailed. I sent
> the rng bundled this way b/c I didn't want to end up a conflict.
> Obv. there's not a rush so I can always split it back out if needs be.

I'm adding a bunch of subsystem maintainers just to check again.  I 
don't have any problem with it, just not really a RISC-V thing and don't 
wan to make a mess.  I've stashed it over at palmer/pcsoc-maintainers 
for now.

Sorry if I'm being overly pedantic about this one...

> 
>> 
>> Arnd: maybe this is really an SOC tree sort of thing?  No big deal
>> either way on my end, just let me know.
>> 
>>> Thanks,
>>> Conor.
>>>
>>>> ---
>>>>   MAINTAINERS | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index fd768d43e048..d7602658b0a5 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -16939,12 +16939,15 @@ N: riscv
>>>>   K: riscv
>>>>
>>>>   RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
>>>> -M:  Lewis Hanly <lewis.hanly@microchip.com>
>>>>   M: Conor Dooley <conor.dooley@microchip.com>
>>>> +M:  Daire McNamara <daire.mcnamara@microchip.com>
>>>>   L: linux-riscv@lists.infradead.org
>>>>   S: Supported
>>>>   F: arch/riscv/boot/dts/microchip/
>>>> +F:  drivers/char/hw_random/mpfs-rng.c
>>>> +F:  drivers/clk/microchip/clk-mpfs.c
>>>>   F: drivers/mailbox/mailbox-mpfs.c
>>>> +F:  drivers/pci/controller/pcie-microchip-host.c
>>>>   F: drivers/soc/microchip/
>>>>   F: include/soc/microchip/mpfs.h
>>>>
>>>
> 
