Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE657867B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiGRPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGRPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:35:52 -0400
Received: from smtpq1.tb.ukmail.iss.as9143.net (smtpq1.tb.ukmail.iss.as9143.net [212.54.57.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE3BC81
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:35:51 -0700 (PDT)
Received: from [212.54.57.107] (helo=csmtp3.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1oDSmj-0007FO-Vz
        for linux-kernel@vger.kernel.org; Mon, 18 Jul 2022 17:35:49 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id DSmjoNpuq45FHDSmjowI7e; Mon, 18 Jul 2022 17:35:49 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=e64V9Il/ c=1 sm=1 tr=0 ts=62d57dd5 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=RgO8CyIxsXoA:10 a=zd2uoN0lAAAA:8 a=4XStSidSkjLePoVboTUA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1658158549;
        bh=Re0gKM4VfIQOJwjWn6tHsiDwKiJQYs0aWH6W1FD15PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gcUpeJiR7N7eC8j6pJQaBd31PNU0EQS7cLYBAfF16suSjFgTAqHLoYG0TPKgHheWB
         Yubl2gfz92RZE3p0pN5U4APu/1TstiSCNwKAd7RHAFkKql5Wc5Ty+NBTwIRHPifLLR
         ET2R/D7pkXndW+kO1PC9PryoUgjqPudEfTkQHc7wTO4zdTRP0KtJVqIIgIU3Bs7tFl
         8w5uzzaA9FGp0MB93dpDS5fFN59cdiqEhRdlNNyvN3SmJRMikVkIyDNOWzZFGbN5Sj
         8/TRA5LXGNKFzfLdeqhDULBVWVfYxkRgBRaTh/CJoppaeQcMW2mjl/36h04cCJx/HB
         jsSt5HirvpIVQ==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 998748DB5C; Mon, 18 Jul 2022 16:35:49 +0100 (BST)
Date:   Mon, 18 Jul 2022 16:35:49 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Retbleed, Zen2 and STIBP
Message-ID: <YtV91cuj/YAZ2k95@llamedos.localdomain>
References: <YtUXda9ymAI0ED7n@llamedos.localdomain>
 <YtV1KT5l8KpoJWGT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtV1KT5l8KpoJWGT@localhost.localdomain>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-CMAE-Envelope: MS4xfMaG3l5YKsL1CAFyJJJs1Hja/9V8vSK6bQRG+j5COPqiH+Z1hj6Rz+1iIZD4+f85hDCK3kg+m3oDs+up2CTPzx4/l8KS821tjnve4MB90cWwSdlbm5R8
 o76oTUqjZIRlD5yakyU0Lka4gHiuPJ4SlPKY+GTOy8KQSlZpRQhONmYLq5cRWyFwC2nPL6CJFPpUSqeUUkJeDkwU6pdiEMrQD/jYDdFJGHuBLe3E4QKDrAiA
 bdFpsXOaoer4Z2wxYaOeuQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 04:58:49PM +0200, Alexandre Chartre wrote:
> On Mon, Jul 18, 2022 at 09:19:01AM +0100, Ken Moffat wrote:
> > Probably like most people, I find the detail of the available
> > retbleed mitigations obscure.  In particular, for zen2 the options
> > *might* include ibpb or unret.
> > 
> > But I have failed to find what 'unret' actually means.  Any
> > pointers, please ?
> > 
> > While ibpb might be available (and slow), on my Renoir with
> > microcode level (0860106h) there were no newer microcode versions
> > available when I last looked (a few weeks ago) but note 7 at the
> > bottom of
> > https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v
> > 7_20220712.pdf
> > implies that the relevant bit is only set on Renoir in 0860109h and
> > later.
> > 
> > Some of the text in that pdf implies that at least one of the
> > options could be set if not already set from the microcode, but the
> > amount of detail leaves me totally lost.
> > 
> > Assuming, for the moment, that I might want to try this full
> > mitigation, is there any way to set this in the absence of newer
> > microcode ?
> > 
> > Or should I just accept that the best I can get is 'unret', whatever
> > that means ?
> > 
> > ĸen
> 
> 'unret' = AMD JMP2RET i.e. replace all 'ret' instructions with
> 'jmp __x86_return_thunk', and safe training the thunk code upon
> kernel/hypervisor entry. This is a purely software mitigation,
> it doesn't require any microcode.
> 
> AMD JMP2RET is described in this document:
> https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v7_20220712.pdf
> 
> alex.

Thanks!

ĸen
-- 
 It is very easy to get ridiculously confused about the tenses of
 time travel, but most things can be resolved by a sufficiently
 large ego.        -- The Last Continent
