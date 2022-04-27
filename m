Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B362511404
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiD0JGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiD0JGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:06:20 -0400
Received: from localhost.localdomain (unknown [219.141.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4EC8677
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:02:50 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id 23R8ss0F006841
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 16:54:54 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 23R8sVfJ006840;
        Wed, 27 Apr 2022 16:54:31 +0800
Date:   Wed, 27 Apr 2022 16:54:31 +0800
From:   Li kunyu <kunyu@nfschina.com>
To:     elver@google.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        oleg@redhat.com, legion@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Optimize unused integer return values
Message-ID: <20220427085431.GB6812@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,RCVD_IN_PBL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this patch is incomplete. I have the following ideas

post_copy_siginfo_from_User32 function can change the integer return value 0 to void return type, and its caller return value is based on it. Can the return type of related function be changed to void.

If you agree with this idea, I will resend the patc
