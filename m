Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB8051AEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbiEDU1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377998AbiEDU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:27:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBA4F478
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93568CE29C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B4C385AE;
        Wed,  4 May 2022 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651695805;
        bh=2v3hr59CVHDM3qb6ZMYwH8aImudmMJoPBTeH9RCp5MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuQVo+Y7z7qMGE4gBxUfnDlOzRw8SXihUlMeAAQVgIyjAw/KgBEaHJLvjPdHdItwI
         poxhqRJeFLjZqROC1TZAtrR6qPfeTEJsoUBBxAnUB11HjQyFDjjiok/+JBOgVDHTSv
         HEUEfI9klXdFTdpnjj3KOoszdVr1UbS878QZcOQu8O/NJd7QWc5ojKcZ6b4vm15EXy
         BuwZ4uqsPo5iVpQVQQL61DPepCoyxay/253lFdYYJD/4XryjnGEYSR8C1x/sBahelk
         fedfWSHCoy7Z7vzyP6PuZyJ7AFebqbj93wsjF1TG1eRk/J/L67nEFZIjgtIrWf/Wvn
         wFPSJkmJswMTQ==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for mm-unstable 0/3] Fix build errors due to folio_test_large() misuse
Date:   Wed,  4 May 2022 20:23:23 +0000
Message-Id: <20220504202323.314656-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YnLdrqzkvzqMPD1U@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 21:10:22 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, May 04, 2022 at 08:07:55PM +0000, SeongJae Park wrote:
> > Several commits on 'mm-unstable' replaces 'PageTransHuge()' with
> > 'folio_test_large()' instead of 'folio_test_transhuge()'.  As a result,
> > several build errors occur when 'CONFIG_TRANSPARENT_HUGEPAGE' is unset.
> 
> I sent an entire replacement patch series mere minutes ago which I think
> fixes everything you mention here.  Please check?
> 
> https://lore.kernel.org/linux-mm/20220504182857.4013401-1-willy@infradead.org/T/#t

Thanks for the answer.  Yes, seems the fix has made there :)


Thanks,
SJ
