Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890DC585403
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiG2Qxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiG2Qxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B089A4B;
        Fri, 29 Jul 2022 09:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5152761EBA;
        Fri, 29 Jul 2022 16:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B7C433C1;
        Fri, 29 Jul 2022 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659113624;
        bh=dRgnIIdxVFBOGYWODaTIxnLssgHH3AEtGG4hzRR5xhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LFgBsAc68I7/coX9CupBt4+uVTyL5a2q6I+m0/1cJmqZ4ibnaahXR2dLCK8NGLrvT
         Vjbgf7o5/rrOrK5K3rMVqYdA2+GAJIyhUnnoYhmTgvD4F+MLA5DzFuvmWDSAJjzzF6
         WZtCkg1AXSFcubVc1w2ZEY2bwRrvSBJZc2xIzhKfmlIMIO1P9oWZumeR6XeyzkosxI
         itXRvX8PDioAbckn73JWSVl49bWuxWFAWoOXJcQIoaZOYuj8UnW2UTIBUZPVgkRB/R
         2yug61uy9UjDCGzYgHtCdOyDtRRTkpQRNzXjupKdqiqcGD7kZ2++pR8wkLyKXw28EK
         E/nXo15xrQQ6w==
Date:   Fri, 29 Jul 2022 18:53:38 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: turris-omnia: convert to use dev_groups
Message-ID: <20220729185338.2bba32f5@dellmb>
In-Reply-To: <20220729140346.2313175-1-gregkh@linuxfoundation.org>
References: <20220729140346.2313175-1-gregkh@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 16:03:46 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner.  Take advantage of
> that by converting this driver to use this by moving the sysfs
> attributes into a group and assigning the dev_groups pointer to it.
>=20
> Cc: "Marek Beh=C3=BAn" <kabel@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-leds@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
