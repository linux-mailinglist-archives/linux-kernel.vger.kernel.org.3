Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C954A6E01
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbiBBJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:43:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48722 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiBBJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:43:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57476137A;
        Wed,  2 Feb 2022 09:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF10C004E1;
        Wed,  2 Feb 2022 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643795036;
        bh=mbuWQWhtqlZqaoDiqbeasy1F5APGJ0XmLbphagm12RM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Zouko4fk6VK7rtcLqVKiGbq0YXgsO25lskod11pz4XCiiS0L2pyciUNlerDv/EYAg
         87O9XcIbTgki8h5zZLGemrCAiG7/YI+6ki3YZWag5Zj6yfXMMSgRDJ/Cl/XcXcxTht
         t8DymBNxyzTYKHgYGE3ZkciggpwOdHaeTzGg9kpg=
Date:   Wed, 2 Feb 2022 10:43:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Marijn Suijten <marijns95@gmail.com>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/2] config: android-recommended: Disable
 BPF_UNPRIV_DEFAULT_OFF for netd
Message-ID: <YfpSUnO6ut9WXjTZ@kroah.com>
References: <20220202093355.108460-2-marijn.suijten@somainline.org>
 <20220202093858.cmkm2z5w2fum6jit@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202093858.cmkm2z5w2fum6jit@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 10:38:58AM +0100, Marijn Suijten wrote:
> On 2022-02-02 10:33:55, Marijn Suijten wrote:
> > From: Marijn Suijten <marijns95@gmail.com>
> 
> Feel free to disregard this `From:` override, didn't catch it when
> preparing the patches from a different machine.

Please resend with the correct one, otherwise our tools will get this
wrong when we try to commit it.

thanks,

greg k-h
