Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7F53E02B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiFFDi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFFDiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:38:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61BB52E75
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD1FCCE10AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F394DC385A9;
        Mon,  6 Jun 2022 03:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654486726;
        bh=OEdTOdZWGYCQRiRZ5NXyWtz6ywfqiCIXus56RC+98sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CliLscswV1qjgHnxmFI8HlfKiRjTu1I4jtyf3KszfuZdkJMtjhk8YUFITGZ4SGT0m
         0nE/xwGxExGWyFQY6egpznloG/d8ythVs0btW+yjfOoAvIFNcQlBw6ssQa4RJNt1ea
         e72tBUJ4kQi40aJiCavTLSTdJBPjmNlHq9h2LBrCe2RBedOgBem5XgOeF/Mkov0/uc
         izpzHowtPEjiNLCz0TL7GuevKzhbzWqv5MQkZtUIDRydjb7nnl3PKrphPftbsmLXcd
         c7bnMEDMNk6JFoGslO2fldA6Kck7u1NsxUBCCZ+T5nEU/WZnIje1vwZS6mqB0xsuIM
         nQHDCpupBzfrA==
Date:   Mon, 6 Jun 2022 03:38:42 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     bleung@chromium.org, groeck@chromium.org, gustavoars@kernel.org,
        dustin@howett.net, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cros_ec_commands: Fix syntax errors in comments
Message-ID: <Yp12wuqQx4uHUMAJ@google.com>
References: <20220606022313.22912-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606022313.22912-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:23:13AM +0800, Xiang wangx wrote:
> Delete the redundant word 'using'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

The corresponding change also applied to EC (https://crrev.com/c/2633984).
