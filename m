Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03424527E68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiEPHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbiEPHSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:18:37 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80513CDD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:18:36 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 6D6D21210F5;
        Mon, 16 May 2022 07:18:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 707F040;
        Mon, 16 May 2022 07:18:29 +0000 (UTC)
Message-ID: <eaf82e8001a370d7be779bd15163f7210a968e8b.camel@perches.com>
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, gcc <gcc@gcc.gnu.org>
Date:   Mon, 16 May 2022 00:18:28 -0700
In-Reply-To: <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
         <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
         <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
         <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
         <YnQKNea6KWFaWNis@slm.duckdns.org>
         <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
         <Yn0538VavQPv+/Ws@slm.duckdns.org>
         <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
         <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ube18spr5b3crk3gobc31nifo7aa5b81
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 707F040
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18jtvK0bs/QQC9DdHFRHLrEMs2Snoe06V0=
X-HE-Tag: 1652685509-763519
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-16 at 14:00 +0900, Tetsuo Handa wrote:
[]
> Changes in v3:
>   Revert suggested change in v2, for kernel test robot <lkp@intel.com> found
> 
>     warning: Function parameter or member 'flush_workqueue' not described in 'void'
>     warning: expecting prototype for flush_workqueue(). Prototype was for void() instead
> 
>   when built with W=1 option.

Odd, perhaps that not a valid error message and is a defect
in gcc's parsing of function definitions.

> Changes in v2:
>   Use "void (flush_workqueue)(struct workqueue_struct *wq)" and remove
>   "#undef flush_workqueue", suggested by Joe Perches <joe@perches.com>.



