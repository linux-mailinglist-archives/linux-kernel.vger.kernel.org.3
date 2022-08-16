Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5959544A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHPH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiHPH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A207F47EA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D82A612B3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD42C433D6;
        Tue, 16 Aug 2022 05:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660626792;
        bh=tKzLj6Lbsr6qspAg55d5vfym6ZkXDJIff0/0OtXmUPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2k4HEeAcQ+gDUO+PG3bflrli3XT93uTqRA/xIscOO3rtvRcKOl7FwPETvfFYdaUm
         970+4IvaMI2Ck9eySfD7R31e72dt/bN4yPmwWsJswX0pHDEeJ79KApKD+6IXapyAEs
         IFCoi8REhuM6ZV2iCJrPXPXh3dfvX4yO0bF4rBJSaJuVsk9dXVN5Z5EKm5/5LBkXPg
         0+6LTnXZJySVHruxWq+8uCCsFZ/yIETWMB32rrj7Wzk94vZ+igSwP+Cjs7HehdBeYy
         0s00xp4FPe0VErQ6OS9t40W9yxKKgQ2HTdyPsNA6Mt0uK3jm6FfMah40V96humc2V9
         mdyCVZzPswVww==
Date:   Tue, 16 Aug 2022 05:13:07 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v5 7/7] platform/chrome: cros_ec_typec: Get retimer handle
Message-ID: <YvsnY6LwVZFibj7x@google.com>
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-8-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063555.1384505-8-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:34:30AM +0000, Prashant Malani wrote:
> Where available, obtain the handle to retimer switch specified via
> firmware, and update the mux configuration callsites to add retimer
> support for supported modes.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

With a nit,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> +static int cros_typec_retimer_set(struct typec_retimer  *retimer, struct typec_mux_state state)

nit: double spaces.
