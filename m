Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9DF4BAC16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbiBQVxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:53:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbiBQVxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:53:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB3A15C9CA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:53:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEB54B824BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AF5C340F3;
        Thu, 17 Feb 2022 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645134811;
        bh=z1sMk9JCTRfIMY3FyLTp3HX3VsLAGj6z3CRj6PZMp5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzBT/WvJGSiDIKsyGrzIRc2iQYb2yeMce0GMc1s4CZ4ISugy6Yom78K/SRq1EWbnL
         9evsaPegYABPJ293pj18Qxjz0fZ489OkRIRmX//cBQnHzUGvk1VCd3djXehOdubdLL
         S0xmNmqddSnu4U4UW1o12C71b2l7u35Kdn87pFGc6o2ewwrYuVHswmQir9PPk8o0B6
         DHCDlWQzC0J2SstWx+7kIKdnLlfRPt9Pk9mcc56EUNWGRQfWq3ZhCD5Sfkv4LN7/4y
         a4bVjqnS1bxycOVly3yB8RCfIJE5NQFg/ibDU4YSKnPI4+ljNQlCR/8EoYTGtwLLnY
         eCcL228INwU8g==
From:   Mike Rapoport <rppt@kernel.org>
To:     rppt@kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        akpm@linux-foundation.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] memblock: use kfree() to release kmalloced memblock regions
Date:   Thu, 17 Feb 2022 23:53:21 +0200
Message-Id: <164513475467.1546013.17869030868153318344.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217145327.16553-1-linmiaohe@huawei.com>
References: <20220217145327.16553-1-linmiaohe@huawei.com>
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

On Thu, 17 Feb 2022 22:53:27 +0800, Miaohe Lin wrote:
> memblock.{reserved,memory}.regions may be allocated using kmalloc() in
> memblock_double_array(). Use kfree() to release these kmalloced regions
> indicated by memblock_{reserved,memory}_in_slab.
> 
> 

Applied, thanks!

[1/1] memblock: use kfree() to release kmalloced memblock regions
      (no commit info)

Best regards,
-- 
Sincerely yours,
Mike.

