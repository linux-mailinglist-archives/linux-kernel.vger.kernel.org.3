Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A094C8B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiCAMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiCAMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:05:46 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CF24F21
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:05:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g21so7681459pfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Tg0u1BcMkcrQ5oCWdVLlVtKu6n/dJivEtpc6Ue4+Jyw4ir2qtSN2EFSPlFVFd7SdRl
         jnkov5ikRhpS6SAVd6dDCcp8eP0rCQgEVgNWB19egrPyeZoIq8yB4MU/P598SN0m6+S7
         HHNv5f1LFKrUuhelYrMBcpMidG8yApaIVKlqToNQwBbiskBmpnciA0FOT0385xykJKsa
         ODgz2rRztKrwiGQcEBg7/zW40GMYb/iNSfA6p4Ax1ukpOeddQocSA2vOe3SmFmvZm3Uj
         WCwHAm+4lcPqqNk2ZRGysgMv4jScRP2J/2jnLLol/MbElYAZt5vXVWSNutcjTtN3NuyG
         /xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=VzOg9ZIS9njxeYrmi3uYDwqM3UaCAash9fqauqi87k++boo+leDnI//WyJ25nPj0I/
         zEqXCsEd/TYj6/FA4LVUZtdSgfqzI1MxDJ4Bt8P0Sod2Z044vTbLdAzYnTbhPuf8KkB5
         TeFG2WlKl4zwZi40xVEl2+XMa/T8O1NVo2J8V6Bbq7G+tW2/3DwPRrRS/ZVKkx1QT5l2
         UTp2BBe7XCIGzbExgstBGTmE6f9/jZGTEgeJKkszBzEEDRAhZ273V6kBlBEwjmAghge5
         fcg/2O8oujZO/GeQoMlehGHl7ZTi79Okov6y0ZsZ/MDt4uxCfJwQXnsDkYUUPBerj88K
         he2w==
X-Gm-Message-State: AOAM533oqdPuK0z3gDJYhmuaEacOG3b0VKPc0/9coDRE56UndwgX/tmx
        G5CszTEeYknr1Led99idAVKF+/0VJJCjpmHO43g=
X-Google-Smtp-Source: ABdhPJzvsG8+SM4sh/25GWnzLzL15pKuPWAYKa2aP9gmBzBW6Y1AXgbzbreCO9U22ZeTCWIbXhy6lAY2X0AWt7Ghw68=
X-Received: by 2002:a63:be0e:0:b0:363:e0be:613f with SMTP id
 l14-20020a63be0e000000b00363e0be613fmr21309057pgf.448.1646136304480; Tue, 01
 Mar 2022 04:05:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: sabu7439@gmail.com
Received: by 2002:a17:90b:3749:0:0:0:0 with HTTP; Tue, 1 Mar 2022 04:05:03
 -0800 (PST)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 1 Mar 2022 13:05:03 +0100
X-Google-Sender-Auth: HHNN5At7GSe_XTKAVQanmHrMpcE
Message-ID: <CAOJFtj1XwynksDFy-yXdjp1tg83AfaQfNX8WdJfAij7DBjLd4w@mail.gmail.com>
Subject: Greetings to you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
