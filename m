Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A435A3D18
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH1KDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:03:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8D2F65A;
        Sun, 28 Aug 2022 03:03:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq11so6746441wrb.12;
        Sun, 28 Aug 2022 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=EDp9bFFfokiyig7e5bgko3ERNvFO4G1q9fzYUvPw5rA=;
        b=l8Wk0pPdk+Bg6FopOMq8pXw5ITY/2Z1ItWKRm37519Fu1W4TLCQzabPFvEPpU0yElT
         T2xbHEvPu2WgPFSMSgXch0/nBnOaxp7RVCesMZVz4z6l8Ib2D5BULnGIILeEXx/KQUw1
         nu5adjwMUv8GS2X9ECOo02FEtIcAzCIOIj4IWekW1OUqPySfU/JfHLZ2a91N/hehI+E1
         uEyJ77XeuApow1Fd3OgKej0HE9QouAU3ml8n6sMJfTDupRC173OPa/2IBSAd2p+n9Bxe
         Yo9fJFHVBrIYF9dVoqr9qup7shF0onOLg2y3Aihdi3pHjdpsWnFbwvjefYxp0vOBhMUI
         CccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=EDp9bFFfokiyig7e5bgko3ERNvFO4G1q9fzYUvPw5rA=;
        b=v3WYGBscRK3Jv5nrmYEwQQhPINUEphoZjNihamwyMQpIAuqMJY2atfzPB9lPuWpk6U
         MMXzu/JsqovjYoGO/fk7gWReY33Wt2GPhrOB7lQ5O0XalVXV5Cq4Ze0UqVUTJK81Nlx2
         E5pRw+7EDviRP4OJ7bIxIXSM7CRyHy2Wa4DLng3m/FFHV+W4rKRQR8Td2a9K5Jt8qOSa
         wSBcXPpikfaYdMeOTkWmqKT/zSgbHXDx9a168+KMk5trtxFS8C8zJAz/HAWe9u74b1Hb
         sLBZ8onVR5cEG4z9vb1kv1ldA7oIAUi+lHfHdWZh1Zif0L3xxCj17x2t145XMlSs5bES
         rlFQ==
X-Gm-Message-State: ACgBeo2eEqu2Z5AF+n4CVjdURVxFBg8ZqI3eDTTsJyFBq2QgPtWT4rYJ
        7Cu10HYPa6hSLcqRmnfC79s=
X-Google-Smtp-Source: AA6agR7dXl20W8E49WAfLNwEYgz6GcwD7bc8mHHbDk311LrvVYorwdtmdtB4ZuNVluxJe8y9t0JTVg==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr3725313wrr.361.1661681000385;
        Sun, 28 Aug 2022 03:03:20 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id az22-20020a05600c601600b003a844885f88sm945512wmb.22.2022.08.28.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 03:03:20 -0700 (PDT)
Date:   Sun, 28 Aug 2022 12:03:18 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        gomapo2868@safe-cart.com, LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Romanenko <romu4444@gmail.com>,
        Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [Regression] Bug 216395 - XP-Pen Star G430S stops working on any
 kernel newer than 5.18.7
Message-ID: <20220828100318.GB4121@elementary>
References: <a3ab81d9-0fe1-0bc9-b265-37793c11ff77@leemhuis.info>
 <nycvar.YFH.7.76.2208261304470.19850@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2208261304470.19850@cbobk.fhfr.pm>
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

On Fri, Aug 26, 2022 at 01:05:44PM +0200, Jiri Kosina wrote:
> On Fri, 26 Aug 2022, Thorsten Leemhuis wrote:
> 
> > Hi, this is your Linux kernel regression tracker.
> > 
> > I noticed a regression report in bugzilla.kernel.org that afaics nobody
> > acted upon since it was reported. That's why I decided to forward it by
> > mail to those that afaics should handle this.
> > 
> > To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216395 :
> > 
> > >  gomapo2868@safe-cart.com 2022-08-22 16:28:00 UTC
> > > 
> > > XP-Pen Star G430S stops working on newer kernels than 5.18.7 (5.18.8, 5.19, 6.0rc1 tested)
> > > It seems to use the uclogic drivers.
> > 
> > See the ticket for details and further comments.
> 
> Thorsten, thanks for the report.
> 
> CCing people who have been working on XP-Pen support recently (Roman, 
> Nikolai, José).
> 
> Keeping the rest of the mail below for reference.
> 
> > 
> > Please look into the issue if you're among the main recipients of this
> > mail (and not just CCed). I hope I picked the right people to sent this
> > to, if not just let everyone know (and apologies for getting it wrong!).
> > 
> > Anyway, to ensure this is not forgotten lets get this tracked by the the
> > Linux kernel regression tracking bot:
> > 
> > #regzbot introduced: v5.18..5.18.7
> > https://bugzilla.kernel.org/show_bug.cgi?id=216395
> > #regzbot ignore-activity
> > 
> > This isn't a regression? This issue or a fix for it are already
> > discussed somewhere else? It was fixed already? You want to clarify when
> > the regression started to happen? Or point out I got the title or
> > something else totally wrong? Then just reply -- ideally with also
> > telling regzbot about it, as explained here:
> > https://linux-regtracking.leemhuis.info/tracked-regression/
> > 
> > Reminder for developers: When fixing the issue, add 'Link:' tags
> > pointing to the report in bugzilla, as the kernel's documentation calls
> > for; above page explains why this is important for tracked regressions.
> > 
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > 
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
> > 
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

I think that this bug report is similar to [1] and [2].

The issue was already solved by Benjamin with this patch [3].
If you can, please test his patch.

Best wishes,
Jose

[1] https://lore.kernel.org/linux-input/CAO-hwJ+MtU5w9M5rqbOPYjUUZtJ609Q0GwPJpy-9egDEjo9m7g@mail.gmail.com/T/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216106
[3] https://lore.kernel.org/linux-input/20220828095624.GA4121@elementary/T/
