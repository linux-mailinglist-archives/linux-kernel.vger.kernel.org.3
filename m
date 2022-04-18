Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D4504B56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiDRD3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiDRD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:29:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC117E22
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 20:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68272B80E1A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC29DC385A4;
        Mon, 18 Apr 2022 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650252391;
        bh=7VisAQYT0TzWPffMkMB/kVe4K1ubWTvxLSBrs0/+ROY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXVkw523LDbp3mJYn6LWdh79yMXv1Zb2dhfUM1ardW33A+TTV8qLZA0v8nSnbZeNJ
         watw1LKxYVaFX+WOaqc0R6TrMnmkwYCidhED+LD9UdiYdlNtC78575BVfU7CysxHOk
         2ivmI9zXW7NqUzdut6hRWc3D6ob22zLieUEycZBEXAg+frxfpJNWYdJAacTuZYVSYB
         I7/U1IneA79UU+ejBcrL60U3GOAL+WROqc0cj5ZKJIRJueCvW3StXS+MC4xt49ES2/
         zGza6Ufzn5XewW+DzvcKBYo+aZJ00ze1Xsbg21KUS6QatDmq8qVoPtDwVglM8vgADA
         6lEL2p5SXFoOQ==
Date:   Mon, 18 Apr 2022 11:26:27 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 3/3] power: supply: PCHG: Use cros_ec_pchg_port_count()
Message-ID: <YlzaYye4xOZDb11A@google.com>
References: <20220415003253.1973106-1-swboyd@chromium.org>
 <20220415003253.1973106-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415003253.1973106-4-swboyd@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:32:53PM -0700, Stephen Boyd wrote:
> Use the common function cros_ec_pchg_port_count() now that we only
> register this device when there are a non-zero number of peripheral
> charger ports.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <chrome-platform@lists.linux.dev>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Share the same comment with the 1st patch in the series,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
