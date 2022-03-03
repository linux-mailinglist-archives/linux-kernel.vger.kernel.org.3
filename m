Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD914CB391
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiCCAD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiCCADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:03:21 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707EE13F92;
        Wed,  2 Mar 2022 16:02:33 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 22302EVL025068;
        Thu, 3 Mar 2022 09:02:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 22302EVL025068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646265735;
        bh=q2ESIbL2ur/uVgrpoH1ou7aTk6vOKFdeTWoLHrqeazk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JMlB+b4GTPhYQHieWq1Zxsvae0M4wM63UN3NMxZ89BpjwrCb8dVJcupcNB7oNdsAd
         RJ0bO0KpSh+EPbLVEwGHua9flll4n9q+a6cPfX3N6B55WyPJ0PVE5jsdsyF8W+mDFM
         X8DOgQJSuMfhj0ppmN7InVdUqRPjQPYvOIS6hPZnLeSESIIakgO6u9A64pAW5y8d1a
         QFpARLS6/xGq6btWNlevlSku8xBv5gDPRCCiztlf+GKwiIGMcuFcvGAQbys41/TnLw
         Qtui/SlPKatuOAs5v0XOWuqN41BcEJkk+GgEq9FLT2Zg9Lzr+Pw9P2oa9AzgvnWoCW
         5c+eqi5ChCWuA==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so2179067pju.2;
        Wed, 02 Mar 2022 16:02:15 -0800 (PST)
X-Gm-Message-State: AOAM531Md+mzWXEXbtJLaLGBDw8KksXpCo+QMZ8Ab3xtG/vqaW0j6Dhm
        vdQuaW2EtKZ9bPiUOSJl4l3AROakNuAJH0XYJHI=
X-Google-Smtp-Source: ABdhPJyQAiBdGbAwXYuJr3tY3nnQBtL+cC/OwcCMGdHg6dkzHq1D+LHcd7w6NBc6K2ZNpe8EqbM7lcxaXCzB5ct6SK8=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr15817258plp.162.1646265734496; Wed, 02
 Mar 2022 16:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20220218044634.169520-1-masahiroy@kernel.org> <20220218044634.169520-2-masahiroy@kernel.org>
 <YhSa8bOW7sOd1cp0@buildd.core.avm.de>
In-Reply-To: <YhSa8bOW7sOd1cp0@buildd.core.avm.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Mar 2022 09:01:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREW5Wm=LuJZvMzUvAczuSG4UaXyDZvew2xc44ydUZVjA@mail.gmail.com>
Message-ID: <CAK7LNAREW5Wm=LuJZvMzUvAczuSG4UaXyDZvew2xc44ydUZVjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] certs: simplify empty certs creation in certs/Makefile
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 5:12 PM Nicolas Schier <n.schier@avm.de> wrote:
>
> On Fri, Feb 18, 2022 at 01:46:34PM +0900, Masahiro Yamada wrote:
> > To create an empty cert file, we need to pass "" to the extract-cert
> > tool, which is common for all the three call-sites of cmd_exract_certs.
>
> Missing a 't' in 'cmd_exract_certs'.
>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
>

Thanks. Fixed the typo, and applied to linux-kbuild.


--
Best Regards
Masahiro Yamada
