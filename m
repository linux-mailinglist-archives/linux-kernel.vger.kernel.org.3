Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053C524559
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350117AbiELGEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbiELGEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:04:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F358F21B16D;
        Wed, 11 May 2022 23:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652335480; x=1683871480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GUnQO9JdQMr0wO2xVWFn0ckakjuuaV315eTIAdrWDCE=;
  b=EnwHnJK+BA/AWVITuciBndPydLn1ivzWSRLKMAygW/88+3MXqRZw3zwD
   G/QEpn1TXvs0LSEjNAGrf/NQNrpG/RkVatyOqbB8OCpc+pogFfmscolKj
   fMYcZ+TEZMuw4bAx2BxJHBjvu8JIyXrOHOFC8ISpCNLAjDKHavC47mGd3
   rIFAl7O1uINUPZp+8i1AqpCQFLYUDECJBqWb/zHQlOzatmLiPN8J/lBNQ
   6jNlhdoPb9lh1Db/4U206/ckbNh7A9xmtj34SYYXSKQbqBcpVEdUwuFe3
   HVI0IzvKTZTnMmAyddaKyd8FJJpmVL2/ouw4sSn84gy8OS2xKhJN2TOKo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249796510"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249796510"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 23:04:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="739540188"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 23:04:35 -0700
Date:   Thu, 12 May 2022 14:03:44 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Sven Auhagen <Sven.Auhagen@voleatech.de>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf_flowtable]  2cd764935d:
 kernel-selftests.netfilter.nft_flowtable.sh.ipsec_tunnel_mode_for_ns1/ns2.fail
Message-ID: <20220512060344.GA31697@xsang-OptiPlex-9020>
References: <20220427071515.qfgqbs6uzoowwnkg@SvensMacbookPro.hq.voleatech.com>
 <20220510092803.GA3969@xsang-OptiPlex-9020>
 <Yno3VXOUEzAOSdDe@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yno3VXOUEzAOSdDe@salvia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pablo Neira Ayuso,

On Tue, May 10, 2022 at 11:58:45AM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Tue, May 10, 2022 at 05:28:03PM +0800, kernel test robot wrote:
> [...] 
> > # selftests: netfilter: nft_flowtable.sh
> > # PASS: netns routing/connectivity: ns1 can reach ns2
> > # FAIL: file mismatch for ns1 -> ns2
> > # -rw------- 1 root root 227328 May  8 22:05 /tmp/tmp.fnnwOCWcA4
> > # -rw------- 1 root root 99388 May  8 22:05 /tmp/tmp.LL8ohakyGQ
> > # FAIL: file mismatch for ns1 <- ns2
> > # -rw------- 1 root root 296960 May  8 22:05 /tmp/tmp.1DlwdJLSUX
> > # -rw------- 1 root root 15584 May  8 22:05 /tmp/tmp.HnObAriWng
> > # FAIL: flow offload for ns1/ns2:
> > # table inet filter {
> > # 	flowtable f1 {
> > # 		hook ingress priority 0
> > # 		devices = { veth0, veth1 }
> > # 	}
> > # 
> > # 	chain forward {
> > # 		type filter hook forward priority 0; policy drop;
> > # 		oif "veth1" tcp dport 12345 flow offload @f1 counter packets 0 bytes 0
> > # 		tcp dport 12345 meta length > 200 ct mark set 0x00000001 counter packets 14 bytes 103660
> > # 		tcp flags fin,rst ct mark set 0x00000000 accept
> > # 		meta length > 1500 accept comment "something-to-grep-for"
> > # 		tcp sport 12345 ct mark 0x00000001 counter packets 57 bytes 8220 log prefix "mark failure " drop
> > # 		ct state established,related accept
> > # 		meta length < 200 oif "veth1" tcp dport 12345 counter packets 1 bytes 60 accept
> > # 		meta l4proto icmp accept
> > # 		meta l4proto ipv6-icmp accept
> > # 	}
> > # }
> > # /dev/stdin:4:73-74: Error: syntax error, unexpected to, expecting newline or semicolon
> > #       meta iif "veth0" ip daddr 10.6.6.6 tcp dport 1666 counter dnat ip to 10.0.2.99:12345
> > #                                                                         ^^
> 
> What nftables userspace version is kbuild robot using?
> 
> It seems this rule fails to load, looks like a unrelated issue?

sorry for a false report. we realized that we need upgrade our toolchain.

