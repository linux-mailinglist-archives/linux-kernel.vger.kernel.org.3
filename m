Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFEA5398B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbiEaVZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348012AbiEaVZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:25:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF69E9E2;
        Tue, 31 May 2022 14:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C5C4CE1689;
        Tue, 31 May 2022 21:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DF7C385A9;
        Tue, 31 May 2022 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654032323;
        bh=JUWh9GAZfGjxtaad+vcDc6URL4qo6s3Tkd4XGZQtLcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W48BBuzdlXEGSJYM0LKQwJLXIXj6kIR9i6gKrQ+APabTcg600neSFlie9CgvS9WNj
         iIxuechCFZxFuxmBWtw0ZaR/ekQK4B++eLC7Y2FZoyG3n0+Lte06Wg8oRyk7gcXUUp
         RjfA3SlC6eLPtZggV//YNyHMvfldwO3PJuX6CYHHouurWTyvq+5+bFy6AxmxeboF6+
         mwV+gMVJ4ESZimo692LFs7bKe3mrT7vpgDMSw49FtnOgA2ju8BVamQlSIiimkOgueJ
         gLV+xuG1wRugZAOtMKM0z4C/pCNF0xSIJBn1uirjT+CBx098p9FQWDLRPX5ZBBgg0J
         deT2dIAkSaBbQ==
Date:   Tue, 31 May 2022 21:25:21 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Message-ID: <YpaHwds1zYRwua3+@gmail.com>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
 <YpZ71MU7+DRedq5S@gmail.com>
 <YpaATWTiipNERoVF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpaATWTiipNERoVF@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 01:53:33PM -0700, Jaegeuk Kim wrote:
> > Also, this patch does nothing by itself.  Which UFS host driver(s) need this
> > quirk bit?  Can you update them to use it?  Or do they all need this, in which
> > case a quirk bit would be unnecessary?
> 
> Likewise other quick bits, using this is up to SoC or UFS vendors. I
> think that combination is up to OEMs who is building the product.

Of the UFS host drivers in the upstream kernel, which ones actually need this?

- Eric
