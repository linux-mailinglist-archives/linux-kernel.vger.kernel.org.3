Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14AC588C80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiHCM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiHCM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:56:11 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E15587;
        Wed,  3 Aug 2022 05:56:10 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32269d60830so170522757b3.2;
        Wed, 03 Aug 2022 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWhjdMPdPPg7+dOLGXKMH2CRK7zvgPgcjni/UiTUnR0=;
        b=B1KkRxiz4Q4K/gShbyOzuKKvvY2U/eaX4Rjgr94MRF9bcHDz85vYabWR2Aqbm3iIzr
         Lrt/NlS+EwTni+1DWU+Z9vW+V9t7QpCG4cyjgVzik3rPZWvZDzz9guyoK26zhyFJXJeA
         LeQiU8LOS/zlVMkd5+8AmuzLmL4UK2F6izkYoAYb2vzCco0rz5sUazXYjDyNwvCjrvc2
         aBj63GUdvpIS7Kbh4mT5xf7ZVz1TZC3KJLwzfwHvONtYiqGXHIeMfQlI8uIi0WpdUtxB
         6kjRbwlXO0Sg7neWndaATYU5mNmfc86Wv0HLBupXjHOMZ5/jOb/VunU5z8Olw5XdSHQY
         9Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWhjdMPdPPg7+dOLGXKMH2CRK7zvgPgcjni/UiTUnR0=;
        b=ubWBuNw/OeMmxj8j494ngemwwOjR/GPw2WeXQiZTD6tnMeMTB9X+UHox/J0PV0EEnM
         pr60HK1BHwhbgjuS6UQEJkXVQ3BDh9VN0N2tnQ4gGJ1aoR2vBdlzORPpUlRECirWffJ4
         UIjP8DsXoZnX6iDSwYn7A0ap+2Szng6nFXlVXYXrQLinPIujggCqxZNtqoPGhhJXpbg3
         511w61jeWZ3BitJxvyZ/NlhXp7QKbtQD4JG5Nan7BtVqkrDfRJij93Q+wJJgaKV7Zo31
         UNRfidjwqNw13Qv8yM1zvWH6fN/bdxjwgc0NkN8GwyiCYzJeHuhsxSaFd+yPtSQDwB+h
         S5yg==
X-Gm-Message-State: ACgBeo1DUs9inlfEXVmd6faDBNXGTod7FTf6TXWZo1AfHpNUUVfG3VTg
        ssV5SeLEj8qGQuQbxfT1rzo1VSuNcFpra4rsAq8=
X-Google-Smtp-Source: AA6agR7QCwuOx0mRewVuL38vo2FhSf7btS7xxtpWdD2Gdxxg2Yy+nGuCmJCDVDMAbuKFuOLevQ3V2jtlembhMvR3Mc4=
X-Received: by 2002:a81:7d84:0:b0:31f:55ef:efde with SMTP id
 y126-20020a817d84000000b0031f55efefdemr23008727ywc.273.1659531369414; Wed, 03
 Aug 2022 05:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220803090218.1313187-1-kkamagui@gmail.com> <CAGRyCJHX1X238TkiTaML3WJ+rdc1-m82_d3Ut4jCVDmuQ=cMOQ@mail.gmail.com>
In-Reply-To: <CAGRyCJHX1X238TkiTaML3WJ+rdc1-m82_d3Ut4jCVDmuQ=cMOQ@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 3 Aug 2022 21:55:58 +0900
Message-ID: <CAHjaAcT2fzpfJ563Jx5n3eYyrZD0vHNLr713qTZ=trrDjPaU=A@mail.gmail.com>
Subject: Re: [PATCH] net: usb: cdc_mbim: adding Microsoft mobile broadband modem
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Oliver Neukum <oliver@neukum.org>,
        David Miller <davem@davemloft.net>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hello Daniele,

On Wed, Aug 3, 2022 at 7:58 PM Daniele Palmas <dnlplm@gmail.com> wrote:
>
> Just for reference, are you allowed to disclose which chipsets these
> modems are based on?
>
> Thanks,
> Daniele

I'm not sure which chipsets are used for them. In the Windows
environment, the information that I could find was Microsoft Surface
Mobile Broadband Modem. Some people guess they are based on Qualcomm
Snapdragon X16 and successors, but I could find no evidence about
them.

If you know the way, would you tell me how I can find or confirm it?

Best regards,
Seunghun
