Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3007254C812
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347071AbiFOMEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFOMEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:04:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE7192AF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:04:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c144so8490827qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Ff44J8cWcPASWwJLD2JxeOCkBQeUfYZ7VOjwflDWiP3NC/FqQiU9idhlppKc3Vxhmg
         ZrfzGDZ1KjVhE22eHUWWJjQjUJNAWQhMg/p4luTVZ+tPG3+BYDbXWIh2Gg4OAR+2P1EE
         VzTLp5HejuiJ/D+YgRzILjwYf2encdpipFOGt228BqSTqFJJa6LOyfvMpyKwURku636I
         j5LHwYyxAYRsQEtbve73XgMlWScWbCWBUKP8XWLJBrYuq3hj2efptPAWaKX2yyLhbc0D
         BaGDg0s3SETHGFne+l/yMgU+9Jo48jCCIH/JrisrIIR0yoR4u1yL6egbQEDRiAhIAPv0
         yDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=382RVneAc+ajjhkPCqD63z3/Xqkoqfn3EMdAHGir6JOLlnyRk9hbw2r1bfnfJz0GHE
         vIyQgyZP9P7PXE7rTr1I8GSD8I4gmmA+Hhb8aD3eW6deDIO9N4y38LQntxLF4351WCdn
         82bGSyCb2jsA3GNLOx3/pPgIl1sIiE3djzHOWr2pHShaP94gAyFEGz3i8vlhPOJm7hHo
         KilfEkAJDWtkmkoVO9hYI+4GZHq80GdiroA4Fa8hQsmhRSbWRSMr1sAMQlSLBgJb2S/s
         s54UjFMVanMdZg2QgX0k3motRbBX7YpW0Aa6XbMvQn82b3GO647pmC1q7WxV4aueYS6f
         GFyg==
X-Gm-Message-State: AOAM53222ampHgL2q4awIfl5HYRZv/Ih/9cwI5ZaVmkvwjEBLIEJXLiT
        irH8B+wZ+en4pPQOftX6yFF0hnHuvO+ijPsIuGo=
X-Google-Smtp-Source: ABdhPJwHxCPkUtFwAmYLSCNJBiPWLq50byLJqxGjRN8hy0uHTDnmHyb79GJY1KJIHVgGDs6WvLJLgySI7Sai8al4vBc=
X-Received: by 2002:a05:620a:12da:b0:6a6:b06b:2ee3 with SMTP id
 e26-20020a05620a12da00b006a6b06b2ee3mr7618356qkl.725.1655294646410; Wed, 15
 Jun 2022 05:04:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: issasalif505@gmail.com
Received: by 2002:a05:6214:2388:0:0:0:0 with HTTP; Wed, 15 Jun 2022 05:04:05
 -0700 (PDT)
From:   Zahiri Keen <mrzahirikeen1@gmail.com>
Date:   Wed, 15 Jun 2022 12:04:05 +0000
X-Google-Sender-Auth: kplCWWxeG8xpGejAe1BwRw_OhoI
Message-ID: <CAO1GMAQeGWXyHMa-QD_BLLwxPuQ7ki_fYvJC0Q74s0+K1N-P0A@mail.gmail.com>
Subject: Hello My Friend.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
