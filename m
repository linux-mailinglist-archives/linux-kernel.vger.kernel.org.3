Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF65966FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiHQBs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHQBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:48:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F87552FED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E92A4B81A96
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C51C433D6;
        Wed, 17 Aug 2022 01:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660700928;
        bh=wWHfPg1K+9e7y2HviJu2z7UZLj7oKPXVzLdLkUJXMR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBwAvtk9/RvJBdFAoATF8thq+U0ZE+BNtmQ9Pf6AE5K8NKRRS8OnagOULObfLPGRF
         ieejljXmmzWVGvfT5HXApvo7uBaa9MT14SofaNJewDL4jOtbePPjMmkuYhTsEe5wxN
         XE2MlzW7biBC+fzR/gZ05C5nwMK94eqPWftOljBTRJT8T2OmNlW/eB5cuojUN7fyKz
         VSDJu3PBDPWrWN4Sg9i0Mjy6iO52t7xbLLMDFypvAshLEMjYMbGZRdmLkOWvitL5Js
         JrWZ4XYUMZiaWZMOsbQtCGmG00099OAYD+NFENB+FKYQbp9nXhsV76fdR2Gj1xW4T2
         bWp9vt4DEf+NA==
Date:   Wed, 17 Aug 2022 01:48:44 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v6 3/7] platform/chrome: cros_typec_switch: Set EC retimer
Message-ID: <YvxI/FYiGCMYCo/m@google.com>
References: <20220816214857.2088914-1-pmalani@chromium.org>
 <20220816214857.2088914-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816214857.2088914-4-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:48:31PM +0000, Prashant Malani wrote:
> Invoke ChromeOS EC host commands to set EC-controlled retimer switches
> to the state the Type-C framework instructs.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
