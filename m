Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7B558A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiFWVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFWVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:21:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594C4DF46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:21:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so759307ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOwhwkA5mmXw3hkTfHa38fc0GYwltKnM7rb5bb5xfwY=;
        b=K6N2zpb6B0fPuw75VVTJv5/Iau7yInQabYZ/WS1X3wrgt+vdkOMKnLtdS1F/b5AfDa
         140WIQmRymqMN3Q5DWpYinTh3T/DzER4L2BidCyIHe3rYDTU5vsJLWrRGg46TkW6E/0n
         thhTOrvDKW5qUCS1Vy7Qg71Lprh1ozNoVAVbPm6ZWDW0IsaD7Px2sO+fafVYr/yGmqhK
         bEZHeIifHM4KZJtWj/BL9IigNmh+Lz8vXVQwnrGaqeqqn84K1FEKAbzZRWE04tMqGFZR
         6odJwWPIegCI8l3F7oqvstsrjS7YLG7VUHcSVWeh3lFzAj1F6Uxaxoplu4M1Q/kgV5WD
         3BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOwhwkA5mmXw3hkTfHa38fc0GYwltKnM7rb5bb5xfwY=;
        b=qPTzmuYcmUtlNZHh+XqUD69cgbPnV0Yiz5djWSAVbQcpt8kjga3K1+GuWio/oLHSCM
         OdEWfgcXCn3B+Wyvavqgw3tjvf3w4vsnvB+pS/6IVXFCGvp8IPpRjYJYlKT2a40KcMTQ
         grMX14NL9Zm52RaYpH1BnQRe8L8edaS6pv2k2lAm8BtDqSmpZtGgmMeR4yPfFtyiF7d2
         1rwAeZpRVBUW2Hr48prBtHfyInMeFeSRmXuIHYBCISawvFUok0PEvZZU+F4eyw5iRiTx
         63kDM12yBWqLPUMA5VmZMbSs1flOMf2aqrDJivKlyVT4HCI5l/VF1iqJSMODtJODSINo
         8PUw==
X-Gm-Message-State: AJIora8U4f4RO5OKUrEgT18aZeDAYp3abGNtWbM6zln5Ia8fLvR6ZCpY
        Rh5vkxD/F4kmfI1e4VNscUdoGxjbELQpDsI7ixI=
X-Google-Smtp-Source: AGRyM1uoYqqSYjAVeHYAlR6Uez4eMhH3clKFNosLdDojQKG+unYQyjNftVHnB9lfhiDL6K3fSsG4goeUohnXhQUa8LA=
X-Received: by 2002:a17:907:2d09:b0:722:f0bf:ac26 with SMTP id
 gs9-20020a1709072d0900b00722f0bfac26mr10248592ejc.77.1656019289957; Thu, 23
 Jun 2022 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655975970.git.f3sch.git@outlook.com> <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
In-Reply-To: <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 23:20:49 +0200
Message-ID: <CAHp75VcQcKaYUP_JsmTFOY-pbOR39+TMw=5ADbb2BRGoMijCMw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 10:44 PM Felix Schlepper <f3sch.git@outlook.com> wrote:
>
> Moved error handling to one common block.
> This removes double checking if all txb->fragments[]
> were initialized.
> The original code worked fine, but this is cleaner.

...

> +err_free:
> +       while (--i >= 0)

  while (i--)

will suffice.

> +               dev_kfree_skb_any(txb->fragments[i]);
> +       kfree(txb);
> +
> +       return NULL;

-- 
With Best Regards,
Andy Shevchenko
