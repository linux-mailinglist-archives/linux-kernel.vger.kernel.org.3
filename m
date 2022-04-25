Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FB50D884
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiDYEvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiDYEuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C170263F8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 21:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51CDF60CA0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB36C385A4;
        Mon, 25 Apr 2022 04:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650861937;
        bh=WfUDenzRqSwN+2AH8dGvIQOwxPGHWP2uyfmC+8Ufc7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpqNSxAFm6ZPMthlxgGs7DN919OioAO5tKDtC8Q4Q5ZJku+Yq99/NIrjpcbx1JcTq
         eHzNF//Em+O77zNpc0CU3vIEYCoz8OrpaDndn24lbDHDAPOBAR8d3DRb1KUljfSN/g
         pnRwmGb+mJGV0bNhfBRyJzBnUJd7WXxd8TkLof2w=
Date:   Mon, 25 Apr 2022 06:45:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Solomon Tan <wjsota@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com
Subject: Re: [PATCH v2] Revert "staging: r8188eu: use in-kernel ieee channel"
Message-ID: <YmYnbKeqce5TZuM1@kroah.com>
References: <20220425011612.113664-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425011612.113664-1-wjsota@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:16:13AM +0800, Solomon Tan wrote:
> This reverts commit 0afaa121813ed602bd203759c339cb639493f8c2 as changing
> rtw_ieee80211_channel to ieee80211_channel causes a memcpy bug as reported
> in
> https://lore.kernel.org/linux-staging/67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com/
> due to their size differences.
> 
> Signed-off-by: Solomon Tan <wjsota@gmail.com>

No "Reported-by:" tag?

