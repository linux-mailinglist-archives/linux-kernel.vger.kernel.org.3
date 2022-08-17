Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B244A596700
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiHQBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiHQBtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:49:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221175F10E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C19EBB81A96
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6A1C433D6;
        Wed, 17 Aug 2022 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660700939;
        bh=FAR+u1EOovTvzVVro+BUSVCe8k8Zki9e4ZhgM5ZaS+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUc8cwBeBlns6irfAuaeOOvKVduIFcntX30RHETmYcZrrEoUK/PI0dCOtA70inqNR
         QyZ2Jm5EYhtDMvJhmq4bcJnrRLfkiNC3OGwsemVpyqtJvSnyiEP+9wBzaGrR5BRRyB
         qRLsqT6TgMRl0nj11vQGedQ8DPyRRRwh/xLHYLYpV38C4N6llmVC2wesOOlSGTIkTa
         D+WXMayUAN4vWUhjOXK2nUvjJotvlkEXiQYQfV6Jfw11/os3v/LGwkBzL4qD4y5Rzl
         JbXyEYEnFXWKosQN8bo2JE2kKGOJET5rmbuJaFJk0o04lk9Ime5m5GEq1kG/fPN3ac
         xtco+E4YCiveQ==
Date:   Wed, 17 Aug 2022 01:48:55 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v6 4/7] platform/chrome: cros_typec_switch: Add event
 check
Message-ID: <YvxJB3SQv9yp8pCD@google.com>
References: <20220816214857.2088914-1-pmalani@chromium.org>
 <20220816214857.2088914-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816214857.2088914-5-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:48:32PM +0000, Prashant Malani wrote:
> The ChromeOS EC updates Type-C status events when mux set requests from
> the Application Processor (AP) are completed. Add a check to the
> flow of configuring muxes to look for this status done bit, so that
> the driver is aware that the mux set completed successfully or not.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
