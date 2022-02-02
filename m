Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6AA4A778A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiBBSLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:11:01 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:43791 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbiBBSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:11:00 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 773B72B002FF;
        Wed,  2 Feb 2022 13:10:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 13:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=BzKbLARq0BSnJcyeCRXnM9y5FOWw5F/q2SIlEb
        vvUnA=; b=ZlB8ag1vlar94J3JIbaoR2kXx0u5H4ra8Sjfw4n3q3CCboC+1wWCB5
        Sil9FMGVAVjvW9ALaqFkT7TjBKjQjEYXIwngJOGRFEDclHRUlbb5V+mcW1bdyX/y
        X3v8uK5tze3wQquixUA90I/KgYQeqmMAJt7DE3+IHxU8qftBsY1UI/+YofwLKNVI
        QsnT0tQ37awOLDS0XJmVk7CGagdBTkPiPhvi0/+HdPsnyLzfsqWlxnjOl1gGYDEx
        6GdSlO+O0zqCj9/7Io0++wLUKw0eThXoLxGh5Kz4NP8Z1buKEbZL22UUgnkTJB1I
        Jz9y7CByX94WIGns6NW5RNDNBuhHAZ7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BzKbLARq0BSnJcyeC
        RXnM9y5FOWw5F/q2SIlEbvvUnA=; b=j6XyjRhrAdRmn42tfpWzYZnxr/tR5NmNQ
        lAVeQ9GP+9I8FJUadv3FsosQl3pJ/MGaYw5GRb1tluNtJ/q3Vbmf9QJ4tTu+8/vL
        Ecu9nq0OKFO+G0OBbED0NlqmIGh7H8b3DjOVZ+auNFEyCIZc3cokMtSMdtON29YC
        c00JcIC3f9NF+L7Dep999cildR8hzlZTO/hxcI9wBdNtVVaFOghaBYpFAjZZuMKG
        JueZlGtY4rzXZeDr3HOod25MgrGNVBDdKW5bKW7co58ia0FudOcYhTlZIfVvR4Dc
        S5CQIypYApmYekGlWYKrDMdxPZ0iSH+sPI7i9hp9/4LjRMQ2JIiMw==
X-ME-Sender: <xms:Mcn6YW9q-PIv0RS62gSQaDq8tSetjHrSQhakN0S_3aYOnVspbbeowA>
    <xme:Mcn6YWsnr0sANF_NSL4Lwq0IabJkqzquKPJBsXfn-yGisp049nAKECNZqYjZLUyvA
    NdkUKG5fWLPgId6Ww>
X-ME-Received: <xmr:Mcn6YcBCAq9branccHxmeLHXAZ9ZqTaKoeuQlEPn_Yx32hLjReQ0DzSahQCLJE45GTXU9jrxf-4yxBe_HeCDLDDGKsqFzkB1M5rQi77R0s9ycQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Mcn6YedX0tmSjPm1uUHblnUFHJGFGKXCK79fg31Xx3K39UL0RYSwbQ>
    <xmx:Mcn6YbO7wFDha-MGKYMNJvSS_ijTMZBCcamUCn4-wrLJ6qKAwx2fsA>
    <xmx:Mcn6YYlZnU5Q5bKh2SIpHFlbF-9CzKUVttet6LJ6rRjkpENUYAi78w>
    <xmx:Msn6YZtSYqi4ZeRclehH33KfZK1uzk6NreNjwvlisoSl3avEIMB-TFfjpQ4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 13:10:49 -0500 (EST)
Date:   Wed, 2 Feb 2022 10:10:47 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, bas smit <bas@baslab.org>,
        =?utf-8?B?VG9tw6HFoQ==?= Glozar <tglozar@gmail.com>,
        Ast-x64 <Ast-x64@protonmail.com>,
        Viktor Malik <viktor.malik@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, jeyu@kernel.org,
        masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
Message-ID: <20220202181047.frwirxdpufwzkbv3@kashmir.localdomain>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
 <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
 <878rvk7uv2.fsf@esperi.org.uk>
 <Yfn145FyE3PDBEad@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfn145FyE3PDBEad@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, Nick,

On Tue, Feb 01, 2022 at 07:09:23PM -0800, Luis Chamberlain wrote:
[...]
> 
> I don't see much traction based on what you have said on dtrace
> on anything other than Oracle Linux stuff, it would be nice if bpftrace
> folks were excited about your changes and we had support for that
> there.

I took a quick look at the v7 cover letter (I'll take a look at
discussion from previous versions later if I get time) and it's not
immediately obvious to me why a stable mapping is beneficial.

Nick, could you elaborate why it's beneficial for dtrace to have a
stable mapping?

For what it's worth, bpftrace uses /proc/kallsyms rather rarely.
bpftrace relies on perf_event_open()'s config1 parameter to resolve
kernel symbol name to address for kprobe attachment. /proc/kallsyms is
mostly used to resolve kaddr() calls in bpftrace scripts.

Kernel symbol size information would be useful, though. bpftrace
currently uses the vmlinux ELF to acquire that information.

[...]

Thanks,
Daniel
