Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38985596701
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiHQBsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHQBsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:48:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52483DF3C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90E9EB81A96
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE7C433C1;
        Wed, 17 Aug 2022 01:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660700917;
        bh=AMXEX+KlV2aRDGZNTsZmuxDJUliJkxuaUi1tKIzDJ6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVVXNnxbrXtjuDpbA7B8J/AIe5VmovYFeO7k/w5dWScoql5mPPRNG5X5ypTYJ4c6p
         2XcRxOG1dpXZQxw9OBGy1BP0MYh0+wA029nJWdy914MrLhAfTvXbKuEJcHkFDWdHWw
         xn7mJbitZphhFSrX/VqUm7LuhE3oEfz6Cu0nrEZJq5TfHJAtbnBJEn2USPRWN5lPxM
         O5Uo0yJVFTzTLN9B5tvixvdrzjdAYZvCsDQP2NAz2ViG9Ff2XTzfRaa8KToEnicNhp
         EPdnXTDKVlmGRtR1Tijd5vtUWgNnhQUE7q7pHGEmFx/BrqnhsJ1PRzolxl7ZUdznXl
         w40Ok8MvuPDwA==
Date:   Wed, 17 Aug 2022 01:48:32 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v6 2/7] platform/chrome: cros_typec_switch: Add switch
 driver
Message-ID: <YvxI8NB6nYFDx/4Z@google.com>
References: <20220816214857.2088914-1-pmalani@chromium.org>
 <20220816214857.2088914-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816214857.2088914-3-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:48:30PM +0000, Prashant Malani wrote:
> Introduce a driver to configure USB Type-C mode switches and retimers
> which are controlled by the ChromeOS EC (Embedded Controller).
> This allows Type-C port drivers, as well as alternate mode drivers to
> configure their relevant mode switches and retimers according to the
> Type-C state they want to achieve.
> 
> ACPI devices with ID GOOG001A will bind to this driver.
> 
> Currently, we only register a retimer switch with a stub set function.
> Subsequent patches will implement the host command set functionality,
> and introduce mode switches.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
