Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091844C425A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiBYKdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiBYKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:33:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2816AA43;
        Fri, 25 Feb 2022 02:32:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 955286155B;
        Fri, 25 Feb 2022 10:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769D0C340E7;
        Fri, 25 Feb 2022 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645785159;
        bh=WQQt1uu312A8XAs+LoP4SDfB91oIAFo5DwTin5tMleA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBW9Hi9JccIwTAKePyO2/690IAkx8JAzL/Kla+OIpGoBi4ZJaBhfVXQleOJNl5a8X
         3xA1o4aNphQibsgBjgX8+znJ3GqA8dLvYVSxUz3BdQZ2cQsIh6BfD0TE9bO5ZG3gHx
         QS9gLSoTdlth+Tm1H1aGGiLWvacrQ3F7QYRN/Jrc=
Date:   Fri, 25 Feb 2022 11:32:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     johan@kernel.org, elder@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        elder@ieee.org
Subject: Re: [PATCH v3] staging: greybus: introduce pwm_ops::apply
Message-ID: <YhiwP/qt+yHLHztR@kroah.com>
References: <1645780561-18481-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645780561-18481-1-git-send-email-chensong_2000@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 05:16:01PM +0800, Song Chen wrote:
> Introduce apply in pwm_ops to replace legacy operations,
> like enable, disable, config and set_polarity.

Why?  You are saying what you are doing here, but nothing about why this
is needed, or what it will help with, or what it will fix.

You need to explain why a change is needed.

thanks,

greg k-h
