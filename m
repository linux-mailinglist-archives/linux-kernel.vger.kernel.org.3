Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC056CA44
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGIPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:07:20 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B843307
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:07:19 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id r18so480663uan.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=S6qZgE2uPwn/d1eg70KlTI5Q2QqMPkD9Yhl3y2T9a6U=;
        b=KxSCPghrjFUv31Ms++e9GVPWtkY6rY/jH/g+51FNSssTeMvAxnmCV+8eq+B74E+b1U
         uJ0R/j2EXxZ4eELUPSGQAsrOY7voZL0ORKvDlf8RkvNAPNZdESmLHBJOAL3R0Q6EV5DP
         N6vWho1BmqXCVgyo7GfkB5ur4DvvcUuLaA3r5Qg6Q3xXWKm+eiSu99+6QrWPCRtHjqTS
         eFXVE1hsvLWygElDtKVUazyKudTom3DKGo+Mv+B/764ri7OTlRMkueZA1kaDt48FgVSP
         7/NU8UQ2AWfkNO/Zlua71jxqLEa+ySCrCme9U9NNYodL4D+q81z1DPgW8OB4H5kBu7Yc
         D11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=S6qZgE2uPwn/d1eg70KlTI5Q2QqMPkD9Yhl3y2T9a6U=;
        b=Qh0LGbIoFLvin2/axwCDfaVHjFX0gZ1gWotWTGICArZMphshWg+QprK/0HnEteDED8
         8wrKWOtgOoiSS/DTEMVVSaBJljw+Hv8XxT2rcP3Xx68ckU0m8OjjjFO9QuFI0OH6uZqZ
         HuZ7e0w3yB68iy+QBd2ifBIQgm0hxx5YqHvm446d/H9E3OmVkcWZBjOrUV1T7WgEqkIF
         S7JeGF3vGk2XDI/HpNbqI55ChwVOkBPszTTvY66hs/FoVwdHBMu8t9UevUE0j0iPbEq1
         pfSyFSlSBdBRvYP1kpLVEY93PcVXC8iQJhKJL7SHIRZYcuraGUKWjY0IDRN+LG5hOy4y
         RQTA==
X-Gm-Message-State: AJIora8mlmcQsc88KJByOol7+X74EQpyHRsQNavOMyUFWgh9zPkmuoqn
        rhvK8YgRJRLqK/9fmqMhsstaFwL7C+iplGgx1d0=
X-Google-Smtp-Source: AGRyM1uY/lfAagfKt6MUwqy5h+d3m26gcVuoVxcR+lzSdxw6U15575gzAL6lAssR+DeAgUwnypB8M+3zuJWxmA4NMFA=
X-Received: by 2002:ab0:7d08:0:b0:382:80d2:6767 with SMTP id
 y8-20020ab07d08000000b0038280d26767mr3432530uaw.33.1657379237868; Sat, 09 Jul
 2022 08:07:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3151:0:0:0:0:0 with HTTP; Sat, 9 Jul 2022 08:07:13 -0700 (PDT)
Reply-To: info@nitoscebu.com
From:   "Robert Avtandilyan." <sanusilamid742@gmail.com>
Date:   Sat, 9 Jul 2022 16:07:13 +0100
Message-ID: <CAOaQi2BGiZh0tc3ex7WTSnS+WHFso_wt9Hju2Z0pRfEc63ynyQ@mail.gmail.com>
Subject: Urgent Call to Rescue
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

Greetings from Moscow - Russia.

I got your contact from the internet, though I didn't keep record of
the exact website on the internet since I'm not sure if you would be
interested in the deal.

I closed my Oil & Gas deal in Russia because of US, EU & NATO Members
Sanctions on Russia from making wire transfer to all over Europe,
America and Asia due to Russia military invasion on Ukraine. But
before the sanction i have pulled my money $125, 500, 000. 00 USD from
my bank accounts in Russia and i want you to help me and receive the
money cash in suitcases for safe keeping place / account for
investment.

Please the earlier the better. You are entitled to 10% of the total
sum for your help, and another 15% of profit accruing from profit on
investments as your share benefits.

I look forward to your reply for further details ASAP.

Yours truly,

Robert Avtandilyan.
