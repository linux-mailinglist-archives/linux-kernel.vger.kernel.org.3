Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDE500A31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiDNJrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbiDNJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429E70F62;
        Thu, 14 Apr 2022 02:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43EC9B828FD;
        Thu, 14 Apr 2022 09:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF48AC385A7;
        Thu, 14 Apr 2022 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649929435;
        bh=2VEUl2b/E+/ehMm5zJhVjkhVugGOJDikH5pjjHrToHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVanonr7eaz0DbDLIDgytLPSFW+4gUelB6wkSp6tl/Q2lEfJlNzAEVq8T3CtiJgEL
         i20yCgxKDm5dNlLzOJgFB/WdN7o6JC9Oa9NspF1d6S7P/KujfiIplTOXTUaMxdGWcc
         f7TXz6zYhHPXY3n19pjVqzNUac234T3kIEgVReRGOfZlBdHABfUGTYXn1iQm+f2Vhc
         8WShPDrJyHLA9xNZjxvp4qCYFQKKiIub5jsRAXqibViDRCidHbRMR86CxW5Ddxviiz
         izUwxvvt27n+PRb7gTrxoAlW1/dPmYRBLC4tSSrv3l1bHF5oCACxcgzF2ulQJuvxuV
         4SpK+XHwj8G9Q==
Date:   Thu, 14 Apr 2022 17:43:51 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: pwm-cros-ec: add channel type support
Message-ID: <Ylfs1yhYsFOUwKv4@google.com>
References: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
 <20220414092831.3717684-3-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414092831.3717684-3-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:28:29AM +0000, Fabio Baltieri wrote:
> Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
> types to the PWM cros_ec_pwm driver. This allows specifying one of these
> PWM channel by functionality, and let the EC firmware pick the correct
> channel, thus abstracting the hardware implementation from the kernel
> driver.
> 
> To use it, define the node with the "google,cros-ec-pwm-type"
> compatible.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
