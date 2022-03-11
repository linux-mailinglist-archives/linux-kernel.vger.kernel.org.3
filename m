Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E364D5A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiCKEzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCKEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:55:30 -0500
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id C34D5E338A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:54:27 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1646974467; h=Content-Transfer-Encoding: MIME-Version:
 Content-Type: References: In-Reply-To: Date: Cc: To: To: From: From:
 Subject: Subject: Message-ID: Sender: Sender;
 bh=JOz+7bTl9V5VGYNsQB9j2Hw+GRpuYoU7noklRjo2KqY=; b=gnWqjcN6n9i+l4N/EDNYb+ghyBox3lMyx2d0e8c4/FEV2BCGLyCqtVqOMReSGxY5ma+SKFal
 Je3eFwvbC7wCQlreAih30ctivNQ1XdCSfIeUbBg+WAVOEgOx1kCnBgzRL4Wy/n9Qlu12YtCl
 ijw61hHpEcKNdGFOUlj7rmIcFdw=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 622ad602ea5f8dddb5c5d491 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 11 Mar 2022 04:54:26 GMT
Sender: michael@michaelkloos.com
Received: from qpc.home.michaelkloos.com (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 35D70400C2;
        Fri, 11 Mar 2022 04:54:25 +0000 (UTC)
Message-ID: <e880a9421239e388ebce74f3cd41637886930f03.camel@michaelkloos.com>
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
From:   "Michael T. Kloos" <michael@michaelkloos.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 23:54:24 -0500
In-Reply-To: <mhng-97bc7422-36da-436a-a326-1705ef6fcace@palmer-ri-x1c9>
References: <mhng-97bc7422-36da-436a-a326-1705ef6fcace@palmer-ri-x1c9>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well at least I can take some satisfaction in that it seems that on my
2nd patch sent to the Linux kernel, I got it right the first time.  No
one has complained about problems with the code itself, just that they
don't want the feature.  I have also received no errors back from the
build bot.

For now, I will try to maintain this port on my own.  Thank you for the
consideration Palmer.

	Michael

On Thu, 2022-03-10 at 20:29 -0800, Palmer Dabbelt wrote:
> On Thu, 10 Mar 2022 05:37:27 PST (-0800), Michael@MichaelKloos.com wrote:
> > Is there something I can do that would help alleviate your concerns or
> > apprehension?
> 
> IMO this is one of those cases where having hardware is required.
> 
> I can understand the goal of providing a Linux port for the minimal 
> RISC-V compatible system, but IIUC the minimal RISC-V compatible system 
> is any object associated with a member of the RISC-V foundation that 
> said member attests is a RISC-V system.  There's really no way to 
> implement Linux on all such systems so we have to set the bar somewhere, 
> and bar is generally set at "more time will be spent using this than 
> maintaining it".  Systems without M have generally not met that bar, and 
> I don't see anything changing now.
> 
> If you have users then I'm happy to reconsider, the goal here is to make 
> real systems work.  That said: we've already got enough trouble trying 
> to make actual shipping hardware function correctly, we're all going to 
> lose our minds trying to chase around everything that could in theory be 
> a RISC-V system but doesn't actually exist.
> 
> > 
> > On 3/10/2022 8:22 AM, Michael T. Kloos wrote:
> > 
> > > Some other thoughts:
> > > It sounds like I am not the first person to want this feature and I
> > > probably won't be the last.  I created the change for my own reasons, the
> > > same as any other contributor.  I think we all know that I can not pull
> > > out some chart and say, "This many people want this and here is why."  I
> > > live in central Ohio and have been doing this as a hobby.  I don't even
> > > know anyone else who knows about systems and operating system development.
> > > If the justification that you are looking for is that I as some
> > > hypothetical developer at a major tech company is about to release a new
> > > RISC-V chip without M support but we want it to run Linux, I can not
> > > provide that answer.  It sounds a bit like some software or hardware,
> > > chicken or the egg anyway.  Trying to maintain my own fork if people
> > > start contributing patches with incompatible assembly scares me.
> > >      Michael


