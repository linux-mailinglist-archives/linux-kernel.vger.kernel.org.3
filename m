Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2714D565C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbiCKALG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbiCKALF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:11:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A18E33B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:10:02 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so9061863edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMsnPfIeFhcT/A+mOIpT8BizjTvoRzNLbD80C+vEk3o=;
        b=U14PzJxheO/vJL9Rww/dMabBJRadRTYlvjXwR7qG4oC3q+WyKvn6l2tiUrjHKC5Xg5
         z0cOkeP382PPXrRh9Qq6b2XHmH9AuQsYxH5U+WdBz1GscO2G0oyPHQNo/kl0qBb4128n
         jaMihxfUqI99y+zcxh3ygaRAIXepFq2Da3HzG9QVk1NnQJGVGRHZnfyciducfPnRl2Fz
         K1INlVkRa+EZkjrtO1r1uiwWv0leGX/2Ye3zDyHHD2h9jUAL5ttGrDFhfhtgHxDo38Po
         HhpKVye4eRElZFSFT7gQb+6hLoYIbj7WqVI0JMusxmqVcYoQVirOcadSlda+pVXAQOCQ
         t02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMsnPfIeFhcT/A+mOIpT8BizjTvoRzNLbD80C+vEk3o=;
        b=nM2gFvrz+S3tGg+XXmTsSNJ+Wm+B0okeNaCM5yn+KaO36g2wz09ZeXsTWVngZ0E39D
         zF9W64UP1YyGVqHjKYuQ/yGwPQlcuYQ24UV0+j/dVuXdUcVASXxUbLEDT67RhD1ry23d
         dB/zf+Wg6WIJuc7vQniHij8OdqOW+o63OIizaHHZMbmetwTT0U+I5LhZ/qbnniK+jOxx
         Ym0twiF5+W9G1TJYpoW8Sw8U0XG2CX+8PgQD3unSyqaKW0CeOmD5At27HN3NkY6kugev
         RxKmEUfmd9+ir6p2nnffLSh0PzPzSKBTl6D/Nc90PhxEy8LcBipH250SuXnl63O4zl2i
         wQ9A==
X-Gm-Message-State: AOAM5301JO7Aw1usq/h2QCeMgXkAkRPO32YB58Vm0ya58OK4Zu9KF6s5
        GhBLKSMEZbxYLI194oA4QCQ2H39Jsq5scbwAHi7XRg==
X-Google-Smtp-Source: ABdhPJxSCMlJEMTP6h0iffFHHi5CfCb2EvS9rNVF40fF7OX12GePFKpiUtWOhXBGANyDpo7VU6DCYVeVqOCUQCdWbsQ=
X-Received: by 2002:a05:6402:4390:b0:416:a29c:660c with SMTP id
 o16-20020a056402439000b00416a29c660cmr6678999edc.149.1646957401135; Thu, 10
 Mar 2022 16:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20220303230301.255049-1-suzuki.poulose@arm.com> <YipxKx+P7Dyc70vS@kroah.com>
In-Reply-To: <YipxKx+P7Dyc70vS@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 10 Mar 2022 17:09:49 -0700
Message-ID: <CANLsYkxJd-wdnkvL1=WQOEQR2E5TJDK_5XR1QWkkOt8giRfkAw@mail.gmail.com>
Subject: Re: [GIT PULL] coresight changes for v5.18
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 at 14:44, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 03, 2022 at 11:03:01PM +0000, Suzuki K Poulose wrote:
> > Hi Greg
> >
> > Please find the pull request for coresight subsystem for v5.18.
> >
> > Suzuki
> >
> > The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:
> >
> >   Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.18
> >
> > for you to fetch changes up to b54f53bc11a584713f79a704c70c488489f524b8:
> >
> >   coresight: Drop unused 'none' enum value for each component (2022-02-28 09:51:40 -0700)
>
> I have the following errors when pulling this tree and having the
> scripts check the commits:
>
> Commit 5340bf5df9d2 ("coresight: syscfg: Fix memleak on registration failure in cscfg_create_device")
>         committer Signed-off-by missing
>         author email:    linmq006@gmail.com
>         committer email: suzuki.poulose@arm.com
>         Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>         Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Commit 91a2f2941df2 ("coresight: Fix TRCCONFIGR.QE sysfs interface")
>         committer Signed-off-by missing
>         author email:    james.clark@arm.com
>         committer email: suzuki.poulose@arm.com
>         Signed-off-by: James Clark <james.clark@arm.com>
>         Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Commit 7f4cd3375906 ("coresight: trbe: Work around the trace data corruption")
>         committer Signed-off-by missing
>         author email:    anshuman.khandual@arm.com
>         committer email: suzuki.poulose@arm.com
>         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>         Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Commit 0ecf2c747437 ("coresight: trbe: Work around the invalid prohibited states")
>         committer Signed-off-by missing
>         author email:    anshuman.khandual@arm.com
>         committer email: suzuki.poulose@arm.com
>         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>         Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Commit 8b6927d0adad ("coresight: trbe: Work around the ignored system register writes")
>         committer Signed-off-by missing
>         author email:    anshuman.khandual@arm.com
>         committer email: suzuki.poulose@arm.com
>         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>         Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
>
> What went wrong???
>

(Sigh)

I know what happened.  The tree was rebased from -rc1 to -rc3 to pick
up a dependency with the aarch64 tree that was needed for a patch.  In
doing so the original committer information was overwritten, which is
what the script is complaining about.

We will send you another pull request.

> linux-next didn't complain about this already?
>

It did not.

Thanks for the patience,
Mathieu
