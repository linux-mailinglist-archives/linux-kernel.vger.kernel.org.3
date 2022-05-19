Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755A252DF87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbiESVpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiESVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:45:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8C5A2C5;
        Thu, 19 May 2022 14:45:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e189so8002819oia.8;
        Thu, 19 May 2022 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RA+gGY8dLwh8y/CQ41vF54pvIQyZE8P1Ve2JTxLWqzk=;
        b=komyDIKLLcEAdb2S/E9vT7gRCg4awOj6VLLeL5gQz8pAou0tQ1fmjMobOtMNbtLMXk
         OiPUvli6Fz2kBCdflelS0IawhAO52s2Vgkmkhzssms83DVJr8UiaGzlk/8DO3li8IRwc
         7wffbBK6V1XjkevgKLnh53ZdTlMHq2HkWqDn9hGhAPKefmdOl3FEVXVFXuK05lRSaI2f
         nFwwO+WzrqUSDMHltYMMVuScxwKdNFXH9LaQON3dgyyuL9i0poQSNdaSKiPtXBv7tdxC
         ScKoz60Vbvx7mN3RKACj+Ud4X1CwO5lKtgodCl3SlP8an5L/Gpw5HtMF6Cx6f0OLojJN
         TYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RA+gGY8dLwh8y/CQ41vF54pvIQyZE8P1Ve2JTxLWqzk=;
        b=Hg42z2zwZTkfOFGq+fpWa+/JTxcwsxobGiEOLqW2cXFMxadkjhAm6gjpVbxpDMxfzE
         z8/dAF4SVc51ovHubxqJ/WwqUJv/calzTQ0slccBZZ6GPITMVRKBnow8f1vsMVdsB66h
         5Ot9C4az50DTUM8PcFtQCgSDEVyx3+0U0FI0hIBrpfs+UaZfEc70RU/4XvIbaRWGxCx3
         TFOMyQesb+5d1ZqL5BoIjAbHx1J7SnL+HMb31KP2H7EpZEGfckFmg3fN3/prKw+6Xcaz
         XCZh5o0Od/3iM6FrbufK+qvlBHEUHUaMkMmu4zE+t0GOzm9nhoFYk2XTu9xGjgDKJlt7
         1QfA==
X-Gm-Message-State: AOAM5308CwwMqZCL5wycAeMggzqjnns++AfLFbjcPk6GAbL8X+VGgALZ
        gReQZpuH9dmr6PZblqhy8WVmntLRZQDbhgfeYnM=
X-Google-Smtp-Source: ABdhPJzm2QGhq4vgYnIu1D0JRtdB/L89IXSqIvyNxpYQgAUcoB9gi8LPbyhIy3iD3MGGXlpowsGU57uLffZ5+6lDRCw=
X-Received: by 2002:a05:6808:2218:b0:326:bd8c:d044 with SMTP id
 bd24-20020a056808221800b00326bd8cd044mr3689489oib.92.1652996715409; Thu, 19
 May 2022 14:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220519085530.999726-1-tmricht@linux.ibm.com>
In-Reply-To: <20220519085530.999726-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 19 May 2022 14:45:04 -0700
Message-ID: <CAM9d7cjjSk-qyA+ZF2YyrJUeaPN8wi7yDzu+ZRbiM4BhjFvg1A@mail.gmail.com>
Subject: Re: [PATCH] perf/s390: Compiler error on s390 for bench/numa.c
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>
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

On Thu, May 19, 2022 at 9:27 AM Thomas Richter <tmricht@linux.ibm.com> wrot=
e:
>
> The compilation on s390 results in this error:
>
>  # make DEBUG=3Dy bench/numa.o
>  ...
>  bench/numa.c: In function =E2=80=98__bench_numa=E2=80=99:
>  bench/numa.c:1749:81: error: =E2=80=98%d=E2=80=99 directive output may b=
e truncated
>              writing between 1 and 11 bytes into a region of size between
>              10 and 20 [-Werror=3Dformat-truncation=3D]
>  1749 |        snprintf(tname, sizeof(tname), "process%d:thread%d", p, t)=
;
>                                                                ^~
>  ...
>  bench/numa.c:1749:64: note: directive argument in the range
>                 [-2147483647, 2147483646]
>  ...
>  #
>
> The maximum length of the %d replacement is 11 characters because
> of the negative sign.  Therefore use %u as format conversion.

But their type is int and I'm afraid some compilers might complain
about it.  Why not just increase the buffer size?

Thanks,
Namhyung


>
> Output after:
>  # make  DEBUG=3Dy bench/numa.o > /dev/null 2>&1; ll bench/numa.o
>  -rw-r--r-- 1 root root 418320 May 19 09:11 bench/numa.o
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/bench/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index d5289fa58a4f..ff0bfd87afbb 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -1746,7 +1746,7 @@ static int __bench_numa(const char *name)
>                         for (t =3D 0; t < g->p.nr_threads; t++) {
>                                 memset(tname, 0, sizeof(tname));
>                                 td =3D g->threads + p*g->p.nr_threads + t=
;
> -                               snprintf(tname, sizeof(tname), "process%d=
:thread%d", p, t);
> +                               snprintf(tname, sizeof(tname), "process%u=
:thread%u", p, t);
>                                 print_res(tname, td->speed_gbs,
>                                         "GB/sec",       "thread-speed", "=
GB/sec/thread speed");
>                                 print_res(tname, td->system_time_ns / NSE=
C_PER_SEC,
> --
> 2.36.1
>
