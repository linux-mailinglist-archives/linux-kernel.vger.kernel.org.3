Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1152B904
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiERLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiERLeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:34:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9F1778B3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B679B81EBF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F61DC385AA;
        Wed, 18 May 2022 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652873659;
        bh=L9LSlbkMeoTCZ5teJUzit5o/STvUaaZaTe1JmHGt9So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FT5ZdUq4wO/dGHCQXxr/Z9ysXmdV2bS0aQ+fnv2b8GC7tNoPV+Xa66RBaJTOxgRmE
         yhba7yzAR1+Cgn4BrRZkty9hP3/esmNAufSwGrR0JMB6PE9xxVLZb0fsZ5X2PeCiDa
         EigoPlT4O0GPAuw7UnrbpKRr0q2Ul1Q4kdc3DriXizxlgTqsDej0+dSipZDesGnwY9
         +xwM8HiJSCAEHdfBQC96H0fC9PcsQVSnbAN166hIx0IqGIMwKWEOlSJiSf097KOigt
         HSOyF0ZYW2KD60f/rloxli92Pg90aa8Pzu30TIii/cBJlvsOmHDxv/MiySRe2fnfDx
         sDQD21LvzBVbA==
Date:   Wed, 18 May 2022 19:34:15 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dianders@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: update
 cros_ec_check_result() comment
Message-ID: <YoTZt+7rHC+HMIip@google.com>
References: <20220517082817.1591526-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517082817.1591526-1-tzungbi@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:28:17PM +0800, Tzung-Bi Shih wrote:
> At first glance, cros_ec_check_result() is quite like cros_ec_map_error().
> They check for `ec_msg->result` and return corresponding errors.  However,
> as calling from `pkt_xfer` and `cmd_xfer`, cros_ec_check_result() should
> not report furthermore errors.  -EAGAIN is the only exception.
> 
> See [1][2][3] for some known userland programs' code.  The return code
> from ioctl only denotes the EC communication status.  Userland programs
> would further analyze the `result` in struct cros_ec_command* for
> follow-up actions (e.g. [4]).
> 
> To clarify, update the function comment.

Pardon me if it is confusing.  The patch now merged into a series in order to
make more sense.  Let's ignore the patch and move discussion to [5] if any.

[5]: https://patchwork.kernel.org/project/chrome-platform/patch/20220518091814.2028579-4-tzungbi@kernel.org/
