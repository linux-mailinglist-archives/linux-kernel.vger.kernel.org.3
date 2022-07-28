Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925305846FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiG1UUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:20:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71A124096;
        Thu, 28 Jul 2022 13:20:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mf4so5026353ejc.3;
        Thu, 28 Jul 2022 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nkqSgnyYL6Nh9u23slZtaHJXCcQKzGcIFUK9lF9foro=;
        b=Cgo5bUYULyvlPnEOEbyta+Z9qVjIZySqeyvHMkyiyH0AaFqFIrvLnIIQllofE6JocT
         HcfzuHSTHWt4SeDtSIf9uutJNTUgvI+oIkbc2LFiXeljvKy1cUKzOCOO0KRpyoK7DjXc
         rHR/eWdG3kbEWYkmepcIVn4PLqtXJHE4pcha0qQpk3bt0NpAWppTtiVkFLEhX+fhLsGl
         iwfHtiChl+TFPQ2PZxjxmuhB0Rt36Af2UWHHrfscfh22W1fIIEC+Hwpez9H1KU1bNu6r
         pw9cp9nVuuXYTs4bYFZ35wIccqPYf/K0cnEYfkWME7XQR7LDTOjME82i+zXSKNFDtW6n
         3K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nkqSgnyYL6Nh9u23slZtaHJXCcQKzGcIFUK9lF9foro=;
        b=e4p8mPWDy57nqEB+u7iaUXhR9RBcDWPVyzsvbSf/YBNX9uqM9JAqEj7lbxIds4+ytn
         LWFfFWP84NPdfqvMBI2H/0OeGLp7IKiaLokCcKv5lNgmdsd9ZF2x3Si4spC1RX6zn1zc
         pi7BNWmSvp2OTPHBei+AYaUhdwmQe7l6BZKpht6j9euut/ayGED2hSx18CtLodLx5w6z
         Gz4YTbywGqOBaBWONfcC5S0tEYE9xpzZNSLMwoHK45eYXYiaQNCdaKG1OWy/vgXE5Aoa
         1bMYi/VfJ8DWpBY++gCIj9xR9q7udU2tpu4OSw1krkyq1GuClMmhiAsQUbt3Sw80RAjd
         T71Q==
X-Gm-Message-State: AJIora/6bo0BtuW5FW0eso97Xb5q3hFB63Nof7cvWC8gOJyhpdTfP16K
        C/hRx6quzPKJZTy7wgWnJYOE+nwD1JjuWB/H3Ac=
X-Google-Smtp-Source: AGRyM1udQoKJoRnagV33t765UHc7wrcRS515vsTnz8/oAPR8Reo3fg+BpM4w7BU/4LsNVMU+ObsUgp3r08YqabyDE1M=
X-Received: by 2002:a17:906:2ed7:b0:72f:d080:411 with SMTP id
 s23-20020a1709062ed700b0072fd0800411mr431854eji.203.1659039645333; Thu, 28
 Jul 2022 13:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
 <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
In-Reply-To: <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Thu, 28 Jul 2022 13:20:33 -0700
Message-ID: <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
Subject: Re: INFO: task hung in __floppy_read_block_0
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 7:23 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wro=
te:
>
> Dipanjan, are you really sure that you want to report a "INFO: task
> hung" bug identified with your syzkaller instance? Especially for a
> floppy driver, probably in your case even just an emulated one
> (right?). Reading data from floppies was always very slow as far as I
> remember those times...

From the bugs reported by syzkaller in the past, we observed that
several of these =E2=80=9CINFO: task hung in=E2=80=A6 =E2=80=9C reports wer=
e considered and
acted on, for example, this:
https://groups.google.com/g/syzkaller-bugs/c/L0SBaHZ5bYc. For the
reported issue, we noticed the read task stays blocked for 143
seconds, which seemed to be one the higher, especially given that it
is an emulated floppy drive (yes, you are right). If it deems normal,
then we do apologize for our misassesment.

> Consider the severity of the issue and judge if you would like to
> point out such a 'bug'.
>
> It might happen that:
>
> Due to bad judgement on your side, kernel developers and maintainers
> will consider the value/severity of the provided bug reports overall
> and then eventually simply ignore all reports that you send.

That would be very unfortunate. Please allow me to explain how we, as
a *small* academic team, are operating. If you closely follow our
reportings we did in the last few days, the first =E2=80=9Cquality control=
=E2=80=9D we
are doing (to minimize the noise and frustration) is to make sure not
to report any bug without a reproducer. Now, the unfortunate reality
is that none of us is a pro kernel hacker with years of expertise in
tinkering with Linux internals, which essentially means, no matter how
hard we try, we cannot simply match up the combined level of expertise
and competency of the people in these mailing groups. We are using our
best judgement before reporting these bugs. Admittedly, we may be
wrong, and we apologize in advance for such mishaps. The developers
can confirm, or refute the reports (if they can spend a line or two
why they think something we reported is not a problem, we would be
grateful). In our defense, what we can say is that, in the last few
days we responded to the developers who asked us to provide details of
a bug, or test a patch. In fact, we are still in the process of
responding to some of them, because being a small team, our turnaround
time is higher than ideal. To answer you, simply ignoring all the
reports we send might be too harsh (unfair?) to an academic group
operating in good faith. Providing us pointers like you did above
(thanks to Greg for helping us in some other thread), and letting us
know what we did wrong will help us to align ourselves better with the
reporting and patching workflow.

> Dmitry and his team around syzkaller and syzbot can give you more
> insights on learning a good judgement of what to report, how and when.

We would very much appreciate any help (even positive criticism) from
the community in this regard.

--=20
Thanks and Regards,

Dipanjan
