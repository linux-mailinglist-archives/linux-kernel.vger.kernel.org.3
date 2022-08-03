Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F336589292
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiHCTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHCTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:05:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86115A8AC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:04:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f22so11646794edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TcHij1jogmYDOiRoe1Ans+jYqEJR2fqb0akEghqp0wY=;
        b=TDAb8Q2BSRY+fzkzp3NCXhL2jfg6VSX92LMQtedyhdQI7E7FqxPNuryYUr8JaAHo3D
         9kZ4Q/qwuW9K7W+0tviZZy5WEc0TUnTFy0VrPb8DfkdO6VEO4018Snzq6zvrplWq6Cnw
         Z0mYSGqAhTKC7CfOCjhODPKCrZD4n+BcZ00j2EWspsjsZhjGlQEP4nR5+wXcVpVdYdGg
         IMT/84IZueCHsJdildUEJKXbZRQuw/BvSYH4Zp2SGAuwLIFIzwD1FEgHtUbOOimY8jKA
         XWFwyiNuYWiWLxTSudDfHXp0hPk0bOa2wSisxV29vrZhXzV6z9lHpgGrcIiAhYqlC+SB
         bnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TcHij1jogmYDOiRoe1Ans+jYqEJR2fqb0akEghqp0wY=;
        b=e1xkadve1wXpfHizyNEpAiR++vFXwZufnU7fURwcravQsX7lk3EeoKyiwAjpkR4Oh5
         dwZK52aS9WRTqEFnsnby0voJ4Fwb/Dpj88CkJ91x5SKqH9FDiOckx/ozdLVimAtJc3Pv
         ZXserz1rdZiDQCAyKjR1dFDb1A/9Dy7Ohsj+Im2VPGEQFxPbR7xsOcaqIvze2mggDlhU
         S8GanLKwk4GFS3Yw/xrxrHRsVhl3JnbchVfETqu0i8UdFuPwoKZaxXYbk6I4ZyH1ULxN
         5E0mCI+YqOkHpppDRTHhDJmsZimAttwfJlcs1j7DLGvd07jVbwVv3khy/OSUqSFeyN7i
         I11w==
X-Gm-Message-State: ACgBeo1w5D2DVO/CCeqip522h00WT4K3KyQ9gw2y/BNgBPfGT23WKHWM
        UpbmxyIb+G+KykkUGAIJZjlpkkPaiW5A0+olPn0=
X-Google-Smtp-Source: AA6agR7atFjtIr7kfyXUcnZ2swP1vrfXW+cFXDEcKLqxM6Mm85r9t9qhiZMSZA76PjAGAzOjz94KeHjv6lIDz2XCDZk=
X-Received: by 2002:aa7:d6cd:0:b0:43d:4ab8:87b8 with SMTP id
 x13-20020aa7d6cd000000b0043d4ab887b8mr22346702edr.412.1659553498357; Wed, 03
 Aug 2022 12:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
In-Reply-To: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 05:04:47 +1000
Message-ID: <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
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

On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> Hi,
> Greg and I talked a couple of months ago about preparing a new accel
> subsystem for compute/acceleration devices that are not GPUs and I
> think your drivers that you are now trying to upstream fit it as well.

We've had some submissions for not-GPUs to the drm subsystem recently.

Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.

why is creating a new subsystem at this time necessary?

Are we just creating a subsystem to avoid the open source userspace
consumer rules? Or do we have some concrete reasoning behind it?

Dave.
