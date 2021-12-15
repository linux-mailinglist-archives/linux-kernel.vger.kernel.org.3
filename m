Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C07476689
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhLOXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhLOXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:31:40 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:31:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id c3so32720345iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2eIdr8Ixu7h3hdJJIzlZrLkiMXBOpFM7Ph27ErX6KM=;
        b=YFWwdrUMA8zrz8185gnIIlOjtqAT/OGKxTcI7lZnkzJtHGcvifBRFJK9irBDHD8Idl
         gXxz1btJKO91Bn4nn2qP+i3VJ3OHNRHMmfr0BswEohzjPE4gAiGGS0SfDUeSbAtswQJ9
         GSrMUkiq9/o1OWt3yPivx6eJyPW9Cz/73gqIIFGvSBYTt+oTiWcAL0gnDjpmwDhFCdZX
         coVqV9yyNc/F76bEjEGJqxxFaWBbR/UmtCjaOPeLZSf2LRwPJVyjnzE5kIbdV2RZHuJs
         vfyBDSxfmjCjguQLy3PHSPa3hum8A5gljVfORUnmCm0MbHt8RgLIvEfiXKnG/t56NKDT
         Bdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2eIdr8Ixu7h3hdJJIzlZrLkiMXBOpFM7Ph27ErX6KM=;
        b=Uk02w4Zfmp5Dusdm/H2ArGyXIykkqa9YHPURDpTuCqYyklLHGhQmWwpomL7EEtiBvq
         QG5+40r814lpnEEom5YpNyMSjgjWFllFbClcAcP+dUEJrniAyFBMXyt7V8ZR2DKvDOZL
         l5kBUzzZoG/3B+3N9LLzgqa19gQowbD4qZkhf48OpdnXBvrxqze9CMwdsvN2g+6MMDWV
         J/5yUWNaGEN7rI2I0swRdTIAZ8ZSSP6hksMR8eh+VzAlHHP8XqR1PlJuZTJn3PzeXAQa
         I4ahoJqQ58oH1l6vZEUAM0Cjiv/aWyswNIkXBasCFARHVbGbiWtnwUmpoFBN4vRXYztt
         4SwA==
X-Gm-Message-State: AOAM530XM4NjvwKgGywbRFlPK7wAWmSAtXROD3KMj/8j7uQJD2YXk3/B
        VJ2uJO4N1aZjHWRGGDnVclNGmQO8iZmJbvsydB8=
X-Google-Smtp-Source: ABdhPJxS/ZDgQQuhrPTo4OoL9zZqITOtiTLx38Xh+B2JnsK04uMfsm4n3r7Qmhhh/wRkKuL1X8Gy92V+7QiROwSTwvQ=
X-Received: by 2002:a05:6638:408b:: with SMTP id m11mr7485904jam.186.1639611099917;
 Wed, 15 Dec 2021 15:31:39 -0800 (PST)
MIME-Version: 1.0
References: <202112160239.cdlehqr0-lkp@intel.com>
In-Reply-To: <202112160239.cdlehqr0-lkp@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 16 Dec 2021 00:31:29 +0100
Message-ID: <CANiq72kVC=xwrCEo1tCJG-ucw3T96j5EVOmmX+SNzNjan0GJkQ@mail.gmail.com>
Subject: Re: [jirislaby:devel 8/33] include/linux/compiler.h:61:23: warning:
 'xmit_buf' is deprecated
To:     kernel test robot <lkp@intel.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 9:50 PM kernel test robot <lkp@intel.com> wrote:
>
>      115 |                 unsigned char   *xmit_buf __attribute__((deprecated));

`__deprecated` is not supposed to be used anymore, no?

Cheers,
Miguel
