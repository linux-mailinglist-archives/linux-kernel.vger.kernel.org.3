Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D254755C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhLOKFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:05:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhLOKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:05:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98A6D212C5;
        Wed, 15 Dec 2021 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639562729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQMLSOp0G9E6/rkpLGVQXGq8LBFPex95kzeQ23SmVL4=;
        b=i0HFqIDYSmkfbOviptnagOeoEtYkzSqvphWXv9HHao8o7EGninevZWu21dTy0wFJOsccpn
        go0ZSGJWUlz8t3pwswe/M4GxAfdqx2JR9ZZdJoNMUvKSW5W8hRtkgW1ENumSjBn+6P7Z89
        rmJdgtExXsiWOf9RR3yPX/JNRnczazU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639562729;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQMLSOp0G9E6/rkpLGVQXGq8LBFPex95kzeQ23SmVL4=;
        b=wCUKK7/fTPY/JNE6VKMFsFb7RHi/GrG/ukccII8Z25hr5UMypY1N0W/yERQ6p4vSl4lkgx
        o4BZ7guzYY2p7CCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82D6413B09;
        Wed, 15 Dec 2021 10:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FrqbHum9uWFRZQAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 15 Dec 2021 10:05:29 +0000
Date:   Wed, 15 Dec 2021 11:05:30 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Carel Si <beibei.si@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [x86/mm/64]  f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <Ybm96seTxl+pWjTX@zn.tnic>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215070012.GA26582@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:00:13PM +0800, Carel Si wrote:
> We have verified by hand, still can reproduce this issue.

Ok, please give details how exactly you reproduce: host, guest, kernel
versions, configs, machine types, i.e., /proc/cpuinfo, dmesg, etc. I'd
like to see if I can find a similar machine here.

Also, would it be possible to upload your vmlinuz somewhere so that I
can download it for testing?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
