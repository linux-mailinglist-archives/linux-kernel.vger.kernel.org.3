Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF9489614
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbiAJKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiAJKNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:13:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D2C06173F;
        Mon, 10 Jan 2022 02:13:40 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y18so16829094iob.8;
        Mon, 10 Jan 2022 02:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ntxl59Py3BYOtLg0Es8HVO2YY2Y0AJ4CbA8VW/mZUR0=;
        b=e8O7yWXlkWY2MrckG/y5p7fh0j4afgR1rr46DubtGLo9nzvHgx77wDCITIt9+bPkCQ
         q7+1OzYv+zY8LXG6hSaAfEiy2dYNCGTkjq8v6CNt3jWSHKKMskIc8WYALOvFLVvJ8zAo
         +8tEjI3pL9kI/Pmf34HQR3qoRjDMLLtbXWH7LbRPFveMR/JI2qn2/3OXCnYflXcw9yr/
         JX6e5ZFVfY2MMzDn9zOdRuArmsDCssdsBy0di5GIS99xlBuwLE7tQSnZvpQAw03Mbl+x
         k38BicjHRqABRGP+GiFHuWGTaZRJMGpJ2A57ixYlsHiyWuU8T+LR+NAkq4votMLBkpX7
         Lzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ntxl59Py3BYOtLg0Es8HVO2YY2Y0AJ4CbA8VW/mZUR0=;
        b=ubX8DIo02PohQAiZesaEi0TQLLlE1pNQ/xmlQS66jDhBb7Dxmde5rkVGisTwPPs7lW
         I+L+fhgXHtD4eW+OPadEFAft3omG5zd8XX+i45hGibdBH65rfbSCwuZHHBcaamQj8ik7
         oakRqfuGFRAMu5U/ehpzxP0xg/8mdcvPDaUc6BoyHoGERrxAzRd7eZD8QcgjU+FkzWee
         5FPOFR/z2Fnoc4l3jdtL+jE8PaKbhm49xOwuNAI8EHNaO+umDktVZZ+mUznL0rQ2bZWB
         dslV/zaCo2KH0JgxsVVsbUHdUbP2tF9kXJrf9PVmWfFTqaS6K3ZzreCD3W0opwONx+ir
         33Jg==
X-Gm-Message-State: AOAM533XMXpFN07TFeyIMmB48TOCrUAFOhjCNOffgM25mX3gkJ5UiRzG
        uGqQ+MZYOQGgcot+4uEI/obsnhZ/hS4mAfFMH/w=
X-Google-Smtp-Source: ABdhPJzcyH9paYFghBMoht0lt797uIqtx6TOGPz+A8vVo+JIqo3EADU6IHzgQyPTIonHth3SRVPpnMivtimWJQb9l50=
X-Received: by 2002:a05:6638:22c7:: with SMTP id j7mr31706855jat.264.1641809620318;
 Mon, 10 Jan 2022 02:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20220110085952.6137-1-sj@kernel.org>
In-Reply-To: <20220110085952.6137-1-sj@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Jan 2022 11:13:29 +0100
Message-ID: <CANiq72nysMx0tOHstkDFWV2wYnjiePDxvGeip=RU4bKkyAZbtw@mail.gmail.com>
Subject: Re: [PATCH v2 for-rust-for-linux] init/Kconfig: Specify the
 interpreter for rust-version.sh
To:     SeongJae Park <sj@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 9:59 AM SeongJae Park <sj@kernel.org> wrote:
>
> Some common tools like 'diff' don't support permissions of the files.

Picking it up, thanks!

Cheers,
Miguel
