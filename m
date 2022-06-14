Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8954B824
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352181AbiFNRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352729AbiFNRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:53:27 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 10:53:26 PDT
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61392286C7;
        Tue, 14 Jun 2022 10:53:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 35079179;
        Tue, 14 Jun 2022 17:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 35079179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1655227823; bh=9ylsUPL7VbCdDnr3J7AuARBJq2lzJrjWzQq70E6IeUw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PijtgX5xJfyI5RKvQtLc6cCWx4yh5eJ9ahWhS/N7syHhPAIZoSKAsJGH59m7JXFAz
         OdHIX1ywy21YB07pPZs9KTng8GTg24uCu19NdEQw2MWReKWqXOfLQYGWKeKPneN2CN
         n5odCHgVVWN16gehJ8ndHnFg1PoJZWSPEjRkx4cQ=
Date:   Wed, 15 Jun 2022 03:30:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     kernel test robot <lkp@intel.com>
cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, keescook@chromium.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] security: Add LSM hook to setgroups() syscall
In-Reply-To: <202206141619.gvenMkdS-lkp@intel.com>
Message-ID: <ddcc855c-d8f-98ff-24c5-3abe24c1fe@namei.org>
References: <20220613202807.447694-1-mortonm@chromium.org> <202206141619.gvenMkdS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, kernel test robot wrote:

> Hi Micah,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on jmorris-security/next-testing kees/for-next/pstore v5.19-rc2 next-20220614]

My next-testing is out of date, I'll push a newer version.

-- 
James Morris
<jmorris@namei.org>

