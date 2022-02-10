Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0E4B174C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiBJU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:57:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241575AbiBJU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:57:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C310C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87784B82744
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FDAC004E1;
        Thu, 10 Feb 2022 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644526665;
        bh=A5PEWqAB8nEJetdzoluo85KfvBoStC8tNmDbk7Uzpqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hufVHiJsscm5zO92YC600YUxG27rFjQ8A3MII79WCKTeqhCyViaoFNo88BErZ6cBj
         l/DEMuqlL53lZIMY0imsxqZbtIaKD2ZMdofLg/Hp1CxEA7JVbWlDoxwRLMr9QcvB0d
         ZrTLAqdaBEWZqbkpC7mM14uSmfVOAoR4JuNLYBg8q0moF75A9gRfdReFOh/gDB4yyc
         5z7iJlf7y4miA3gwFXvoudjcfRJmuQi4dCubYCzKJ34/pu+Gk7yjgmCLAswCU6bEEJ
         7iw1h1JKyudD2MoslVLb3esr8OMoZUQl6cAJ/I/ziS2FU9gl8nary9VBvdLQhzfK1i
         8WfW6acFVtOmw==
Date:   Thu, 10 Feb 2022 12:57:42 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <20220210205742.GA1658422@dhcp-10-100-145-180.wdc.com>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power
> to nvme device is removed during suspend-resume process. This
> is done to avoid the failure dring resume.
> 
> This enables simple suspend path for this platform.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
