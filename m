Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB544FB48D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiDKHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiDKHYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:24:22 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB27038BFF;
        Mon, 11 Apr 2022 00:22:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 75so7108329qkk.8;
        Mon, 11 Apr 2022 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cle8K5S6vVtn1JXrhhTeWuHVXYaRfpQzQC3UXOxjSXQ=;
        b=Y6h0WBWvhdDrbLDKkIlt6BolxlUasB2v7HT2X+21KUGqBKjhk1WZuiBYUSN8BfVhOp
         GaqIaIM8k3tsr4V0pLaDITzBcEuIq6aCgmETg4vEt4ivazuNeB+lGHrgekpApesOOFQy
         NnMjkWHqqW05oMFKsnFutvWZD9q9T0JZi9YDUFddgGk7h2L4teMediK1sFIGpXJqguLH
         Jp9V/NxmQ5x4HfvZrjzL6RsyKWVBLjZKmA5vbu2uDu9eyUkKNP84a8XhyW2JBv0vIS8M
         3/l4Qvg9LXXmyZayEaK0PH9PiN1+OUGeei5LRrVjGw2kYr9S1vXTIlMB59DTEokwdXw+
         brbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cle8K5S6vVtn1JXrhhTeWuHVXYaRfpQzQC3UXOxjSXQ=;
        b=jSgeqyNcm9zP7OuHgHakvr1s0M9B1g7AR0JbPTd08/j/J6ulUrC48QmruoR6KoNMDX
         rCzBxKIQnHEb+uyizraiFa0P/6hH5LD50/jcMOHBW659+LbaMuOclL5QtsYCQCp8FApj
         yfcV5AeXOCSM0j3N6noW32rpDXw46cRBIHyL4YH99FFdNq0snmDgL+8vWa5u8XEMEtyV
         38I+WvOnTDC6KRskOwO9vvRXqnXB5ZfgHrS9eMsFGxaocQnY+z3fLsG5cAmOchMqAmAt
         qOoDq7whxX7j5u2PNCDDBPh8buwAGNNCF5mpYZjE/sgXeWRy1J9nG3o5kJEkpwJUYOXp
         1vkg==
X-Gm-Message-State: AOAM532s/L1gkcO1rFAvi/zBpBEDwC3E/zrTP5s6S/bXhupmfHPZCJUY
        qY/m705HZav6FDv2H/ldO7sGqAV8CJx3T04xQNI=
X-Google-Smtp-Source: ABdhPJxLRWIxX+ylSeHh5gNn/W0febTp1WSbgiRGPMA2M0haLGbHDuacQuJmqW/SsTB2vLUtNxHD7kryu35rr91PuUU=
X-Received: by 2002:a05:620a:bd5:b0:67d:15ed:2fcd with SMTP id
 s21-20020a05620a0bd500b0067d15ed2fcdmr21096563qki.81.1649661728137; Mon, 11
 Apr 2022 00:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220410203138.22513-1-arinc.unal@arinc9.com> <20220410203138.22513-3-arinc.unal@arinc9.com>
In-Reply-To: <20220410203138.22513-3-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 11 Apr 2022 09:21:57 +0200
Message-ID: <CAMhs-H9yu-DS_7jHitHg4=0qQusQMN0LqA++k0nJFt0q7z-GzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mips: dts: mt7621: remove binding for defining gpio
 function for pin groups
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 10:32 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> All pin groups function as gpio unless set otherwise. Therefore, remove
> this unnecessary binding.
>
> Tested on UniElec U7621-06-16M on OpenWrt.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 12 ------------
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 12 ------------
>  2 files changed, 24 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
   Sergio Paracuellos
