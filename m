Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AA48437A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiADOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiADOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:34:54 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078A3C061761;
        Tue,  4 Jan 2022 06:34:54 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g80so64766074ybf.0;
        Tue, 04 Jan 2022 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1I8V+uRVCFde8TDw1Syj7IYeFiqjg/uEQaa3IZgcSIM=;
        b=mH2ASWCXNWYTYQ9alZR/1t3Wck2R+vlUTMOapZnK+hDDwBwtoyBiFWiwiY0cohppS5
         Ram0FqKQyb1Z2kAFtxKYdjRXfbUbQkzkldOINID9arbh0Fc5QoD2V/Hux0S/mArNj3Vu
         yN2656APixeSzZrvZNNWI9keCwx1H3TPWtNzNqjsG+F090upzaT7UP5ZTS+wUiMcy2om
         FpfAfXD+GRv0Q8DdukycG8v59FfjH7HEJlOsoZSwBAMG3z9FFbT0CT5P6zioA0d6tX/w
         d0Oz0mTfnEIWEN6Y/We12rGs+eOFAI5TNZEkkOqB6iMiPWH82+JdJ1KtQ6pfmHLnEv0g
         HoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1I8V+uRVCFde8TDw1Syj7IYeFiqjg/uEQaa3IZgcSIM=;
        b=2kcf7sPuqUQMZpt5yYSIYaKzZVzDbeR+RBhfuHs1nSTPbddNTcxnh+1A8SgiBYhbm1
         CnTH2/GQsfXGNEqIqnu7AcqMC3BJWHdHWHkEZaA+I0zmoIKfG4Pq5jMWF0u08ZHiB1bZ
         uAULpmmx3Ffg6ml9fbOXFJ9B+ebY/SzrIHNJYXVzaRFuB9d24mU9k6/QUgwBT1oRJ203
         BAZL+cRwxNSFPEwT74EVRat1RVzQawpGK4KZTGeZ1NknyPCma2fvp6V9iILT49e8mjHQ
         b3R5nUyJC0pTsWqWWsZ0lxCPLxLzCGW+xAp5sl58e2MJeTY7YI3GNtG9uYoj6RbU+YX6
         dgXg==
X-Gm-Message-State: AOAM533FR46Yyn8O4WATOV3txmggO3/akpt5aL2A6x2++WNMCNvgDaME
        f1m8FmfJYpWWrsuLrwFI2h8YHcXfc5VBnqU/xFM=
X-Google-Smtp-Source: ABdhPJxgLTDOUdxKtPHOX3cG7eOARJMBZpSD/Q4L7hc1uYG+3yqK2qJ2ww2LO3vykV6WyzHwQ5UmTOUf/af+jbPd5mE=
X-Received: by 2002:a25:44c5:: with SMTP id r188mr61357398yba.160.1641306893263;
 Tue, 04 Jan 2022 06:34:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
 <6338e7cd-80cb-11af-e3c0-edd740bb9e49@gmail.com>
In-Reply-To: <6338e7cd-80cb-11af-e3c0-edd740bb9e49@gmail.com>
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 22:34:41 +0800
Message-ID: <CAFkrUsgEJcMAdVUP3aUB7-H4YmUjFeii5754nPpOVh+vo3bnLA@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in hci_uart_tx_wakeup
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are so sorry for that. You can try the following websites, which
can be accessed without registration.

console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/

Sorry again and look forward to your reply!


Best Regards,
Yiru

Pavel Skripkin <paskripkin@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 1/4/22 11:49, kvartet wrote:
> > Hello,
> >
> > When using Syzkaller to fuzz the latest Linux kernel, the following
> > crash was triggered.
> >
> > HEAD commit: a7904a538933 Linux 5.16-rc6
> > git tree: upstream
> > console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/plain/
> > kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/
> >
>
> Btw, can you, please, use plain pastbin or something else, that does not
> require a registration? I think, most people here do not have ubuntu one
> account and don't want to have one. I saw people using google drive for
> these kind of things
>
>
> Thanks for your reports!
>
>
>
> With regards,
> Pavel Skripkin
