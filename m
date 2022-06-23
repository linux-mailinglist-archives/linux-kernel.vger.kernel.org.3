Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A55577A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFWKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFWKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:16:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3090849FA4;
        Thu, 23 Jun 2022 03:16:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c65so4781615edf.4;
        Thu, 23 Jun 2022 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAgGmVWVOWwerEi+BAH4Lljnu8y7SnGhYb00GohsXcI=;
        b=UZAbgb+QBE+NUiOZbaeaQbs37/VcrS4+/t7K3VQuriZ1KcWZX1mfDUcCOiel0wOKlD
         nlc5OYyFb5l4wWVJCOWB/W8j6VYRg82xPXPLpLSY9k1tcgEVXfe+ezFEzFUjPJuFtlf8
         CmuG4ESOEfKhkYcGdxOe8YtTLCutLkkMOXeIqnQv+IS/LChOqkl3P0axOrmtW+MRiVa+
         XpafKMx9HsIBDsQD+x/S3+dKVJdM/ihTpsw+JAKLErvxw+x1OPwA86UeQCxvmCiwiF4S
         QuE6dd/UrPX0yqHgQ3s9JK2Tgs44DamSMFp3YvUSIftAHVS/a8e6s4c8FmciVcZLDSQ4
         +cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAgGmVWVOWwerEi+BAH4Lljnu8y7SnGhYb00GohsXcI=;
        b=KoMTe3OWZ29m6pq3zn+m3Xz47xKKr+6shkGaPXssDXWQYQhGd387mY9tt4LKp0acJK
         z2Hh923QVmxDWdFQylj+Fx+M/FMYsLmoNS/vWOjlKJO1AeQYNJc9GTl+Wf71Ge2dq/W/
         SVSGnyFf1YbbzzfafwB/SKxSAZBR+isCnXfg8VlqiM/ET3IKuyTHW2bV9n89vIduUeWS
         6S3VrTmVLUheJUUAsgJvfkiApH2wIMBO6oEOE2nrImPd0CjnKCNnhZSpit4/pGObPiyR
         o3ELRR2XD7FHUO8XFPqFhjmEkbSa5H7TYQ+HAzBcSwRKWQGzpyqPgd8sAW8DS9VRVcv3
         ZgZA==
X-Gm-Message-State: AJIora/CgQeMBtpgrGiFDHUHEBewNonZknc9wbinaQPIhPsOU6SyTnga
        FH83GQba+Ll5BvpvfOfk5KUxp+1OEQY560VBJvU=
X-Google-Smtp-Source: AGRyM1sSuZjSq7A6HWGZLYY3BlpzlEJnoj0eAD636Y9Xon5vjxM4t5uMTgVMQ7BDVd8jO2E0fYc4iSv4eaJ59vgiG2M=
X-Received: by 2002:a50:9f6a:0:b0:435:5804:e07 with SMTP id
 b97-20020a509f6a000000b0043558040e07mr9791666edf.178.1655979384373; Thu, 23
 Jun 2022 03:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com> <03467516-3962-4ff2-23d2-2b3a1d647c5a@kernel.org>
 <CAHp75VeKhY6dN7j_yXQXUMhOqRwqQ2yN_qF95U9wU6K4uKPdaQ@mail.gmail.com> <c7115ff1-2a97-f5a0-a0c2-c7c1064af291@kernel.org>
In-Reply-To: <c7115ff1-2a97-f5a0-a0c2-c7c1064af291@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 12:15:42 +0200
Message-ID: <CAHp75Vfsy5yY3saSCvCu87E-arifwEZXUNtFMrMn38gJY2LU0g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] serial: Consolidate BOTH_EMPTY use
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "speakup@linux-speakup.org" <speakup@linux-speakup.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 10:24 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 23. 06. 22, 10:11, Andy Shevchenko wrote:
> >     * prom_putchar_wait() should be implemented using
> >        read_poll_timeout_atomic(), incl. failure/timeout handling.
> >
> > Not sure since it is an early stage and scheduler might not work as
> > expected. Conversions to iopoll.h macros bitten us a few times already.
>
> Except _atomic does not use scheduler :).

Sorry for a bit misleading comment, but I chased it down, so this what
I had in mind when commenting:
be24c6a71ecf ("soc: qcom: rpmh-rsc: Don't use ktime for timeout in
write_tcs_reg_sync()")

(Yes, it's about _atomic variant)

Means we need to use those macros with care.

-- 
With Best Regards,
Andy Shevchenko
