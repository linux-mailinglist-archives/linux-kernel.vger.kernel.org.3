Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F54D536F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245440AbiCJVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiCJVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:09:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365BC4D270;
        Thu, 10 Mar 2022 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FB6xomPY64jUpZu9dmUXFN9bddMNt8Vm5I5LWavAGS0=; b=TRzawf2mWrbNgqP14p+c3NbZie
        SW9NQ/H5gn+77T5ym3xwXXMorG3xmCG05eMrb9MZMEhbaN9Bqcql4XYxHmXvIyLCyMOSznmAyQGqx
        pz1RdiKi4MAd8ZC8jFUqMu/4WnyiahzXqbIV4xQ/+iVCycogdSoOIih9tCmGtiKF1em2eq/E4UZrk
        Llx9OAFcdsva2m6GxTJbZAsmZtob0R5yCtA3o1sZUi0HnPpyTnnrTCdI7w+3XttxQAU0n6zTjAqJv
        luZxTGnYksr5TP9xL6qPFh1oKU/H8w6AW9vHXiwD3d/0asZ9a1BgxBZ6eEGxxs9JWWCXctpjGxbr6
        KbdDXQgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSQ0r-00E2ut-Cy; Thu, 10 Mar 2022 21:07:57 +0000
Date:   Thu, 10 Mar 2022 13:07:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, christophe.leroy@csgroup.eu,
        hch@infradead.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <YiporeSIrkFg/YS8@bombadil.infradead.org>
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309120640.uumh46n2l37jaddf@maple.lan>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:06:40PM +0000, Daniel Thompson wrote:
> On Tue, Mar 08, 2022 at 10:52:03AM +0000, Aaron Tomlin wrote:
> > Hi Luis, Christoph, Daniel,
> > 
> > Is this patch ok or would you rather another iteration of the series?
> > Either way is fine for me. Thanks.
> 
> Another iteration makes more sense to me.

Iteration yes, but separating the patches no into another series no.

> The removal of kdb_modules is semantically part of your module clean
> up patch set and should certainly be included in it.
> 
> The removal of the spurious #include's in other kdb files is a
> good change but it is fully independent of the module rework. AFAICT
> those fixes are good with or without your changes. This suggests
> these changes can be separate from the main patch set.

Small fixes get piled in first on the series. But this is not a fix.
This effort will not be merged separately too. This won't go into the
next merge window either, because:

1) There is no rush
2) It is too late as all this needs proper testing and
   its too late to claim enough testing

So given this is all related to the move I see no reason to treat
this as a separate series. Your review of the v11 would be nice.

  Luis
