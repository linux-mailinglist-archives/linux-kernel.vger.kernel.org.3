Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5491255DE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiF0LOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiF0LOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747D64F2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A755E61422
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B60C3411D;
        Mon, 27 Jun 2022 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656328480;
        bh=CuTVlnDxPspUkWoxUuNJrsBCoLuz5p9INPa5En/Q7mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rur5ID9MNCtGNviB7b5Lz/hlnAM7+UXiShfWmuyQPtmADYoVbkm7AQiaWvlNyrkza
         pClXCM+0zyeg/IjMupTP1RCFJ8/t4F7o4iryjYGihE2NxDTEhDcC7jDqSsjjUdYa9Y
         n1i6UETQ1n8dA8v+GW8BR4XpPXEArSloVSvuiBuwdqVtjiGMpEZdAQQT3zQTxZHmva
         LEW78C7mgV2xANEJjeVxuhFGMDQWO2BtjXohLJ+7w8BFwa/WyLJvpQs1Y91SJ2Ccwr
         3Hv5K9KagUSwjg6gMt0mUWhSDJ6HyteKDGPRIGe6+9QPIRNUlQda0IEshq8v26aLQW
         /3jYrwn1/EqTA==
Date:   Mon, 27 Jun 2022 12:14:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de,
        anshuman.khandual@arm.com
Subject: Re: [PATCH v5 0/6] arm64: Cleanup ioremap() and support
 ioremap_prot()
Message-ID: <20220627111434.GH22095@willie-the-truck>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <9a6e61da-0a5c-02bb-d769-98cf1f602de8@huawei.com>
 <3f99f9a1-5598-1c0a-b552-186ec6ff01ca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f99f9a1-5598-1c0a-b552-186ec6ff01ca@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 07:06:41PM +0800, Kefeng Wang wrote:
> 
> On 2022/6/14 11:21, Kefeng Wang wrote:
> > Hi Catalin, could you help to pick up it, thanks.
> Kindly ping...

Sorry, this is on my plate for 5.20. I'll try to get to it today.

Will
