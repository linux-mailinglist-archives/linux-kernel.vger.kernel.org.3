Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10E47D735
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbhLVSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhLVSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:54:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:54:27 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 685B11EC02B9;
        Wed, 22 Dec 2021 19:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640199261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HHrdNq1IzUE95HNm7pAxbzhbcVx1bL9fSpAqLB6cNoY=;
        b=AAHIKAnoPEm85M4UrCLuHhIVNTdMZEPznVLa5Jy788i/hx4NRudx9MSUfBYzgXJvy8Z9BU
        r7y6w1AB/eRcJXQGdyTtjLXFUTZN/IBwOk8iRwhhiCLqVXdj3qwV+N6yos2FV3uJVyrcWE
        mdjIHcmzquPqBUb28w4oiotaRDQPQ+I=
Date:   Wed, 22 Dec 2021 19:54:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>,
        x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: remove set_fs for UML
Message-ID: <YcN0X+hBm1TUBGnq@zn.tnic>
References: <20211215165612.554426-1-hch@lst.de>
 <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
 <20211222081753.GB22041@lst.de>
 <YcMuW88cOBNXAdb/@zn.tnic>
 <689476797.194605.1640192159613.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <689476797.194605.1640192159613.JavaMail.zimbra@nod.at>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 05:55:59PM +0100, Richard Weinberger wrote:
> Would be great!
> When I'll drop "x86/mtrr: remove the mtrr_bp_init stub" from the UML tree.

Done.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
