Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D5A5ADAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiIEV1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIEV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:27:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B13AE60
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:27:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id cu2so19378217ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pSL2MZrpVB7qxuOy9eYDodpImR+sJNN/K13mEhYsepI=;
        b=cowKY13aK1XRDe5igS3FPN14nBu4YDfTCGgQTEMDPH+lKsLWSRPno9GjMV/Eilzz/g
         2b7ximSJT7cB0QsnYWTt5dOHKh3pE6TWIw0nTyBBh9YPpMRex/sDVrwx/A7tbDY7fXSg
         vuHIgQxx/dz/v+WKILO4+OAyRJC5tb/iShTNn4vL9qsFuiPf0ibckmNHHHNNtamuO6GV
         j710FWtjQ33Gm/yq2K+Uf+J10IQh6W1U8GtWaMjiXIonQQQJLtUvcuj3T1ImipVeUVxt
         1m32ApU7cW3/qCYMibWyD4BGNpx1IO7qm/jkGdFLur3x1dJUxib5M2PSgj3FIUa6I43D
         SZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pSL2MZrpVB7qxuOy9eYDodpImR+sJNN/K13mEhYsepI=;
        b=riWcEa+wy/ak1lMI8lD9eGVYbPtK6WZxCCBX5XBVuDBLvyi1auqQkcJCh6hQJ7G8p0
         5qwF8ozDW8CVexRbPSQJ4nfjGSAi/dfEvOZq+FK2PeSW4dfX0HmsWocgRUTWrvWInFZK
         v4e6Xk7Yji7NXdPvVicyLe9/t3+5Z/1ms2P3EFZhNwNb9Pk+iCir0CfKCUOkqDiZrUWH
         KiUt8I7eSlcqq/jw6nC83jWHXmzjWc6DgKRgq3iYdK7yOnE3zVhZtBCYnS10UIDc7rF/
         MmI76MlZN8DzgaSf7t0AgC7necEEv/lrtMBXNWKflVdpgEruQHliqU0f8eb/4dFsIytI
         KCvQ==
X-Gm-Message-State: ACgBeo1aazkFyvY0zszy8ACKWYMPYMih000QOKg9YbydLafZuvixUpH+
        Blv/6QQO/DpFKHE/Gpc7bybFSkpFTcbv2nYvHjsvjDXl
X-Google-Smtp-Source: AA6agR7keC7o1LaBA6FdPEjezVKDG9tZsO9ABOeeccUYRet74YeiohD0rMsIAEc0SrBZzVgX29S+r9c1Wc64MWYVfto=
X-Received: by 2002:a17:906:8b81:b0:733:183b:988e with SMTP id
 nr1-20020a1709068b8100b00733183b988emr36582320ejc.457.1662413239154; Mon, 05
 Sep 2022 14:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
 <20220905081552.2740917-8-senozhatsky@chromium.org> <CAGsJ_4yciyk49cTk9A4di2sM=io-4z5oi4Q7P-SUOG-MGJGcQg@mail.gmail.com>
 <YxXHFZ1PJI3h6BZY@google.com> <CAGsJ_4zqXJJHA02NzyZ662jfL+sNp3LrErTP18vGz2N4u1Tqiw@mail.gmail.com>
 <YxXM0PwVEghPF9hg@google.com>
In-Reply-To: <YxXM0PwVEghPF9hg@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 6 Sep 2022 09:27:08 +1200
Message-ID: <CAGsJ_4x5zGNydNm_3YxdQOAiVhKE4XRStwwHPeQHF7kfeP=iJA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] zram: Introduce recompress sysfs knob
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Sep 5, 2022 at 10:17 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/09/05 22:06), Barry Song wrote:
> >
> > make sense! thanks! i assume you will have some benchmark data to compare
> > three cases,
> > 1. lzo with recompress zstd
> > 2. always use lzo
> > 3. always use zstd
> >
> > such as power consumption, cpu utilization, available memory, benefits to user
> > experiences especially to UI smoothness under memory pressure?
>
> So I didn't want to include any benchmarks, because this is entirely
> specific to device's data sets/patterns. In term of CPU usage, zstd
> decompression is really fast [1]; and the way plan to use is battery
> aware - e.g. when low on battery do not recompress at all, if AC is
> plugged in then recompress more aggressively, etc.
>
> In term of benchmarks... a copy paste from our internal tests. But
> *do note* that this is relative only to our specific data sets.
> Your millage may vary.
>
> ZSTD recomp algorithm (5.10 kernel, so the last column is the number of
> 'zram huge pages'):
>
> - Initial state of zram swap partition
> localhost ~ # cat /sys/block/zram0/mm_stat
> 8955662336 2180671776 2277711872        0 3179720704   798724   469474   118949
>
> - Recompress HUGE objects only
> localhost ~ # echo huge > /sys/block/zram0/recompress
> localhost ~ # cat /sys/block/zram0/mm_stat
> 8944390144 2106998658 2211835904        0 3179720704   798617   469474    66821
>
> - Recompress IDLE pages that are >= 3000 bytes in size
> localhost ~ # echo 3000 > /sys/block/zram0/recompress
> localhost ~ # cat /sys/block/zram0/mm_stat
> 8934166528 2085232505 2207690752        0 3179720704   798484   469474    66811
>
> - Recompress the remaining IDLE pages that are >= 2000 bytes in size
> localhost ~ # echo 2000 > /sys/block/zram0/recompress
> localhost ~ # cat /sys/block/zram0/mm_stat
> 8913981440 1946488434 2145157120        0 3179720704   798130   469474    66498
>
> - Recompress the remaining IDLE pages that are >= 1000 bytes in size
> localhost ~ # echo 1000 > /sys/block/zram0/recompress
> localhost ~ # cat /sys/block/zram0/mm_stat
> 8905592832 1711533182 1984495616        0 3179720704   797162   469474    66222
>
> [1] https://facebook.github.io/zstd/

Thanks very much. I guess the difficulty is that we need to
comprehensively evaluate its
effect on a real product such as android. there is always a trade-off
between cpu utilization
and more available memory.

Best Regards
Barry
