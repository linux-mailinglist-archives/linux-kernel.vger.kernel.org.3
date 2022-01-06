Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6F486422
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiAFMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiAFMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:08:29 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD11C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 04:08:28 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c6so4663786ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpgGSyGEQQRWhz6gLn6Z6w69YoxpmLPVoF4zi6f/rTk=;
        b=a4Xyp/+RhmcQ+zI9Lfyyfye8LM3oO31xxD6pjYkFTDiJKpJ/Fw8ZyeH6bhJdDgdRGI
         OEa9eGcE473qdzC26Qlm7rmL/Sg4T4QyZCwQn2FCFNnP/fmSfXiKBnQbPl6NmlzZ+nZ1
         PCtyUjRWVeYbpBLDwKBeNlduiJkeSBOtVYMt7oCYj8jVzP1RrsmI+h4/M3PE3X2ZXRlW
         +xKRW7bbA6umK+1WVR1cKOXFQAmt0Cn5OE2qPpx7Aefi/DZzEHoHQuiC1txiCEme4V0v
         c1laAWm9Nwi4K0xnw6f2Q2bTr6gXeRHCvjQEoOlcWcc1CwNcbG2N10GQAZz1/UalLYV9
         IjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpgGSyGEQQRWhz6gLn6Z6w69YoxpmLPVoF4zi6f/rTk=;
        b=r+ePQ0yZjJRH8vWs79bMwJOAO6oVooskjk0NEcCPnWSxM+oCeUpqKtBFkW3kYgt5Mq
         dbu9JT6/9B2+3qLdaFMVEr8oy16UFTJGOd+x5oIdCAc95HFkjStFw7VF+gsz/5QrqdN7
         VCDaxxTzJCcSbwdKJWmdHNReS8+NhKFxOrcPKmFmSvdGUJCxDFM9ohWW+SSVM3kH6NVf
         ktUeLhuRT8CzbD+jv0h4ur88rOYic2MsV2BhZCpOESkYXi+Sl2I+ji8KvQR0C51FTz8l
         cdw5nOUwfTvZAlCgOlF92O8UmHmcbmXSTcGdDt4Bm8H0LovFbJTtmK162w/DfWW2/+Ap
         V4kQ==
X-Gm-Message-State: AOAM533hV4wIisTG32I7LkJvpLtHOT63UR4f0GPAX1TYnLPKBENW6uHg
        y25CAUZjMioNoSQ7eBLhfb8ngyrZdxvwd+o33aoMVQ==
X-Google-Smtp-Source: ABdhPJyhNaXBOIV9KQ0ZfZklIGrupJ1mp6YPxTPe7msSU2KFafqbM/WnBo2uvkGtF8P0VhBWZZU2GeQO5fNgrzdURxc=
X-Received: by 2002:a25:b981:: with SMTP id r1mr68402195ybg.520.1641470907960;
 Thu, 06 Jan 2022 04:08:27 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtaoxVF-bL40kt=FKcjjaLUnS+h8hNf=wQv_dKKWn_MNQ@mail.gmail.com>
 <YdbGZiKKdVgh8A4i@kroah.com>
In-Reply-To: <YdbGZiKKdVgh8A4i@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Jan 2022 17:38:16 +0530
Message-ID: <CA+G9fYtNQh8KygC7ufvkMuB_d7PX-meknhOpDcuQiPx8oBcrCA@mail.gmail.com>
Subject: Re: txtimestamp.c:164:29: warning: format '0' expects argument of
 type 'long unsigned int', but argument 3 has type 'int64_t' {aka 'long long
 int'} [-Wformat=]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jian Yang <jianyang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 16:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 06, 2022 at 03:39:09PM +0530, Naresh Kamboju wrote:
> > While building selftests the following warnings were noticed for arm
> > architecture on Linux stable v5.15.13 kernel and also on Linus's tree.
> >
> > arm-linux-gnueabihf-gcc -Wall -Wl,--no-as-needed -O2 -g
> > -I../../../../usr/include/    txtimestamp.c  -o
> > /home/tuxbuild/.cache/tuxmake/builds/current/kselftest/net/txtimestamp
> > txtimestamp.c: In function 'validate_timestamp':
> > txtimestamp.c:164:29: warning: format '0' expects argument of type
> > 'long unsigned int', but argument 3 has type 'int64_t' {aka 'long long
> > int'} [-Wformat=]
> >   164 |   fprintf(stderr, "ERROR: 0 us expected between 0 and 0\n",

<trim>

> Same question as before, is this a regression, and if so, any pointers
> to a fix?

This is a known warning on Linus's tree.
The fix should come from Linus's tree.

- Naresh
