Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E207D51678E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354233AbiEATsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiEATsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:48:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7B10FD9
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:44:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so24441923ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lSkWyJ22j/Gy1+rBPKEz6ICjIB7fl5dNRWyogOjMNiA=;
        b=F9jEL0m5dCExabt9JtdIhocs1L9i3dnwB2TDZqj2ap6Lq+zXvHZ6rHaxGaMOzJDjvI
         kMMdgwzfDyl3DBbW7dmg8TRcHv3hwSG1wTbl8jHJvHExvCr4azznQuC0sT5XTFE+mI/a
         2NT2CkJpVfMdv2oyovIOLaojlIf7wM4Iw6WTvb/mHTgEd1k2QSHOoZzmgDr3uNwyo64y
         aOlVwJEmJasp4nv1V46RVWkxbEwG79jS99v+Sq+5CALFlisDqdlWJy3n/CYcIVD2FWBh
         YHEz0/GiK25AjEBGws1JygK+td5Kfq8pu98IqWQHVbzgCYKCXGAG6XrcLLqkYNFsylEF
         3CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lSkWyJ22j/Gy1+rBPKEz6ICjIB7fl5dNRWyogOjMNiA=;
        b=EDNQybNKW3isc6Z7yvJU4qXmEb7aWBjmqgcPGvwpZBbwm0o1z0csHwVQD0aHIw8L9X
         UGpCKpcpMZYrYWe0Pox+/f4y2hV9pfVcI3W5tVxv1uGD0oq9gHT4rr5M1G1M5mH2mSr3
         I3Ls+v6AXvEbi540u+F9ulEE4bnVO6LbgPBYlOTs64xbowGWFUaENvYdmVSBzXznWcm1
         /XozYJhwX8p+V1+VwGHr/ZFhGtPeMisZ5yi/+lOU3tAnR6mWRdVH/jWPE457a48jmosD
         VS9xw8ypJTxsgzxBmgHFmXAnuQvQ4u4YCEa5583trBApE4km55LQjZbxcOWybOXLMmlI
         4xAg==
X-Gm-Message-State: AOAM530OwxXBV/aFg+vsEOCh23Cx6StkFGr8rFTSLO/K91nc/9l1vQF+
        DoGY6/e3uV01+JZmKktpQGk9C5lNH6qL8gqOIUU=
X-Google-Smtp-Source: ABdhPJwzwsI+XJN31grZYG7NyEU0V0hcG4a1Fj6YmOYwOlEwwGACzdjSwvtwWqOAYxPX3hRzUK5vgehrAuAUhgD0cgY=
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id
 la21-20020a170907781500b006ce52421280mr8716226ejc.217.1651434293566; Sun, 01
 May 2022 12:44:53 -0700 (PDT)
MIME-Version: 1.0
From:   Ozgur Kara <zgrieee@gmail.com>
Date:   Sun, 1 May 2022 23:44:42 +0400
Message-ID: <CAOFRbG=mGdbR72moLtW87ZQW_T1HkhZtcpHRGzZy3NZ7afGVqQ@mail.gmail.com>
Subject: [5.18.0-rc4+] report: kernel compile
To:     linux-staging@lists.linux.dev, ozgurk@ieee.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
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

Hi,

The v5.18.0-rc4+ kernel was automatically tested.

Hardware:

Asus TUF Gaming (notebook) - PASS
Samsung RC530 (notebook) - FAIL (1)
HP Compaq 8100 Elite (Workstation) - PASS

Intel(R) Core(TM) i7-2630QM - PASS
AMD Ryzen 5 3550H with Radeon Vega Mobile Gfx - PASS
Intel(R) Core(TM) i3 CPU 550 - PASS

NVIDIA:

1650 - PASS
1660 TI - PASS
1080 - PASS
1080 TI - PASS
2060 - PASS
2060 Super - PASS
2070 Super - PASS
2080 - PASS
2080 TI - PASS
3060 TI - PASS
3070 - PASS

Motherboard:

MSI Z170A GAMING M7 (SSD, latest BIOS) - PASS
ASUSTeK PRIME Z270-A (SSD latest BIOS) - PASS
Gigabyte Z370 HD3-CF (SSD latest BIOS) - PASS
ASUSTeK PRIME H270-PLUS (SSD latest BIOS) - PASS

Architectures:

Raspberry PI Model B - FAIL (2)

Fail Log:

+ nvidia driver fail.
+ scripts/Makefile.build:497: recipe for target 'arch/arm/kernel' failed
