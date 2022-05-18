Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0486652BE99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiEROt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbiEROtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:49:23 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C816D12D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:49:08 -0700 (PDT)
Date:   Wed, 18 May 2022 14:48:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1652885344; x=1653144544;
        bh=IsjIuEcd94fJyea+PJUOHJx9oBPXjXJI/nvIH2UQIB4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=H+4JrRKpUNATvt4sS6rD86JXIX6ZCAuofur4bSZtpk8cAWYbsiDl9pGOO4BOsxNF8
         hbHGIIjbSk3/qBPfzMsoStr82KUKMDaz0iw6bl/hra1Ths4rYFFPrk+hq1S9ssDfGg
         SBvg+PDTpUv2RrM8zSC+RMOKQSapFGqIUdvDycREiw7QVEMO9a44F4GkyEHZppgi5r
         KKFqTMZgYUPJDnLiABRqWNksmmm7a0zfoWxWLygTBNPlQAGpCnxWgVPBfnUssXO9Yr
         Xwb6/2/2D3JdjOFly2GwGCtfw/RmNR4EnK+xH89T7HuSEt0JcjQftXWi0L1hE7pbS9
         uK7KRjvyNyOTQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Reply-To: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Subject: I have just discovered that Linux operating system is powering F5 BIG-IP network devices
Message-ID: <f8Bx8Cr3V7DmlJr-TK0uKqe5rf9VGfLxb4HTMFO9P00jEAC0rrjkpDq0557hDLQQJplXeeduCDPWFLjQtgTT6nzGvp_7_l8ty5Kfe27im8Q=@protonmail.com>
Feedback-ID: 39510961:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_40,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I have just discovered that Linux operating system is powering F5 =
BIG-IP network devices

Good day from Singapore,

I have just discovered that Linux operating system is powering F5 BIG-IP ne=
twork devices. Please refer to the following news article.

Article: Critical F5 BIG-IP vulnerability exploited to wipe devices
Link: https://www.bleepingcomputer.com/news/security/critical-f5-big-ip-vul=
nerability-exploited-to-wipe-devices/

[QUOTE]

As the exploit gives attackers root privileges in the Linux operating syste=
ms powering BIG-IP devices, the rm -rf /* command will be able to delete al=
most every file, including configuration files required for the device to o=
perate correctly.

[/QUOTE]

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
18 May 2022 Wed
