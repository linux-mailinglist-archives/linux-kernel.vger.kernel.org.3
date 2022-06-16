Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8988554DA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiFPF4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFPF4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:56:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AF5A5A2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:55:59 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t32so442019ybt.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8dSHGBYiSAsqMqEIcbjH60egC7Q/x8LYtXvnpaZD7bY=;
        b=nplhnyXkwq7Zg3E6n+F1m+KRr06K0OCfAUQqSugPTTYehk6ycrsV1IUf6RQwh2/vpM
         WO5szrmEDrsvh2lg/MalDHdC+JKAvV7N64VcIkkfCnaQcDRfYXsn13vcQ5NXkTT/oNAh
         +m8gcQ64sKkH1dTi9CSto+Sj3ZJBnrcdxdq3rR6TF/Gotpf3qqBv+WqN7sT8EaF7GajU
         QXtr5LlvYF5BmkMAvlbhffh4ZsE3qLk4SoMzjdhXZlvYWriscPXds94+t94rsf3fT0LU
         ffRCwesS/4ej/o0MJYITeFitWyIkshOkN+chHBjbi4PMx5MrL4xSA/4V2W1Ggx7zjQnK
         alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8dSHGBYiSAsqMqEIcbjH60egC7Q/x8LYtXvnpaZD7bY=;
        b=5/pA/1ylPLshE3n7G+AWjbeBEuf8z+Rrl8Ql6P+OqTdbdqmcqUHf4w6cCssqJw4DAR
         gxqe3HrB4WG5SLlrQe5x1ke7XVmiNiiadRy2PXCbzfW64OVOcEl6YfZbFnyqa1PNDg8n
         gBWfJdrMAKDx+qhKPW+o1tUDl0jxDRxLNBCWb4n9kkff84rRH1zS9VfF6VP+nj0FZQgA
         sho3I9Nlz3fVWLFmJlht8E4e5ZZzMbioeUr4hdZ3YaOVC2whOAswoXmoisb2tVfAyWEl
         T0QUskYRbf5UCTzu3vBsVcRpRrNDK6XvAf8Dex5yMHa5ygXqfhU1P8qs/nSSGDhBnUIS
         zxKw==
X-Gm-Message-State: AJIora+qdaoAQF0b15rE5EtpJkD3KPmX36C8kZGvU6ExDDdRPtCCYujE
        XhFWWlYW3Jd28C3zFhM1B2/1tk90DWQmhJQYskEFic/TudY=
X-Google-Smtp-Source: AGRyM1vRtxV3rGdjir/sJetChjOaTVdE4SxsZk2gKBzdUlYWpO5kjZY+kPtGLm2E96DJUqX8dImj3Th80Lw78B54NZg=
X-Received: by 2002:a25:e089:0:b0:668:91ce:17ac with SMTP id
 x131-20020a25e089000000b0066891ce17acmr1341933ybg.642.1655358958741; Wed, 15
 Jun 2022 22:55:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Thomas <jason.thomas.0704@gmail.com>
Date:   Wed, 15 Jun 2022 22:55:48 -0700
Message-ID: <CAAGKmqL9k87xw68zwH9ZM7fQFFsgMnA7V=RB+tQ-M2WS6CZg4A@mail.gmail.com>
Subject: Error while building kernel with allyesconfig
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to build the Linux kernel checked out at the commit
e71e60cd with allyesconfig, gcc version 9.4.0, and Ubuntu 20.04. But,
I am getting the following error:

FATAL: modpost: vmlinux.o is truncated.
sechdrs[i].sh_offset=4236180760 > sizeof(*hrd)=64

However, building with the default config (defconfig) just works fine.
Any help would be appreciated.

-- 

JT
