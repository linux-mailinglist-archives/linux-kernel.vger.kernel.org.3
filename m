Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AF47D581
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbhLVQ4D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 11:56:03 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36410 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344121AbhLVQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:56:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 752B1614E2CD;
        Wed, 22 Dec 2021 17:56:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CF-VDLV6_9Wv; Wed, 22 Dec 2021 17:55:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D297C614E2D5;
        Wed, 22 Dec 2021 17:55:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3T-5_MrcWr8U; Wed, 22 Dec 2021 17:55:59 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AB83A614E2CD;
        Wed, 22 Dec 2021 17:55:59 +0100 (CET)
Date:   Wed, 22 Dec 2021 17:55:59 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bp <bp@alien8.de>
Cc:     hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>,
        x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <689476797.194605.1640192159613.JavaMail.zimbra@nod.at>
In-Reply-To: <YcMuW88cOBNXAdb/@zn.tnic>
References: <20211215165612.554426-1-hch@lst.de> <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at> <20211222081753.GB22041@lst.de> <YcMuW88cOBNXAdb/@zn.tnic>
Subject: Re: remove set_fs for UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove set_fs for UML
Thread-Index: VWc5UxOt2mEfXDfyiYxJYrg133SXXQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,

----- Ursprüngliche Mail -----
> Von: "bp" <bp@alien8.de>
> An: "hch" <hch@lst.de>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "x86" <x86@kernel.org>, "linux-um"
> <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 22. Dezember 2021 14:55:39
> Betreff: Re: remove set_fs for UML

> On Wed, Dec 22, 2021 at 09:17:53AM +0100, hch wrote:
>> On Tue, Dec 21, 2021 at 10:05:03PM +0100, Richard Weinberger wrote:
>> > So far UML seems to work with these changes applied. :-)
>> > I have applied both patches to my UML tree for now, I assume x86 maintainers are
>> > fine with
>> > patch 1/2?
>> 
>> Looks like patch 1 needs this fixup for some configurations, where
>> pci.h doesn't get pulled into kvm by other means.
>> 
>> But we probably want an ACK from the x86 maintainers to be sure anyway..
> 
> I don't see why not so
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 
> Should I take the first one along with this hunk below?

Would be great!
When I'll drop "x86/mtrr: remove the mtrr_bp_init stub" from the UML tree.
 
Thanks,
//richard
