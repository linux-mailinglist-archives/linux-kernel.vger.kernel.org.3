Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A903C58A8E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiHEJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiHEJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:36:25 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0843A29C91
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659692143; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=HdRixjmY7k8QmEF2vJHaiZupbePpR/Hu1Oqp9XUbYzHXJGRTY3+pm0yWidT675bqbaYBpS9HveNo4tO6DX0V8Gzk+eVexXVxsYc3dCu1KOboGGBC0A67zBjRpKTwsh0ZzER0wItw+t5xXRsCd1CMYjOndNwUoPNbPGiLQRv5Wvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659692143; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=G8MsDCNn/ZMR+NcTrqGGmERIgvdoqAtb+ck1u1WQQns=; 
        b=Exz9DJO9SDONKHw3+wLd5DntW4JHs7hNnUWnzSJFsVa5TaX58Gy0Z65JPCCgzzYRPsexWzzgB3a3i43nFjnFWJOLJwtdPDn+1Cl/8G329zudX5fcYM2W7e8cHwsB3qviaQcI7dAaYwu1xWtaroSGz52UyeuY1lGsHXWuZGOqBZ0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659692143;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=G8MsDCNn/ZMR+NcTrqGGmERIgvdoqAtb+ck1u1WQQns=;
        b=JrkzXZwEhfuPxSVR+Vtx8JiRjTCCR+078sCcwoc2XKVOp6jwNyuxjNbF4BTDvACx
        WBh2BHk5ED7fRmznza4E1R2XiZGWQzDgTDBnEH6ZvThDH8RJ+QD0acm3ris8YM7SL6u
        sQYJkdV+mtVaHNQ6X3jRDTAGUZW8kL1jNbYxw9E0=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659692132718539.7638172100387; Fri, 5 Aug 2022 15:05:32 +0530 (IST)
Date:   Fri, 05 Aug 2022 15:05:32 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "David Howells" <dhowells@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <1826d5c2956.568f80f5118689.2103252186884814555@siddh.me>
In-Reply-To: <YuzFIx36zDXX0z/0@sol.localdomain>
References: <cover.1659618705.git.code@siddh.me>
 <6bac2d4c2b50d921eb16fa5344ffe258be90c651.1659618705.git.code@siddh.me> <YuzFIx36zDXX0z/0@sol.localdomain>
Subject: Re: [PATCH 2/3] kernel/watch_queue: Improve struct annotation
 formatting
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2022 12:52:11 +0530  Eric Biggers  wrote:
> On Thu, Aug 04, 2022 at 07:00:23PM +0530, Siddh Raman Pant wrote:
> > Improve formatting struct annotations in watch_queue.h, so that they
> > fall in the preferred 80 character limit.
> > 
> > Signed-off-by: Siddh Raman Pant code@siddh.me>
> 
> This patch isn't just fixing overly long lines, but rather is introducing
> kerneldoc comments and documenting things that weren't documented before.
> That's fine, but please make the commit message accurately describe the patch.
> 
> > diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
> > index fc6bba20273b..c99c39ec6548 100644
> > --- a/include/linux/watch_queue.h
> > +++ b/include/linux/watch_queue.h
> > @@ -18,57 +18,103 @@
> >  
> >  struct cred;
> >  
> > +/**
> > + * watch_type_filter - Filter on watch type
> 
> If you're going to use kerneldoc comments, they should be correctly formatted.
> This is not, since it's missing the word struct.  You can run this command to
> see the kerneldoc warnings:
> 
> 	./scripts/kernel-doc -v -none include/linux/watch_queue.h
> 
> > + * @lock: Spinlock
> 
> Please make sure that comments provide useful information and don't just repeat
> what the code says.
> 
> - Eric
> 

Okay, will do.

Thanks,
Siddh
