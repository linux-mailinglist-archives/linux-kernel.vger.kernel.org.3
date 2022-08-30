Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FCB5A5C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiH3HAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiH3HAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:00:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6847DEB9;
        Mon, 29 Aug 2022 23:59:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5so10279364pjs.0;
        Mon, 29 Aug 2022 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=un7bfVrxWZbMlE5lL0c6Bd0MjpZ+yc/hHTZvrL6aS9g=;
        b=oNYSMrpaiet3PYYywR1WswJAmgfjdDmPJG3KhvS7rDU6qZ+nnXO92DSb5d9+zqCjaS
         FWl1cINOjAgto4nDGR0AXZQulcuOAtYreDGrb4KQOFI3f1WU1V3gVtgtctRhBnh4gOll
         Iu3gDTw6Ch2svTgEjk6ToVqHlJ9QedyuagBdhfS2UG2NWmxRiYTU3JT4kES47Bn2ezIv
         UemNp2X6ouTICU7/KGptRf8SOxOZg/zygyiB+uTppCcXapbS/H/iF+NyN7rUgeT0IYOP
         TX+OTz7Uv36F4t3RG3Tx/HBB10RGalqiKGLkrSYiPo1Y6ARQLYeWeZ2Vl4rlZAqSfky/
         ax0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=un7bfVrxWZbMlE5lL0c6Bd0MjpZ+yc/hHTZvrL6aS9g=;
        b=rE+BObm7f6g9niUlEQYLzVB64gcwXtJu19YyDLXBsiIF4Ir0BR8GfZrbujPAZOQT4X
         EYgg60ZwXsU8hjO8GQYjXlbZY4Ga+jUak1H1UvaLdapa50Jh7dm2dxgfyKAR8io2/YKb
         JgkS8RptQCg5Qppq5xqQ3hiIeIpkD8luMOzHPER0QJSxDJb2Y7JX7zOdBI66YtqdkJ51
         9GzxddIhomst9+XiymiAOC8ugGIyG69CtWC78hccEtfP3vydZguspaonsDXOP9pqxcGJ
         NCgU3/8lPYf6u0IPSynD0d5GREk8gNqnQfdRUhJ77ve2O6z9y2v6fodRNatnm6i3d2nF
         4LyA==
X-Gm-Message-State: ACgBeo3U0YLjTujUImGwYqydsb94TOpclBbvWd6LiyRfhTG4zK9D6Xne
        mehfa9EjZIACyaBSILdNW9+bVyA0C8DmPNnsyVA=
X-Google-Smtp-Source: AA6agR6zYvWXw59Gspf7WJkW0aOYI5u+qi7kfd/iPbvB7KONax93pyauLxtDTrHlOHbAo8FFHLcyFQlEczlZWaBkr8s=
X-Received: by 2002:a17:90a:de93:b0:1fd:b278:4736 with SMTP id
 n19-20020a17090ade9300b001fdb2784736mr11750700pjv.159.1661842796276; Mon, 29
 Aug 2022 23:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220826083612.1699194-1-floridsleeves@gmail.com>
 <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com>
 <CAMEuxRqBEMdva3qEphvuYkFLpRjp=xg7vpqQT1oqb2AgkkG2+w@mail.gmail.com> <2033d06d-10a4-5a57-d650-7541c39990ee@linux.intel.com>
In-Reply-To: <2033d06d-10a4-5a57-d650-7541c39990ee@linux.intel.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Mon, 29 Aug 2022 23:59:45 -0700
Message-ID: <CAMEuxRq6wn+wakYHGtnS_vSgpcw6aNOir=KyXWb12vPrOr76pA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/tty/serial: check the return value of uart_port_check()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Mon, Aug 29, 2022 at 12:09 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sun, 28 Aug 2022, Li Zhong wrote:
>
> > On Fri, Aug 26, 2022 at 9:01 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Fri, Aug 26, 2022 at 11:38 AM Li Zhong <floridsleeves@gmail.com> w=
rote:
> > > >
> > > > uart_port_check() will return NULL pointer when state->uart_port is
> > > > NULL. Check the return value before dereference it to avoid
> > > > null-pointer-dereference error.
> > >
> > > Have you taken the locking into consideration?
> > > If no, please do, if yes, expand your commit message to explain why
> > > the current locking scheme doesn't prevent an error from happening.
> > >
> >
> > The locking is taken into consideration but these three checks do not n=
eed to
> > unlock in error-handling because unlock() will be called in the callers=
. Will
> > add the comment in v2 patch.
>
> I think he meant you should indicate why the current locking doesn't cove=
r
> the case you're fixing, not whether this function should call unlock() or
> not.
>

Thanks for clarifications. The locking does not guarantee the return value =
of
uart_port_check()  is not NULL. Actually in line 773 of this file
(drivers/tty/serial/serial_core.c), uart_port_check() is also called in
critical section but still there is check on whether the return value is NU=
LL.

> --
>  i.
>
