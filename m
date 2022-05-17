Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69152A3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348060AbiEQNwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbiEQNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:52:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A336240
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:51:59 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q10so22325331oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqs07Jep3liZKF0qlg72VGmG+rgWTVuefUqFlS6fV4E=;
        b=DiyJpaLtLiYYlr+WkATrplEODo5bpr5osxh2vS/3wvBAVDg1+JkKE+BoRb/ttsfyxR
         oyGcWzpr8/ipWcCIG1yqypp3VD5SCK5bpCmQ8+b0t/LwlQQ1LRSzngujpNhBVwqW0qlN
         yI4eubrQloteLw4cIuZ4Uvom4nlBVe0o8aM4W6lG/RTxYc/HFY1yvowv9/qGN4I09tEk
         4aeEaBU3bCgsrByt+TIHgA6Ig/WKhID3AuRuRmrK9FzIHkZKm8p4s0osfPr9hwLfegpm
         QfzFD8+BNwyg+FWKLL3TAH6bEtftK+2esD3jqnRtviYJ/lZTlhvbJFLu7JTZxUN+dBKY
         vnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqs07Jep3liZKF0qlg72VGmG+rgWTVuefUqFlS6fV4E=;
        b=UL/l6BMrP+omegmJ5gpVU+gZqUHK3oObotoY/rasIfyfZr1VxKk0sdvCUHkdok3Z1D
         hqwRsApR9iuIT2X+/mUPC4TNWXZPISFOwSGtrQ277EZAnKuK8Wyddsi4BAGjH7X9yXfu
         7mVPsreUXQCJe1UYynZu8ogz8sVrsCAyXWojeQijQe3/FJEvCFf44VocLs0mmyUiKmtZ
         Y8CU0YmcK5RwWJmKzepi4V8QPb7ecnXdA4VsOdVmGhiSwQMESXRfqtmTi5Zh56AQDqdQ
         SZtvBZB9xZk3t0sfuVIyCO9FnQwZK8xQyOzSglv4Jr4vQsGXRvYXGNWem3GjqY/rj85B
         VLCQ==
X-Gm-Message-State: AOAM531Cji/c7ZAH1O2X5yYV3tVPFvGtx2ATsQ5BONFDF43W5pMZZvsL
        8Io5Liaktgc4b9uYdegOdaWCk/1SIcMGchyPdYfrHSy8Qp0=
X-Google-Smtp-Source: ABdhPJwryDf71vdU031pJAEI8zXEOUflzmYA497rKIyES5J2JKlDPPLwnq9rb0Qv4oal9+7ZDUMhhtoygFYY1XXmzsY=
X-Received: by 2002:aca:39d5:0:b0:326:b279:592 with SMTP id
 g204-20020aca39d5000000b00326b2790592mr16218328oia.276.1652795518396; Tue, 17
 May 2022 06:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220516170306.6008-1-makvihas@gmail.com> <20220516170306.6008-3-makvihas@gmail.com>
 <7b926f43-8c6b-6eae-edc6-02dc16376eb0@gmail.com>
In-Reply-To: <7b926f43-8c6b-6eae-edc6-02dc16376eb0@gmail.com>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Tue, 17 May 2022 19:21:47 +0530
Message-ID: <CAH1kMwTM9oT+wr7D7km68LXYWxs1TvsjhsFizq9Bm2juvQpJyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: r8188eu: fix checkpatch.pl warnings in rtw_pwrctrl
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
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

On Tue, May 17, 2022 at 1:15 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Vihas,
>
> On 5/16/22 20:03, Vihas Makwana wrote:
> > Refactor the code to fix following warnings:
> >      WARNING: Comparisons should place the constant on the right side of the test
> >
> > Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> > ---
>
> [code snip]
>
> >               if ((pwrpriv->smart_ps == smart_ps) &&
> > @@ -356,7 +356,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
> >
> >       pwrctrlpriv->LpsIdleCount = 0;
> >       pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
> > -     pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
> > +     pwrctrlpriv->bLeisurePs =  pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
> >
>
> Please remove extra space
>
Oh sorry, my bad. Will submit a v2.
>
>
> With regards,
> Pavel Skripkin



-- 
Thanks,
Vihas
