Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F94CD44D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiCDMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiCDMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:32:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069D1B30AA;
        Fri,  4 Mar 2022 04:31:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c14so9247801ioa.12;
        Fri, 04 Mar 2022 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LD6gTN1e1zlXj/t0lCkcVAaZ8PXN0Am12ReQ8fAXUPs=;
        b=e6PlMr+Ng2RXFkOsDTEEIhu/IDbXp+tbne53o6Az1rCcgVUCSmdAi5esbgyj5fhip0
         OXaYzRHIvIYTVjmHTnfWM7nV0W8zBeFEt65eLj4HHQfbYLB6FkFGXxF1mmU/wIa9JKwx
         vlqALBCvvLDGTcFP0GKIJWlAIqOSUUuJbCE57aiVO1cqEtXg6Lq9qXyVPpEC8yg8dDkk
         uK7iIZckpbA/Sf0xniKEBDK3d4UVaDthvT6On4lTEV/Q+vlIGmp5kmqBYiGrB0On/mDN
         36H+CTOHGEheF9h3F78UPrIVSks/dNl4rBMufzgNrbxLkc0zSKqLV5vif1SLMmJZIrcA
         RhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LD6gTN1e1zlXj/t0lCkcVAaZ8PXN0Am12ReQ8fAXUPs=;
        b=52ZXRr1+Ble4nCspUGsMJwiRUsu0dO6d/22hmEL6TJ6JFoeY030oFUdBDmAIqIVOOd
         2xALi8LRxmAEnAg+JSwBSoFU7JxR4Z3g7wGX1R6NLIggcw9vgDwfaEmrte/cH7yb2iPB
         wzwcwDfWZMNjUOvRxq9y9Iwt8r+80SoStkbyO4uTmshkKvNI9kC1j+se2Hx7wlWcISKP
         Gd2K5QWQX0qpfg3QQXWGirC1U7uMMQZPjDxd8JF9xARLLH1agaBnRiDZc2Ty8beHj+yc
         pWUKLVN+hcKyeREwKViG+PCOS2+jVdS+yxbeYRFHYv28IWJ8r2sPxSMkbZlQW1TCtzmS
         ZEqQ==
X-Gm-Message-State: AOAM530gZ1k8Z0eNttsrx9qkSFJGvONkYndbw761FMdFrCOrjfobfxa1
        x3m6ymWqRJ5gWgoa9gTjsC5Vpo7GhnFg6GZajMY=
X-Google-Smtp-Source: ABdhPJzgoS8M3g05AsBUieLPYXmV+8l+IaUmXwXDcgNemeZDL75Od1vp3aFBe6iRKW58gyU5bLS4LMxRJNvrbH9wl30=
X-Received: by 2002:a05:6638:168b:b0:314:7a8d:19d4 with SMTP id
 f11-20020a056638168b00b003147a8d19d4mr33662849jat.199.1646397119277; Fri, 04
 Mar 2022 04:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com> <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org> <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
 <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org> <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
 <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
In-Reply-To: <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 4 Mar 2022 13:31:48 +0100
Message-ID: <CANiq72noan-b84yU370wVaRRu-GX=A5X0Ocfv4uJDk2nyeR0aw@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Joe Perches <joe@perches.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Tom Rix <trix@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
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

On Fri, Mar 4, 2022 at 5:03 AM Joe Perches <joe@perches.com> wrote:
>
> It's up to individual maintainers to each decide on what might be
> considered unnecessary churn for the subsystems they control.
>
> One argument is that churn leads to difficulty in backporting
> fixes to older 'stable' versions.
>
> I think the churn argument is overstated.

I was only pointing out that, for the global `.clang-format` file, the
style in `coding-style.rst` should be followed. Then subsystem
maintainers may override it if really needed.

I definitely agree that we should aim to have a consistent style.
However, by allowing a few exceptions, some major subsystems may start
using `clang-format` sooner.

Cheers,
Miguel
