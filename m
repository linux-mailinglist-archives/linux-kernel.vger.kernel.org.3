Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D884B8CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiBPPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:51:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiBPPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:50:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769102A796A;
        Wed, 16 Feb 2022 07:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14DB061A4F;
        Wed, 16 Feb 2022 15:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A78FC004E1;
        Wed, 16 Feb 2022 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026644;
        bh=v5whEidQUlc/uO+L6cMKKBxpQk4dvUiKyAMI6jTeB8U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FrnMOV3BEyLHghpJLZmX8elb+m0bxP5nnecgSHm1LUB7qgu+pn7BvHO6cLq8VYViY
         gvpQaBt8FGZVSBwM1DqhsDobwekjBskaZ88gcSh+82XdXg1yFXSCue8/6S1fcF5AF9
         ISqHmFF3kWev740S9kxF8g5KYSWIZJioicEtvKPs8GDEuC1Ng7AqkWCHJ1FHmpeMT/
         Dc/Ftf7UKjwuQhIFCHrPfglc6h/rb/kt0BALRCqbEQTwt13082WINsSKNWg7v/biZC
         bCHau/b8IPsidfWDDhk3REBUn8NiUjtwlRZqx9hzuwH7zRJpST+7sW7zbm5kbozYY6
         wnsj67cFgYE7Q==
Date:   Wed, 16 Feb 2022 16:50:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: apple: Report Magic Keyboard 2021 with fingerprint
 reader battery over USB
In-Reply-To: <20220208185530.51690-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202161650350.11721@cbobk.fhfr.pm>
References: <20220208185530.51690-1-jose.exposito89@gmail.com>
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
> version with fingerprint reader registers 2 different interfaces. One of
> them is used to report the battery level.
> 
> However, unlike when connected over Bluetooth, the battery level is not
> reported automatically and it is required to fetch it manually.
> 
> Add the APPLE_RDESC_BATTERY quirk to fix the battery report descriptor
> and manually fetch the battery level.
> 
> Tested with the ANSI variant of the keyboard with and without numpad.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

