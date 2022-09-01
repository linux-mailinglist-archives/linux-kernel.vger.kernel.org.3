Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38E5A9203
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiIAIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiIAIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:21:43 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1309E8B5;
        Thu,  1 Sep 2022 01:21:40 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2818LPGK013562;
        Thu, 1 Sep 2022 17:21:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2818LPGK013562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662020486;
        bh=pNu2mRekQdnmjRBKbAVVw81nkqpftwyn7RqAHAETuOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RSpN2UH7Zsbo9e7veyXT6kJwwNCl2wLMqttWfei6bNRPgmNcIfArZXK7dk4bCNbLz
         +nKR/hWtMZU5+VoWsNosvYifg/AxHutqQXypTHkZf1b7S0B7dVp1WveVVruO7Kw8mS
         SvqAQaxBFU2SrXbpOApyfhlOTve1tXyBrCc6BQ7e0IqghxWff2ZIjs5PqVpuiPKISv
         hiA+Ft6pdo/lrsSOK8dRrPxy/mEEUOsYvWSOce39WWB62VFj9Q/5sdrdrCV77kV1Lq
         Hr7ekZBiB8FT1h4tsFkTZ37mvvA5F2ceQWj6DxGr//ji7sPGgHGdS5wsRME5CLkZt6
         dfF1TOTJ4EF4g==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11f34610d4aso19066482fac.9;
        Thu, 01 Sep 2022 01:21:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo2hUSkJlv4ayKdAwoAXuiHB7NlHzCIp1+DW0JNeomhyZSGWatFx
        +1KBJx/GJsYwJAVwCi8h94Mpm6DFyG84qvdbKjg=
X-Google-Smtp-Source: AA6agR6wHVcvBE38npDjxrhrkbQsogGCuTbd+PGzpdXi8/QMAPLEyKyXahO+1XD/k1+ekV0tQ5Y7XPXxj/R1+fXeCmY=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr2805155oil.194.1662020484891; Thu, 01
 Sep 2022 01:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATbAVE8QY_QZQkiaNy9UZb2tH30eP50n0TNpgsHVrTKJQ@mail.gmail.com>
 <YxBZ5wcGUSQ/VeHD@rli9-MOBL1.ccr.corp.intel.com>
In-Reply-To: <YxBZ5wcGUSQ/VeHD@rli9-MOBL1.ccr.corp.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 1 Sep 2022 17:20:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYiRr2-m73bBK-Ly8Tg35SK+nJw5bxULhuFh1vG=nN8g@mail.gmail.com>
Message-ID: <CAK7LNAQYiRr2-m73bBK-Ly8Tg35SK+nJw5bxULhuFh1vG=nN8g@mail.gmail.com>
Subject: Re: [LKP] Fix make.cross for 0day bot
To:     Philip Li <philip.li@intel.com>
Cc:     lkp@lists.01.org, 0day robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 4:06 PM Philip Li <philip.li@intel.com> wrote:
>
> On Thu, Sep 01, 2022 at 03:55:52PM +0900, Masahiro Yamada wrote:
> > Hello,  maintainers of Intel 0day bot,
> >
> > make.cross is supposed to use the latest GCC by default
> > (according to the comment "use highest available version")
> > but actually chooses GCC 9.3.0 rather than gcc-12.1.0.
>
> thanks a lot for pointing out the issue and fixing it. Do you mind to send
> a PR to https://github.com/intel/lkp-tests, or you suggest we composing
> a patch based on your fix below?
>


Sure, I will make a PR.
Thanks.


-- 
Best Regards
Masahiro Yamada
