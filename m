Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1C4ED53B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiCaIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiCaIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:12:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2AE16BF98
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:10:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x2so22707201plm.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CU14Grw8x1R6dlLwFTJvdYMaQj7ZrTh/1RqpTDiqx2U=;
        b=djHfu01mF/YJqvH+sMtK4CrW0fLGkATPWmeyAg61ZiXjyDPJEj89LUbSBex8BOJ5bB
         GbkPOLgD8yOB6+ByVdCDTmUcN1Mz1w6kV/Bbk08R2ec93gN9POAyCSK9E3n4F/x8OS5q
         z3Jf0iLSDUev5zgon8LDiTM8Xwc34yyRz4GkEtw5pMjct0cgpN+jNlZxhd6YbgmX6lod
         IGL8CYqSnRIioQe7Dn/aLGnO6BVF4I3VHt2xNqbdJL8TJAZ0VM2cHeWIFPv3CdUA7OyI
         a8wzCvrQ04yFWvZyDgb/TqLUvgF4ARpX6pzsg7IgK7nW3hgGA/D0VZ5/PwPO9XseCN1B
         ja6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CU14Grw8x1R6dlLwFTJvdYMaQj7ZrTh/1RqpTDiqx2U=;
        b=BNaPyLdIbdPv+5U8baKAE8jD1OtMbHoic5/NACLyGsgpt+A3PUly08bRn8Lgl86OUF
         yptp/2qgo90PdVwTEhI2ZjpdheYaMhGNqQlry+VwJRoEqg5+1IuH/tvXxlU8QYhBWEX6
         5K87/WnZD88mdrH8CnwIi/dR2WOIOJoLVSIxatrkH3DgroeBF7vJKxlsAu7XezwQxxYO
         +9GeilPrQuqqC0Rv8sJAn2s2oZ8V+z2Q/+mFvdsrw1k4cDdYXQLmtV1lBqhSysEhfku9
         vKeUucXTURbixThrUPNiT6H+QuNpLl9PJGsmqJ1R4QoAqAKV68TrHLdyg7lsEppKHIYP
         IgpQ==
X-Gm-Message-State: AOAM530jx+CyBRw8IB2MU8RAzi/D24kganIhcVg8Ybrozs3vQKA+lvP0
        SUaoEjpVeGjmNjFbCYNkF5IttUnrpY7Oi/qZbE7wuwHktlEvgw4s
X-Google-Smtp-Source: ABdhPJz/7UhVBaiiJb8qucgYLxXBr2sUkMaDMQH0ZUsBCVhU538J7p3MzuNpAUMJaxX7kvgMGC/r8bRIzwdSePSUtF0=
X-Received: by 2002:a17:902:d2c7:b0:154:5aa1:a55b with SMTP id
 n7-20020a170902d2c700b001545aa1a55bmr4193241plc.5.1648714233934; Thu, 31 Mar
 2022 01:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFf+5zgz0R0NO_YXrcsfBWiqP2ctyQt+ZAShBP6N8=1HvOnC7Q@mail.gmail.com>
In-Reply-To: <CAFf+5zgz0R0NO_YXrcsfBWiqP2ctyQt+ZAShBP6N8=1HvOnC7Q@mail.gmail.com>
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Thu, 31 Mar 2022 13:40:24 +0530
Message-ID: <CAFf+5zieEohX+qs+pRKjuKiVip43ynXDAkuH6P90gRgf0qg8rg@mail.gmail.com>
Subject: Time travel is not possible.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that time travel is possible.

For time travel to be possible, all the past, and present, and future
should exist somewhere in material (physical / tangible) form.

This means that the state of earth 5 seconds ago should be existing
somewhere in material form. This also means that the state of earth 15
minutes into the future should also exist somewhere in material form.

If we assume the least count of 1 second, then given the age of earth
as 4.543 billion years, there should exist 143 quadrillion (past)
earths somewhere in material form.

But there is no evidence that another earth exists somewhere in
material form, forget about 143 quadrillion earths existing
simultaneously.

Same goes for future, if earth will remain around for another 4.543
billion years, then there should exist 143 quadrillion (future) earths
somewhere in material form but there is no proof of this also.

Same theory can be applied to universe and it can be said that
quadrillion of past/future universes should be existing somewhere in
material form but there is no proof of that.

One theory is that when you start time travel then "that earth" to
which you are time traveling to will come into existence but there is
no proof of this.

So, I think that time travel is not possible.
