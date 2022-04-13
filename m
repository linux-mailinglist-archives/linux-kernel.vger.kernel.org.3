Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032E4FFC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiDMR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiDMR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:27:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20353340D7;
        Wed, 13 Apr 2022 10:24:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so2983043pjb.1;
        Wed, 13 Apr 2022 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmbDbKwFkRfAHla+Obm2SRSnbhnY3lf6FQeoqlNnf1I=;
        b=FxDtmPiybnU6Nsluby2qSgkJ4MnJfSZ7l/YNeY2Uu9oNF8Pay4u/CIWVnPUkdB/xXF
         YCoyw2z/+GNxiTkXRKFfnL/Kr0+JLRU1+afwn1vDmoRQ8mItD0awRykidkCNgOV+Vm1m
         XzledoWIiYUGDCvCe8nuzTdZEMdliLDQFE1ulUr9/dtEQEpH7nJfhU3AIdQ1P/VG0DL6
         /9qgTbLVVCPY0nJiFQ8oZrAL2Oq52e1s2F7sKDMBEQ2ixNlvXitVjwm+GBY0cvzrDie1
         wVfVKEEqHbkg9r1LROgFWLexStlyTNQauYfBg9rOGPR92YK2suPnmdrXlVAcsZJ/vcDg
         KMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmbDbKwFkRfAHla+Obm2SRSnbhnY3lf6FQeoqlNnf1I=;
        b=O5bj9pz2eGtRWZeoiQ3I/Zphn93Bishs2ERUxAUxH827FSDHa9drPcL7CvFoC5yktF
         Bd8v3w4eXTu8yj4MWcN2Tk+G+yrY+jf6mUhFOyO1p4brFt/2lEnaM7CZmPNsY1lmgXuX
         HHAmygL4kdyiil8ZL+bu76T9S63Fp+zWrZW5J20bSxEpoFtjfbmi8hYoXOW6natC7Opn
         Rp1heE4H6s5/k8eJflBGbXxS6E4NFjFFpspdouQNlqQf124mpzCbmq+NLNFONgvq1VhE
         KoTVWyfpbkNS0ysm6oZLCdpYbTAThVaxt80AnaoRgVdRh/WK55Lhxkwechf0UhCxgbkY
         bW1g==
X-Gm-Message-State: AOAM530AaxDpMsU5ag0jiL+652Osf5WuCsNurzoCw0itG2Emqxf5a3NU
        viB9qaAI7LOwEnLRsr8XSwLhpcQ5zTiX473xzRjBePZH59I=
X-Google-Smtp-Source: ABdhPJzKIhOLJdNYoK6M9EU5+XSZ9CmXOYb3bE2TiX9+/aL4d3+rAJ9fbdfUrKGv3u4zXz8d8jpqGx8cOTVqeqyuO7o=
X-Received: by 2002:a17:903:3014:b0:158:921b:6ebe with SMTP id
 o20-20020a170903301400b00158921b6ebemr7243194pla.164.1649870668691; Wed, 13
 Apr 2022 10:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHFT+o-wv=5AUrzwYDR5t4fA4vDJW8QY2SCpteNYrq6nYB2ZQ@mail.gmail.com>
In-Reply-To: <CAEHFT+o-wv=5AUrzwYDR5t4fA4vDJW8QY2SCpteNYrq6nYB2ZQ@mail.gmail.com>
From:   Velumani T <velumani.t@gmail.com>
Date:   Wed, 13 Apr 2022 22:54:17 +0530
Message-ID: <CAEHFT+rq_Pn9Y+38ZBptCDpEUUtKL5RYGUh2gmySXtjQefLG8g@mail.gmail.com>
Subject: Multi-color LED framework
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     patrick@stwcx.xyz
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

Hi All,

I have a question about the multi-color LED driver, Is the multicolor
driver implementation specific to the RGB color integration?

If yes, is there a way I can use static color LEDs with this driver
framework making changes to have this as enhancement?

In my case we have blue and yellow color static LEDs connected in
GPIO, I need to choose the color from the application and the LED
shall glow based on the application configuration.

Please suggest.

Regards,
Velu
