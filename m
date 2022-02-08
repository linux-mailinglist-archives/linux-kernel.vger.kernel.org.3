Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D94ADE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383062AbiBHQWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383035AbiBHQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:22:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A681C06174F;
        Tue,  8 Feb 2022 08:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F346163C;
        Tue,  8 Feb 2022 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F12C004E1;
        Tue,  8 Feb 2022 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337322;
        bh=UaVxOWmsbivSkU9vIw/GYJbDCYQehGoFF7tme6i5Rgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9Q0TqQSdjW4iYnYCrU2P4W7USzsBBA/Ckk5QjBhmR1VitF63RGskEr/3mzgYnuuj
         qIgjoH+EVmb/4V3v6GpxKPcPmvoaxIALpXP1kKpDKkG9jVps2momdSLPeMz30DOJZY
         0utjHzP133Ov84Z9EZUuZjW1zLOzf7Q3LGTHQZvxXQTm1WSZ1a6EvJl2FS0rCWi3tQ
         7cGVMz8vbvMv7173RfD+zf0bI6YrSvcmwDNfBWoRuLFYy7TmqdwM3W6bsrENAp7VlU
         PiXhNaFzBSwKS53bHCu+fSxEgcCsJ1Ib8Wq28M8D4hIoazgXSBo+SP9jdhMUdgF7xC
         mbXo2FXH7L7fQ==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
Date:   Tue,  8 Feb 2022 16:21:51 +0000
Message-Id: <164433570600.932619.3193725963159387011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
References: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 23:50:48 +0100, Christophe JAILLET wrote:
> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
> 
> So turn a devm_kzalloc()+explicit size computation into an equivalent
> devm_kcalloc().
> 
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
      https://git.kernel.org/will/c/98b64741d611
[2/2] iommu/arm-smmu-v3: Simplify memory allocation
      https://git.kernel.org/will/c/fcdeb8c34043

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
