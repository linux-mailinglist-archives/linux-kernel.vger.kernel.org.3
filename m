Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E35514FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiFTJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiFTJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:56:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391813E19;
        Mon, 20 Jun 2022 02:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FD5BCE1154;
        Mon, 20 Jun 2022 09:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A22C3411B;
        Mon, 20 Jun 2022 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655718978;
        bh=1feoivY7gwwMDCEhN+h7CXS1lJojSZFu+I+k5bzv8lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXSZGrRZaf5e2n8tbsdGgJIvPmuI2GM9VQK6GSLMSkonCkVFpjPmfOzhF7bNZJsHe
         ULseOJRdk5rQbsZsEAjaJcz0mHlPE7xstzmqAyqOO+zTWh6XqMn5i8sDZr51KbHOxh
         2W2neMoTs2CkoRr0Zy0wBgbSASRpSf4DjQ1PI6Ts=
Date:   Mon, 20 Jun 2022 11:56:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     maciej.kwapulinski@linux.intel.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, corbet@lwn.net,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        guy.zadicario@intel.com, linus.walleij@linaro.org, olof@lixom.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
Message-ID: <YrBEP4P9JA60LeOB@kroah.com>
References: <85a6nq45uh.fsf@linux.intel.com>
 <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:49:07AM +0200, maciej.kwapulinski@linux.intel.com wrote:
> Please share your thoughts.

No code here to share thoughts about :(
