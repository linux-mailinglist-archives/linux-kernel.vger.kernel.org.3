Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507BB4BB966
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBRMv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:51:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBRMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:51:55 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE303279930;
        Fri, 18 Feb 2022 04:51:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m8so4531344ilg.7;
        Fri, 18 Feb 2022 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIUCArmyrbOnhzOdx2kusGExPtu+3+2n2vWCg1y7ftQ=;
        b=SpY91+zXZbbdxQSOq29eqFEm8LYyu1xekxwyYP/gAQLFqjcvQSITEl6HibLZW2o+8r
         tgdfMl3g2mB/3npcFEDYPScfJJyZ+MTsCGcH6hEHKqeEJrMZsSEKH/5U1mnl8/Wrq4GN
         U/atVDEeojOcGerVAMmWbclPolH/Uc/B4Y16ysdC2pZ3OpVxGd1oDi4hFiXUVRGhlyAn
         NS1utBYMyqZdysSBx+AbyxRO9iCasxNIAI0p6hK6GwT5+Hjl4dtKTvJIWwakqV6FHODz
         2MdOSFwQWt9QXm0wEKpjlbhvgLRcoQ+yZxF9OaQJ3Y/hAKGH/6+UcfxbsuF8yBw2rpbD
         ozxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIUCArmyrbOnhzOdx2kusGExPtu+3+2n2vWCg1y7ftQ=;
        b=6WJpmuSzw3DlHNgRVDpKOL36rqIKz07diW+xcq6aISHAiwLnaRVNbPwdWg+S45tLUz
         dghLot/yw1dIwWskpHPHvPCrJsXh9iKn7vH3Wg7ylw6UcDeIdwguphVy1dHpqFmsDh3z
         Elq8cGn0/2U9sUsf/TAm5FUbtWBcPwL69wImFYUl28yNM8IbqTl280qaQf2GYyKjm5GZ
         8oJxa4T1HF6TQLWy2zEnt5sXGuqI0zeXx05/tA7+G/TtA6eNefDigIGC5LRIOY0sPnZU
         fcmeuHaj3LxVSSAdPkORDRsxh7CG/y36k5Qo3DvoRtnJl/SYpxnZCmd8S844pU4Dwf3P
         B1yg==
X-Gm-Message-State: AOAM530l981SA3OK/fE83ZW91G37RHoHADVRxcVthPfnfm5QKrFPeriQ
        RF0+0zhEONojts40+BMoGmiBeiisftc9OlMldwqgHUAUKqY=
X-Google-Smtp-Source: ABdhPJzx9yDdk1djVWJ/t/ELmKRBWQYPTcCRcWtti0xHQgr6qys8m9hnWhrdwFLsKUPWiVljXswTuQK927v9NxDLwTE=
X-Received: by 2002:a05:6e02:1bcc:b0:2be:454d:4bf9 with SMTP id
 x12-20020a056e021bcc00b002be454d4bf9mr5505622ilv.5.1645188695228; Fri, 18 Feb
 2022 04:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20220218015136.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
In-Reply-To: <20220218015136.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
From:   Silvan Jegen <s.jegen@gmail.com>
Date:   Fri, 18 Feb 2022 13:51:35 +0100
Message-ID: <CAKvUva-tORYVZrMEiS+pStOvfQEtzBuO+phXG3eY2nAs5ycKOg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: Add mapping for KEY_DICTATE
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
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

Hi

On Fri, Feb 18, 2022 at 2:55 AM William Mahon <wmahon@chromium.org> wrote:
>
> Numerous keyboards are adding dictate keys which allows for text
> messages to be dicated by a microphone.

You have missed one typo here, s/dicated/dictated/.


Cheers,

Silvan
