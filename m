Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430B552A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbiFUFmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiFUFl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:41:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50F15726
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 22:41:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f65so12121930pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=JmpuQ9VWTtePgeT5vmI8RTcy+6u4iepJuQi1T8hAzCE=;
        b=ExYKIPg6B+8i0yV8z3AXEupfe/yp3p/1qrUlQrL/g22PV9q7Tmdih3pjt9EYIWlOn7
         Fj870vzTZ0gOo4QsFJiMGU8nqdaTcjNdsIk4WzK2CmOTRResV4Nbk6IGfYuooKTwG69x
         DAap0AP30T/VCKWpRd9ajOcy0BHbTGuQP+xchLnHh3HAs/JnSeZVx67Nab3Cg38yVcwy
         F7rImXphOTn8LjtQng0rt+7h7VGacRKErfMXgOjCkAH/r7h2emdz7eg60w+RqNOYzYYR
         eQ9a28kMwdP1ANJAR361TyLH6v1S9LZ0M3AnSeMdNY0Z4eO5psJmMD2tdepK8ts1jZTQ
         RAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JmpuQ9VWTtePgeT5vmI8RTcy+6u4iepJuQi1T8hAzCE=;
        b=kOd5M48yjH3JZI12KgA27lEW0aVe7V7uwLYR0Rm4CCjkV8FR+taVUovPPHBhbMBnkn
         tCRkD4kWN2yPiR78m6H2iP1GjLZWsS4YnlWLmdFa4ljju0HWYZdYZec8o8I7KzZHOugT
         D+mqtKXuwEEUPVMFPKAKwy5Enq8YCf9yz6GP9GlsH4TDR0rSBaWooEcdbI7XtkHgtP3W
         SKFpyUTPMAh2Uy4zZuV+PPau+AVIDfNSs3rzcgojP7LHfiuiIAU7eymErNH0WLRfUpdm
         x3TGzx1TPnq22C6iYQgOjMJZ41fSkB/scu/qqz7EKfbcwp1LwQvxEHtkRuYqWPIW5hSn
         fmCQ==
X-Gm-Message-State: AJIora+uVlVsNukYxzLbtvSiyUOqxIPMNIKyJsNfu+PLsVR5kvwRRvk5
        a5ChDmy1EWE2ZEHVdcD/i2Nok1e/c6j1zdWuL22eX/O4bzSfPA==
X-Google-Smtp-Source: AGRyM1vgLUFf4khSDVzvVbtSOae8P6KHuppuAGNG6joBgsHYKi6oFV/Lud7FuieWaWHoghtzUDhnrbYv/taunQ9EL6o=
X-Received: by 2002:a63:734c:0:b0:40a:88ed:dc3b with SMTP id
 d12-20020a63734c000000b0040a88eddc3bmr23448221pgn.244.1655790118090; Mon, 20
 Jun 2022 22:41:58 -0700 (PDT)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Tue, 21 Jun 2022 11:11:48 +0530
Message-ID: <CAFf+5ziP3GBTk4UKnVGBUByGyAD-pAxkz7hTESJk+ZTRaFb05Q@mail.gmail.com>
Subject: Simple but sufficient .vimrc settings in case someone needs it.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple but sufficient .vimrc settings in case someone needs it.

set hlsearch
set ts=4
set expandtab
set shiftwidth=4

set autoindent
set smartindent

syntax on

set formatoptions+=r

set colorcolumn=81
highlight ColorColumn ctermbg=black ctermfg=white

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
exe "normal! g'\"" | endif
endif
