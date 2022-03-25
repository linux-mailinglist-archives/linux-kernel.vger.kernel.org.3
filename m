Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B378F4E6F26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354913AbiCYHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbiCYHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:48:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9ACCA0EF;
        Fri, 25 Mar 2022 00:46:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1B9BA1F745;
        Fri, 25 Mar 2022 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648194403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGMOuXB7AbKqx+2GTktrlM5bbqBSU6RPeiMitMpafNQ=;
        b=Mo16838jUIyFoR4/+g9qGoohV0hADpi19padXFDxSLQ6o6b3VGgGrjK7DOZ7aClDHqtkk8
        3Vei3tohr98FCIN2aEN8Z7Ys2ZTqpu/jj4R6hvTxoOms0hM2d9rrDcXkBwjrDpC/AUdi7C
        9us7MWsQw++dXlURxCRigjRLKqSrubI=
Received: from suse.cz (mhocko.udp.ovpn2.prg.suse.de [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E31ACA3B82;
        Fri, 25 Mar 2022 07:46:42 +0000 (UTC)
Date:   Fri, 25 Mar 2022 08:46:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, chenfeiyang@loongson.cn
Subject: Re: [kbuild-all] Re: undefined reference to `node_data'
Message-ID: <Yj1zYhEfnEiq6MEs@dhcp22.suse.cz>
References: <202203232042.AS9SV1zv-lkp@intel.com>
 <Yjs0ausRy6/mLUFD@dhcp22.suse.cz>
 <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
 <20220324090443.GA5375@alpha.franken.de>
 <YjxmrTKxRpTFeHnE@dhcp22.suse.cz>
 <06178ca0-66ad-c7fc-a79c-0ea1873408bd@intel.com>
 <a80b2c1f-cbb9-b320-3e97-0152109d261f@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80b2c1f-cbb9-b320-3e97-0152109d261f@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-03-22 11:40:37, Tiezhu Yang wrote:
> 
> 
> On 03/25/2022 09:16 AM, Chen, Rong A wrote:
> > 
> > 
> > On 3/24/2022 8:40 PM, Michal Hocko wrote:
> > > On Thu 24-03-22 10:04:43, Thomas Bogendoerfer wrote:
> > > > On Wed, Mar 23, 2022 at 05:46:59PM +0100, Michal Hocko wrote:
> > > > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > 
> > > > > > > All errors (new ones prefixed by >>):
> > > > > > > 
> > > > > > >     mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
> > > > > > > > > (.init.text+0x1680): undefined reference to `node_data'
> > > > > > >     mips64-linux-ld: (.init.text+0x1690): undefined reference to
> > > > > > > `node_data'
> > > > > > 
> > > > > > OK, I can see what is going here. The page allocator normally
> > > > > > uses NODE_DATA but arch_refresh_nodedata refers to node_data directly.
> > > > > > This is a problem with
> > > > > > arch/mips/include/asm/mach-loongson64/mmzone.h:
> > > > > > extern struct pglist_data *__node_data[];
> > > > > > 
> > > > > > #define NODE_DATA(n)            (__node_data[n])
> > > > > > 
> > > > > > Unfortunately we cannot use NODE_DATA there because of header
> > > > > > inclusion
> > > > > > ordering. I will think about a solution.
> > > > > 
> > > > > Is there any reason why (some?) MIPS arches use __node_data rather than
> > > > > node_data as most other architectures? Would it be acceptable to do the
> > > > > renaming? It would help to cover the above compilation problem because
> > > > > arch_refresh_nodedata could keep using node_data directly.
> > > > 
> > > > I've just checked history and I don't see a reason for __node_data.
> > > > So I'm fine with changing it to node_data.
> > > 
> > > Thanks a lot for double checking Thomas! This is a dump&simple sed over
> > > mips file. 0-day guys, could you give it a try please?
> > 
> > 
> > Hi Michal,
> > 
> > It returns another error:
> 
> Hi,
> 
> I think the following patch should fix the build error
> "undefined reference to `node_data'":
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=f8f9f21c7848

Thanks that looks much better than my renaming patch. Thanks a lot.
FWIW
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
