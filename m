Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC755A8D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiFYKYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFYKYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:24:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B613DFA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 03:24:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b7so5479005ljr.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=lkx9shy389bjUkUVzL/gjZ86apFk2k0QZbOelmBX0OE=;
        b=hLKCRtDbLgCgk8Pp0iktJW+6iq5Emts2wgNo2ytOVYoOS0e984gxy9uLGqk87mWCrH
         q2Eg0gOVNhtNZY7rLBpyJNOvwuLFPnb01OFQ2Bnq3ppCQb+mgWNYaXRqFUc2OpcmThuJ
         n5LXojZljF1gypIth1ijbeJtIy/YHEjdzKii9mhQ9ocEz4/MMKNNwZ6fwBr0IFKEHVCY
         SYHE8bHrSC5qHhWmdna7aMx5jTkze4v+Zn+nXHR/cF98UDmlOq1QQWQMyWsNMy/BvEqQ
         ZvCf/R1S1reelMnWwaLrfsEs9qim4lA5S+1INWfr2vrFMKgkltAcR93fnFhnwBw9Qmzt
         8zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=lkx9shy389bjUkUVzL/gjZ86apFk2k0QZbOelmBX0OE=;
        b=P/ULlTdntAi/mODMrZCVC/FjGXgf0a/n1d6QZQfjILjBPITKyw+brluLnOmojGy8Eq
         fEws452gJRM3j5oDN7huWZ8/CLa0JGROHce9iYfovh/fIi3RxFGoZOwKhKFSmrM83WCX
         1vzcJtCK4ogC+AYg0Zzn9B84fZ4oi1/H4ckSAX5REhQqR+i0cTGLazDLI2j3iSCI0Ojs
         vprx4vsUgIovbPL0pkkgzQxhx07vry8fsl3HKPyB5VVjzKCvwKXWMjCdSfzC9WyMJrcP
         yfvjUpznKK7bmV2JYyab4kz02hybODi2C1RtGxKvkMSVKm/fCo9ILlsOFEmpKWEPjupi
         3DHw==
X-Gm-Message-State: AJIora/0pZnMKZMx8LPBbR6Sye7xPEoQzGQDjM/ZWo64OUmk7nDZRT41
        XwIVv4Tc5wQQw7Ycm/92AaloBNDZkF9qFUscdmU=
X-Google-Smtp-Source: AGRyM1t8f87V6I5aKnUbC8/CNEpqL8V1bx+rAU5ciw/LmM5hiAEDmGSwRu3KEeCObb/2I2ASbNVqMycNl+zDO9BHPt4=
X-Received: by 2002:a05:651c:1617:b0:25a:9e88:af82 with SMTP id
 f23-20020a05651c161700b0025a9e88af82mr1580624ljq.106.1656152640120; Sat, 25
 Jun 2022 03:24:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:3096:0:0:0:0 with HTTP; Sat, 25 Jun 2022 03:23:59
 -0700 (PDT)
Reply-To: zjianxin700@gmail.com
From:   Zong Jianxin <johnsonchesaina@gmail.com>
Date:   Sat, 25 Jun 2022 03:23:59 -0700
Message-ID: <CA+Q_prH_uWweR_THagbPk0fM+Ezff6NeH4Cf7RZWhHgyQJ6Enw@mail.gmail.com>
Subject: Hello!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Did you receive my previous email? I have a Profitable deal for you.

Thanks
Zong Jianxin
