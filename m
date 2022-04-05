Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6834F445B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389921AbiDEP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbiDEJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:42 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29622DFD4A;
        Tue,  5 Apr 2022 02:32:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0V9GYmUY_1649151171;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V9GYmUY_1649151171)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Apr 2022 17:32:53 +0800
Date:   Tue, 5 Apr 2022 17:32:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-doc@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-iio@vger.kernel.org, Huang Jianan <huangjianan@oppo.com>,
        Chao Yu <chao@kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: unexpected indentation warning in
 Documentation/ABI/testing/sysfs-*
Message-ID: <YkwMwqWDPokAxfY0@B-P7TQMD6M-0146.local>
References: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
 <4df1fc93-2a2a-3482-085f-3a88970440ff@redhat.com>
 <1b01580f-f888-5725-e571-816073148303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b01580f-f888-5725-e571-816073148303@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 05, 2022 at 02:52:18PM +0700, Bagas Sanjaya wrote:
> On 04/04/22 19.54, Hans de Goede wrote:
> > 
> > These 2 are fixed by this (pending) patch:
> > https://lore.kernel.org/linux-kernel/20220324165918.22005-4-hdegoede@redhat.com/
> > 
> > And I also have this pending patch for a pre-existing warning:
> > https://lore.kernel.org/linux-kernel/20220324165918.22005-3-hdegoede@redhat.com/
> > 
> > I'm not sure who should pick these 2 up ?
> > 
> 
> I think linux-doc can pick them, if no subsystems do it.
> 

btw, I can pick the erofs one up though, but since it's a doc-specific
series, I think it can go with linux-doc too.

Thanks,
Gao Xiang

> -- 
> An old man doll... just what I always wanted! - Clara
