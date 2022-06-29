Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7673F55F3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiF2DMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiF2DMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2A2BB3A;
        Tue, 28 Jun 2022 20:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A74DDB8215B;
        Wed, 29 Jun 2022 03:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051A4C341C8;
        Wed, 29 Jun 2022 03:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656472359;
        bh=1P+6d07Qx1cBRIKwEDFs1zrtCoocCzlp05XUFi0KdN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rqlyq7g5tdJ/wYOf5A7tYj4RUmI1SFFFt5YqSgIqMD6iCvdEffAoDwZgyDi3Lo46E
         nzPMTdCNNady34vD5iuKukBu9czAuG8iNK1tCUTnH+PYSripo9v81eqcXjZleJH92/
         WcFN7ElTBpI56SzmBLG6gWFM3msjihVBJW947Y81lREqncC9yQFyfW+OGBCA+/2a0I
         ZToeREUhnkPO1WGzj8UDSR7nhEOmdJevu49dLbbdkTsBGzmUrQaO8P3a5mU2nOLO7a
         bG3AvowfGdwEZSD4K/S+qJbQ98SrosdI2zNBGtsha62ktGOYH7ndpMC1Vt51oV55+k
         FtOHEJXL9GSYg==
Date:   Tue, 28 Jun 2022 20:12:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel-team@cloudflare.com,
        abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: Re: [linux-next] [[5.19.0-rc4-next-20220627] WARNING during reboot
 to linux-next kernel
Message-ID: <YrvDEqdk3ZfcEy9i@sol.localdomain>
References: <3c38b723-40e6-ded9-5a3b-7b442a3f65d8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c38b723-40e6-ded9-5a3b-7b442a3f65d8@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:33:55PM +0530, Tasmiya Nalatwad wrote:
> Greetings,
> 
> [linux-next] [[5.19.0-rc4-next-20220627] WARNING during reboot to linux-next
> kernel
> 
> --- Call Traces ---
> [    1.788574] ------------[ cut here ]------------
> [    1.788577] alg: self-tests for rsa-generic (rsa) failed (rc=-22)
> [    1.788586] WARNING: CPU: 9 PID: 218 at crypto/testmgr.c:5774
> alg_test+0x438/0x880
> [    1.788598] Modules linked in:
> [    1.788603] CPU: 9 PID: 218 Comm: cryptomgr_test Not tainted
> 5.19.0-rc4-next-20220627-autotest #1
> [    1.788609] NIP:  c00000000062e078 LR: c00000000062e074 CTR:
> c00000000075e020
> [    1.788614] REGS: c00000000e733980 TRAP: 0700   Not tainted
> (5.19.0-rc4-next-20220627-autotest)
> [    1.788620] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28008822
> XER: 20040005
> [    1.788632] CFAR: c00000000014f244 IRQMASK: 0
> [    1.788632] GPR00: c00000000062e074 c00000000e733c20 c000000002a12000
> 0000000000000035
> [    1.788632] GPR04: 00000000ffff7fff c00000000e7339e0 c00000000e7339d8
> 0000000000000000
> [    1.788632] GPR08: c000000002826b78 0000000000000000 c000000002566a50
> c0000000028e6bb8
> [    1.788632] GPR12: 0000000000008000 c00000000fff3280 c00000000018b6d8
> c00000000d640080
> [    1.788632] GPR16: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [    1.788632] GPR20: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [    1.788632] GPR24: c000000000da49e8 0000000000000000 c000000050630480
> 0000000000000400
> [    1.788632] GPR28: c000000050630400 000000000000000d c000000002cd33d8
> ffffffffffffffea
> [    1.788691] NIP [c00000000062e078] alg_test+0x438/0x880
> [    1.788696] LR [c00000000062e074] alg_test+0x434/0x880
> [    1.788701] Call Trace:
> [    1.788704] [c00000000e733c20] [c00000000062e074] alg_test+0x434/0x880
> (unreliable)
> [    1.788712] [c00000000e733d90] [c00000000062c040]
> cryptomgr_test+0x40/0x70
> [    1.788718] [c00000000e733dc0] [c00000000018b7f4] kthread+0x124/0x130
> [    1.788726] [c00000000e733e10] [c00000000000ce54]
> ret_from_kernel_thread+0x5c/0x64
> [    1.788733] Instruction dump:
> [    1.788736] 409e02e4 3d22002c 892913fd 2f890000 409e02d4 3c62fe63
> 7f45d378 7f84e378
> [    1.788746] 7fe6fb78 3863fa90 4bb2116d 60000000 <0fe00000> fa2100f8
> fa410100 fa610108
> [    1.788757] ---[ end trace 0000000000000000 ]---
> -- 

It's caused by:

commit f145d411a67efacc0731fc3f9c7b2d89fb62523a
Author: Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri Jun 17 09:42:10 2022 +0100

    crypto: rsa - implement Chinese Remainder Theorem for faster private key operations
