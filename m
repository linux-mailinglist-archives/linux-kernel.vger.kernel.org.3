Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB3479A77
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhLRLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:01:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52326 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhLRLBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:01:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F3F51F395;
        Sat, 18 Dec 2021 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639825304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvqLio9Zgx6ozWSwy5A/gRNCGArwCbDJTMnmUeZkkWI=;
        b=t0rT+r5vQk6NeshX5fIYsZCGandlbEJxcqDZwbDWLAFqiliu9R7Pe+q5NmVAuvdI3lk9uj
        BGDGxzLcbgdOPDPM80mW1OA6EkAB/wIFjL2L34b9nnzlDPbspaYebqB1wypw7ZxDIX9X48
        c685Xh9BWD6zqFrfwfqNDJKdas0AiFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639825304;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvqLio9Zgx6ozWSwy5A/gRNCGArwCbDJTMnmUeZkkWI=;
        b=0BGkigjqY+HpviFdV6dtrarxXtmIzh12al2RhAgdG0DWdAWhHcw9wzGGdz3t7kQG2nI//6
        u7WnQBGZehREHPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37F09139F0;
        Sat, 18 Dec 2021 11:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id anKYDJi/vWFCHwAAMHmgww
        (envelope-from <bp@suse.de>); Sat, 18 Dec 2021 11:01:44 +0000
Date:   Sat, 18 Dec 2021 12:01:50 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Carel Si <beibei.si@intel.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, bfields@fieldses.org,
        llvm@lists.linux.dev
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Message-ID: <Yb2/nqfzu3VYo+bG@zn.tnic>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
 <b11156b7-e912-5b65-3b2f-4fd940727bc9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b11156b7-e912-5b65-3b2f-4fd940727bc9@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 06:39:46PM +0800, Yin Fengwei wrote:
> Thanks a lot for sharing this. Lessons learnt here. Will follow this
> rule exactly in the future.

Thanks. And for the future, please trim your reply like I just did. :)

> I tried this fix and it works fine in my local env. Will test it also
> in our test box once we back to office. Thanks.

Good, much appreciated.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
