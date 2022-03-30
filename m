Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E84EBA83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiC3GBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbiC3GBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:01:38 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867141CFCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:59:53 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kd21so13211578qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fii15z5BdqeKVdyRrQjR89UzGkIpNccPLX9tr8s7gIA=;
        b=iCWRSqk7ZZDcLY7AA0TWbvoaXCD5tIK4K0pYqtP3XYWJ++OAYC87CxlQVCTeWn7H4c
         s0DzUM66DR2NQboRA7PMOl4KLRskQGe6Hw04doFvF0qp2AEx6iFf7SN1HssCa2D2rw7u
         GKIzcGWapWdM+T/2qrpCtcIm7Au62A9I3zjDzYhac0QAavc1ji1iNm5ToVOlZulxcODB
         kBkBEvJIIGVo3F8AxVtPnQOuvAmB3lFcHq8Xu0LsJBg4oMdsp3VV0c9p/cBsA/WZJ+kk
         lxZu+92fP9sa+tXUrHWpFHquEOQP2Y2MdSqbFI4aCY2kxWdfpH3xsyflCCGknadk1lmD
         uYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fii15z5BdqeKVdyRrQjR89UzGkIpNccPLX9tr8s7gIA=;
        b=YNmbYQuCe580B1Ez0DUoxYyqVDlweHT9jl8kE0DHxRdD1mJV4tIZY4zxuSgsWKGuwe
         ICWe1fw1O1eY9I+VRzKYqNYy9IS+9Pe+jCsXX/6ZAHRC/bHwmPImNysnp/p84W55+mhT
         IOjRZvVFGHmT9Is5gH4jbCntnD1RiviPad7CHTvAuaqBru5VEiaPXP3a5sJjlLSmlhho
         SPsgB+t/yJj5A7PqZcvh62E1O+IyXQacg+eGUSjiGoe3ni0PMXCCiVtdlnaIDshp+NVT
         qCGlCZfr42nzkXkRyKGT3lA84dVo1vcZrv7Vu4SnAsingJ/1jwQYs/bcY3QzR/dRnSKM
         Llfg==
X-Gm-Message-State: AOAM530iUvQ/rko7CeZDMfr1xsvRkFvtlcHiFm7ssfmFy6FhkDjxfhmw
        NVcmHAVTb6sr4HY0e8xA7v4=
X-Google-Smtp-Source: ABdhPJy7JhQnst3fNKGP6qDDp0NbdUv+svIp+Ze3jCARpjEflPmrl1E9FEk9a+xm0onCdHJQkFWRJQ==
X-Received: by 2002:a05:6214:20e4:b0:441:7bed:5ccd with SMTP id 4-20020a05621420e400b004417bed5ccdmr25606284qvk.119.1648619992562;
        Tue, 29 Mar 2022 22:59:52 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z19-20020a05622a029300b002e1a763dac1sm16867557qtw.9.2022.03.29.22.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:59:51 -0700 (PDT)
Message-ID: <6243f1d7.1c69fb81.b19c7.7ec1@mx.google.com>
X-Google-Original-Message-ID: <20220330055949.GA2378119@cgel.zte@gmail.com>
Date:   Wed, 30 Mar 2022 05:59:49 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com>
 <62426553.1c69fb81.bb808.345c@mx.google.com>
 <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
 <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com>
 <CAHC9VhTLTQmHaka9tTyuu=rQOzpsn_K2NxfJ==7-6FSY3KnuFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTLTQmHaka9tTyuu=rQOzpsn_K2NxfJ==7-6FSY3KnuFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:11:19AM -0400, Paul Moore wrote:
> On Mon, Mar 28, 2022 at 11:22 PM CGEL <cgel.zte@gmail.com> wrote:
> > On Mon, Mar 28, 2022 at 11:06:12PM -0400, Paul Moore wrote:
> > > On Mon, Mar 28, 2022 at 9:48 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
> > > > I have no alpha environment and not familiar to this arch, much thanks!
> > >
> > > Regardless of if this is fixed, I'm not convinced this is something we
> > > want to merge.  After all, a process executed a syscall and we should
> > > process it like any other; just because it happens to be an
> > > unrecognized syscall on a particular kernel build doesn't mean it
> > > isn't security relevant (probing for specific syscall numbers may be a
> > > useful attack fingerprint).
> >
> > Thanks for your reply.
> >
> > But syscall number less than 0 is even invalid for auditctl. So we
> > will never hit this kind of audit rule. And invalid syscall number
> > will always cause failure early in syscall handle.
> >
> > sh-4.2# auditctl -a always,exit -F arch=b64 -S -1
> > Syscall name unknown: -1
> 
> You can add an audit filter without explicitly specifying a syscall:
> 
> % auditctl -a exit,always -F auid=1000
> % auditctl -l
> -a always,exit -S all -F auid=1000
>
I have tried this, and execute program which call syscall number is -1,
audit still didn't record it. It supports that there's no need for audit
to handle syscall number less than 0.

sh-4.2# auditctl -a exit,always
sh-4.2# auditctl -l
-a always,exit -S all


> -- 
> paul-moore.com
