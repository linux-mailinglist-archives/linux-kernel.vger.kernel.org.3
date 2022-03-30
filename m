Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410EC4EC430
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbiC3MgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiC3MgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:36:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D68BF52
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:21:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAAA91F38C;
        Wed, 30 Mar 2022 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648642899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnC+6t70ASJsW6BfBNRk9Tew7XA4UG7UNazYiXq6HEs=;
        b=JD+is4KLCevy3JP9VbbzRPe3WsbPmyFSDJic8sTW8B+S+nq0AonR8tdxP/ihP2YmZP4ZTE
        +i34WBATlBI+uB/M6f+NB04aUGsnkyIE8mWMxV4lxt+95sMseIADPQEf8yvQ0jiXC9+1y1
        yziF96FjkOyUWhacvYZoL07R/4/dczY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648642899;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnC+6t70ASJsW6BfBNRk9Tew7XA4UG7UNazYiXq6HEs=;
        b=KDzX7K26VgdC0M/88e0OlkPhX2eqqwxoiFz/yFIv2KSzjrbG5FX9TCofuOQvym4hne8VIz
        fM0JQtOhR/ErH8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F04B13A60;
        Wed, 30 Mar 2022 12:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HYnDJlNLRGKCNAAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 30 Mar 2022 12:21:39 +0000
Date:   Wed, 30 Mar 2022 14:21:38 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Shirish S <Shirish.S@amd.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/x86/kernel/cpu/mce/amd.c:552:6: warning: no previous
 prototype for 'disable_err_thresholding'
Message-ID: <YkRLUixkF7OEICBL@zn.tnic>
References: <202203301632.RmI9R5aU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202203301632.RmI9R5aU-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:45:25PM +0800, kernel test robot wrote:
> Hi Shirish,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   965181d7ef7e1a863477536dc328c23a7ebc8a1d
> commit: 30aa3d26edb0f3d7992757287eec0ca588a5c259 x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk
> date:   3 years, 2 months ago
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220330/202203301632.RmI9R5aU-lkp@intel.com/config)
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30aa3d26edb0f3d7992757287eec0ca588a5c259
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 30aa3d26edb0f3d7992757287eec0ca588a5c259
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mce/ drivers/gpu/drm/i915/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/cpu/mce/amd.c:552:6: warning: no previous prototype for 'disable_err_thresholding' [-Wmissing-prototypes]
>      552 | void disable_err_thresholding(struct cpuinfo_x86 *c)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~

I can't trigger this with gcc-9 (Debian 9.3.0-22) 9.3.0 on that commit
with your .config.

Please drop this.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
