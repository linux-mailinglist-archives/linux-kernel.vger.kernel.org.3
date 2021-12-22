Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9547D7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbhLVTbX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 14:31:23 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:38550 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbhLVTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:31:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B433F62DA5EC;
        Wed, 22 Dec 2021 20:31:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T_IkduecIwqS; Wed, 22 Dec 2021 20:31:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 426A062DA5F1;
        Wed, 22 Dec 2021 20:31:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1eDtkPYl3ZHJ; Wed, 22 Dec 2021 20:31:18 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1CAD662DA5EC;
        Wed, 22 Dec 2021 20:31:18 +0100 (CET)
Date:   Wed, 22 Dec 2021 20:31:18 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        kernel <kernel@axis.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Message-ID: <1827544067.194741.1640201478025.JavaMail.zimbra@nod.at>
In-Reply-To: <20211222102356.GA25135@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com> <342397676.191011.1640120120622.JavaMail.zimbra@nod.at> <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net> <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at> <20211222102356.GA25135@axis.com>
Subject: Re: [PATCH 0/2] Devicetree support for UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: Devicetree support for UML
Thread-Index: KOuXZL681kKwDmBzRMUXWEWXR3/55g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent,

----- Ursprüngliche Mail -----
> Von: "Vincent Whitchurch" <vincent.whitchurch@axis.com>
> An: "richard" <richard@nod.at>
> CC: "Johannes Berg" <johannes@sipsolutions.net>, "Jeff Dike" <jdike@addtoit.com>, "anton ivanov"
> <anton.ivanov@cambridgegreys.com>, "kernel" <kernel@axis.com>, "linux-kernel" <linux-kernel@vger.kernel.org>,
> "linux-um" <linux-um@lists.infradead.org>, "devicetree" <devicetree@vger.kernel.org>
> Gesendet: Mittwoch, 22. Dezember 2021 11:23:57
> Betreff: Re: [PATCH 0/2] Devicetree support for UML

> On Tue, Dec 21, 2021 at 10:13:03PM +0100, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>> > Von: "Johannes Berg" <johannes@sipsolutions.net>
>> > Gesendet: Dienstag, 21. Dezember 2021 21:56:50
>> > On Tue, 2021-12-21 at 21:55 +0100, Richard Weinberger wrote:
>> >> WARNING: unmet direct dependencies detected for OF_EARLY_FLATTREE
>> >>   Depends on [n]: OF [=n]
>> >>   Selected by [y]:
>> >>   - UML [=y]
>> >> 
>> >> Please note that my UML config has CONFIG_OF=n.
>> >> 
>> > Hm. So maybe that needs to be
>> > 
>> >	select OF_EARLY_FLATTREE if OF
>> 
>> Yeah, IIRC arm and mips use such a pattern too.  Vincent, what do you
>> think?
> 
> Yes, that looks like the correct fix.  I've tested it and it works.  Do
> you prefer to fix it up locally or should I repost?

I'll fix it myself. :-)

Thanks,
//richard
