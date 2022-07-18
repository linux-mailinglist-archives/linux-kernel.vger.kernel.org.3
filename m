Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2D577F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiGRK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiGRK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4461C934;
        Mon, 18 Jul 2022 03:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B903B810A0;
        Mon, 18 Jul 2022 10:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5330DC341C0;
        Mon, 18 Jul 2022 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658139972;
        bh=MF5LRamwYXcM0ZIXRv1F2d4aJR1Nj2A7Ufiw8kzm5wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcSMcBWcxA5i5CXTG1KOdupbZ69haMMTXjtSUg21aLigCBR1MYNul6/5azrTQyp0N
         Bk7cIDZZP8M+DWwglNq9IhmQN5EGEJc2zSR86g295JCR4OWXRgmjdM67BoUzi0wdhS
         5+Z60itQuug0RMAvSFJhuBGxwC2pwMnCCsGQHQZk4rm6AXTJ/hyJZMW38x9QCXAJkc
         aeyg34F2jdUSILqSVnXwoP6/sxAppvQvRwvtsza0s9DXrxRhSQUSzPL1wme/fG3Z8o
         vt8OzOPhyVpv58O3bULtQPIcVVxkUFAhPi/t79qQIGnKZtlYX+po5jkgDNFqYqCgzg
         CQRZ3NtYpbF5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDNwz-0004wq-Fu; Mon, 18 Jul 2022 12:26:06 +0200
Date:   Mon, 18 Jul 2022 12:26:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/serial: fix repeated words in comments
Message-ID: <YtU1PS9zdcQgY/04@hovoldconsulting.com>
References: <20220716134826.48413-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716134826.48413-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 09:48:26PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

This has been addressed in -next:


	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=9ec7e8d5fae34b3da52b4b0a7a47877bc6aa8416

Johan
