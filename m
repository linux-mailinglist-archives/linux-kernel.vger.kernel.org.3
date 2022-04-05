Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF24F5209
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849287AbiDFCeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446036AbiDEWWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:22:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB910505B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:14:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 10so1189697qtz.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o0wDpIkEwpRJQFvM50lGA/vb8efTxI0/dQ/fmk4QzbA=;
        b=ThI3NTIpoBycVs2LfLGSPPFPXxE4ZirP4bQIXVK4NbCb7Gu+0u7SnfLzt3RF2+v2Ua
         Om2EemBJj5MGUstXBIhyiQ5C9tIkivpr4u0eqJAwXUtK2uxch/zsc8jti2zcPazIB2hM
         ZF//e5qzhrW1jE2djugTCfKFrjmvXwhJvNL9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o0wDpIkEwpRJQFvM50lGA/vb8efTxI0/dQ/fmk4QzbA=;
        b=lF7rBMl/WOXAI4RxCoQTT0Hw+bf+p2zeoxj2cr8d+W1LO7Z0H2bW9GS1CnTOIJQm4E
         p3/5DDhnYobpYCZIMl271OCGBzO+SSSd9HSF9LXnZCqqkdeJxuTO5W/LMa4HdfAxLrXG
         i/S2u5dAE256O6xB4HAzYLnzloJkK5cm/2ZfYH88WBmUtDDqkLdJHuL+kFJb0tKj90Rg
         rWUR/ILNdjMpgV2ctuDpFK4IUEtpa9atgGUuoeDAHKzKmlTa36v8ckdTTkIkOe1PgEo6
         ISnSiUqEF+G9HQ2MmQrnJ5sj+KWmTAFXIrofPXVCqGgr6KSbzR2cAkthAB47vuvMV6rP
         j8/Q==
X-Gm-Message-State: AOAM530H7jfz56mjpM70eILbz7EMALDP5sEGFOrQkDa2nepbf8elIXIm
        io2Kq7YinjO/THtRNaoimbzfIw==
X-Google-Smtp-Source: ABdhPJxz81u5YQuiZoDNOUymjm0pKS8xOdGu0TNaTbvTwvmeHetQudOhEx7SLNocVGCOfNZxig1XXA==
X-Received: by 2002:a05:620a:24c5:b0:67d:99c9:eaf9 with SMTP id m5-20020a05620a24c500b0067d99c9eaf9mr3685452qkn.379.1649193269614;
        Tue, 05 Apr 2022 14:14:29 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id v9-20020a05620a0a8900b0067db9cc46a9sm8216024qkg.62.2022.04.05.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:14:29 -0700 (PDT)
Date:   Tue, 5 Apr 2022 17:14:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.18-rc1
Message-ID: <20220405211427.ybl54q5smqicvad4@meerkat.local>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
 <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
 <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
 <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
 <ea840ab9-0c20-8c06-f7d4-bb9642a63500@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea840ab9-0c20-8c06-f7d4-bb9642a63500@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:45:46AM -0700, Guenter Roeck wrote:
> I tried to tell my provider, but to no avail. Until now I used gmail,
> but gmail will disable that ability by end of this month, leaving me
> in the dark. Lose-lose situation for me. Right now I don't have a
> useful alternative that doesn't require me to change my e-mail
> address completely (or setting up my own e-mail server which
> is a pita).

There are hosting providers that are known to work well. Many people happily
use fastmail (e.g. Greg KH), and it is known to do All The Right Things when
it comes to DKIM/DMARC.

-K
