Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F952AD57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353163AbiEQVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353161AbiEQVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:09:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E802532F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:09:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n10so17803pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=R/7z8eWZxiYe9S0To66yjly59RWl9dyPFi7uANEALSM=;
        b=vkkR5tKDxiQQYhXSKUjsv5XIK18wcJvUl2NcE2t/3wUFdjG/1uvIQXQf6lzhh6NsNx
         aakGM81RtKLwz51MPDh8PH/xVqKHMKxkDEvwrdPyUNQ83FT9e7LelTlzO8A9mLjM0EId
         WlL1qs5ogPv3DNH1y9e5cPMdBh5L/h6zQx6WNi3PPzOd9JAonlNbTMqSLRIffRH7mvdt
         mSgIgITy+2Y0iZEm2K8Zy9VdalWT+F0xO8loMKOrwUAsDF2VEJfYzf55XI+kY1Qo6nzK
         0ds/FyoJVy17vFeNh0HbIiveKB0Z4Dri5+U4gGRYaWbl3qCUE3+yO4adbX1iAu0GWNOo
         eX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=R/7z8eWZxiYe9S0To66yjly59RWl9dyPFi7uANEALSM=;
        b=PvwhRtTWSuVixfpAqAUMQcPR+DCjPr3U0b/YtkAyCCPM9hGa5b9aWMS6rYDmpeYsey
         LOf4Ldg4bKmZqTHmQW6CD46EDMINmZTrXsB/yf2Mas2Ufqeya5A8jLBqm8sGY2GE65n9
         XKLV0H3C1i1dyff4Gw3bJKImXUDKM3J0YxSmUDbjtHZgx5/pL3CIVyogBJkObRhGm6h7
         qSNGWqe2JBBscEEGEye34T6WuyC6m3n5XCLrd1TwD4MISao15TP+LPhPM9RaWPTyEzqY
         Se34rsI/vi+G9LbfhcGBKGz6VCtI/91MNpkoikVz3lHyKbBu33HCvD+Pav6qPFe97UBn
         H1Bg==
X-Gm-Message-State: AOAM5307L2hs63VYIzlziTlnaz51RWZVoQ74tOfdmuTG/cyZzvGe+r0W
        paJHDoL/dkDMK3Sv4nOoeFnUcw==
X-Google-Smtp-Source: ABdhPJwyZDjPxyc5RmbaiaP1rkSweQ2E4F8JTK4aBmp1Io0axoQVTBsN13qBX6XYwUbLeDAc7Vck/w==
X-Received: by 2002:a17:90a:6f44:b0:1df:7cfb:d9f9 with SMTP id d62-20020a17090a6f4400b001df7cfbd9f9mr6854344pjk.201.1652821785698;
        Tue, 17 May 2022 14:09:45 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 1-20020a620501000000b0050dc76281e1sm162511pff.187.2022.05.17.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:09:45 -0700 (PDT)
Date:   Tue, 17 May 2022 14:09:45 -0700 (PDT)
X-Google-Original-Date: Tue, 17 May 2022 14:09:43 PDT (-0700)
Subject:     Re: CFP open for RISC-V MC at Linux Plumbers Conference 2022
In-Reply-To: <CAOnJCUKjSCrRNT4841MzO3vWmYszX5CSmvtPoRLydzG7FFm7kA@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, opensbi@lists.infradead.org,
        linux-kernel@vger.kernel.org, sw-dev@groups.riscv.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-1b49d564-a55c-464c-9834-2ac4a334b930@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2022 18:30:46 PDT (-0700), atishp@atishpatra.org wrote:
> The CFP for topic proposals for the RISC-V micro conference[1] is open now.
> Please submit your proposal before it's too late!

Due to all of the extra complexities around hosting conferences right 
now we're going to try and get our schedule together a bit earlier than 
usual this year: specifically we'll be going through our first round of 
acceptances at 10am Pacific on Friday June 17th, to make sure we can 
give adequate notice to both the attendees and organizers before the 
schedule is set.  That's quite a bit earlier than usual and only a month 
away so sorry if it's a bit inconvenient for folks, but the goal is to 
remove one source of chaos from what will likely be a high complexity 
set of conferences this fall.  As usual the deadline is soft, but if you 
miss it then it just luck as to whether your talk can be fit in.

Also including a reminder to anyone planning on attending that the visa 
process is likely to be even more difficult than usual this year, so you 
should plan accordingly.  If you're from a country that has a complex 
visa process then we're happy to help any way we can, just let us know 
via email.  As usual Plumbers fills up and late registrations are a 
headache for the organizers, so be sure to register as early as possible 
and let us know if you're running into any issues.

> Here is the announcement[2].
> https://lpc.events/blog/2022/index.php/2022/02/04/cfp-open-microconferences/
>
> The Linux plumbers event will be both in person and remote
> (hybrid)virtual this year. More details can be found here [3].
>
> [1] https://lpc.events/event/16/contributions/1148/
> [2] https://lpc.events/blog/2022/index.php/2022/02/04/cfp-open-microconferences/
> [3] https://lpc.events/
