Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7F51CDD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387557AbiEFA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387544AbiEFA3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:29:39 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30AD13CC8;
        Thu,  5 May 2022 17:25:51 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a127so5767672vsa.3;
        Thu, 05 May 2022 17:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAkK4SrhA/bock8oo1T7lBqM1M3V+LitUKvmLyL1MpA=;
        b=ZXgQzX/+0Vzl0EIdb0PBR503txgI+ab5b7tUVLY8lGOTO1Ydwg2Ng1SBOsq7uZgCxv
         dahSl0jVM+R8MUZxtIaWLa6QjAcC2mLS0mEcgOhkLFp2Cf5wnrqeY2j1C2tihwvHxMHc
         D36hyKzIrWMWJoLBAeusM/WIdXfEu3UyaM6HysVqT6b4qxmrjTUoUPAA4Qw6Z2QmUGqL
         bmmTRsyujgL+OcA8h8fVvOjvEXW4WZkEyqv3AD3gwYJi24p4Gfbi5+njIpAHXWaMjnMX
         IjcenNhQsPWj8MRiTBZyD4hdVWeMOFmt7LRLvZVYpUsSvb6JQxFY+/tlXT6NyiYXqcFO
         nsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAkK4SrhA/bock8oo1T7lBqM1M3V+LitUKvmLyL1MpA=;
        b=z1AkHhHcT9q5S1GJKpWdx65q7V5luvIfyG2Zt7fbllxiIWctvxfZgZDxTXimSg5wvI
         xrMuLROlFZGlHz6PxiLE85FtLYgwLJQMPRayH0LkIKsvMQ0kfpeaxPPrBIjR/AIXZsBI
         yZJ/6qf502ylwaRoXIo6WE/EjpDqvMNiRFkLXd6j/odBksiXA9zKoilMEwZ1N1LKfFw7
         l8ZQ1ya3J6WLk9vD+umXnaArioqefg9LZkvqDUtnGJpsYEPfS85kY/VM7S5av/nIqkqx
         JdHHVV3rhF1ymZ03N3JcoF+37JmPUxiX2ldnRnb7BNoY+yYECYu6EsvBn7Gn+s7LfFYd
         l0SQ==
X-Gm-Message-State: AOAM530L2OaUcC4SZbm/6MQMXpR2Dmm6G38YwXazi1e/olzDRU0hIdHH
        XWYbHB/edOVLRAB+SkyavCvL2JbKHcsuFs+inPzHZNC8
X-Google-Smtp-Source: ABdhPJx9NZEgOil3xmWCH5JGBqs9KTx7udNiZP5vc6xRzj9HSLwHbzX5+CafkLHQgXJH9vqC7+O79O/v7qFBaPjXMsw=
X-Received: by 2002:a05:6102:aca:b0:32a:1acf:5ff8 with SMTP id
 m10-20020a0561020aca00b0032a1acf5ff8mr213559vsh.81.1651796751020; Thu, 05 May
 2022 17:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220427104825.15a04680@canb.auug.org.au> <20220502121736.57b06150@canb.auug.org.au>
In-Reply-To: <20220502121736.57b06150@canb.auug.org.au>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 5 May 2022 17:25:39 -0700
Message-ID: <CAKdAkRQN48WjsW1BAztTn3-c0pf68tP9+G0028ZyXB4-8aCtKQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the input tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Sun, May 1, 2022 at 7:17 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Wed, 27 Apr 2022 10:48:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the input tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/input/keyboard/mtk-pmic-keys.c:93:36: error: 'MT6359_TOPSTATUS' undeclared here (not in a function); did you mean 'MT6358_TOPSTATUS'?
> >    93 |                 MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
> >       |                                    ^~~~~~~~~~~~~~~~
> > drivers/input/keyboard/mtk-pmic-keys.c:48:35: note: in definition of macro 'MTK_PMIC_KEYS_REGS'
> >    48 |         .deb_reg                = _deb_reg,             \
> >       |                                   ^~~~~~~~
> > drivers/input/keyboard/mtk-pmic-keys.c:98:25: error: 'MT6359_TOP_RST_MISC' undeclared here (not in a function); did you mean 'MT6358_TOP_RST_MISC'?
> >    98 |         .pmic_rst_reg = MT6359_TOP_RST_MISC,
> >       |                         ^~~~~~~~~~~~~~~~~~~
> >       |                         MT6358_TOP_RST_MISC
> >
> > Caused by commit
> >
> >   0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")
> >
> > I have used the input tree from next-20220426 for today.
>
> I am still getting this failure.

Sorry for sitting on this. I dropped the patches from my tree, we can
either push them through MFD, or retry after the merge window.

Thanks.

-- 
Dmitry
