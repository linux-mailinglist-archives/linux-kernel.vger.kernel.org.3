Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2F4941B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357324AbiASUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:30:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357292AbiASUaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:30:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0913212C8;
        Wed, 19 Jan 2022 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642624217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywc5UoO8NX8S8S/pJ5HLwzS/reCPa/8WSHOl8HoEIuw=;
        b=qNMU9Cfh57FovLAExsfNucwAloEwR1A/1NupR3Uqklkby2DWQp+dKVIRXMcoDL1cIQy7W2
        p2vrsWaHALXxMg10WGQrlVxe8SNla0b9UM5mKsQEggZANwbz+DtHGKy6YlwvqlLE4pFDm2
        gyb22mEAdHvG1g85W+8IOwDEKuqj6tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642624217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywc5UoO8NX8S8S/pJ5HLwzS/reCPa/8WSHOl8HoEIuw=;
        b=3unkpyQP+QPwoXkwJP0IFPSCURmsZ6WzIMe4Yz4uG8UHSCxglNu5sn3xNguKufIoV9MZyx
        kd3pmcLERCr/edCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9AE913B9A;
        Wed, 19 Jan 2022 20:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 06CJM9l06GFoCwAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 19 Jan 2022 20:30:17 +0000
Date:   Wed, 19 Jan 2022 21:30:15 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <Yeh013gIveIKdFMP@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
 <YXe7AnMmiWXk36NC@zn.tnic>
 <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YehZsGAqgd3tJyDV@zn.tnic>
 <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:15:23AM -0800, Jakub Kicinski wrote:
> Indeed, still present with a fresh tree.

Doesn't fire here with

$ gcc --version
gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]

which compiler are you using?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
