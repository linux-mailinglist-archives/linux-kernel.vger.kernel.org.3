Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DD545B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiFJEk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbiFJEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:40:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FFBB71
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 129DBCE31D1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B341C3411B;
        Fri, 10 Jun 2022 04:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654836017;
        bh=RFKhmbbGUS5Nof2MKwAPSMefbkU7RgczX0nUrSE3S50=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Upz15JXNz+LKxnUVsHW3n+yjVqsTsSQZzl8GhF5g9H+aF0Te/TaAigkbGzfXKMIF3
         oKfznl6X89nVsYN4PCZK96nLumBYk9RrbYVMCN+SJS6j8zaR6jjhkYcATP+IUI1cLW
         bYq/3aiu1GlVUzH8mkSdVosomZzLc+NXRlH2mddI8G1pvEL8LhBRSqd8mS9918oow0
         S3/K01y8EiGqBwXshfmQP3+SrbptOIr0kbITk71kWEhGG1GZpSiYEQLwCkEuu9TsG8
         Y5LcErKtvnw8WbcIkCe/S7b4uDW17kIFmMiCP9AZYTGmthfQDYevT8U6nkFTpcPjmM
         f2JU5wyBXbGxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21AE4E737EA;
        Fri, 10 Jun 2022 04:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/21] platform/chrome: Kunit tests and refactor for
 cros_ec_query_all()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165483601713.17399.11359129384528230256.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Jun 2022 04:40:17 +0000
References: <20220609084957.3684698-1-tzungbi@kernel.org>
In-Reply-To: <20220609084957.3684698-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu,  9 Jun 2022 08:49:36 +0000 you wrote:
> The series adds Kunit tests, refactors, and clean-ups for cros_ec_query_all().
> 
> Tzung-Bi Shih (21):
>   platform/chrome: cros_ec_commands: fix compile errors
> -> Fixes compile errors when including cros_ec_commands.h.
> 
>   platform/chrome: cros_ec_proto: add Kunit tests for
>     cros_ec_query_all()
> -> Adds Kunit tests for cros_ec_query_all().  They are baseline tests
>    for the following refactor patches.  They are designed to pass current
>    code.
> 
> [...]

Here is the summary with links:
  - [v4,01/21] platform/chrome: cros_ec_commands: fix compile errors
    https://git.kernel.org/chrome-platform/c/ea7f0f777d28
  - [v4,02/21] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_query_all()
    https://git.kernel.org/chrome-platform/c/b99eb596efbd
  - [v4,03/21] platform/chrome: use macros for passthru indexes
    https://git.kernel.org/chrome-platform/c/3db0c9e5de7b
  - [v4,04/21] platform/chrome: cros_ec_proto: assign buffer size from protocol info
    https://git.kernel.org/chrome-platform/c/e796c0c4b1ad
  - [v4,05/21] platform/chrome: cros_ec_proto: remove redundant NULL check
    https://git.kernel.org/chrome-platform/c/8e3991610ba5
  - [v4,06/21] platform/chrome: cros_ec_proto: use cros_ec_map_error()
    https://git.kernel.org/chrome-platform/c/93bea2faed63
  - [v4,07/21] platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info()
    https://git.kernel.org/chrome-platform/c/b4d0836e8160
  - [v4,08/21] platform/chrome: cros_ec_proto: add Kunit tests for getting proto info
    https://git.kernel.org/chrome-platform/c/3e97581ed9a2
  - [v4,09/21] platform/chrome: cros_ec_proto: handle empty payload in getting proto info
    https://git.kernel.org/chrome-platform/c/878c36f6caa4
  - [v4,10/21] platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info_legacy()
    https://git.kernel.org/chrome-platform/c/a88f79666d14
  - [v4,11/21] platform/chrome: cros_ec_proto: add Kunit test for getting legacy info
    https://git.kernel.org/chrome-platform/c/cce5d551809c
  - [v4,12/21] platform/chrome: cros_ec_proto: handle empty payload in getting info legacy
    https://git.kernel.org/chrome-platform/c/d394ab5c062a
  - [v4,13/21] platform/chrome: cros_ec_proto: don't show MKBP version if unsupported
    https://git.kernel.org/chrome-platform/c/b36f0643ff14
  - [v4,14/21] platform/chrome: cros_ec_proto: return 0 on getting cmd mask success
    https://git.kernel.org/chrome-platform/c/f91183aa459a
  - [v4,15/21] platform/chrome: cros_ec_proto: add Kunit test for getting cmd mask error
    https://git.kernel.org/chrome-platform/c/a8f77c63baec
  - [v4,16/21] platform/chrome: cros_ec_proto: check `msg->result` in getting cmd mask
    https://git.kernel.org/chrome-platform/c/ec5134899335
  - [v4,17/21] platform/chrome: cros_ec_proto: add Kunit tests for getting cmd mask
    https://git.kernel.org/chrome-platform/c/8120febafccb
  - [v4,18/21] platform/chrome: cros_ec_proto: handle empty payload in getting cmd mask
    https://git.kernel.org/chrome-platform/c/aac29b04dc3f
  - [v4,19/21] platform/chrome: cros_ec_proto: return 0 on getting wake mask success
    https://git.kernel.org/chrome-platform/c/d65da5f9bb0a
  - [v4,20/21] platform/chrome: cros_ec_proto: add Kunit test for getting wake mask
    https://git.kernel.org/chrome-platform/c/e43772294246
  - [v4,21/21] platform/chrome: cros_ec_proto: handle empty payload in getting wake mask
    https://git.kernel.org/chrome-platform/c/cfed691b80dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


