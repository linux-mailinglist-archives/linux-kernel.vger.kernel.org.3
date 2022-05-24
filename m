Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A72533318
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiEXVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiEXVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E67CDFD;
        Tue, 24 May 2022 14:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 172BE6177E;
        Tue, 24 May 2022 21:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39328C34100;
        Tue, 24 May 2022 21:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653428638;
        bh=pk0sDBNvdlwJrrfflBf7nAqss/iUtPV4Fv51aafyOjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IyV6K52Us5WXrhJD9okiGheCfOjZTydDt2eib5m8dLJXlPQW4fAFv2FpE1a8zYrUD
         n1nomQmTtsNKNLfy9uOHCdgAvHzHGncBUrEyON2R/UvYYLYe1tOER+jOFMMfC9kVeD
         cl4vJtek0ZMMsTT0WyMtrbLKlx295/vYuIWK2AqiRC2ydk2cLdsWSANyTfblNu1Ra0
         +EYl9mHpAOnwggy1jwiS+SMXz7siEv7nobzglBvObqzc4EEq1nfOWszFLQ9BrOUZHC
         zmCAhkcrNTJA7XPkisj3gWKpImU1Fkl+wli9+zI7a09ROJP5zwxEzC0+Lpvd0zt2Hf
         PMVbq2/reJeBQ==
Date:   Tue, 24 May 2022 16:43:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20220524214356.GA275586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525070723.426cbfd4@canb.auug.org.au>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 07:07:23AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   5db490f54497 ("dt-bindings: PCI: qcom: Add schema for sc7280 chipset")
>   ee485c61f0e5 ("dt-bindings: PCI: qcom: Specify reg-names explicitly")
>   3d49f91acbcc ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
>   e93dde4b6768 ("dt-bindings: PCI: qcom: Convert to YAML")
>   ed5e8fe0db30 ("PCI: qcom: Fix unbalanced PHY init on probe errors")
>   f36120778857 ("PCI: qcom: Fix runtime PM imbalance on probe errors")
>   53063d1437e5 ("PCI: qcom: Fix pipe clock imbalance")
>   5945b7056322 ("PCI: qcom: Add SM8150 SoC support")
>   ddd0cc4df5a1 ("dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC")
> 
> are missing a Signed-off-by from their committer.

Sorry, fixed.
