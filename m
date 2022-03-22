Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65C4E3DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiCVLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiCVLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:46:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435D4AE0B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E14FB81CA0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81416C340EC;
        Tue, 22 Mar 2022 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647949494;
        bh=+0r1IVgjA7xYvFqjlSYTelChQdleZQ8HY0Q371h6m30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l636owiMehGIYeJFaMCfXrg85FNoqpBa/g0RSK6r+d2Mabjk//tXU7W8a/Eff0Idh
         kPYPUn71elMTbZqd94mUrKwu2p+58sPJyIgB92RA1z3JcUPMHJftGXuJo1DyxZ2Bk/
         up3ri++dNnq8S2dJ8+GUdSB1RBFDF2n4MMMoudLhdrpAcVyKVeRIqtv+E6782d0ZpS
         wKECVxh1XNcuShw2TJU9K4T2I/i2plkeFsi+dxlDKcrXjITE0pTyK3gjlLhZjvOHQu
         gyOdbT9SIcbQj2xsPTUaf9WaWTbKWPXs0QJPvp7lzZOrF2+r+Yu99Qx1JpoyI0I0es
         JwkMCab/Bj57A==
Date:   Tue, 22 Mar 2022 20:44:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [bpf-next:master 209/265] kernel/trace/fprobe.c:201:14: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-Id: <20220322204450.a09369b16d3e585be31dc394@kernel.org>
In-Reply-To: <202203221549.JQIr40CT-lkp@intel.com>
References: <202203221549.JQIr40CT-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 15:22:30 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> head:   f97b8b9bd630fb76c0e9e11cbf390e3d64a144d7
> commit: 5b0ab78998e32564a011b14c4c7f9c81e2d42b9d [209/265] fprobe: Add exit_handler support
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220322/202203221549.JQIr40CT-lkp@intel.com/config)
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=5b0ab78998e32564a011b14c4c7f9c81e2d42b9d
>         git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>         git fetch --no-tags bpf-next master
>         git checkout 5b0ab78998e32564a011b14c4c7f9c81e2d42b9d
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/ samples/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> kernel/trace/rethook.c:68:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> kernel/trace/rethook.c:68:9: sparse:    void ( [noderef] __rcu * )( ... )
> >> kernel/trace/rethook.c:68:9: sparse:    void ( * )( ... )
> --
> >> kernel/trace/fprobe.c:201:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
>    kernel/trace/fprobe.c:201:14: sparse:     expected struct ftrace_hash *hash
>    kernel/trace/fprobe.c:201:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
> 
> vim +201 kernel/trace/fprobe.c
> 
>    158	
>    159	/**
>    160	 * register_fprobe() - Register fprobe to ftrace by pattern.
>    161	 * @fp: A fprobe data structure to be registered.
>    162	 * @filter: A wildcard pattern of probed symbols.
>    163	 * @notfilter: A wildcard pattern of NOT probed symbols.
>    164	 *
>    165	 * Register @fp to ftrace for enabling the probe on the symbols matched to @filter.
>    166	 * If @notfilter is not NULL, the symbols matched the @notfilter are not probed.
>    167	 *
>    168	 * Return 0 if @fp is registered successfully, -errno if not.
>    169	 */
>    170	int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
>    171	{
>    172		struct ftrace_hash *hash;
>    173		unsigned char *str;
>    174		int ret, len;
>    175	
>    176		if (!fp || !filter)
>    177			return -EINVAL;
>    178	
>    179		fprobe_init(fp);
>    180	
>    181		len = strlen(filter);
>    182		str = kstrdup(filter, GFP_KERNEL);
>    183		ret = ftrace_set_filter(&fp->ops, str, len, 0);
>    184		kfree(str);
>    185		if (ret)
>    186			return ret;
>    187	
>    188		if (notfilter) {
>    189			len = strlen(notfilter);
>    190			str = kstrdup(notfilter, GFP_KERNEL);
>    191			ret = ftrace_set_notrace(&fp->ops, str, len, 0);
>    192			kfree(str);
>    193			if (ret)
>    194				goto out;
>    195		}
>    196	
>    197		/* TODO:
>    198		 * correctly calculate the total number of filtered symbols
>    199		 * from both filter and notfilter.
>    200		 */
>  > 201		hash = fp->ops.local_hash.filter_hash;

Hm, I need to use rcu_access_pointer() to access the filter_hash field,
because it is a __rcu pointer.

Thank you,

>    202		if (WARN_ON_ONCE(!hash))
>    203			goto out;
>    204	
>    205		ret = fprobe_init_rethook(fp, (int)hash->count);
>    206		if (!ret)
>    207			ret = register_ftrace_function(&fp->ops);
>    208	
>    209	out:
>    210		if (ret)
>    211			fprobe_fail_cleanup(fp);
>    212		return ret;
>    213	}
>    214	EXPORT_SYMBOL_GPL(register_fprobe);
>    215	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


-- 
Masami Hiramatsu <mhiramat@kernel.org>
