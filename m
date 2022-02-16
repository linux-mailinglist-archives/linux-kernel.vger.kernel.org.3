Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE964B8C63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiBPP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:27:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiBPP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:27:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE861A2767;
        Wed, 16 Feb 2022 07:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 949F3B81F1D;
        Wed, 16 Feb 2022 15:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329E5C004E1;
        Wed, 16 Feb 2022 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645025253;
        bh=VcAdSWqdU/WSmMty8G3/WlfT7f658+1Q8omlAuQMkC0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=m67A9rtEOpND/7uAPUgyMOibcmovBWl2dpobopl/r/naQM0fQv6fLAFqGrsBysszo
         eyNn7INS6bld5PsL/jmoiCqhQWYGdpcCiXpozx720F7YWx4P7BGUhakG+BCBH9Siul
         F8drJlLGC61BPH30w7vu8jnzgGI03TiKmfDQCpNhFO8FynO82Ze1NOGvq1O4stE+ol
         ubqcUTac4l9WD5D9mnKzFieinbyvdLdM6JT4MlJRR2Fawm7XeFr4Pqz9CFLeRg4rYf
         kk8VopIHvln52n1mDhnr+Y/PXN9/tOUKpfHRNc8r3u56n3et86kygCojjKOY2yti2L
         OOje6bm9Mp1bQ==
Date:   Wed, 16 Feb 2022 16:27:30 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push() (was Re:
 [PATCH] mac80211: fix RCU usage in ieee80211_tx_h_select_key())
In-Reply-To: <87r1849h0w.fsf@tynnyri.adurom.net>
Message-ID: <nycvar.YFH.7.76.2202161626550.11721@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm> <af6abf72593074c007fe42205e941dabfd08bf3a.camel@sipsolutions.net> <nycvar.YFH.7.76.2202151700540.11721@cbobk.fhfr.pm> <87r1849h0w.fsf@tynnyri.adurom.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Kalle Valo wrote:

> I think we have discussed this before, but patchwork can't handle
> patches the way you embed them in email discussions:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2202151700540.11721@cbobk.fhfr.pm/
> 
> Please resubmit.

Ok, I've resubmitted in a separate thread

	https://lore.kernel.org/r/nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm

Thanks,

-- 
Jiri Kosina
SUSE Labs

