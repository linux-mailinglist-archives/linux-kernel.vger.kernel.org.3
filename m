Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A418595448
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiHPH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiHPH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC64DC084
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7B9612AC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C80C433C1;
        Tue, 16 Aug 2022 05:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660626774;
        bh=0NPCl8h/PhjoO6Udfj2C+IRqq9TJkwg8U+5iaTjcdhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCHOmWEx9qhPG1+ocGxP2ppCfP6gcV8IFx1eF9iRd1VT7XQS2ntm5onLCq9u/u6BW
         iPkVqkRUNZXHJTQazU2k8t6b29GHnyiowYvoTVmvczo1TPk4vx29N/yv7xXdbGVhgX
         1zC9ei14STqkiLjEVF5/nJ2zsKB25QYeb1S09sL6U+qZfWIHe5X7Wk6eP+Pr9NV2ei
         sHSobNc1Rof+w/GWRr+CMOyFHHZz5fUjJ/ke+ZWZuOyBy7rzrZo+ELcBZ3bcCeV5TN
         oUYQcR5MUcT4aD/0jA4M3i39fsVHDC3qXMhPq5lKao92PoQLxG4QuNwrui2mwH7X88
         05L5AL8suwPQw==
Date:   Tue, 16 Aug 2022 05:12:50 +0000
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
Subject: Re: [PATCH v5 6/7] platform/chrome: cros_ec_typec: Cleanup switch
 handle return paths
Message-ID: <YvsnUqn6EMxD0Bo5@google.com>
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-7-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063555.1384505-7-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:34:28AM +0000, Prashant Malani wrote:
> Some of the return paths for the cros_typec_get_switch_handles()
> aren't necessary. Clean up the return paths to only undo the handle
> get's which succeeded.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
