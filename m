Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF347CFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhLVKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:24:00 -0500
Received: from smtp1.axis.com ([195.60.68.17]:19706 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239280AbhLVKX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1640168639;
  x=1671704639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AiRNQTH94r+D9lKMXJMutmL10d1qDEsq3uj6a3lEGO8=;
  b=lwyPloZTQba7Tld8cKS8Bvaupv7qHm7bCvDbDyMUtP/J4Pk+jWrcLVPs
   R/JN8DbYR+gj/hnpimNvvypcR/jsrf5RLDiGsFVK9gRBdvH/xrwlFcl+r
   h/PX+uinWB0r0rc8sApm8uOMbDM9Ak+ZXui9mCyNSo1aZ9/GUBkE/JFD7
   t0HJ+UI+kMOJmBNzwtYzvJegwYPbDKw0Ynl84uWpTSOuvSt9Oj8dCmHul
   2qnZoB69mbvdGAgRlzVzX9RI8F7A6M/uj8kgjPXdckBfd/c1yPJKLj2YC
   qHf452PVF9SWsb/is+V5yGYLJ43EEc7JksphA+BT3Zb1GUjD9/0oKO4ql
   g==;
Date:   Wed, 22 Dec 2021 11:23:57 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        kernel <kernel@axis.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/2] Devicetree support for UML
Message-ID: <20211222102356.GA25135@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
 <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
 <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:13:03PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Johannes Berg" <johannes@sipsolutions.net>
> > Gesendet: Dienstag, 21. Dezember 2021 21:56:50
> > On Tue, 2021-12-21 at 21:55 +0100, Richard Weinberger wrote:
> >> WARNING: unmet direct dependencies detected for OF_EARLY_FLATTREE
> >>   Depends on [n]: OF [=n]
> >>   Selected by [y]:
> >>   - UML [=y]
> >> 
> >> Please note that my UML config has CONFIG_OF=n.
> >> 
> > Hm. So maybe that needs to be
> > 
> >	select OF_EARLY_FLATTREE if OF
> 
> Yeah, IIRC arm and mips use such a pattern too.  Vincent, what do you
> think?

Yes, that looks like the correct fix.  I've tested it and it works.  Do
you prefer to fix it up locally or should I repost?
