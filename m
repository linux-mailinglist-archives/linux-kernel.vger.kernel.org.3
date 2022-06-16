Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B254E9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiFPTEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiFPTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:04:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D13EBB2;
        Thu, 16 Jun 2022 12:04:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 25so3436117edw.8;
        Thu, 16 Jun 2022 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0a2TaJYP6yL2Op8VteTrUU00jTduYyBEGf31hBz5rA=;
        b=q0wXwq25zeH9/5ItNgZVMoviAwA72GvrmGQUt/BeA4IEVm3eJouGqpMX+mmp87I7eH
         RE+2AE00a3Jih8Mfv27SQTF/zB800Hyky11fYaTKbALQeQhTCISFzUNgIwXd3g4rXYgO
         FVAhsWtrQ9feykpZRE9gxFG21R1vbkWtiqjipQ2jr84/m9NYYSx5fj6TZFCfuGCxNwE1
         B7TQzVDiB0ifk56MjsDGDVv09UwgDa81OD1p/4vRSceTIHLFm5N+w8cGBCTBF+JwZHkx
         UMxd2zg/kw8vTkN81K+esZdnLi77CzhyssXXXtq3deBZu0ZeebdeI59rKbr+CPJeRq6y
         aWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0a2TaJYP6yL2Op8VteTrUU00jTduYyBEGf31hBz5rA=;
        b=sZVc6uizUAfKRblI+83WUhjjV5nQZsK+7CdYdt5QgNdl8TmR0yOKge+PI6TrORz2uH
         TMHRj61ezH1o4yLaw8zooC90wpup7lTGCQKgFH8uO1Rv9ZImP9lnZIpYwFTmiDuzkXVv
         EpNMh9BAvmOhSD7tARJdmYVteRicAWLD+6BPjIfBk7unfo36VUxRVzQlxFnRx3ligvzg
         NRllSf6otXXhtHuiGaMAk+Y3tWcWgnQR+iVNuy0OtPbsjPSISytZB1vNwgz9dsaP+/yt
         oleRqwuh5PZtO+f9GjoVKojJ6oGt+p8VSw+2ygLnqQBzHe0s9HxZynMSI8+NYVDmGGB7
         IwSw==
X-Gm-Message-State: AJIora+ohhB4+dyBj10Ww/dSq56LgGtRKReMaZJdAIjNKI0YXRJRIpGC
        tCi9cv/NmkbAlWw0mUzQN29fgIJMMwCsg1A/LV0=
X-Google-Smtp-Source: AGRyM1uBbNbOSgrWbZtrGwKruG86bIyxVcfouw3xSMJA//eSTENcFr8h45KQ2S43iez9OIvszadmSPM5Nh0dU69Aj2w=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr8140538eda.141.1655406243947; Thu, 16
 Jun 2022 12:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com> <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com> <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
In-Reply-To: <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Jun 2022 21:03:25 +0200
Message-ID: <CAHp75Vdxw8r=GhsMhe-UyHXfc2pBeYghobbvbdmYzfa3YQPpaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
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

On Wed, Jun 15, 2022 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 6/15/22 19:10, Stefan Seyfried wrote:

...

> If anything there should be a DMI match for Kenneth's model and
> reporting the events normally should be the default.

You beat me up to this comment. I was about to answer something similar.

-- 
With Best Regards,
Andy Shevchenko
