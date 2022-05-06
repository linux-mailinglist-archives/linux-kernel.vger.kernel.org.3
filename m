Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8611451D161
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbiEFGfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiEFGe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE485DA63;
        Thu,  5 May 2022 23:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36252B83341;
        Fri,  6 May 2022 06:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA8C385A8;
        Fri,  6 May 2022 06:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651818671;
        bh=y7POrv73PpQHvD+HJqu0OGbIrN/X8i4wShhzutDoNX0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OzcstYxVxRaqjttZMVdNB/j1mObbqE26OxUEAA2qJZYcM2u4QbvmEcghtJeyGINiO
         gPh2qi+Socw1tNeBI98qtmTGTTr7CBIY9L+jU+tBKTQfih5c4VI18EhORwB23fKv7r
         tpnE+Pw1YCUPE/9OeW0mu66c6lO7O4vTw4AOMxjjyV+1CcBMw7i2AeOx6/mrpKi6Nl
         8jFeaG0SWoFcIy791OM5hPgWgH5dWq6I+556eYoZTSaGr4914uMxOhSKjCjusk7mUJ
         lCNv7NU72CSQTdL9frxahIbu6VkuowbHbkd1Vs5j6zughZPVRjpZCEdI7Ys354oibo
         KIu0Y3EWfH+fw==
Date:   Fri, 6 May 2022 08:31:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     frank zago <frank@zago.net>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: Add support for Mega World controller force
 feedback
In-Reply-To: <20220421024041.98786-1-frank@zago.net>
Message-ID: <nycvar.YFH.7.76.2205060830550.28985@cbobk.fhfr.pm>
References: <20220421024041.98786-1-frank@zago.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022, frank zago wrote:

> This patch adds support for one of the several Mega World USB game
> controller with integrated force feedback. It is a HID based
> memory-less game controller, with a weak motor on the left, and a
> strong one on the right.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

