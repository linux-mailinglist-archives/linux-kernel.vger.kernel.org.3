Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0C5A0CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiHYJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbiHYJcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B5979C0;
        Thu, 25 Aug 2022 02:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E3B0B827B0;
        Thu, 25 Aug 2022 09:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A66CC433C1;
        Thu, 25 Aug 2022 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419968;
        bh=giBw2Ge0kvHTOOLhLqERownbmN1JP1/B1ngNjLMJhdY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ko+J6tJlz7Plt3yat03TlKHnfmjpmm4/iE2BiAqKg2Jzx6xv4rSd90Qtgw6VvHbPM
         WTHLZyb1TmokNdBd1F6g25IFez9/w09s0pDZ3QyNxwFKM/XlYLMubq2Jt6btYI8Hl4
         c1xddBZNgiiD9jwe+R837yrPtEnmpRF6aYM/24Q4fOhuSJrkuCXQ6Z3z7k6VYNGCZR
         md+rCcFhRDm4cfLHPxTrL9hOfUXGGeNHlG+0QNXEcsUc/fI8yKliEaBVTOX2agKNuM
         vti12jfN+a790e1baFNSRE+dYPmiCLei187HpUqYMZEs0Pz5bscrCG4jXeVCeTaXFI
         8uySO+cVOgp0g==
Date:   Thu, 25 Aug 2022 11:32:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: Simplify comments
In-Reply-To: <7eec2e24a231510577647853a32bddb89a762128.1659468931.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2208251132330.19850@cbobk.fhfr.pm>
References: <7eec2e24a231510577647853a32bddb89a762128.1659468931.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022, Christophe JAILLET wrote:

> Remove a left-over from commit 2874c5fd2842 ("treewide: Replace GPLv2
> boilerplate/reference with SPDX - rule 152").
> An empty comment block can be removed.
> 
> While at it remove, also remove what is supposed to be the path/filename of
> the file.
> This is really low value... and wrong since commit 471d17148c8b
> ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

