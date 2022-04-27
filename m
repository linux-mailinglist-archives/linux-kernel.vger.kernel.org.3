Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8392051104C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357735AbiD0E4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiD0E4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609B5641C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8D5612DB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14116C385A7;
        Wed, 27 Apr 2022 04:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651035177;
        bh=DxCUyl9p44smzXQftcVWir2mw4zf6/UMSiRlQ4twW6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ag0XENDOV5yFKAC9dzETXOjBBqj+UP190wk2Xfl+oSr4qSpFf5wx6mOCAWyGrqs8T
         58wVf+JgqNixbOiROO2gGFUPzWynnQCbDBWkJd+zFHf5dmnMAr26ibSBwjT4lF/ihk
         NniF2jZsF2kosB0bx4oTWU7J6kO9JeDRTAFj2zQE=
Date:   Wed, 27 Apr 2022 06:52:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6655: Replace MACvReadMIBCounter with
 VNSvInPortD
Message-ID: <YmjMJHup1TJohVZd@kroah.com>
References: <cover.1651001609.git.philipp.g.hortmann@gmail.com>
 <50cbf7b87759dbfe023554fc42a499dd923b7f8c.1651001609.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cbf7b87759dbfe023554fc42a499dd923b7f8c.1651001609.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:02:17PM +0200, Philipp Hortmann wrote:
> Replace macro MACvReadMIBCounter with VNSvInPortD and as it
> was the only user, it can now be removed.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1 -> V2: Shorted and simplified patch description

There is no "v2" in the subject lines in this thread anywhere :(

git will create it automatically for you if you use the '-v' option to
git format-patch.

Please fix up and send a v3 series.

thanks,

greg k-h
