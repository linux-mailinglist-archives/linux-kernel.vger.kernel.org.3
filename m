Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DA4A8F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiBCUzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiBCUzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:55:46 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B39C061714;
        Thu,  3 Feb 2022 12:55:46 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o10so3206457ilh.0;
        Thu, 03 Feb 2022 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vd2yu0FneFgwLXdVaMVexY0bk2I77mKzcPHsD0qaVE=;
        b=cDm6Z3DzUefOrt3ilpnyq626HCBXLO6k5EBdxFC3aVt+tCwK0n3CBwvZg4wKWj+kIQ
         7Mott6gvYV6m4Iftl1ICq/hB+BvgBBQ0AtnG1yTk2QPgbslII/Yj2/dRxsdi7zTN53gc
         xJ70elzB3+iWDL+PqW0OTLepALUJYT2sLLT1McRSZCtoHxVfnoypwy06T62VYTUje1t3
         +oKO2yLAY5rnmj/P1BKRSbyvYIUsMMTEx5s8nvWO7odiQN5/Sj+uP8CISnMjhtNF68qZ
         YhgOS7QTL4hGyZI5ehnc/GH4BtR2pwK38y7YOFLbrRBOOdXzLzyiKO8R9XXLcayEhWiK
         et2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vd2yu0FneFgwLXdVaMVexY0bk2I77mKzcPHsD0qaVE=;
        b=4k49k3GcbufTTuhT9n3wZ2zX+INec+9b2yj9rHIq3XcGcJrjBEDawirf1vu/0TDJiS
         tkIXWXGYqazTVt3rrybeafGbb5UFpzVDuvf0ff8enqs0ExMcu1MzOphNaNFHrRB3Opw4
         FdpgbbIYlN7D9nxA9rNF61lpowkK4tIKRS7qlmm3e1vzGLV3K2B4gZF8e/O81tnS9Zk4
         kpLTqD1blM7o0GC9lpwpsTsX8jEmeaVf+tzxBPzNXm44JoX7wICmbZ4HLlxgfW5K1myG
         5efBf3t3ST70I0Ig7mfl3PD1+k6XH3j0iu/CKK+7FxZslcGx9q7KQuDjZy+SXIGF/+Qb
         IWjQ==
X-Gm-Message-State: AOAM530wxhoKNFpeZUM/8dDmz2S1Mwq5B8eGR9ulkyfSyNJ0Bz3/A56b
        ovkG3+ZejH3zSYmjeJ4l/m9/a5mE5QtFVZ8UOJk=
X-Google-Smtp-Source: ABdhPJwfupPyeg1M28OEnq69j1jmCKZn8pPv3Bs6qjeDJBF2/XWwRQa2Wn6rxSEhzSZnIULNbMc1j7UPK0I+FIiVN7o=
X-Received: by 2002:a92:d350:: with SMTP id a16mr21739839ilh.187.1643921745924;
 Thu, 03 Feb 2022 12:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net> <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
 <8022383.T7Z3S40VBb@natalenko.name> <13a9d0fd-1b2c-b9c1-24a7-ff4fc5f4b8cc@roeck-us.net>
 <CAB95QATUK+q01TLuubqR9D1fLJM=C6VjxpabnkseQRUvsd-9YA@mail.gmail.com> <20220203222310.6a025c5d@netbook-debian>
In-Reply-To: <20220203222310.6a025c5d@netbook-debian>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 3 Feb 2022 21:55:34 +0100
Message-ID: <CAB95QAT2iZexNF__dwJQHWoeFACcCMPGFGQQyF_9weATkfeJ+A@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v8 0/3]
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have also retested code, it works for my case.
>
> Tested-by: Denis Pauk <pauk.denis@gmail.com>

Thanks!

> What about other B550/X570 boards?
>
> We have such candidates with same WMI methods in nct6775:
>         "ROG STRIX B550-A GAMING",
>         "ROG STRIX B550-E GAMING",
>         "ROG STRIX B550-F GAMING",
>         "ROG STRIX B550-F GAMING (WI-FI)",
>         "ROG STRIX B550-I GAMING",
>
> B550-A does not support asus-wmi-ec-interface("ERROR: Can't get value
> of subfeature fan1_input: I/O error"), but what about others?

I don't have DSDT for these boards, but most of them have the
T_Sensor, according to the specs at the ASUS web-site, so, probably,
their EC should report something, because most of their boards report
T_Sensor reading via the EC.

Best regards,
Eugene
