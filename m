Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5993D4941E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiASUhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:37:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58544 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiASUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:37:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A3F61752
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DDC004E1;
        Wed, 19 Jan 2022 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642624636;
        bh=kugWSgLYsdQSom1sAt9BLy4REvPou5WjFa0k0yBfsPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G3GqanxdANlgThXDN8laqLRXADLcTcbVaEgh7TbHQCzv4W6V7J/e+DjP4ZWxv6WEX
         atBiLvMg3xRPq5ikPkUJBWbUK9a+Xm7WGAmWc6XK51sI7lKh6gQbJNboOJcVgUVZfJ
         BQDONf39htX8Pg/KSf9O4j/rVh5aEQJeaMhFSJHmCYW4cSBPCTAXl18pvxewyRhTxD
         /Z3m5YVOAKWFhs7tjO2MFm6SYzXjhYqpo5oGfcvzK3WJ1bn1bgmmmeBbOcdt39w00B
         gPuMJ6yIOQIure2G19+lgjjsbw+ehyNdKjllpJgT5QZie4APKa9jj/AQVJT9xGBxRr
         irnLkQIc88eEw==
Date:   Wed, 19 Jan 2022 12:37:14 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <Yeh013gIveIKdFMP@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
        <YXe7AnMmiWXk36NC@zn.tnic>
        <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YehZsGAqgd3tJyDV@zn.tnic>
        <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh013gIveIKdFMP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 21:30:15 +0100 Borislav Petkov wrote:
> On Wed, Jan 19, 2022 at 11:15:23AM -0800, Jakub Kicinski wrote:
> > Indeed, still present with a fresh tree.  
> 
> Doesn't fire here with
> 
> $ gcc --version
> gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> 
> which compiler are you using?

gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3)
