Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E024EE587
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbiDAA5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDAA46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:56:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3A1F1251
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:55:10 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u103so2334338ybi.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86DTzap4bdiVTuZNwdTqOhXAkw8m2QiKxxFLmTpRn4c=;
        b=ewPouCCRc+TgbTluxb631jmVzywNZXcbJ2uyae1cvgEjQU1HOuXtjU0wGn8FjveNfi
         iFRvHs3BdjHl+0JaNAFnPpps7juudS8kviF/Xx6ggtd75I3XsR4mz1pV54Qt4L9qZqvt
         8yz1mtdv1yOcLvKVtlQgqFVYYT2RtY2xuYYdCpT4XUypYhDLcXyfGl7ey+IzwV+MEQA6
         9fp1HUZTmsqxQW0d0Z0G1kqnSSxXJ3J6kxa+Eyw3HbCJ47ooTm2DG8rj/E9Xje+Wat6a
         mELDMimY7kAyj87oS5SU3W4b7h5+1s4WHO1abjlxM5xAbRIHPqrXgNYyYHxlR40NWrUG
         gEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86DTzap4bdiVTuZNwdTqOhXAkw8m2QiKxxFLmTpRn4c=;
        b=D9YsZGbQNRp36eazl+rEDUQ6xiCKatYeYJvq6Os7WZCfDzRVPBGevFxbd8zrXKKe86
         mkHr0Skkrol5GTpOimOIdluQn98E9jPpVXP/Lufq7KqtkPjnDq+R6aa+9KGpiNofHGu4
         JiAq+NFNH6ikgQy/PXTKbvRmKhuE3fq5SFUJuKwZo+Q0KPVL0Q2NtwURobbU90+Ay/wK
         YhbdpzB51OdG+TGkzLDwQIqwoIkAYWGdM+wr7/NyyALvEwaEEgEyWMk2pcI2hRnrdWyM
         rxSU5nLDjUsrumslDwjzo4+c8sdcjRsatbHb9rU7pQPQRxst2aIAg11qIPuYyOgbhUEn
         QZdQ==
X-Gm-Message-State: AOAM5316/TaJC4ofiNDatoRRl5Zi5Z6zM4i7jNWYPdZseNv5lYDrSdrV
        VBswyfIz64KXatEi+kZ4ZjVKqiZ4/P59tAqeQX64Tw==
X-Google-Smtp-Source: ABdhPJzzKIq9hPymPphLUnTQT4/xUNSd8LVrZ4/47f29wSqMfPIYp3UhD2pvEracvmXnYanipnWJu3BDkDIqzjDIBYg=
X-Received: by 2002:a25:8382:0:b0:63d:6201:fa73 with SMTP id
 t2-20020a258382000000b0063d6201fa73mr628199ybk.55.1648774509318; Thu, 31 Mar
 2022 17:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <E1nZMdl-0006nG-0J@plastiekpoot> <CADVnQyn=A9EuTwxe-Bd9qgD24PLQ02YQy0_b7YWZj4_rqhWRVA@mail.gmail.com>
 <eaf54cab-f852-1499-95e2-958af8be7085@uls.co.za> <CANn89iKHbmVYoBdo2pCQWTzB4eFBjqAMdFbqL5EKSFqgg3uAJQ@mail.gmail.com>
 <10c1e561-8f01-784f-c4f4-a7c551de0644@uls.co.za> <CADVnQynf8f7SUtZ8iQi-fACYLpAyLqDKQVYKN-mkEgVtFUTVXQ@mail.gmail.com>
 <e0bc0c7f-5e47-ddb7-8e24-ad5fb750e876@uls.co.za> <CANn89i+Dqtrm-7oW+D6EY+nVPhRH07GXzDXt93WgzxZ1y9_tJA@mail.gmail.com>
 <CADVnQyn=VfcqGgWXO_9h6QTkMn5ZxPbNRTnMFAxwQzKpMRvH3A@mail.gmail.com>
 <5f1bbeb2-efe4-0b10-bc76-37eff30ea905@uls.co.za> <CANn89i+KsjGUppc3D8KLa4XUd-dzS3A+yDxbv2bRkDEkziS1qw@mail.gmail.com>
 <4b4ff443-f8a9-26a8-8342-ae78b999335b@uls.co.za> <CANn89iL203ZuRdcyxh16yKXqxXJW2u+4559DsDFmW=8S+_n7fg@mail.gmail.com>
In-Reply-To: <CANn89iL203ZuRdcyxh16yKXqxXJW2u+4559DsDFmW=8S+_n7fg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Mar 2022 17:54:58 -0700
Message-ID: <CANn89i+6LCWOZahAi_vPf9H=SKw-4vdMTj5T0dYsp1Se4g9-yw@mail.gmail.com>
Subject: Re: linux 5.17.1 disregarding ACK values resulting in stalled TCP connections
To:     Jaco Kroon <jaco@uls.co.za>
Cc:     Neal Cardwell <ncardwell@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 5:41 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Mar 31, 2022 at 5:33 PM Jaco Kroon <jaco@uls.co.za> wrote:
>
> > I'll deploy same on a dev host we've got in the coming week and start a
> > bisect process.
>
> Thanks, this will definitely help.

One thing I noticed in your pcap is a good amount of drops, as if
Hystart was not able to stop slow-start before the drops are
happening.

TFO with one less RTT at connection establishment could be the trigger.

If you are still using cubic, please try to revert.


commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Nov 23 12:25:35 2021 -0800

    tcp_cubic: fix spurious Hystart ACK train detections for
not-cwnd-limited flows
