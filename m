Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC755F652
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiF2GKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiF2GKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71911468;
        Tue, 28 Jun 2022 23:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7133E61835;
        Wed, 29 Jun 2022 06:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A0AC3411E;
        Wed, 29 Jun 2022 06:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656483001;
        bh=3XEIIpgbvu0eBh9Xwce2LFWyoqzm016+CfeL/TqnSVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2ExU8zOXKM24g/RA+NZ7kWrl2MOMUqnyx8UQziMGc+Ke7jyZpFM6U6bYdYuzQ4WT
         r9iqQovsOMIGD2xQTTdDSYBAbl5lNd3MJLXdfXcSLrTw50HAKMJWbGd67dRmkbITSR
         dPB+bMEbFSoEGVK9LgCZcefUeZTBBxxU62+i2swY=
Date:   Wed, 29 Jun 2022 08:09:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-serial@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_bcm7271: Save/restore RTS in suspend/resume
Message-ID: <YrvstwByh05I2PZc@kroah.com>
References: <20220628215901.3074262-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628215901.3074262-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:59:01PM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The previous patch prevented an early enabling of RTS during
> resume, but it did not actively restore the RTS state after
> resume.

There is no "previous patch" here, please be specific and explain why
you are doing what you are doing here.

thanks,

greg k-h
