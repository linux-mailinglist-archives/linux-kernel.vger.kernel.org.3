Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34864A0108
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350960AbiA1Tk4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 14:40:56 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:24900 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbiA1Tkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:40:55 -0500
Date:   Fri, 28 Jan 2022 19:40:52 +0000
Authentication-Results: mail-4317.proton.ch; dkim=none
To:     Marc Zyngier <maz@kernel.org>
From:   Conor Dooley <mail@conchuod.ie>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Reply-To: Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: sifive, plic: Fix number of interrupts
Message-ID: <c3221217-52de-64fd-2375-78b5d80c8a9a@conchuod.ie>
In-Reply-To: <87mtjf66cx.wl-maz@kernel.org>
References: <cover.1643360419.git.geert@linux-m68k.org> <f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org> <D-55Hk0vrg2vkivFR3NXwnyI8hno6J5TA6gRHi3GbGVflgVPOGQNM2auwcIoHVt3fuzkg-pe7MAARda8PG8-KPoEnarmha7U6TI-pA7V6uI=@conchuod.ie> <87mtjf66cx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.0 required=10.0 tests=ALL_TRUSTED,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 18:51, Marc Zyngier wrote:
> On Fri, 28 Jan 2022 17:57:04 +0000,
> Conor Dooley <mail@conchuod.ie> wrote:
>>
>> [1 PGP/MIME version identification <application/pgp-encrypted (7bit)>]
>> [2 OpenPGP encrypted message <application/octet-stream (7bit)>]
>
> Please refrain from posting encrypted messages to the mailing lists.
>
> 	M.

Apologies - not my usual mail client. It appears to have decided that
you (and Rob) should get it encrypted even though I had that disabled.
Actually doing so also would appear to be non trivial. I am hoping but
not expecting to have fixed it.
The mail to the list itself looks to be fine however.

>
> --
> Without deviation from the norm, progress is not possible.

