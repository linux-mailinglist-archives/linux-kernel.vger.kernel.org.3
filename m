Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E605AC9E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiIEFuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiIEFuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:50:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34813E83
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:50:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2ECB68AFE; Mon,  5 Sep 2022 07:49:58 +0200 (CEST)
Date:   Mon, 5 Sep 2022 07:49:58 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Sungup Moon <sungup.moon@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers/nvme/host: Fix namespace duplication check
 rule
Message-ID: <20220905054958.GA1069@lst.de>
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p4> <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:49:41AM +0900, Sungup Moon wrote:
> Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
> sub-system because of the bit size of ID.

Huh?  Fixed value of a EUI64 is brokem, so we must warn and ignore
those.  The whole point of the EUI64/NGUID/UUID is that they are
uniqueu per namespace.
