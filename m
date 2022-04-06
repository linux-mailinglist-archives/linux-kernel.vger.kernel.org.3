Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE34F53FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450840AbiDFDfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445407AbiDFDTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:19:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C7AE6140;
        Tue,  5 Apr 2022 17:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F15B8B82015;
        Wed,  6 Apr 2022 00:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123CC385A0;
        Wed,  6 Apr 2022 00:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649203334;
        bh=8Y6GbWre1d9UcnkZekzlBiAAWHoA0YZbonR1DZwHe34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p2qruuopq3d7gKMFdyaQ9EWX9cr27cQZLAZ7xfYCMJDQFXa3U/+0W6bQdVM6DG6L3
         oqGsWWNgiWdTgYa8OXierOl4J6hopRh4DczDGAFoOMLxCFba6ruYKPfolAFBZ+ns3+
         5bIhu5S4inE0IxqOkpe0xx/eMTBAPJt+M3VlEIhxrrgRym8aMx+8f5kIv3zgwjyKkp
         S14PCjSHze7pQoiiGH1jecqJnBMMdsd10f0nF4EYfP+1RqOJeYy6CRjbSOqlffnvwG
         1nAcBmOI1j0RxxrcIC+PJ/Kb6hUxfIbd7L+TPzXyVuF6KqsHthMLU0n18jN3aiRy0P
         1pLrPnhR7Xu/Q==
Date:   Wed, 6 Apr 2022 02:02:10 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the v4l-dvb
 tree
Message-ID: <20220406020210.2c01889f@coco.lan>
In-Reply-To: <20220406083253.70adb56f@canb.auug.org.au>
References: <20220406083201.15e8e589@canb.auug.org.au>
        <20220406083253.70adb56f@canb.auug.org.au>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 6 Apr 2022 08:32:53 +1000
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> On Wed, 6 Apr 2022 08:32:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Commit
> > 
> >   535f49a9e1f9 ("media: platform: imx-mipi-csis: Add dependency on VIDEO_DEV")
> > 
> > is missing a Signed-off-by from its committer.  
> 
> Sorry that is in the v4l-dvb-next tree.
> 
Fixed, thanks!


Thanks,
Mauro
