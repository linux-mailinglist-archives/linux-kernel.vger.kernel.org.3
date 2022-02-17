Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9C4BAC17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiBQVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:53:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiBQVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E9015C67C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F184CB824BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2588CC340E8;
        Thu, 17 Feb 2022 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645134808;
        bh=/cLw/qVooXw4C6F7KJdYAKpM6CUZS9G6nX+wxnSCh78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtIVKQrz4Dn6yBS5PAWdgdMBm/SnsJuyYc7y4hvW1s/hxrbMGfVflqNQzbEUExWPs
         6Y9jJRGNVDxJH55zZ1MR2Rxe8lL/KuTeI0SihqM6qphSv0xP+Kg0ska+LIjGnFtpWx
         W9urweKBU8uAYmoHA5N7lZgP30inY76Kb6FCwNoeHljV8MEsIUsdKO8zjYjqePTJDS
         ehS5EA8kuJYylWtFuV6F6/PrGhAidspjxX+8BIoC+DrztjElGswGQY+v+haTD3+nMV
         vbjkEvxhC/MYcapfj5uE8pvVBmI0guP5pLa2tzDRYMoMsccNe4mJtvsB6mMSOmHYH6
         e3ZD721WDZ9Kw==
From:   Mike Rapoport <rppt@kernel.org>
To:     rppt@kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        akpm@linux-foundation.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] memblock: remove unneeded local variable nid
Date:   Thu, 17 Feb 2022 23:53:20 +0200
Message-Id: <164513475467.1546013.10565618776838543491.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217140754.1026-1-linmiaohe@huawei.com>
References: <20220217140754.1026-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

On Thu, 17 Feb 2022 22:07:54 +0800, Miaohe Lin wrote:
> The nid is only used to act as output parameter of __next_mem_range.
> Since NULL can be passed to __next_mem_range as out_nid, we can thus
> remove nid by passing NULL here.
> 
> 

Applied, thanks!

[1/1] memblock: remove unneeded local variable nid
      (no commit info)

Best regards,
-- 
Sincerely yours,
Mike.

