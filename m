Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50E64943EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiASXxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:53:14 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:59730 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiASXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:53:13 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JfMsJ5Bttz1s9Mk;
        Thu, 20 Jan 2022 00:53:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JfMsJ4Hbyz1qqkB;
        Thu, 20 Jan 2022 00:53:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dRGOlz5u8L7s; Thu, 20 Jan 2022 00:53:07 +0100 (CET)
X-Auth-Info: 9m4bgV9T2M+yZZxp4SgYjNeW8kikBjyhixaHbLns0GY06zMhMO/XYHIJRr/oHbKB
Received: from igel.home (ppp-46-244-165-91.dynamic.mnet-online.de [46.244.165.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 20 Jan 2022 00:53:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 1F9032C3AD3; Thu, 20 Jan 2022 00:53:07 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
References: <20220117154433.3124-1-changbin.du@gmail.com>
        <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com>
        <87v8yg6lhf.fsf@igel.home>
        <AAAA7852-EBCA-47A3-B74E-A425023468C6@jrtc27.com>
        <8735lj78wu.fsf@igel.home>
        <8F8D535F-3637-4BC7-8853-B709EC5D14C9@jrtc27.com>
        <87y23b5t9g.fsf@igel.home>
        <BD64D67C-613B-495E-9FB7-2AFB6FA15308@jrtc27.com>
X-Yow:  Now my EMOTIONAL RESOURCES are heavily committed to 23% of the
 SMELTING and REFINING industry of the state of NEVADA!!
Date:   Thu, 20 Jan 2022 00:53:07 +0100
In-Reply-To: <BD64D67C-613B-495E-9FB7-2AFB6FA15308@jrtc27.com> (Jessica
        Clarke's message of "Wed, 19 Jan 2022 21:27:46 +0000")
Message-ID: <87tudz5llo.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19 2022, Jessica Clarke wrote:

> What’s your point?

LLVM doesn't have to deal with the extra complexity.

> doesn’t mean other toolchains that do need that to be correct should
> just do something wrong.

__builtin_frame_address with count > 0 is considered bad.  Nobody should
use it.

You don't have to be arrogant.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
