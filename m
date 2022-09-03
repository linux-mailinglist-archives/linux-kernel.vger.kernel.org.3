Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C804F5ABD4B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiICFwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiICFwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02089E0FD3;
        Fri,  2 Sep 2022 22:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B08FBB82E86;
        Sat,  3 Sep 2022 05:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0D9C433C1;
        Sat,  3 Sep 2022 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662184334;
        bh=6YniWjPstmX/B66MOBeISmMJHhLUUpAX4beRrbMKeDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP0NeKyEiQUbXzrsGwEp+IetgZgEYEqrAf3Lo+fYzVoH9qTGL1fDi3PhI1nkubeYh
         7IRIQPXoS47zwXlofaPDYGRWnOfZ2SsQBTNwtWk7Gqok0YKAtRZHRTJdl+RgD+hktS
         eysF0Tsc9cVvI7W60tD7wlsnJl8lK5/x9oWleEbk=
Date:   Sat, 3 Sep 2022 07:52:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: psmouse - switch to using dev_groups for
 driver-specific attributes
Message-ID: <YxLroDLbX95pRtvL@kroah.com>
References: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
 <20220903051119.1332808-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903051119.1332808-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:11:18PM -0700, Dmitry Torokhov wrote:
> The driver core now has the ability to handle the creation and removal
> of device-specific sysfs files, let's use it instead of registering and
> unregistering attributes by hand.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
