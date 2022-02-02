Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689084A6B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbiBBEsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:48:08 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43550 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiBBEsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:48:02 -0500
Received: by mail-lf1-f45.google.com with SMTP id u6so38142564lfm.10;
        Tue, 01 Feb 2022 20:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyK+/6qP7kN+wc7CsR4iD7blD5sT3x4HZNV6o1Uplps=;
        b=bQ/ReRtspnW2Jhm7bfxp9ONQh94/Gkk+lVuKzsAuDfTIVerVEQ7qGSi0PcOiamLhJ2
         FkjFoIydPeboMZgIkZfi1jgGKDAEuD15eLonimDu59qEkvA5MFZPb2gKOX3crEXTbnPf
         UDvLEffIvSNYOkDS9g/+Y7R7SojinznyCmBqMLVe9QZ+nyBlr7GxDjuxK61n2WPskR9I
         IM7wMZKykRokMZnTMK9quSaG6Qh1Rk/JC4HS96o35yHodU9PiFsHyp7VtFzgac+nU8Oy
         5xrpNWKgYFBsa8LaKokeEkbjRs+Ozecq2k6K+L4MhTAbPQ3DPlbvl3LkTTcqBvZTLxjv
         blZA==
X-Gm-Message-State: AOAM530eBlf3oXJWlGJBMmalLWiiF2n7UY1wej3KwPWNRQ1a+KQsEOqK
        5X9OgtagjBSWPOpfjN/98xva+ow6XkwOclwu3Gjp7qYq
X-Google-Smtp-Source: ABdhPJx41fqiUJXEhiFLFaWHRYRn+gpUishnN3Tr0nW2nvEK0Q3RCXwQiy5xFjfTSrAGAcfQWAk9DmXv87DjG3401GU=
X-Received: by 2002:a05:6512:39c2:: with SMTP id k2mr20948880lfu.586.1643777281127;
 Tue, 01 Feb 2022 20:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20220127132010.4836-1-changbin.du@gmail.com>
In-Reply-To: <20220127132010.4836-1-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Feb 2022 20:47:49 -0800
Message-ID: <CAM9d7cgPhL9roWuJ=ktKRCGQTM824JEvi+Ar5mibCnK9LWku6A@mail.gmail.com>
Subject: Re: [PATCH v2] perf/ftrace: system_wide collection is not effective
 by default
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 27, 2022 at 5:20 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> The ftrace.target.system_wide must be set before invoking
> evlist__create_maps(), otherwise it has no effect.
>
> Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Acked-by: Namhyung Kim <namhyung@gmail.com>

Thanks,
Namhyung
