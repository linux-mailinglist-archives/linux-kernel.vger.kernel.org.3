Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE655EFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF1UpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiF1UpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:45:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133C2657D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:45:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so6458723pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=klHwOIrGUdoErqjay96x3dFn9GkD+dj20qf/FYcK12c=;
        b=X1i5WzweIaOt4XY1kmRXEbKZUdnuCT+fLaExkoVCRnE3JAsx/bTF0pDmO2QTDtm8Fw
         A5+awOokJJ59Cmj/cp0AOFgthP2Uyl5ZBd90AcTwerYAX+tnuYJZi+5iW2WVqxVUHUKu
         9lYxUaOFtveWIpTFFupPy07e0u15Jhpf+6A22ZzQ3VWy4iTaXdFxbTLLBMOkY7VfEVcl
         uNdwGBa6P0p6k31C9gp0jqSHZ2SsTHspthrB5+WmguUodkpRMeaplWfelsjlypPqdVY5
         UEPfPh3kE6PLyKNtF3hcx75UlE1306/bY+L+2+zCgDFOPp8OvQveDB7cvYRLWGRXD6s7
         +Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=klHwOIrGUdoErqjay96x3dFn9GkD+dj20qf/FYcK12c=;
        b=Kr8jxJNQcASSL7h+3TWVXg7w2Nr2clr+PZ++pPFAfr8RZE/+yXTc0JWZxEeERrCBED
         nyTcIjSaNz6UKYtqT9z7MPdvir9viHswFKijL5PKASgES6YyvIfzJy0kneYM8Yup9YVi
         YDPZgO6IA1tTHoopoT1QXDvnkhRe5FJqqCNacpGcrWXCNSkSaO6zLXS7LjalgX0v/L3B
         D2y+rsdu7kkuKn+83lK8Z/F37V5Yd+W9Tr3eateRKICEeSbDPjuDLs96Pudt9BDXqSxo
         6WEnYPYv/abiUD7jjzEIMKqvSJB7+jdsevGQuaPDmJTuQnIp81Iw8PCsq8PQCXy+Yuzz
         NKTw==
X-Gm-Message-State: AJIora9xVt9VINkt0eXaiUDJFMYuBK4MhRwtaOH6evWUXw8nhcEB5vuh
        vGIb3VctpHJM2/Ckre0B6X5x2m6hHDE=
X-Google-Smtp-Source: AGRyM1thlfN+vY8bV/1O836jKS536CGQUOb+TlJKrsUHmr0aLtbqVvyJN8rXzGMMSYz/3jZsbw1VXw==
X-Received: by 2002:a17:902:ac90:b0:16a:1c0d:b586 with SMTP id h16-20020a170902ac9000b0016a1c0db586mr6790829plr.155.1656449101406;
        Tue, 28 Jun 2022 13:45:01 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79208000000b0050dc76281e0sm5578951pfo.186.2022.06.28.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:45:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 05:44:59 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
Subject: Re: [PATCH] wireguard: selftests: support OpenRISC
Message-ID: <YrtoS7ZUnKUg8Soz@antec>
References: <20220628000210.763674-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628000210.763674-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:02:10AM +0200, Jason A. Donenfeld wrote:
> Stafford and I have been using this to shake out OpenRISC bugs, and it's
> been a great help, so it's time OpenRISC support for the WireGuard test
> suite is made into a proper commit. The QEMU changes necessary for this
> to work should also be around the corner now, and they seem some what
> stationary in their interface too.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Hello,

I am not sure what happened to my reply on this yesterday, but I did have this
queued for 5.19 fixes.  However, as we just discussed there are still some soft
lockup issues that cause 'rcu: INFO: rcu_preempt detected stalls' noise.

I will hold off sending this upstream for now.

Example isssues:
 - https://א.cc/x3Vt402T
 - https://xn--4db.cc/bKiNzmFE

-Stafford
