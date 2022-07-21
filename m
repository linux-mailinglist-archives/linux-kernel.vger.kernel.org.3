Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4257C1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGUBJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:09:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09067435E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 18:09:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g4so251881pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uuEYhykDgwahn59nB7oGHoLMCAAnBI6MbSNiUBV8AmQ=;
        b=d2uCXiB7IP7eSTLMsrL/VMRerI0Fl9dkmNT87JGk/aOqT5jIMUjSI1vVqa/tyoBJdl
         gitQDvyM/k0ubarK2oRgIW2uAHtDzixLpOqogK8pYHtROJnWYT38ndYngLsToFvMhY8/
         jHhCqg9+DFwav4Z1D3tPm941I40sn1qY6/ktHYy90qrHMLeUEzshsIx/a9p2cBKYdJPF
         a3KEvVs5r+YW4qt1U2p3r7k7rUz+YM5vFdwfXBpZuIC3oAu8MytXT1Hj25XAJVDk2gCk
         c0YhxRWhX4F3ay9Xw6kJenuiQSdixk1I3mQLM6HYNkjvf+4kYpCbUzLXagPuTcc8OdY5
         Isdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uuEYhykDgwahn59nB7oGHoLMCAAnBI6MbSNiUBV8AmQ=;
        b=sqTY7WnjJN8Wc/xEglofWTYAqOg0PBnlFaCAGP44L0lBVBwG+ieOGNbxTSpF1u79i7
         BOtSjotXRY0rY/coxN8DML1dSjUIlKx3n2vu3XvFA5cSXedzxMPl+zDcs4/BHlT1PrTj
         6hldr/sJNX+PUwuK7IfzgZELimliUebN17VTjLDF2D3HNrON/NjaQt9GJ8OxGdHYaxYd
         +vGMeqKUMfF7LfCiVJMURPGL+NarriIFaRb5YRhNCOWP9Od3hPxOX/3/iBvVVhoh086a
         dVmK3Tm6GlTxq0Ik7S1UOPsA4kwIwq1j3/cXp9lM6fQIfk4yjignPcZ2/JPhevPKdmCG
         sWHQ==
X-Gm-Message-State: AJIora91U6XaVncyyiKvskKzDTKm3gcRNIvze3SsWZ77k09pdmvrCpcH
        WPWF6Ovq8xdZO+g1dn4WAksd5slfqIDMsfzFrcw=
X-Google-Smtp-Source: AGRyM1v1sA3wlaPfr/3rwo7qPpHQilOIoMcyZnV74QOyhuuAPRWV7N9MrZp+zwSVY4liYs5FEICiRjdrs25MnpTjRX0=
X-Received: by 2002:a63:b443:0:b0:40c:fbf9:8366 with SMTP id
 n3-20020a63b443000000b0040cfbf98366mr35360130pgu.308.1658365744130; Wed, 20
 Jul 2022 18:09:04 -0700 (PDT)
MIME-Version: 1.0
Sender: kingspharo@gmail.com
Received: by 2002:a05:7300:3b28:b0:6a:d9c7:8bba with HTTP; Wed, 20 Jul 2022
 18:09:03 -0700 (PDT)
From:   "Miss.Ella" <ella.hazem1@gmail.com>
Date:   Thu, 21 Jul 2022 01:09:03 +0000
X-Google-Sender-Auth: t6ZvuJJkq3lHj6U9BibTagyrUPw
Message-ID: <CAFZV-eb8nwKyqpRW+HKVD3UOaD0_e99DG_WvkQn7rq36kLZjgQ@mail.gmail.com>
Subject: Hello darling.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello darling.

How are you today? I want to communicate with you. My name is Ella
Hazem. I am single. It will be my honor to establish healthy life
friendship with you. I'm right Make new friends, my hobbies are
reading, traveling, swimming and dancing. Please write me again so
that I can explain everything about myself to you.

Sincerely,
ella
