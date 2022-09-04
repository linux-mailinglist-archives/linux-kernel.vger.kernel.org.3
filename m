Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9C5AC3FE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiIDKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiIDKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:46:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE03E767
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6392AB80B40
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 10:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B47C433D6;
        Sun,  4 Sep 2022 10:46:48 +0000 (UTC)
Date:   Sun, 4 Sep 2022 11:46:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        wangkefeng 00584194 <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/kmemleak: make create_object return void
Message-ID: <YxSCFTSHzO88IVd6@arm.com>
References: <20220901023007.3471887-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901023007.3471887-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:30:07AM +0800, Liu Shixin wrote:
> No user cares about the return value of create_object,
> so make it return void.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
