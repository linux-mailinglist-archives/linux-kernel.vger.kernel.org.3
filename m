Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C09581BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiGZVt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGZVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:49:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F832DA1;
        Tue, 26 Jul 2022 14:49:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso136509wma.2;
        Tue, 26 Jul 2022 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MTvIHY1+sk/IfyQlDB9BN0iEiRHab4pKfxh/Bmcwdqs=;
        b=gKeGSe2VVBmzq1vR4lDTI4p9OovZtfZpbVVigkC5MGep7YDEyLIV/2wgYmwIYvIxii
         Ai8MdUGEbIxLB+Vkf2kg7ZMSGvddJUSl1MS2oYIF17F329wJ5YifTWjESjmmYZc0CJBR
         Se7tjySqjGNF2O7hKgwE6LRgjlt0ffWCGey7XNX7PBUAPRbhMGbzzWq4dDhpoIgTKvpd
         yGJe7B5x3BD6iFqdtKSVEdQgn3iMqeoTKQoZj97mOmPjLKH0o2fkIHeco0cbddeVY2tu
         MQ2PE8IbATepDHLJXHyrrvHDyYoxWHGgxFxaLDZITL3ccA6OwT0nec30dtOoLDA8us0G
         WZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MTvIHY1+sk/IfyQlDB9BN0iEiRHab4pKfxh/Bmcwdqs=;
        b=Ww0DhQa6qlRCc7ajbtZqp0uMhgfcN/a0KV93j2iaCXZJzmINKegeWrGLx2OHFrnubA
         REbg94/rFnSM3fJ7qGJ5e0fut2F6tEFTA0yi7nWlSFAMadvBs53xV9yygAAGlya30PbW
         +sIFHiGTz7YoRX0y2ttOJ6uDeLiwRXZ2sMvmZdSJrnwQIHrjtO5nX4KmLgLP8gL0u3Wt
         s2UeKtPqkttMIbTvk9LFfzdu15VmNUzlIt117WwKujUGxnTRvhDBVP/cYmLwCFbR1I0T
         dC3sViyepeS2TkD4D+pIYvioSi+PMe6hQwLZgPvmlHlsqSD88B3fJRsIn4A4eL8Upg1P
         H49A==
X-Gm-Message-State: AJIora/aa6JO2qVo7rgAodIPRnIP8Jn64gGSZGqmDuWfcsWK/XsvRWiY
        gxUKOD/2u0XlmPtkbg8bV2fitIguRaxIJQ==
X-Google-Smtp-Source: AGRyM1s9hgg+rXDV7L51renow9bWQbBEn3YPuV04PPElp6FmXP6WYBzoQ6Ly1MeZLiFDxhu5LzyW5A==
X-Received: by 2002:a7b:c399:0:b0:3a3:c8e:3221 with SMTP id s25-20020a7bc399000000b003a30c8e3221mr753323wmj.122.1658872162189;
        Tue, 26 Jul 2022 14:49:22 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id c18-20020a056000105200b0021e4f446d43sm15105286wrx.58.2022.07.26.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:49:06 -0700 (PDT)
Date:   Tue, 26 Jul 2022 23:48:58 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Hansson <newbie13xd@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220726214858.GA3202@elementary>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary>
 <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Jul 26, 2022 at 01:58:24PM -0400, Stefan Hansson wrote:
> Hi again!
> 
> On 2022-07-25 18:48, José Expósito wrote:
> > Hi everyone,
> > 
> > On Sun, Jul 24, 2022 at 01:48:49PM +0200, José Expósito wrote:
> >
> > [...]
> > 
> > The first bad commit is 87562fcd1342 ("HID: input: remove the need for
> > HID_QUIRK_INVERT"):
> > https://lore.kernel.org/all/20220203143226.4023622-11-benjamin.tissoires@redhat.com/
> > (CCing the folks whose email is in the patch tags)
> > 
> > I reverted the patch on hid/for-next and, after fixing a tiny conflict,
> > I can confirm that the tablet works again as expected.
> 
> Thanks for looking into this! Bisecting has been slow on my end
> unfortunately. I built today's linux-next (20220726) with your proposed
> patch below and my drawing tablet curiously still does not work as expected.
> The stylus works a couple of times, but eventually stops working (unlike
> prior where it always seemed to only work once). Do I need both your revert
> and this diff for it to work properly?

You are right, I just tested for a while with the diff applied (without
reverting the commit causing the issue) and after putting the pen in
and out proximity a fair amount of times (> 100) it stopped working.

I added some logs with the hope that they help to understand the issue:

Once the stylus stops working, hidinput_hid_event() is called with a
usage->hid of HID_DG_TIPSWITCH.
Next, it gets called again with HID_DG_INRANGE. At this point
report->tool_active and report->tool evaluate to true, i.e.,
hid_report_set_tool() is not invoked.

This succession of HID_DG_TIPSWITCH + HID_DG_INRANGE is repeated while
the stylus is in range and the tool used is never reported to user
space. In other words, using "libinput record" I can see ABS_* events
but without a leading and trailing BTN_TOOL_PEN event.

Notice that when the stylus works, report->tool evaluates to false and
hid_report_set_tool(), which calls hid_report_release_tool(), is
invoked.

> Also, do you know whether the revert be backported to stable 5.18?

Let's wait for Benjamin's opinion. I don't think that reverting the
commit is the best option in this case. While checking Benjamin's
series I remembered this libinput MR:
https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/724

And I think they are related. Ideally we'd like to keep that fix.

Usually, these kind of patches get backported eventually. I'm afraid I
can not tell you if it'd be the case this time.

Jose
