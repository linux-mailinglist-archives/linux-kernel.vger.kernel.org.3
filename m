Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA144C405A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiBYIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBYIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:44:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EE1186235
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6557FB82B98
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC64C340E7;
        Fri, 25 Feb 2022 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645778613;
        bh=oGOrRQb4Wq9padIb9oBVCYbpCpufpOd8E+7hPls+87Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPHxhu8O3sIentsEeZZYqlFIV8MvVJ76L8s61U6HvyovwheqNlyqWDNr7xDHEHKMB
         sGnhcjLW8Ckb+aVzyx6NrPoojLL1GPZekJ4B0IZG/j+QntOP7KRDVPBieu4su+2hyh
         usAqe8obB8NehzCjJ8Rb9g2IqIbYAT/5gkoZOHB1Fcq6GU7b389YF1zq8hHHuJ8dEK
         TRk8NMMlvIa0zR8gKN/idjD8GF2qdRNt0dhTPSMaZQH8/nGL7Corr6oDgmQWzGw/o4
         b6xcLp/LthTJsMj2iG6tqt8PQnrmMBqYCM2Q8Fe4wY7z2Ktqe4Jp3hY1MSnqdh1XTg
         TLWRIdGLwjyVQ==
Date:   Fri, 25 Feb 2022 14:13:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2] phy: usb: Add "wake on" functionality for newer
 Synopsis XHCI controllers
Message-ID: <YhiWsTyaGL9CFZkW@matsya>
References: <20220215032422.5179-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215032422.5179-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-22, 19:24, Florian Fainelli wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> Add "wake on" support for the newer Synopsis based XHCI only controller.
> This works on the 72165 and 72164 and newer chips and does not work
> on 7216 based systems. Also switch the USB sysclk to a slower clock
> on suspend to save additional power in S2. The clock switch will only
> save power on the 72165b0 and newer chips and is a nop on older chips.

Applied, thanks

-- 
~Vinod
