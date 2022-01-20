Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAB494F19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiATNgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiATNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:36:11 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EDC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:36:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c3so5223944pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUW2meWg5OLvz//LwavLlfc7na/3LKc5cqojegOb3/c=;
        b=WF7bL4I14qBhW2FNg9LW9XFoQ0NYbf5Mr6wONjTv5s8d5RdkQ3IvuebvI5CvOmRbST
         5ZUuICBHB6peiMKpjp6+vEeYj9aqw8wrRqPlbTSZaou3I1CE1qSkFGKopSd/3ZkOk/yU
         faEzmOFcYagv6d9wWzkOCd074azLgS72uNRSYbxsU/WRIj5Vh771BgpSxHMJ5zbZQY4y
         EkgsjojvKwyfuH6ENLTkREX9k0CS/mCDwrdGglke8LiQ4kff8uVNEcUSJzrJqvdt2RXM
         9m3e8Jz5RFGLlVUPbJbLBIzIaEmuQoll0FY2sHlktkVH2cA1ZMelQ6T+NPoQ8q3vFkv8
         UHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUW2meWg5OLvz//LwavLlfc7na/3LKc5cqojegOb3/c=;
        b=CzP0Tl20KVs3Iag01j6JL3qljz5zKLd8Vaf3kCBhj7xwvQze1PylH0H5A+zypfZeRL
         /BK066CShQaQgAVpVLR4hUGZwXi1OxCNF6CtgEpLS+ri9+OL5Ala+EkKoE1LCjOxsWzP
         OPj33Q1PI4vuhPBIKdE8onajGCEPBT0p1rznH7EyPBRbTcgiyOZoUIgw8S1V/iCkZFPI
         Roeyk77qIq2eiRpKc8TOyjr7b5Ic/gUypkgRdBi5A+1ixPNlpEffe6hE19zNFcPCp7PW
         i/NXWo/Obfg4rc5EavlsvvRLZWux2YMfghgjBhBwqp4jc9RE+eYXPWhFsQCLtP1nZrPj
         Xftg==
X-Gm-Message-State: AOAM533O3lX3VCa4DbzHBcskgFWQk4UdadiAYzDz/qqQdKiKtu2Gpm8a
        1lpjDngAEwDcg2wCDo+tkDgdGB4JN+KhoKkDWbi6bg==
X-Google-Smtp-Source: ABdhPJxgR5PMNTAlh10RT/pYJXQeMj9K9h7xxK0wSfgQYf0oNgYaXG9Pesy/HUOzhsGf0mbIMj3Pn5wE83MdKoNoqug=
X-Received: by 2002:a17:902:e792:b0:14a:ff44:41c6 with SMTP id
 cp18-20020a170902e79200b0014aff4441c6mr5476077plb.111.1642685770783; Thu, 20
 Jan 2022 05:36:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPqJEFoUyHiyNj8Hx-wRaw86NLb5hGo-WT4ysqV4RGerYyDyJA@mail.gmail.com>
 <CAM9d7chL4_hY8BLHV=q2J_HJ14gUj07t5QvUvUBOj+4hmvY7hQ@mail.gmail.com>
In-Reply-To: <CAM9d7chL4_hY8BLHV=q2J_HJ14gUj07t5QvUvUBOj+4hmvY7hQ@mail.gmail.com>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Thu, 20 Jan 2022 21:35:59 +0800
Message-ID: <CAPqJEFqJpnq1TF-ZA7Worsy2Yx6au-KHBPkCN0cSnQuyGbwsfw@mail.gmail.com>
Subject: Re: About perf tool set exclude_guest = 1 on guest environment
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Wed, Jan 19, 2022 at 1:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, Jan 17, 2022 at 8:05 PM Eric Lin <eric.lin@sifive.com> wrote:
> >
> > Hi all,
> >
> > Currently, I run the perf command 'perf record -e branches:u ls'  and
> > 'perf record -e branches ls'. It will set exclude_guest = 1 as below:
> >
> > # perf record -e branches:u ls
> > # perf evlist -v
> > branches:u: .., exclude_kernel: 1, exclude_hv: 1,, exclude_guest: 1, ..
> >
> > # perf record -e branches ls
> > # perf evlist -v
> > branches: ..., exclude_guest: 1, ...
> >
> > As I understand it, set exclude_guest =1 will not include guest counting.
> > May I ask if I run the above commands as a guest user, should the
> > architecture implementation ignore this exclude_guest flags and still
> > make perf can count guest events in Linux kernel?
>
> So do you want to run the command in the host?
> Then you can use both 'H' and 'G' modifiers like
>
>   # perf record -e branches:HG ls
>
> or (for user-mode only)
>
>   # perf record -e branches:uHG ls
>

Actually, I want to run the commands in the guest.
But when I run the commands "perf record -e branches:u ls" and "perf
record -e branches ls", it will set exclude_guet = 1.
According to the documentation[1] exclude_guest definition, it should
not count guest events.
So, if I run these commands as a guest user can I get the profile data?

[1] https://man7.org/linux/man-pages/man2/perf_event_open.2.html

Thanks,
Eric Lin

> Thanks,
> Namhyung
