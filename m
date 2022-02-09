Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAE4AFEFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiBIVIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:08:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiBIVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:08:14 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3AFC03C1B8;
        Wed,  9 Feb 2022 13:08:16 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so2770283ilm.13;
        Wed, 09 Feb 2022 13:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsilYW3DDh1toEVnhvN/0AB1n2KJSIEgQPDPpYS3ogg=;
        b=lTCxyXVlpMZ7ZhnHlr0IFLmVb5WhXpMalHcioq+FeyOlAMckPjGFTC1N9qKM+0tJeQ
         32xDRJmJn7C5ngTBYjkBu8ftFMiW8Jw7c3Xsbu/QtV8XG5pYYNdqTE5nl+KqN0QL/8pO
         e602NNbmMWqt8hrx6QN2kpl+T4Nxun0BDnG28QRongQ/QyKL85nOQ6JhHB99N9pu81t5
         vn4jeiRC4jJcX3/IcdKIHvKYS/ws+oug+cT5YiVk9GYasw3I5OsTeemgLi7nObhhipmG
         AERACopq8wGlgJevfITcbiBtBg+qh4G70NATunGDSCdqrhcEecvYgJyaPxQLH5vw3tg6
         1jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsilYW3DDh1toEVnhvN/0AB1n2KJSIEgQPDPpYS3ogg=;
        b=lSv2DG3+KmIMjhGdnLbo0E+voxH4LrnZx7+2GURuz/zywuIdkpFHR2FvPyyKxFH6qJ
         PAc36qROoAKmsOCqywxUBiuUhp7ewh4Rkpq2ba1cnpe/0hHgFulSv+dqcNK3dH8EXIJ3
         0iOf9yHasSWvnd9xU8V0FPRk41S4xBJP4toPD2WS/v7pF/DNxlT/B20PQEOwZytfwODJ
         eujk94lngGcu4jqSd/UQcwwwSScgiriZet99dai+E5uroS02p5J+vlsazFgxl/WYiy3o
         oZiwrgFOo6lYK4M4aK6MPSBF+q0eL5nlRSUF/w+07iKYSEDnP33U7A4N4N0b31kw2X2e
         mElQ==
X-Gm-Message-State: AOAM532ovB7LzJ06XeCbt7YoSJc8b1ZClOhWTK9wJJO/vE6t9YhZcgW/
        0V4QyUFcLPkil/Ap4jC5a9AYbz+LudqAZOFEAVc=
X-Google-Smtp-Source: ABdhPJwJrGQcC++AJxv7m7KPpMf0I6w86y2CQ/5IPmwRw3aecp3EqZ/n1Wd6sld664BgP/YVhBpLla98iuTmQWAaq9o=
X-Received: by 2002:a05:6e02:1ba2:: with SMTP id n2mr2240764ili.5.1644440895628;
 Wed, 09 Feb 2022 13:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20220201185054.1041917-1-german.gomez@arm.com>
 <CANiq72nb_M3PJLG=mFfQVgAd4fbkL=OhGKS_uQHNf8Jbef3hag@mail.gmail.com> <4632061c-ec87-c4d2-3387-fcfdccf1da6e@arm.com>
In-Reply-To: <4632061c-ec87-c4d2-3387-fcfdccf1da6e@arm.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Feb 2022 22:08:04 +0100
Message-ID: <CANiq72muQyY_TkXdZEo=Ca3j16A8qATpOTSCB1WcOJZeeStPgg@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Remove demangle-rust files as superfluous
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
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

On Wed, Feb 9, 2022 at 9:55 PM German Gomez <german.gomez@arm.com> wrote:
>
> Yes, I should've added these tags from the start. Sorry Eduard-Mihai.

No worries. Also my apologies: I noticed you dropped the patch looking
at the archive after sending this, but I haven't got the other emails
in the thread (yet?).

Cheers,
Miguel
