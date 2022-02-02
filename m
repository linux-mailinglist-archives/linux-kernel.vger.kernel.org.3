Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CA4A72B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbiBBOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:10:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52032 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiBBOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:10:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7017B830F5;
        Wed,  2 Feb 2022 14:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBCAC340EB;
        Wed,  2 Feb 2022 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643811007;
        bh=6uznsR4H3yFEQiaP1m7THbQ2MOu1Lo/N213pW2a1JJY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WEV1GWOwYGozfq3wU15ekgvJTOvdsgSPY/6lUN4aU02JNoheDkT2IhXaDaT/X85ny
         ZZvZTlwsNBcN7Tsl58q2ngqPNEalQg6kN/QAiwk8n7elVGe7ToMfMq1b/0kdFwrz8B
         RTvl9ZWvL+dj+uX/4YX/v5TPVaH+BWmrUcWvZgeXlq56zknzL5PYEGa6BaHoSfpEqR
         YOL0cqH0Oh0hFSQ9UxgALB1X6pwTAQLtooj+iFFqsmWBKBdgAoD+Cw98MyNZ8ZOtfr
         CIcwDdx5CbS0OVkWaHhEbRnUpLkZwzGlUmM4rW+q+EBtPW522AFSAxqyEe9lyXOfUM
         JuxspxCupXCcA==
Date:   Wed, 2 Feb 2022 15:10:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] HID: google: Use struct_size() helper in
 kzalloc()
In-Reply-To: <20220125233744.GA81239@embeddedor>
Message-ID: <nycvar.YFH.7.76.2202021509550.11721@cbobk.fhfr.pm>
References: <20220125233744.GA81239@embeddedor>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022, Gustavo A. R. Silva wrote:

> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/hid/hid-google-hammer.c:61:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thank you Gustavo.

-- 
Jiri Kosina
SUSE Labs

