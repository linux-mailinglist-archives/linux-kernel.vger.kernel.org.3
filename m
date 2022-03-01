Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032804C91A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiCARg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCARg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:36:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36231211
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:36:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC06DB8184F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B303C340EE;
        Tue,  1 Mar 2022 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646156174;
        bh=J2f1Ap24Th6GXbnOt8CRImIJbN+kyKpKah1CLpzcdUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IHB8XLDFfvAmalWH7Uo+JM5XKBaqHIDxXAc5VtUDWi34KK+hspTzPDiKpAltzR5Qi
         cw9gUir2qSGOi0nKxvsMJ0dBhH9xC/zZSKtnvaVPWAgP+jY92Z3y7GCRekf3mOg1UX
         TQwYQ8YkKd8X0GLDgPBsNhsUUIF+rvsUhMfQZ5B8=
Date:   Tue, 1 Mar 2022 09:36:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] A few cleanup patches for z3fold
Message-Id: <20220301093613.0849d09db2061b0d53ccb66d@linux-foundation.org>
In-Reply-To: <e7162599-0313-f34c-c708-f8c22b5973de@huawei.com>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
        <e7162599-0313-f34c-c708-f8c22b5973de@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 21:03:37 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/2/19 17:25, Miaohe Lin wrote:
> > Hi,
> > This series contains a few patches to simplify the code, remove unneeded
> > return value, fix obsolete comment and so on. More details can be found
> > in the respective changelogs. Thanks!
> > 
> 
> Friendly ping in case this is forgotten. :)

I was expecting updates resulting from the [6/9] discussion?
