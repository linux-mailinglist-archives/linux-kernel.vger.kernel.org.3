Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBE49EA71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiA0SiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiA0SiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:38:18 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2984C061714;
        Thu, 27 Jan 2022 10:38:18 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D30037C;
        Thu, 27 Jan 2022 18:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D30037C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643308698; bh=VSy0e4wWqMfsYR4i7qNPEXGEhCC4zwtpbTZT6TbNb2c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g3w7qv7/QTsmYWH7cJjp2KypLonwoXl29osGTxOQ/1806GTPjOOen9yEr0Vkin3AA
         2Ee/N3go8KYh0Pp5ZvfCoPJ6VTAdh6c/tpV/KF2OGXHUQN3LQHJnXG6fpKZF6V47nn
         0tREePGb7VUKIbuYH4Tbh1FlEGNC6bUc34/Ppvc4/BotWyFLOTb9NXsSm2EhSIrthu
         mA1B0wcCMdRcOXh2OKQkJFk79BNLLs8pHz1AF2T0X8vebP6hs1BKvc6e4/1t0WhkcK
         Pvc2e3gVz5882+Hn7OarFMP7WxjCh1KfsUg/yfGgxgPwEfvPHvXVaZK44UfUaI+p5t
         bIxtFgE+q3dOg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <seakeel@gmail.com>,
        teng sterling <sterlingteng@gmail.com>
Cc:     yong w <yongw.pur@gmail.com>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wang.yong12@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
In-Reply-To: <CAJy-Amne22+2cApoeEAGSc7d7ppSQja7pLX6SY_3+0wr8i3Asw@mail.gmail.com>
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
 <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
 <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com>
 <CAOH5QeAka4QsLCOHaNK8NBp1BUFsu3HqEqiOhWOewabA58fVqw@mail.gmail.com>
 <CAMU9jJr4A0jsZGAqdOUTc-gBeshCgPAS=2Vvubs_kmsJSegzkQ@mail.gmail.com>
 <CAJy-Amne22+2cApoeEAGSc7d7ppSQja7pLX6SY_3+0wr8i3Asw@mail.gmail.com>
Date:   Thu, 27 Jan 2022 11:38:49 -0700
Message-ID: <87y231qb0m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <seakeel@gmail.com> writes:

> Right. The better way is asking Yang Yang to give a reviewed-by in
> mailing list next time. Otherwise, the private tag can't give a good
> support.

Agreed with that.

> for this patch. Reviewed-by: Alex Shi <alexs@kernel.org>

Another nice rule of thumb: put Reviewed-by on its own line so that b4
picks it up :)

Patch applied, thanks.

jon
