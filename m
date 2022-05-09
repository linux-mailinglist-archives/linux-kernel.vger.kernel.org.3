Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB21651FB84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiEILpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiEILpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B591F0DF8;
        Mon,  9 May 2022 04:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42F23B80FE7;
        Mon,  9 May 2022 11:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C54C385A8;
        Mon,  9 May 2022 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652096511;
        bh=MriFEYCRXMcS4d1eJRDeJo66M96ghK/YDPGH2KZFOLE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=h2ahg1DJH+MIiX8BDup3qy2RQXt26FIFvGIZTZSut5VUhF1zRoGqL7ExxE6cygUEn
         mZwqLbI4m8zb86r8pdofvLPXbSiI3Fu4BJq3f93HOcyJUOGpXgs8Ve3KOfysYzNww4
         RXDXBalFL4HVhMi9T2GyIg6K7mpVX4+ZQAofUAolgWwkG0yqcSEEPsN6Wb2XVrUWyE
         AYiKiXZsnlDsqtvv/btzXbTUouTw6EW1bazXNNA3Pd5UmfvvLYXYHU8ZRPQhH4NlSU
         Y0xtbUGjWZ20yC+pxWO6EshosXAd7usIppJNeA0F4ojA1oJxESNiP1FhMetIZ5Z1bC
         o159Dh7nmU8Ww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/1] bcma: gpio: Switch to use fwnode instead of
 of_node
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220504092525.71668-1-andriy.shevchenko@linux.intel.com>
References: <20220504092525.71668-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165209650778.4132.13422568580298973668.kvalo@kernel.org>
Date:   Mon,  9 May 2022 11:41:49 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> GPIO library now accepts fwnode as a firmware node,
> so switch the driver to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied to wireless-next.git, thanks.

f63bc788727c bcma: gpio: Switch to use fwnode instead of of_node

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220504092525.71668-1-andriy.shevchenko@linux.intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

