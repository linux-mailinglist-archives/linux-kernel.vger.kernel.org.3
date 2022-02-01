Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210414A61C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiBAQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBAQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:58:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFCC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DogyCkgr+GOg36Ln7NJEnUDmh+Ueuorh9WLAPxcwaUI=; b=S+MZ/cYDFEJ1tBVanSH8Y9DZy5
        MlYqs88ax5FRo/YB8sa3sCFWzLf8HxkPV/xQmCJOz5KZPHzk8W0T6TlwEax/Zc9tRmPps7QzZU/I5
        8tOtJIoNhEtIS4jt22VrH/sfzLnjj0lQGsqQjGsurdDWmDQSi8VLeQ5p2dwc7myA4OXP3Towrs+qh
        skAzsmewiQBrxloa1v+5/3R4GnUNdpYmna9tIQnqt9OnTRHoR8bv+/4SXcaJ0xVhh5gWGhwLTUbVF
        etq+69IuS2YBivu9a5KtlePiv8cyNd9aDmRsheCiPb9xJ3cWrPNSnbEr5E85RWtcYEPZAunJq9icI
        vnnIoUaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEwUS-00Cgin-IK; Tue, 01 Feb 2022 16:58:48 +0000
Date:   Tue, 1 Feb 2022 16:58:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sean Young <sean@mess.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests/ir: fix build with ancient kernel headers
Message-ID: <YflmyHrYg1xJlW0u@casper.infradead.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
 <YfQqI2ryOYEDuvON@gofer.mess.org>
 <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
 <YflldzHZPVK3OQRJ@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YflldzHZPVK3OQRJ@gofer.mess.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 04:53:11PM +0000, Sean Young wrote:
> +/* Support ancient lirc.h which does not have these values */

Can we have a little more information here, such as "Can be removed once
RHEL 8 is no longer a relevant testing platform"?  That will save people
doing archaology to find out when it's safe to remove.

