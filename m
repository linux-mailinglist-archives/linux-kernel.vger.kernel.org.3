Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB94D584D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiG2IK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiG2IKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940711A04;
        Fri, 29 Jul 2022 01:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7C361C9A;
        Fri, 29 Jul 2022 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D448C433C1;
        Fri, 29 Jul 2022 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659082220;
        bh=BvKlDnh9cU0HZ+oSmGTqHqFzpwVEA0UVMnTKLAsW1t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsKYdOICG+u2L1NeckIDTea4vZR/7c4ENTer6g0wHVHVt/tnxkZwyNhHCAWDDD1Le
         qQ8GfZZiaiIeSxYGwaJfWqQz2BHFrOuVk5+8zAknV9s5mz7Vy7+ZXIWO76lrNUGMfU
         jFQKhw/GO+kCHUZ2Hle2jPVSK7/+XbZKaJWWiPUo=
Date:   Fri, 29 Jul 2022 10:10:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ufs: add function to check CRYPTO capability
Message-ID: <YuOV6l/7KoVO4yZp@kroah.com>
References: <20220729020508.4147751-1-dlunev@chromium.org>
 <20220729120216.v3.1.I6b7934b96fff0d5ea22531e57c0a11f0ccd1acd8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729120216.v3.1.I6b7934b96fff0d5ea22531e57c0a11f0ccd1acd8@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:05:07PM +1000, Daniil Lunev wrote:
> To align with other capability check functions.

This is not a valid changelog text, sorry.  Please read the
documentation for how to write a valid one.

> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> 
>  drivers/ufs/core/ufshcd-crypto.c | 8 ++++----
>  drivers/ufs/host/ufs-mediatek.c  | 2 +-
>  drivers/ufs/host/ufs-qcom-ice.c  | 4 ++--
>  drivers/ufs/host/ufshcd-pci.c    | 2 +-
>  include/ufs/ufshcd.h             | 5 +++++
>  5 files changed, 13 insertions(+), 8 deletions(-)

Something went wrong with your patch, there is no --- line, so git will
apply it with the diffstat, right?

Did you hand-edit this?

thanks,

greg k-h
