Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E71595430
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiHPHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiHPHzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:55:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880152E69
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ED30B815F3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9A6C433C1;
        Tue, 16 Aug 2022 05:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660626532;
        bh=EkH4HoC5GYbUkWQltFaYg7uW98fpm2YY+hcM9wgH/2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcVGd3nXbEK3CtsS7RzJIxS4mgZeBgCA1SqOJZwqrD47/MQlHuy++Jreh7QtiFuv7
         /tV3B5S4Hje+O0KBaJDyxMEKiIEjNHNto1aGlMkIq8mVJXsLs6zZsEKBpI+SGWy3Ac
         tb1cjTgNjiNIHV5v98nK5nxa2p6rLNDsvievBFbXkrckCsJpQT/I4EezEMUGj2uIXK
         h66AlVbX28qKlkmAz/RFcdk6mBW0mn3Jj2wbRLqoX6P44HL0f+1KDKv9P0AuZgl1tq
         /6Esdx/RjfovnSIuuBrsIHNUHBbtHi0QeVD7yPZhzMDI2SmVtzOu9T9CoSpCOxTbAf
         pUBAo4kOiwXpw==
Date:   Tue, 16 Aug 2022 05:08:47 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v5 1/7] platform/chrome: Add Type-C mux set command
 definitions
Message-ID: <YvsmX9Fh5mXwQYx9@google.com>
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063555.1384505-2-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:34:17AM +0000, Prashant Malani wrote:
> Copy EC header definitions for the USB Type-C Mux control command from
> the EC code base. Also pull in "TBT_UFP_REPLY" definitions, since that
> is the prior entry in the enum.
> 
> These headers are already present in the EC code base. [1]
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/b80f85a94a423273c1638ef7b662c56931a138dd/include/ec_commands.h
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
