Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625AF471570
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLKSn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:43:56 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:22980 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhLKSnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:43:55 -0500
X-Greylist: delayed 19950 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Dec 2021 13:43:54 EST
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1BBIhRKr016074;
        Sun, 12 Dec 2021 03:43:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1BBIhRKr016074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639248207;
        bh=Pz3dF9PPQep3xOaK2zujTsGDwukNR0l5tOVxlFgqOZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KUiFWipvDwZ8Z1Y8bfKJsd4WE5qDnDacidtVuFldauI8wVlxqHBV6nG+Zg87xCRQf
         zmcvA8xZWDUHarTy54hJ9g9J68vZ6aAX4vasZhoJ4AYb36voe1/4vGZdSdDbnP3JQW
         nL8Pv4DH8vJWhVs+NppDDrGKlTy5hdLDEHAMB/dYEf/rU1SuBvuYzYLKt0LMnPGAm2
         Xw/oGKMSMe0JBCK/vUnLBv5oM/SJWCdfX5Pv3BhiFKxkIkQxz+kSk0Ap82dkk/pkZT
         yeh/DH8H8opi5OM1dPeZAC6qm/DK37zYiJ7+1eBjMaYdMgAht+1H1t7QhBPwfDuvp7
         Ye8DVY2xOT5pw==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so11748137pjb.2;
        Sat, 11 Dec 2021 10:43:27 -0800 (PST)
X-Gm-Message-State: AOAM530yyzPUcfnJX/DZvlaHFAS/fyZRviZnq3ByiYVJfwsy/nlsJuPZ
        p+mEBMlgIQ0OQZLLzCp7R0WTVZkv2qirlLm8S0Y=
X-Google-Smtp-Source: ABdhPJyL0GtPOiOvMvalV61y7xQnhrpV6fE3mzvWbxGVUpwXbWtHw2KdRkuujuayvvY+zCnztGHz1dnWkEB0H6qHbJU=
X-Received: by 2002:a17:90b:b14:: with SMTP id bf20mr2480431pjb.119.1639248206686;
 Sat, 11 Dec 2021 10:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20211105035959.93748-1-masahiroy@kernel.org>
In-Reply-To: <20211105035959.93748-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Dec 2021 03:42:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASn9XD6u7-KfP6XZoy8vQLoZfU4c=SA-vNVEEqX4fS5rQ@mail.gmail.com>
Message-ID: <CAK7LNASn9XD6u7-KfP6XZoy8vQLoZfU4c=SA-vNVEEqX4fS5rQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] certs: various cleanups of certs/Makefile
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 1:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
>
>
> Masahiro Yamada (5):
>   certs: remove meaningless $(error ...) in certs/Makefile
>   certs: check-in the default x509 config file
>   certs: remove noisy messages while generating the signing key
>   certs: use 'cmd' to hide openssl output in silent builds more simply
>   certs: use if_changed to re-generate the key when the key type is
>     changed
>
>  certs/Makefile            | 74 ++++++++-------------------------------
>  certs/default_x509.genkey | 17 +++++++++
>  2 files changed, 32 insertions(+), 59 deletions(-)
>  create mode 100644 certs/default_x509.genkey
>
> --
> 2.30.2
>

Applied to linux-kbuild because this series is a prerequisite
of the next kbuild work.


-- 
Best Regards
Masahiro Yamada
