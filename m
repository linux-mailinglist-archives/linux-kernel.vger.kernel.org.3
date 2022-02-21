Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C764BD7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiBUIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:15:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiBUIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:15:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4CE19C26;
        Mon, 21 Feb 2022 00:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363D160FFE;
        Mon, 21 Feb 2022 08:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD281C340E9;
        Mon, 21 Feb 2022 08:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645431289;
        bh=boZhPSB1xtCOEB/B6XCck3Jo6oe1RHC8RkPDFQS7pFQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TSlz0KJCs+LdQvPlsuuDJ4YEHMrf4VEt2dUmxXP3tHPmn3kll7WaZMDG25dVRELm5
         7O9iSoLgTrjO5xM51JRzJIR/wYhGu4icHJhGFqHWW0mokW10ltghbaktaNYgtNW/HX
         UGY1N1qihUl9Zx6oxBHMU9GoaVrthtDF9swg1i1birLclgS95v9qUD2Yuzc8L9ex+I
         O+DnvkVHYjxZGucVY+Qer3y3fvMEs3iSBoOqT+Q1PjLQcjapGPNhHa4yCEiJyMsXvo
         qco+CoVpRu9PdaeH+EdYo5sSiv3Aa2+Ma55R5MPYkBWz9XPpxpGHMdZDvFT0QuBdma
         kYpxwtaj+6Y6w==
Date:   Mon, 21 Feb 2022 09:14:45 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
cc:     syzbot <syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com>,
        alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in thrustmaster_probe
In-Reply-To: <43992c7a-c8e7-29a6-d0f0-f69abccd62a1@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202210914220.11721@cbobk.fhfr.pm>
References: <000000000000d181a205d874c066@google.com> <cd08c05f-f648-071f-d8f5-0a022cd35b7b@gmail.com> <nycvar.YFH.7.76.2202210900420.11721@cbobk.fhfr.pm> <43992c7a-c8e7-29a6-d0f0-f69abccd62a1@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022, Pavel Skripkin wrote:

> >> Looks like missing check for malicious device. Need to check number of
> >> endpoints before accessing endpoints array
> >> 
> >> 
> >> #syz test
> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > Thanks Pavel. Could you please send the patch with proper changelog and
> > SOB my way?
> > 
> 
> I've already posted the patch :) You can find it here [1] (you are in CC of
> course)
> 
> 
> [1] https://lore.kernel.org/all/20220220160114.26882-1-paskripkin@gmail.com/

Hmm, for some reason I don't see it in my inbox, but I'll grab it from the 
ML and apply.

Thanks,

-- 
Jiri Kosina
SUSE Labs

