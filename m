Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07674B8CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiBPPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:51:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbiBPPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:50:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF92A82D2;
        Wed, 16 Feb 2022 07:50:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73BDCB81F39;
        Wed, 16 Feb 2022 15:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F2CC004E1;
        Wed, 16 Feb 2022 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026633;
        bh=l41tHDdLAtkQtvCVNj2n8mCIQt6xzYlxhzyYNAoaFVM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=D5QyWCoAfxhWNSVHutCMYJLizbVojzCaAw4OjM1HEPkyjE3JEP2t99bF+JivlBVCw
         WNQgtvg81rGrIuY0l2cSArptTUGVWGGa/s94f9+iHpojo93pWskhjfw05WbVjR/fDv
         xmXWn0kYkVO9stOcy+MAK8Nz1sni2I1kB0iedgodLhQSI/Y6KAsw45yjBQoZRnXEBx
         9zLm+NPO+g7pDtciK3xrlEJ9Fl74z/TgxfomW+mEv0+pPltCXLELzT3yeOKiq59eWj
         PJuOgacPUlakG2oI/2f6DadgPX+gq6OYUQ5M32H9m2jpkV80joNLzDxxB7wy27uiy+
         sin8b2W9ib73g==
Date:   Wed, 16 Feb 2022 16:50:30 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: apple: Report Magic Keyboard 2021 battery over
 USB
In-Reply-To: <20220208185009.49100-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202161650240.11721@cbobk.fhfr.pm>
References: <20220208185009.49100-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022, José Expósito wrote:

> Like the Apple Magic Keyboard 2015, when connected over USB, the 2021
> version registers 2 different interfaces. One of them is used to report
> the battery level.
> 
> However, unlike when connected over Bluetooth, the battery level is not
> reported automatically and it is required to fetch it manually.
> 
> Add the APPLE_RDESC_BATTERY quirk to fix the battery report descriptor
> and manually fetch the battery level.
> 
> Tested with the ANSI, ISO and JIS variants of the keyboard.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied.

-- 
Jiri Kosina
SUSE Labs

