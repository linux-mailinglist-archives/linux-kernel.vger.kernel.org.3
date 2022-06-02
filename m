Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7153C095
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiFBWFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiFBWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:05:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266DC344C7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:05:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u2so5833697pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=g981gwU+QbTg1CTVTnIejpAqiSS5b7TknMhPk3HO7t0=;
        b=f+xLJvXfZ7e0YYIiiG8/GcUc8u5hceELJk7W0M5Z8D0q6oLUhThpXVrRVn4y0jhhvC
         Ut6IybYQv8Mv7pD8rhq6L0fhXEcKCpqK5E4EcpolBLU6gbuIZ/agRNZGeJ/J+3q7Y/0C
         KMrlYVsCiohb3vs++/UFKwcvaDr+OZhULyIF1n4JPP7FIb5MmJzOIH0Mu8BXBB/yWujM
         dtmgdw8M7+TUOyU3oQo2P9SyhzTEHYH9g429NAnTkfO2V6zryGGxZcIbIqqrX8PrOdoo
         QHCdFrdmVyUDhefMW3/KPJh+xRq0JAktWEE71h4yPSIu3kg3Tv1hF+Wq+bgDp0hywitT
         6B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=g981gwU+QbTg1CTVTnIejpAqiSS5b7TknMhPk3HO7t0=;
        b=Lg1dP8lyfVgAT0H2u7H+yxs0WIQOX/EcmPu/nioddxrOksEsj1jD/FjlFpQ6YmOmKH
         9enVq4sSvcgWxNaoLUl7AnY+cOFaOXK04Y2GFHNAxaA5SkwP+4r2QPfAeH4jdYO4XEFQ
         4UP90I2rbYQOCsvF9SIIFSUM2/kzAqHEtjKTVYcDAaadqEvUY9ZXLLqnYHFYZm+ZCt29
         1E+0YYXHd/SPV4t2RY3V+D8chM7hKxdHxTJzhA+OONI+lTxUsQleuQ3v19NqlouFk2Ra
         91lanlOoE02P1tWWv9raGfVgEFRrTCeotuk8RWvLtQ8iYqq3VwOXHuU9gipeCZUuHFZZ
         XLHg==
X-Gm-Message-State: AOAM5338mNxIEnJJfrMtSkz1XEyiO8McR/XnGhY189Ts65wpAv29+Tv2
        ItUAhZaUoTOj9Ut28IRCk2BsvA==
X-Google-Smtp-Source: ABdhPJxjSFUzsf4lkLoMfmFY1WMKhCTegBCaUe/romqfX3cM5aFA6cCJrrqxQjntq/bZuusWI+FpQw==
X-Received: by 2002:a65:5385:0:b0:3fa:52e3:6468 with SMTP id x5-20020a655385000000b003fa52e36468mr6077685pgq.366.1654207515548;
        Thu, 02 Jun 2022 15:05:15 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a39c500b001df6f26c64esm6362810pjf.13.2022.06.02.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 15:05:14 -0700 (PDT)
Date:   Thu, 02 Jun 2022 15:05:14 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Jun 2022 15:05:13 PDT (-0700)
Subject:     Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock drivers
In-Reply-To: <20220602163152.GA22276@bhelgaas>
CC:     Conor.Dooley@microchip.com, Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
        sboyd@kernel.org, linux-pci@vger.kernel.org,
        mturquette@baylibre.com, Paul Walmsley <paul.walmsley@sifive.com>,
        kw@linux.com, linux-clk@vger.kernel.org, aou@eecs.berkeley.edu,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Daire.McNamara@microchip.com,
        Lewis.Hanly@microchip.com, Cyril.Jean@microchip.com,
        robh@kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     helgaas@kernel.org
Message-ID: <mhng-0b996c2b-86e2-4997-86ee-5510337ee460@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jun 2022 09:31:52 PDT (-0700), helgaas@kernel.org wrote:
> On Thu, Jun 02, 2022 at 04:39:08AM +0000, Conor.Dooley@microchip.com wrote:
>> On 02/06/2022 02:55, Palmer Dabbelt wrote:
>
>> > I'm adding a bunch of subsystem maintainers just to check again.  I
>> > don't have any problem with it, just not really a RISC-V thing and don't
>> > wan to make a mess.  I've stashed it over at palmer/pcsoc-maintainers
>> > for now.
>> >
>> > Sorry if I'm being overly pedantic about this one...
>>
>> I don't mind. Maybe this should go via Andrew next cycle or w/e?
>> There's obviously no hurry etc
>
> My turn to be overly pedantic :)  IMHO there's no benefit in delaying
> MAINTAINERS updates.  There's zero risk, and delaying only means
> people will miss out on bug reports and other things they should learn
> about.

If by "delay" you mean wait until a merge window, then I definately 
agree -- that's just more cofusing for folks to have defacto 
maintainership outside of the tree, might as well get these in.  It's 
not like a MAINTAINERS update is going to introduce a regression or 
anything.

I'm just delaying because I just want to wait to make sure folks from 
the subsystems are OK with the updates, as these aren't really anything 
to do with RISC-V so it's not really my decision to make.
