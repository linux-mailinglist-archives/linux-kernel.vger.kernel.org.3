Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E08536A79
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 05:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353752AbiE1DvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 23:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE1DvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 23:51:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C542384;
        Fri, 27 May 2022 20:51:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o80so10897821ybg.1;
        Fri, 27 May 2022 20:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orLkwKBDXLhrzD4BMFuH9kb4hQtpnaRtRA74RMpv3ig=;
        b=ThcmND6RFj2HLB5DknQBN270ZC7q5ZBSbUhnpvjSSxPkpgWeN8xWuH7kxfUlGvDX4U
         RLbW71kg8ym/EFwAXdAVnbEK2sShyDaVJEw/XQXd7oTnGyIO4zbqhx+C6w/UnhiqyK+r
         gWgK9LgL9tEM0fDqCJxUaOW8uk2meXg0Ih7leP537y4W0wTOnRSUNy2/nLq2ToQ7w2ew
         xQOCfHwwIkzPbZddQlJUC3Y92S+W6XtrKusrrHiZkTX/puTeHq/skzPAHerq0aSYI9XN
         FEyld4ttK60iVF0N/LStp5gDIbc+PG/spteC7pGozY3QlmlEu0CxD9rk1TlZyEknnBnI
         sBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orLkwKBDXLhrzD4BMFuH9kb4hQtpnaRtRA74RMpv3ig=;
        b=wFBRb2OC16Z7H+dJiqN8vUxUTQi0VayXtRKeaTamGHMC0coULp9+Rwox9D2fx6GQ4y
         ZPE60zj0aWwRE8RvGPeubk4I44CG7nH1ddxZ/vKQONrlfnkYlepQIhvAbaj87DR8y1W9
         EKYBVGYRZMQ5DfbgaSPF2rcBmJwzQrdLnWFeeWQHW2+9GIPyhKr2WvY9KE8sV6CCPwPB
         u53lZjuuepfGSylP/m6BjiL8IJjspLTsKwqgVO6n2ZjHcK1zs5BKGZN/YKW6mfuKvTjY
         Wf8OP9psr5fKkqKohgL3WrvTwwX0xJIX7s1RQaDXuoXJ2AGDyHTYzgpy4YD9PVy+fg74
         XcxA==
X-Gm-Message-State: AOAM531ZNmfdgs4mJ7OdEWILV7OR7ktHAFa/A9tJ0XLNrE46sc1zj7Il
        HZeuSfT+NrpC2FzRwLnWDuwADRDHDLbpQaeAUqXLfB6L/dk=
X-Google-Smtp-Source: ABdhPJxxrYOkGAyX4e1QCYM6a1+xjZEfex+Ht0UhrC0tGLmf7QERIkMp3OjP4TmXl+gdHOj7c3+u9HT6TM4EjppppOI=
X-Received: by 2002:a05:6902:14e:b0:64f:d2eb:2df0 with SMTP id
 p14-20020a056902014e00b0064fd2eb2df0mr27601593ybh.557.1653709874725; Fri, 27
 May 2022 20:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjGWp4+Ub_Ccaw+tx1NQrNcqyjUG5K30uPH3uYTF_wxfw@mail.gmail.com>
 <CAOuPNLgzBA2Sbn6vS4856LwYyBo67OYKQp49+xpwX=Bi+KpLZg@mail.gmail.com>
 <65f1b675-84ac-b5da-6075-2a9f0353ab37@quicinc.com> <CAOuPNLh-NJ=GK63+iHFE-th9J8yfWZg_S3xmLgHGM_-nCFexvg@mail.gmail.com>
 <CAOuPNLgk8zRHwq7PP56NYpFagjnf_+1j1c_TYvdo6kmWQBwwuQ@mail.gmail.com>
In-Reply-To: <CAOuPNLgk8zRHwq7PP56NYpFagjnf_+1j1c_TYvdo6kmWQBwwuQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 28 May 2022 09:21:03 +0530
Message-ID: <CAOuPNLhN0rFVRx_ur7isKHO2GcZxefs-A=9wqJxBtMHgy3M0GQ@mail.gmail.com>
Subject: Re: Queries: Using ifdef CONFIG condition in dts files
To:     "T.Michael Turney" <quic_mturney@quicinc.com>
Cc:     open list <linux-kernel@vger.kernel.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        linux-mm <linux-mm@kvack.org>
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

Sorry, a small correction.

On Fri, 27 May 2022 at 17:06, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Fri, 27 May 2022 at 15:34, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi,
> >
> > On Thu, 26 May 2022 at 19:53, T.Michael Turney <quic_mturney@quicinc.com> wrote:
> > >
> > > Kernel developers correct me where I go astray, but this seems like the
> > > CONFIG_XYZ value is not available in this file.  This would explain why
> > > the disable case works.
> > >
> > > At top of dtsi file are you #include <config.h> or whatever the correct
> > > syntax is to see the CONFIG values?
> >
> > Thanks for your comments.
> > No, I could not find any specific config,h to be included to make the
> > CONFIG values visible to dts.
> >
>
> BTW, I tried another approach but this also doesn't work when CONFIG is enabled.
> a) I have created a new header file such as myxyz.h and defined a new
> macro with config check.
> => myxyz.h
> +#ifdef CONFIG_XYZ
> +#define XYZ_CMA
> +#endif
>
> b) Then I included the header file in my dtsi file and used ifdef with
> the new macro.
>
> #include "myxyz.h"
>
> #ifdef CONFIG_XYZ

#ifdef XYZ_CMA

> &reserved_mem {
>         xyz_region: xyz_region {
>                 compatible = "shared-dma-pool";
>                 reusable;
>                 size = <0x600000>;
>         };
> };
> #endif
>
> But unfortunately this approach also did not work when CONFIG is
> enabled. So, when config enable/disable its same behavior.
> However, if I put the #define in the dtsi file itself then it works as expected.
>
>
> Thanks,
> Pintu
