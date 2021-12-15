Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FF4761AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbhLOTZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbhLOTZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:25:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA993C061574;
        Wed, 15 Dec 2021 11:25:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639596323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KT7JY3Ys8b/8L35+SOW16m9hH70RGmEctiRxYgxc0o=;
        b=JtPW/xveQu3FbzczfH2uHSkiYkMm5v37tPc+2fllWFZIQNy8B4c1ZxvzpkooR4JhWSeKXd
        Z269HOXQrZLCXqBCRlrBh1OJvK9VqBcGVAMhK0X7VXyNSN0/cef5VXwJDum854rZEEAgdA
        Ukg5Xena3yMwqeyz3sKCD8/vz20BOGgAWzeQt2Ks/7zPiNaq0Fz/qQ6goJaBiF17FxRHbI
        pJISb3qltI9u+AndtzXgIbxafa4Ni6niUv+bvMxfjefF24u2skIWML13kPcypl2KHPY5D5
        5EV1nAB6PLIKDNUQfdUTO6MfBdpaZPDHE4oT6eURN3gv4ZdWzKxUMf6ne8uv3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639596323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KT7JY3Ys8b/8L35+SOW16m9hH70RGmEctiRxYgxc0o=;
        b=GwPn0D2VOJ/OVkzz9WbHxXH0EAnlcu9SWihSxjAZHweJ0ePHW0MZMrKzyLKnOUh6ctCaHc
        ReLnGf0BLmHq8ECw==
To:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 14 (arch/x86/kernel/apic/msi.o)
In-Reply-To: <c916e22d-5b97-9cdc-486f-64d06d82cef9@infradead.org>
References: <20211214223228.1745315-1-broonie@kernel.org>
 <c916e22d-5b97-9cdc-486f-64d06d82cef9@infradead.org>
Date:   Wed, 15 Dec 2021 20:25:22 +0100
Message-ID: <87lf0lr7q5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14 2021 at 17:49, Randy Dunlap wrote:
> On 12/14/21 14:32, broonie@kernel.org wrote:
>> Hi all,
>> 
>> News: Releases may or may not happen over the next few days since I'm
>> getting a vacciene dose tomorrow.
>> 
>> Changes since 20211213:
>> 
>
> on x86_64:
>
> ld: arch/x86/kernel/apic/msi.o: in function `arch_restore_msi_irqs':
> msi.c:(.text+0x245): undefined reference to `xen_initdom_restore_msi'

Fixed. Arnd sent a patch already.

Thanks,

        tglx
