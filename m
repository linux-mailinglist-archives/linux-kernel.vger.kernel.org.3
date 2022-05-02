Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4F5171F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385615AbiEBOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350573AbiEBOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:51:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710999FF1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:48:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 230BA1F38D;
        Mon,  2 May 2022 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651502904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oL5aruEm90sJ5sm/xZJzQZSAFeKPbOQn51medaxSNpo=;
        b=jLf3/4fes+dwOivLP5p/l86M6kaXPwDp2i2MNn8Sl23k827rc+qMG/HvZ2J0TanwJKQquy
        3FxqbcG4sp8NhyVHEx4mfmFmj3/c6PA2wQ9FLbkE9C3MevtL0irK3yZ/H+cXFt8W7FssXZ
        8bUzI41UWDRmbpKMD0O6r258FfAkXis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651502904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oL5aruEm90sJ5sm/xZJzQZSAFeKPbOQn51medaxSNpo=;
        b=nShChD+jEIGqsiJVYp+DWku7SnaEfBlSBN2kuRJias7mjhC1bn3Apx4WRbrSz032DxCaFm
        Ysf1UOzHOZP5N5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171F3133E5;
        Mon,  2 May 2022 14:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UaedBTjvb2I9PQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 02 May 2022 14:48:24 +0000
Date:   Mon, 2 May 2022 16:48:22 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kernel test robot <lkp@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [tip:x86/sev 55/55] arch/x86/kernel/sev.c:605:17: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <Ym/vNnmW09TPxBEi@zn.tnic>
References: <202205022233.XgNDR7WR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202205022233.XgNDR7WR-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 10:19:04PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
> head:   c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
> commit: c2106a231c2ba36ff9af50cdf2867b9a5f8150a6 [55/55] x86/sev: Get the AP jump table address from secrets page
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205022233.XgNDR7WR-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip x86/sev
>         git checkout c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/x86/kernel/sev.c:605:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct snp_secrets_page_layout *[assigned] layout @@
>    arch/x86/kernel/sev.c:605:17: sparse:     expected void volatile [noderef] __iomem *addr
>    arch/x86/kernel/sev.c:605:17: sparse:     got struct snp_secrets_page_layout *[assigned] layout
> 
> vim +605 arch/x86/kernel/sev.c
> 
>    588	
>    589	static u64 __init get_snp_jump_table_addr(void)
>    590	{
>    591		struct snp_secrets_page_layout *layout;
>    592		u64 pa, addr;
>    593	
>    594		pa = get_secrets_page();
>    595		if (!pa)
>    596			return 0;
>    597	
>    598		layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
>    599		if (!layout) {
>    600			pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
>    601			return 0;
>    602		}
>    603	
>    604		addr = layout->os_area.ap_jump_table_pa;
>  > 605		iounmap(layout);
>    606	
>    607		return addr;
>    608	}
>    609	
> 
> -- 

Mike, that ok?

---
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 166375084b1f..c05f0124c410 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -589,20 +589,23 @@ static u64 __init get_secrets_page(void)
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page_layout *layout;
+	void __iomem *mem;
 	u64 pa, addr;
 
 	pa = get_secrets_page();
 	if (!pa)
 		return 0;
 
-	layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
-	if (!layout) {
+	mem = ioremap_encrypted(pa, PAGE_SIZE);
+	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
 	}
 
+	layout = (__force struct snp_secrets_page_layout *)mem;
+
 	addr = layout->os_area.ap_jump_table_pa;
-	iounmap(layout);
+	iounmap(mem);
 
 	return addr;
 }

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
