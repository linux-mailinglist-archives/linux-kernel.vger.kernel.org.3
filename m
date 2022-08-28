Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8165A3D25
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiH1KPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:14:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587C13F90;
        Sun, 28 Aug 2022 03:14:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6693376wmc.0;
        Sun, 28 Aug 2022 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=K4m+AVo1CT485UUYwfaOl51yrQiPjw00bO34cVu9dLQ=;
        b=StfpQQmdFNPy18AzJHZlT2b9/ytPedwCAmHpp5cuu9SAp0HxOMkFOB6HqhNZsjKjRU
         1dnl1PJum0wA/2rowouCdA+21m1VupPLTqgH6vAQWBtABHixidY6ruK7vfX7E2jR6Ha8
         cPCFJa8X74MS0jzPUE5QwvE1y5gKvU8ltuJKhfXEgNH1iXHzoKhlRc3ugWTYamdJt1F5
         I6JnuACKRm0H43buhWIptSsZ5JfpFQ4pUaqIHPaWABaa8gMAUzcOzQc6zODDY1vafHcb
         Mz9zovk/a/IH1rnlSw+L9v14zreo3msaJOAkmQYs/+k0nwAQUavSBvfOJpdOrG0Xo+Vj
         o3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=K4m+AVo1CT485UUYwfaOl51yrQiPjw00bO34cVu9dLQ=;
        b=cr+Bqe/aHKlrZCSAwECh1izXs52OLk3b4/a7bDxQkQX6YFiXenMElXNqXewuXNPGXM
         /kOZwcF+lKBPq6mNy2WSh9QQgOpu5nnSZjJj/+H7aTognFU6Gi3Y+g7Y+Bh8DbgvPSDx
         BTYaPSLQXsl8oNOOwqhX6cCDbhkyz26Qcesz5dzZc65xHb9BuSowqxnu8FNpgk6oxKIE
         bxwXC/DPQEWLsOabF/4xOU9Yi5m6SqYbITfL3CvBTYd1Mduhx+HtAvvoOMXBdK0T2IDF
         ZbghxloctN/4QJpxShjJE7gnZjYgzmFWeQ6tn+lz7Y79sFzq1iS4nDl87oby25Dm25em
         8TJw==
X-Gm-Message-State: ACgBeo0xRmdNx0HHYbvCKYrBJI4/SDbrBm/9qMAqi5RhAc5+daV5NYWd
        4iDRiXbGWwt1EuJFwri9vOk=
X-Google-Smtp-Source: AA6agR6So3mQ3numtJZ8feUGhHgOildtKqFv+k4qDvQeERw/D8dnaF3IqgsFSNBY1lgBm18fC69vHA==
X-Received: by 2002:a05:600c:4e4b:b0:3a5:d36e:8349 with SMTP id e11-20020a05600c4e4b00b003a5d36e8349mr4345585wmq.44.1661681696059;
        Sun, 28 Aug 2022 03:14:56 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c430c00b003a60bc8ae8fsm5202518wme.21.2022.08.28.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 03:14:55 -0700 (PDT)
Date:   Sun, 28 Aug 2022 12:14:50 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <20220828101450.GA183368@elementary>
References: <20220826095647.2484954f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826095647.2484954f@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 09:56:47AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   609174edeb75 ("HID: uclogic: Fix warning in uclogic_rdesc_template_apply")
> 
> Fixes tag
> 
>   Fixes: 08177f4 ("HID: uclogic: merge hid-huion driver in hid-uclogic")

Sorry about that, checkpatch didn't catch this one. This should read:

Fixes: 08177f40bd00 ("HID: uclogic: merge hid-huion driver in hid-uclogic")
 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
> 
> -- 
> Cheers,
> Stephen Rothwell


