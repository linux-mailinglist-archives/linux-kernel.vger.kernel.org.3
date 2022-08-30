Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B75A5AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiH3Etc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3Et3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:49:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7DADCE3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA19DB8161C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04247C433C1;
        Tue, 30 Aug 2022 04:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661834965;
        bh=MX3HxKSSop3rjgdhjGuG13nF1e38sAvQKoCTUvhyoj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9Ngg8Oz+9ub/LTUoxB5A7w2yb5j3iCV11c37OUcfd0/dKaWglX5MTcpxH1kRb0JB
         FJwpEb10EalJ8DWnYiNoZN08vesNBzBybRy8O163m9h4g224XJEypOdeZKmF1Q3rtJ
         KMMeTaksT20lG1YvTK/DVPf3b+OxgZr02HHMasVDYNsHSxdgbfzfWuyATTA54TutZE
         xfey/PuiLBe6AkcCLxJg4Ou/pfnFpkP9IcOjkVRy/PIaV4VfPXa/fyxkh59NjH1vZ0
         XBKci6P28xMu6BvoV9Gl1vz2uI3hgB07IbYE1cFgnYJ1nlh99/ZQNZlXDgrMLw79C+
         Z0ZR84HTHNRMg==
Date:   Tue, 30 Aug 2022 10:19:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 00/11] soundwire: register cleanups
Message-ID: <Yw2W0GYriUZIE2k6@matsya>
References: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-22, 13:38, Bard Liao wrote:
> Clean-up and reorder/regroup SoundWire SHIM registers.

The series does not apply on sdw-next. I have already applied and pushed
IDA series, so I guess it needs rebase on that

-- 
~Vinod
